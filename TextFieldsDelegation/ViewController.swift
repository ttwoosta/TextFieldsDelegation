//
//  ViewController.swift
//  TextFieldsDelegation
//
//  Created by Tu Tong on 7/5/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var textFieldZipCode: UITextField!
    @IBOutlet weak var textFieldCashValue: UITextField!
    @IBOutlet weak var textFieldLockable: UITextField!
    @IBOutlet weak var switchTextFieldLockable: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lblWarning.hidden = true
        self.textFieldLockable.enabled = false
        
        // focus on zip code textField
        self.textFieldZipCode.becomeFirstResponder()
    }
    
    ///////////////////////
    // UITextFieldDelegate
    ///////////////////////
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        self.lblWarning.hidden = true
        
        // Delete did tap
        if string.isEmpty {
            return true
        }
        
        switch textField {
        case self.textFieldZipCode:
            println("Zipcode text field changed")
            
            // is entered string a digit ?
            let intValue = string.toInt()
            if intValue == nil {
                self.lblWarning.text = "Must enter digits only!"
                self.lblWarning.hidden = false
                return false
            }
            // ensure zip code 5 digits long
            let str: NSString = textField.text
            let appendStr: NSString = string
            let len = str.length + appendStr.length
            if len > 5 {
                self.lblWarning.text = "Zip code should be 5 digits long!"
                self.lblWarning.hidden = false
                return false
            }
            
        case self.textFieldCashValue:
            println("Cash text field changed")
            
            // is entered string a digit ?
            let intValue = string.toInt()
            if intValue == nil {
                self.lblWarning.text = "Must enter digits only!"
                self.lblWarning.hidden = false
                return false
            }
            
            // declare value of double type
            var value: Double = 0.00
            
            // create number formatter with currency style
            let numf = NSNumberFormatter()
            numf.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            // retrieve current value
            let number = numf.numberFromString(textField.text)
            println("number: \(number)")
            
            // is textField contains any value
            if number == nil || number == 0 {
                value = Double(intValue!) * 0.01
            }
            else {
                // insert entered number at beggining
                let cv = Int(number!.doubleValue * 100)
                let newvalue = "\(string)\(cv)".toInt()
                value = Double(newvalue!) * 0.01
            }
            
            // currency style format
            textField.text = numf.stringFromNumber(value)
            return false
            
        case self.textFieldLockable:
            println("Lockable text field changed")
        default:
            println("Unknown text field did change")
        }
        
        return true
    }
    
    ///////////////////////
    // Switch value changed
    ///////////////////////
    
    @IBAction func switchValueDidChange(sender: AnyObject) {
        self.textFieldLockable.enabled = self.switchTextFieldLockable.on
    }


}

