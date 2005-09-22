From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001438]: AC3 playback not working with Terratec Aureon 5.1 USB MK-II
Date: Thu, 22 Sep 2005 19:32:22 +0200
Message-ID: <5192e2cabb3f4bb86b047574907174ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7AB1151
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 19:32:22 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1438> 
======================================================================
Reported By:                mitch_f
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1438
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.4.28-gentoo-r9
======================================================================
Date Submitted:             09-21-2005 21:26 CEST
Last Modified:              09-22-2005 19:32 CEST
======================================================================
Summary:                    AC3 playback not working with Terratec Aureon 5.1
USB MK-II
Description: 
If I try to playback a file containing AC3 audio data with mplayer, it
complains with:

alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82
AES2 0x00 AES3 0x02}
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM iec958:{CARD
0 AES0 0x02 AES1 0x82 AES2 0x00 AES3 0x02} definition (id: iec958, value:
cards.pcm.iec958)
alsa-init: playback open error: Invalid argument
Could not open/initialize audio device -> no sound.

2-channel audio works fine (analog and SPDIF) and AC3 playback also worked
on the cmipci-based card I used before.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 09-22-05 17:21 
----------------------------------------------------------------------
The USB driver currently doesn't support AC3 streams because we have never
seen any device that would implement it according to the USB Audio
specification.

Please show the output of "lsusb -v" for your device.

----------------------------------------------------------------------
 mitch_f - 09-22-05 19:32 
----------------------------------------------------------------------
Here it is:

Bus 001 Device 003: ID 0ccd:0028 TerraTec Electronic GmbH
string descriptor 1 invalid (bf bf; len=0)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0ccd TerraTec Electronic GmbH
  idProduct          0x0028
  bcdDevice            1.00
  iManufacturer           0
  iProduct                1
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          369
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
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
        wTotalLength          179
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
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
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0603 Line Connector
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               9
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               8
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 8
        bNrInPins               3
        baSource( 0)           10
        baSource( 1)           11
        baSource( 2)           12
        iSelector               0
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 9
        bSourceID              15
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bControlSize            1
        bmaControls( 0)      0x43
          Mute
          Volume
          Automatic Gain
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                11
        bSourceID               3
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x02
          Volume
        bmaControls( 0)      0x02
          Volume
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                12
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                13
        bSourceID               2
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                14
        bSourceID               3
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x02
          Volume
        bmaControls( 0)      0x02
          Volume
        iFeature                0
      AudioControl Interface Descriptor:
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                15
        bNrInPins               3
        baSourceID( 0)          1
        baSourceID( 1)         13
        baSourceID( 2)         14
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0
        bmControls         0x00
        bmControls         0x00
        bmControls         0x00
        iMixer                  0
        junk at descriptor end: 00 00 00 00 00
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
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  3 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
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
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        200
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         1 Milliseconds
          wLockDelay              4 Milliseconds
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              0
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
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
        wMaxPacketSize        600
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         1 Milliseconds
          wLockDelay              2 Milliseconds
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
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           7
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
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
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        200
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
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
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      48
          Report Descriptor: (length is 48)
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x01 ] 1
                            Consumer Control
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Local ): Usage, data= [ 0xe9 ] 233
                            Volume Increment
            Item(Local ): Usage, data= [ 0xea ] 234
                            Volume Decrement
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x02 ] 2
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile
Bitfield
            Item(Local ): Usage, data= [ 0xe2 ] 226
                            Mute
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile
Bitfield
            Item(Global): Report Count, data= [ 0x04 ] 4
            Item(Main  ): Input, data= [ 0x01 ] 1
                            Constant Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile
Bitfield
            Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Global): Report Size, data= [ 0x08 ] 8
            Item(Global): Report Count, data= [ 0x02 ] 2
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile
Bitfield
            Item(Local ): Usage, data= [ 0x00 ] 0
                            Unassigned
            Item(Global): Report Count, data= [ 0x03 ] 3
            Item(Main  ): Output, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile
Bitfield
            Item(Main  ): End Collection, data=none
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          3
        bInterval              32
  Language IDs: (length=4)
     0409 English(US)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-21-05 21:26 mitch_f        New Issue                                    
09-21-05 21:26 mitch_f        Distribution              => Gentoo          
09-21-05 21:26 mitch_f        Kernel Version            => 2.4.28-gentoo-r9
09-22-05 17:21 Clemens LadischNote Added: 0006354                          
09-22-05 19:32 mitch_f        Note Added: 0006356                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
