From: mark@undertone.org
Subject: Re: testers for SB Extigy wanted
Date: Mon, 14 Oct 2002 14:11:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021014191103.GA6704@undertone.org>
References: <s5hbs61cazj.wl@alsa2.suse.de> <20021011143659.GA31907@undertone.org> <s5h8z15c8uq.wl@alsa2.suse.de> <20021011153411.GA32132@undertone.org> <s5h7kgpc6bi.wl@alsa2.suse.de> <s5h65w9c55m.wl@alsa2.suse.de> <20021011180023.GA32632@undertone.org> <s5hy994c09l.wl@alsa2.suse.de> <20021011183901.GA310@undertone.org> <s5hr8et6wk5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr8et6wk5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, here are the new results. I've decided to include most of the
output as attached files. Figured it would be easier this way for most
people.

The tests were done with the cvs tree from around 14:30EST with your
test define included in the usbmixer code. Included are:

lsusb-out.txt: lsusb -vv -s 1:4
sys-out.txt: syslog text when initializing default alsa drivers
proc-stream0.txt: stream0 contents (only stream file available)
alsactl-store-out.txt: syslog text when doing a alsactl store

As always, need anything else and I'll be more than happy to
provide. Sorry about the slow reply today, Mondays are full of
meetings.

-mark

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsusb-out.txt"


Bus 001 Device 004: ID 041e:3000 Creative Labs 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x041e Creative Labs
  idProduct          0x3000 
  bcdDevice            1.00
  iManufacturer           1 Creative Technology Ltd.
  iProduct                2 Sound Blaster Extigy
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          794
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          410
        bInCollection           3
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
        baInterfaceNr( 2)       3
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
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
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
        bTerminalID             4
        wTerminalType      0x0602 Digital Audio Interface
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
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 5
        bNrInPins               2
        baSource( 0)            3
        baSource( 1)            4
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID               5
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0603 Line Connector
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 8
        bSourceID               7
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             9
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               9
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                11
        bNrInPins               3
        baSource( 0)            7
        baSource( 1)            9
        baSource( 2)           17
        iSelector               0 
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                12
        bSourceID              11
        bControlSize            2
        bmaControls( 0)      0x03
        bmaControls( 1)      0x00
          Mute
          Volume
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        bmaControls( 0)      0x00
        bmaControls( 1)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            13
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              12
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                14
        bNrInPins               2
        baSourceID( 0)          8
        baSourceID( 1)          6
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        bmControls         0x00
        iMixer                  0 
        junk at descriptor end: 00 00 00 00
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      7 (PROCESSING_UNIT)
        bUnitID                15
        wProcessType            3
        bNrPins                 1
        baSourceID( 0)         14
        bNrChannels             5
        wChannelConfig     0x0037
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x01
          Enable Processing
        iProcessing             0 
        Process-Specific    
      AudioControl Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                16
        bNrInPins               4
        baSourceID( 0)          2
        baSourceID( 1)          6
        baSourceID( 2)         15
        baSourceID( 3)         10
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
        junk at descriptor end: 00 00 00 00 00 00 00 00 00
      AudioControl Interface Descriptor:
        bLength                30
        bDescriptorType        36
        bDescriptorSubtype      7 (PROCESSING_UNIT)
        bUnitID                17
        wProcessType            1
        bNrPins                 1
        baSourceID( 0)         16
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x03
          Enable Processing
        iProcessing             0 
        Process-Specific     07 03 00 03 00 0b 00 33 00 3b 00 37 00 3f 00
      AudioControl Interface Descriptor:
        bLength                21
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                18
        bSourceID              17
        bControlSize            2
        bmaControls( 0)      0x17
        bmaControls( 1)      0x00
          Mute
          Volume
          Bass
          Treble
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        bmaControls( 0)      0x02
        bmaControls( 1)      0x00
          Volume
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      8 (EXTENSION_UNIT)
        bUnitID                27
        wExtensionCode          0
        bNrPins                 1
        baSourceID( 0)         18
        bNrChannels             6
        wChannelConfig         63
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x01
          Enable Processing
        iExtension              0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                28
        bSourceID              27
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            19
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              28
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0302 Headphones
        bAssocTerminal          0
        bSourceID              18
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      8 (EXTENSION_UNIT)
        bUnitID                21
        wExtensionCode          0
        bNrPins                 1
        baSourceID( 0)         27
        bNrChannels             6
        wChannelConfig         63
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        bControlSize            1
        bmControls( 0)       0x01
          Enable Processing
        iExtension              0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                22
        bSourceID              21
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                23
        bSourceID              22
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            24
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bSourceID              23
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                25
        bSourceID              22
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        bmaControls( 0)      0x00
        iFeature                0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            26
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bSourceID              25
        iTerminal               0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval              10
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
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           1
        bDelay                  0 frames
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
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        200
        bInterval               1
        bRefresh                0
        bSynchAddress           3
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
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
        bTerminalLink          13
        bDelay                  0 frames
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
        tSamFreq[ 0]         8000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize         40
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
      bInterfaceNumber        2
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
        bTerminalLink          13
        bDelay                  0 frames
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
        tSamFreq[ 0]        16000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize         72
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
      bInterfaceNumber        2
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          13
        bDelay                  0 frames
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
        tSamFreq[ 0]        24000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        104
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
      bInterfaceNumber        2
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          13
        bDelay                  0 frames
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
        tSamFreq[ 0]        32000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        136
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
      bInterfaceNumber        2
      bAlternateSetting       5
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          13
        bDelay                  0 frames
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
        bEndpointAddress     0x86  EP 6 IN
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
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           3
        bDelay                  0 frames
        wFormatTag           4098 AC-3
      AudioControl Interface Descriptor:
        bLength                15
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             2 (FORMAT_TYPE_II)
      Warning: Descriptor too short
        wMaxBitRate           640
        wSamplesPerFrame     1536
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        44100
        tSamFreq[ 1]        48000
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      3 (FORMAT_SPECIFIC)
        wFormatTag           4098 AC-3
        bmBSID         0x0000001f
        bmAC3Features        0x00
          Internal Dynamic Range Control: not supported
        junk at descriptor end: 00 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize         84
        bInterval               1
        bRefresh                0
        bSynchAddress           5
        AudioControl Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                6
        bSynchAddress           0
  Language IDs: (length=4)
     0409 English(US)

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsactl-store-out.txt"

Oct 14 14:00:09 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:286: cannot get ctl value: req = 0x81, idx = 0x0, val = 0x500, type = 3
Oct 14 14:00:09 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:286: cannot get ctl value: req = 0x81, idx = 0x1, val = 0xf00, type = 0
Oct 14 14:00:09 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:286: cannot get ctl value: req = 0x81, idx = 0x1, val = 0x1100, type = 0
Oct 14 14:00:09 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:286: cannot get ctl value: req = 0x83, idx = 0x200, val = 0x1100, type = 3
Oct 14 14:00:09 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:581: 17:0: cannot get min/max values for control 2 (id 17)
Oct 14 14:00:09 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:286: cannot get ctl value: req = 0x81, idx = 0x2, val = 0x1100, type = 3

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sys-out.txt"

Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Master Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Master Playback Volume] ch = 6, val = -25600/0
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Master Playback Volume] ch = 1, val = -25600/0
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Tone Control - Bass] ch = 1, val = -48/48
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Tone Control - Treble] ch = 1, val = -48/48
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [28] FU [Speaker Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [22] FU [Digital Out Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [23] FU [Digital Out1 Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:14 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [25] FU [Digital Out2 Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:20 atrophy kernel: usb.c: deregistering driver snd-usb-audio
Oct 14 14:06:30 atrophy kernel: PCI: Found IRQ 10 for device 00:08.0
Oct 14 14:06:30 atrophy kernel: usb.c: registered new driver snd-usb-audio
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:1:1: add audio endpoint 0x2
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:1: add audio endpoint 0x86
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:2: add audio endpoint 0x86
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:3: add audio endpoint 0x86
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:4: add audio endpoint 0x86
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1820: 4:2:5: add audio endpoint 0x86
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbaudio.c:1601: 4:3:1 : format type 2 is not supported yet
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [2] FU [PCM Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [2] FU [PCM Playback Volume] ch = 1, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1369: [5] SU [Digital In Playback Source] items = 2
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [6] FU [Digital In Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [6] FU [Digital In Volume] ch = 1, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [8] FU [Line Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [8] FU [Line Playback Volume] ch = 2, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [8] FU [Line Playback Volume] ch = 1, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1164: [15] PU [3D Stereo Extender Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [10] FU [Mic Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [10] FU [Mic Playback Volume] ch = 1, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1164: [17] PU [Up Down Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1164: [17] PU [Up Down Mode Select] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:1369: [11] SU [Capture Source] items = 3
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [12] FU [Capture Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [12] FU [Capture Volume] ch = 1, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Master Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Master Playback Volume] ch = 6, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Master Playback Volume] ch = 1, val = -25600/0
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Tone Control - Bass] ch = 1, val = -48/48
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [18] FU [Tone Control - Treble] ch = 1, val = -48/48
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [28] FU [Speaker Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [22] FU [Digital Out Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [23] FU [Digital Out1 Playback Switch] ch = 1, val = 0/1
Oct 14 14:06:30 atrophy kernel: ALSA ../alsa-kernel/usb/usbmixer.c:816: [25] FU [Digital Out2 Playback Switch] ch = 1, val = 0/1

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-stream0.txt"

Creative Technology Ltd. : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 24000
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 32000
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48000

--VbJkn9YxBvnuCH5J--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
