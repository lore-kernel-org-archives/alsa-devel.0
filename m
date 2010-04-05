From: Mark Hills <mark@pogo.org.uk>
Subject: USB mixer on MixVibes U46DJ
Date: Mon, 5 Apr 2010 17:07:16 +0100 (BST)
Message-ID: <alpine.NEB.2.01.1004051603190.10341@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id CD6D710386E
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Apr 2010 18:07:16 +0200 (CEST)
Received: from mark (helo=localhost)
	by wes.ijneb.com with local-esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>) id 1NyopY-0002Vi-Ko
	for alsa-devel@alsa-project.org; Mon, 05 Apr 2010 17:07:16 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The audio input and output of this USB soundcard works well, but I could 
not make much sense of the hardware mixer.

The hardware is relatively simple: 2 stereo pairs in, 3 stereo pairs out 
(or 2 stereo pairs out when operating at 48kHz) for DJs.

The mixer presented by 'alsamixer' is not a good match for the hardware. I 
hoped to create a mapping to fix this, but then it was more difficult 
because it seems that the mixer controls behave inconsistently. For 
example, to mute the monitoring of inputs 1-4 one must use:

  $ amixer cset numid=4 off,off
  $ amixer cset numid=5 off
  $ amixer cset numid=4 on,on

This, on its own, does not work:

  $ amixer cset numid=5

It was trial-and-error which got me to this conclusion.

Is this common behaviour for a USB device like this, and can I map around 
it? Or does it mean the hardware is buggy?

The mixer presented by the Windows software is nothing special, with 
normal controls (see http://www.pogo.org.uk/~mark/tmp/u46.png), and it 
behaves consistently. So it is possible.

How can I get this device to sensible mixer controls? Thanks!

$ amixer -c 1 contents
numid=1,iface=MIXER,name='U46DJ Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=2,iface=MIXER,name='U46DJ Capture Switch',index=1
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=3,iface=MIXER,name='U46DJ Capture Volume'
  ; type=INTEGER,access=rw---R--,values=4,min=0,max=15,step=0
  : values=0,0,0,0
  | dBminmax-min=0.00dB,max=22.50dB
numid=4,iface=MIXER,name='U46DJ Playback Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
numid=5,iface=MIXER,name='U46DJ Playback Switch',index=1
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=7,iface=MIXER,name='U46DJ Playback Switch',index=2
  ; type=BOOLEAN,access=rw------,values=4
  : values=on,on,on,on
numid=8,iface=MIXER,name='U46DJ Playback Switch',index=3
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=6,iface=MIXER,name='U46DJ Playback Volume'
  ; type=INTEGER,access=rw---R--,values=4,min=0,max=31,step=0
  : values=23,23,23,23
  | dBminmax-min=-34.50dB,max=12.00dB
numid=9,iface=MIXER,name='U46DJ Playback Volume',index=1
  ; type=INTEGER,access=rw---R--,values=6,min=0,max=31,step=0
  : values=31,31,31,31,31,31
  | dBminmax-min=-46.50dB,max=0.00dB

$ lsusb -v -d 0a92:00e1

Bus 003 Device 009: ID 0a92:00e1 EGO SYStems, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.01
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0a92 EGO SYStems, Inc.
  idProduct          0x00e1 
  bcdDevice            1.00
  iManufacturer           1 ESI
  iProduct                2 U46DJ
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          264
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
      iInterface              2 U46DJ
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength          117
        bInCollection           2
        baInterfaceNr( 0)       2
        baInterfaceNr( 1)       1
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0201 Microphone
        bAssocTerminal          6
        bNrChannels             4
        wChannelConfig     0x000f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
        iChannelNames           0 
        iTerminal               2 U46DJ
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               7
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 1)      0x03
          Mute
          Volume
        bmaControls( 2)      0x02
          Volume
        bmaControls( 3)      0x03
          Mute
          Volume
        bmaControls( 4)      0x02
          Volume
        iFeature                2 U46DJ
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      5 (SELECTOR_UNIT)
        bUnitID                 7
        bNrInPins               1
        baSource( 0)            4
        iSelector               2 U46DJ
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          4
        bSourceID               5
        iTerminal               2 U46DJ
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          3
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0 
        iTerminal               2 U46DJ
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 8
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 1)      0x03
          Mute
          Volume
        bmaControls( 2)      0x02
          Volume
        bmaControls( 3)      0x03
          Mute
          Volume
        bmaControls( 4)      0x02
          Volume
        iFeature                2 U46DJ
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      4 (MIXER_UNIT)
        bUnitID                 9
        bNrInPins               2
        baSourceID( 0)          8
        baSourceID( 1)          1
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
        iMixer                  0 
        junk at descriptor end: 00 00 00 00 00 02
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               9
        bControlSize            1
        bmaControls( 0)      0x01
          Mute
        bmaControls( 1)      0x03
          Mute
          Volume
        bmaControls( 2)      0x02
          Volume
        bmaControls( 3)      0x03
          Mute
          Volume
        bmaControls( 4)      0x02
          Volume
        bmaControls( 5)      0x03
          Mute
          Volume
        bmaControls( 6)      0x03
          Mute
          Volume
        iFeature                2 U46DJ
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          1
        bSourceID               2
        iTerminal               2 U46DJ
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              2 U46DJ
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              2 U46DJ
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
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0220  1x 544 bytes
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
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              2 U46DJ
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              2 U46DJ
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           6
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             4
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
          Usage Type               Data
        wMaxPacketSize     0x01a0  1x 416 bytes
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
      iInterface              2 U46DJ
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
        bInterval              20
Device Status:     0x0001
  Self Powered

-- 
Mark
