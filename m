From: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>
Subject: Re: Altec Lansing FX5051 mixer
Date: Mon, 27 Aug 2007 10:36:44 -0600
Message-ID: <46D2FD9C.5030807@atrus.rifetech.com>
References: <20070827152359.GA22496@rifetech.com>
	<1188231535.15509.1207493335@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a15.dreamhost.com (sd-green-bigip-66.dreamhost.com
	[208.97.132.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E50C1038F7
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 18:36:44 +0200 (CEST)
In-Reply-To: <1188231535.15509.1207493335@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Jeremy Nickurak wrote:
>   
>> The mixer doesn't work at all w/linux kernel 2.6.22, everything is locked
>> at 100% volume, which is pretty unhelpful, as it's the only way to adjust
>> the volume. (no analog controls).
>>     
>
> Are there any messages in the system log when you try to change them?
>   
Nothing in syslog or dmesg.
> Please show the output of "lsusb -v" for this device.
>   

Bus 004 Device 002: ID 04d2:5051 Altec Lansing Technologies
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        16
  idVendor           0x04d2 Altec Lansing Technologies
  idProduct          0x5051
  bcdDevice            1.12
  iManufacturer           1 Altec Lansing Technologies, Inc.
  iProduct                2 Altec Lansing - FX5051
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          139
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      (Missing must-be-set bit!)
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           44
        bInCollection           1
        baInterfaceNr( 0)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x15
          Mute
          Bass
          Treble
        bmaControls( 1)      0x02
          Volume
        bmaControls( 2)      0x02
          Volume
        bmaControls( 3)      0x00
        bmaControls( 4)      0x00
        bmaControls( 5)      0x00
        bmaControls( 6)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             6
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0240  1x 576 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     172
          Report Descriptor: (length is 172)
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x01 ] 1
                            Consumer Control
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0xe2 ] 226
                            Mute
            Item(Local ): Usage, data= [ 0xe9 ] 233
                            Volume Increment
            Item(Local ): Usage, data= [ 0xea ] 234
                            Volume Decrement
            Item(Local ): Usage, data= [ 0x52 0x01 ] 338
                            Bass Increment
            Item(Local ): Usage, data= [ 0x53 0x01 ] 339
                            Bass Decrement
            Item(Local ): Usage, data= [ 0x54 0x01 ] 340
                            Treble Increment
            Item(Local ): Usage, data= [ 0x55 0x01 ] 341
                            Treble Decrement
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x08 ] 8
            Item(Main  ): Input, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                            (null)
            Item(Local ): Usage, data= [ 0x01 ] 1
                            (null)
            Item(Local ): Usage, data= [ 0x3a ] 58
                            (null)
            Item(Local ): Usage, data= [ 0x2e ] 46
                            (null)
            Item(Local ): Usage, data= [ 0x09 ] 9
                            (null)
            Item(Local ): Usage, data= [ 0x0a ] 10
                            (null)
            Item(Local ): Usage, data= [ 0x3d ] 61
                            (null)
            Item(Local ): Usage, data= [ 0x3e ] 62
                            (null)
            Item(Local ): Usage, data= [ 0xff ] 255
                            (null)
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x08 ] 8
            Item(Main  ): Input, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0xe2 ] 226
                            Mute
            Item(Local ): Usage, data= [ 0xe9 ] 233
                            Volume Increment
            Item(Local ): Usage, data= [ 0xea ] 234
                            Volume Decrement
            Item(Local ): Usage, data= [ 0x52 0x01 ] 338
                            Bass Increment
            Item(Local ): Usage, data= [ 0x53 0x01 ] 339
                            Bass Decrement
            Item(Local ): Usage, data= [ 0x54 0x01 ] 340
                            Treble Increment
            Item(Local ): Usage, data= [ 0x55 0x01 ] 341
                            Treble Decrement
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x08 ] 8
            Item(Main  ): Output, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Global): Usage Page, data= [ 0x00 0xff ] 65280
                            (null)
            Item(Local ): Usage, data= [ 0x01 ] 1
                            (null)
            Item(Local ): Usage, data= [ 0x3a ] 58
                            (null)
            Item(Local ): Usage, data= [ 0x09 ] 9
                            (null)
            Item(Local ): Usage, data= [ 0x0a ] 10
                            (null)
            Item(Local ): Usage, data= [ 0x3d ] 61
                            (null)
            Item(Local ): Usage, data= [ 0x3e ] 62
                            (null)
            Item(Local ): Usage, data= [ 0xfe ] 254
                            (null)
            Item(Local ): Usage, data= [ 0x00 ] 0
                            (null)
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x08 ] 8
            Item(Main  ): Output, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Local ): Usage, data= [ 0xf0 ] 240
                            (null)
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xff 0xff ] 65535
            Item(Global): Report Size, data= [ 0x10 ] 16
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Output, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Local ): Usage, data= [ 0xf1 ] 241
                            (null)
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xff 0xff 0xff 0xff ] -1
            Item(Global): Report Size, data= [ 0x20 ] 32
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Output, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Local ): Usage, data= [ 0xf2 ] 242
                            (null)
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0xff 0xff 0xff 0xff ] -1
            Item(Global): Report Size, data= [ 0x20 ] 32
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Main  ): Output, data= [ 0x82 ] 130
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Volatile 
Bitfield
            Item(Main  ): End Collection, data=none
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered

>   
>> Also, the digital control panel
>>     
>
> The remote control?
>   
There is an IR remote which is also locked, but that's not what I'm 
referring to. The volume (and also surround/treble/bass balance) can be 
set by selecting a mode, and spinning a dial, which adjusts the 
corresponding volume setting. There's an LED "meter" which lights up 
from 0 to 100 on the panel, just like alsamixer. The LED's switch to a 
low-power brightness when not used.

Volume always seems to show 100%, just like the PCM setting in alsamixer.

Bass and Treble always show approximately 50%, which is also what 
alsamixer appears to be locked too. Holding "up" or "down" on these 
settings in alsamixer will occasionally get it to move a hair off their 
otherwise locked states, but will immediatly revert to 100% for PCM, 50% 
for bass/treble. Interestingly, the control panel's LED meter reflects 
this, dropping a step or increasing a step, but only 1 step.

>> locks up when the speakers power up, further preventing any access to
>> the volume controls.
>>     
>
> What does "lock up" mean?  Nothing happens when you press buttons?
>   
On closer inspection, it seems to show precisely the same behavior as 
alsamixer (with one minor exception). The volume, bass, and treble 
settings cannot be adjusted up or down more than hair, locked at 100%, 
50%, and 50% respectively. The power button works, except that the 
device turns back on after a couple seconds. This sequence does not 
cause any usb disconnect/connect events. Instead, it seems to function 
more like a mute, shutting down the speakers without shutting down the 
usb device.

- Jeremy Nickurak
