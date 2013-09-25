From: Meelis Roos <mroos@linux.ee>
Subject: usb-audio mic problem with Polycom C100S
Date: Wed, 25 Sep 2013 17:09:19 +0300 (EEST)
Message-ID: <alpine.SOC.1.00.1309251653350.17530@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 03BF42654CF
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 16:09:19 +0200 (CEST)
Received: from math.ut.ee (math.ut.ee [193.40.36.2])
 by smtp2.it.da.ut.ee (Postfix) with ESMTP id 82B7073D5C4
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 17:09:19 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
 by math.ut.ee (Postfix) with ESMTP id 5EB4A427977
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 17:09:19 +0300 (EEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tried to use Skype (4.1) with Polycom Communicator C100S. Audio 
output works fine but mic seems to be dead, although it is set to 
capture and volume is even max. Dmesg tells the following two kinds of 
"cannot get freq at ep ..." messages while trying to use it.

Linux is 3.12-rc2 but I saw the same behaviour a couple releases ago 
when I first tried it.

I am not subscribed to alsa-devel, please CC in replies.

dmesg

[117273.437015] usb 1-1.2.3: new full-speed USB device number 9 using ehci-pci
[117273.901033] usb 1-1.2.3: New USB device found, idVendor=095d, idProduct=0005
[117273.901036] usb 1-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[117273.901037] usb 1-1.2.3: Product: Polycom Communicator
[117273.901038] usb 1-1.2.3: Manufacturer: Polycom,Inc.
[117273.901039] usb 1-1.2.3: SerialNumber: L80646021E21
[117273.962134] hid-generic 0003:095D:0005.0005: hiddev0,hidraw3: USB HID v1.00 Device [Polycom,Inc. Polycom Communicator] on usb-0000:00:1a.0-1.2.3/input3
[117273.974525] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117273.978540] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117274.019749] usbcore: registered new interface driver snd-usb-audio
[117380.633919] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117380.636540] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117383.587846] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117383.619463] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117383.639484] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117383.671451] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117383.697219] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117383.699840] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117385.663752] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117385.666495] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117386.090400] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117386.122894] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117386.143015] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117386.174880] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117386.200626] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117386.203252] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117392.696024] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117392.698650] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117395.407411] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117395.410160] ALSA sound/usb/clock.c:309 9:1:1: cannot get freq at ep 0x82
[117449.635703] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
[117449.638451] ALSA sound/usb/clock.c:309 9:2:1: cannot get freq at ep 0x1
 
lsusb -v

Bus 001 Device 008: ID 095d:0005 Polycom, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x095d Polycom, Inc.
  idProduct          0x0005 
  bcdDevice            1.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 3 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          231
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
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
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           83
        bInCollection           2
        baInterfaceNr( 0)       2
        baInterfaceNr( 1)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 3
        bNrInPins               1
        baSourceID( 0)          2
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID               5
        bControlSize            1
        bmaControls( 0)      0x03
          Mute Control
          Volume Control
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               6
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
        bTerminalLink           4
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
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
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
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
        bTerminalLink           5
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
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
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
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
          wDescriptorLength      52
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10


-- 
Meelis Roos (mroos@linux.ee)
