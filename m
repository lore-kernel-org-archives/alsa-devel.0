From: "Jan Baumgart" <raga.raga@gmx.de>
Subject: MiniDSP USBStreamer / UAC2 / Alsamixer bogus
Date: Thu, 22 May 2014 19:36:47 +0200
Message-ID: <trinity-69d5b18f-8b7a-4d6a-97e4-025a61f952fe-1400780207708@3capp-gmx-bs24>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 63CCF261ACD
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 19:36:48 +0200 (CEST)
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

   Hi there,

   Today I received a MiniDSP USBStreamer Box.
   (http://www.minidsp.com/products/usb-audio-interface/usbstreamer-box)
   It's an USB to ADAT optical interface and claims to be UAC2 compliant.
   It's based on a XMOS L2 core.

   Audio worked out of the box!
   8-Channels In & Out :)

   But the alsamixer controls seem to be bogus.
   Here's a screenshot of qasmixer:
   icem.folkwang-uni.de/~jb/geheim/usbstreamer_qasmixer.png

   All controls are named "USBStreamer Clock Selector"...
   The first control always snaps back to zero.
   The following 8 Multi-Controls don't have any effect.
   Only the last two Input/Ouput Master controls work as expected.

   The most important problem is that I cannot set the clock source:
   > amixer -D hw:USBStreamer cset numid=7 1

   numid=7,iface=MIXER,name='USBStreamer Clock Selector'
     ; type=ENUMERATED,access=rw------,values=1,items=2
     ; Item #0 'USBStreamer Internal Clock'
     ; Item #1 'USBStreamer ADAT Clock'
     : values=0

   The value always stays 0 (internal).

   On OS X 10.8.5 without installing any driver I see 8 Input/Output
   Volume Sliders + Master Sliders and a working Clock Selector.

   I'm running debian testing with a 3.13-1-amd64 stock kernel.

   Any ideas? I've attached lsusb and amixer infos below...

   Cheers & Thanks,
   Jan


   _________________________________________________
   > amixer -D hw:USBStreamer controls
   numid=7,iface=MIXER,name='USBStreamer Clock Selector'
   numid=8,iface=MIXER,name='USBStreamer Clock Selector Capture Switch'
   numid=9,iface=MIXER,name='USBStreamer Clock Selector Capture
   Switch',index=1
   numid=10,iface=MIXER,name='USBStreamer Clock Selector Capture Volume'
   numid=11,iface=MIXER,name='USBStreamer Clock Selector Capture
   Volume',index=1
   numid=3,iface=MIXER,name='USBStreamer Clock Selector Playback Switch'
   numid=4,iface=MIXER,name='USBStreamer Clock Selector Playback
   Switch',index=1
   numid=5,iface=MIXER,name='USBStreamer Clock Selector Playback Volume'
   numid=6,iface=MIXER,name='USBStreamer Clock Selector Playback
   Volume',index=1
   numid=2,iface=PCM,name='Capture Channel Map'
   numid=1,iface=PCM,name='Playback Channel Map'


   ______________________________________________________________-
   > amixer -D hw:USBStreamer contents

   numid=7,iface=MIXER,name='USBStreamer Clock Selector'
     ; type=ENUMERATED,access=rw------,values=1,items=2
     ; Item #0 'USBStreamer Internal Clock'
     ; Item #1 'USBStreamer ADAT Clock'
     : values=0
   numid=8,iface=MIXER,name='USBStreamer Clock Selector Capture Switch'
     ; type=BOOLEAN,access=rw------,values=8
     : values=on,on,on,on,on,on,on,on
   numid=9,iface=MIXER,name='USBStreamer Clock Selector Capture
   Switch',index=1
     ; type=BOOLEAN,access=rw------,values=1
     : values=on
   numid=10,iface=MIXER,name='USBStreamer Clock Selector Capture Volume'
     ; type=INTEGER,access=rw---R--,values=8,min=0,max=255,step=0
     : values=255,255,255,255,255,255,255,255
     | dBminmax-min=-127.50dB,max=0.00dB
   numid=11,iface=MIXER,name='USBStreamer Clock Selector Capture
   Volume',index=1
     ; type=INTEGER,access=rw---R--,values=1,min=0,max=255,step=0
     : values=255
     | dBminmax-min=-127.50dB,max=0.00dB
   numid=3,iface=MIXER,name='USBStreamer Clock Selector Playback Switch'
     ; type=BOOLEAN,access=rw------,values=8
     : values=on,on,on,on,on,on,on,on
   numid=4,iface=MIXER,name='USBStreamer Clock Selector Playback
   Switch',index=1
     ; type=BOOLEAN,access=rw------,values=1
     : values=on
   numid=5,iface=MIXER,name='USBStreamer Clock Selector Playback Volume'
     ; type=INTEGER,access=rw---R--,values=8,min=0,max=255,step=0
     : values=255,255,255,255,255,255,255,255
     | dBminmax-min=-127.50dB,max=0.00dB
   numid=6,iface=MIXER,name='USBStreamer Clock Selector Playback
   Volume',index=1
     ; type=INTEGER,access=rw---R--,values=1,min=0,max=255,step=0
     : values=255
     | dBminmax-min=-127.50dB,max=0.00dB
   numid=2,iface=PCM,name='Capture Channel Map'
     ; type=INTEGER,access=r----R--,values=8,min=0,max=36,step=0
     : values=0,0,0,0,0,0,0,0
     |     | chmap-fixed=FL,FR,FC,LFE,RL,RR,FLC,FRC
   numid=1,iface=PCM,name='Playback Channel Map'
     ; type=INTEGER,access=r----R--,values=8,min=0,max=36,step=0
     : values=0,0,0,0,0,0,0,0
     |     | chmap-fixed=FL,FR,FC,LFE,RL,RR,FLC,FRC

   ______________________________________________________________
   > lsusb -s 3:10 -v

   Bus 003 Device 010: ID 2752:0016
   Couldn't open device, some information will be missing
   Device Descriptor:
     bLength                18
     bDescriptorType         1
     bcdUSB               2.00
     bDeviceClass          239 Miscellaneous Device
     bDeviceSubClass         2 ?
     bDeviceProtocol         1 Interface Association
     bMaxPacketSize0        64
     idVendor           0x2752
     idProduct          0x0016
     bcdDevice            5.30
     iManufacturer           1
     iProduct                2
     iSerial                 3
     bNumConfigurations      2
     Configuration Descriptor:
       bLength                 9
       bDescriptorType         2
       wTotalLength          524
       bNumInterfaces          4
       bConfigurationValue     1
       iConfiguration          0
       bmAttributes         0x80
         (Bus Powered)
       MaxPower              500mA
       Interface Association:
         bLength                 8
         bDescriptorType        11
         bFirstInterface         0
         bInterfaceCount         3
         bFunctionClass          1 Audio
         bFunctionSubClass       0
         bFunctionProtocol      32
         iFunction               0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        0
         bAlternateSetting       0
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      1 Control Device
         bInterfaceProtocol     32
         iInterface              2
         AudioControl Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      1 (HEADER)
           bcdADC               2.00
           bCategory               8
           wTotalLength          257
           bmControl            0x00
         AudioControl Interface Descriptor:
           bLength                 8
           bDescriptorType        36
           bDescriptorSubtype     10 (CLOCK_SOURCE)
           bClockID               41
           bmAttributes         0x03 Internal programmable Clock
           bmControls           0x07
             Clock Frequency Control (read/write)
             Clock Validity Control (read-only)
           bAssocTerminal          0
           iClockSource            9
         AudioControl Interface Descriptor:
           bLength                 8
           bDescriptorType        36
           bDescriptorSubtype     10 (CLOCK_SOURCE)
           bClockID               43
           bmAttributes         0x00 External Clock
           bmControls           0x07
             Clock Frequency Control (read/write)
             Clock Validity Control (read-only)
           bAssocTerminal          0
           iClockSource           11
         AudioControl Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype     11 (CLOCK_SELECTOR)
           bUnitID                40
           bNrInPins               2
           baCSourceID( 0)        41
           baCSourceID( 1)        43
           bmControls           0x03
             Clock Selector Control (read/write)
           iClockSelector          8
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      2 (INPUT_TERMINAL)
           bTerminalID             2
           wTerminalType      0x0101 USB Streaming
           bAssocTerminal          0
           bCSourceID             40
           bNrChannels             8
           bmChannelConfig   0x00000000
           bmControls    0x0000
           iChannelNames          15
           iTerminal               6
         AudioControl Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      9 (EXTENSION_UNIT)
         Warning: Descriptor too short
           bUnitID                51
           wExtensionCode          0
           bNrPins                 1
           baSourceID( 0)          2
           bNrChannels             8
           wChannelConfig          0
           iChannelNames           3
           bmControls        0x00
           iExtension             42
         AudioControl Interface Descriptor:
           bLength                42
           bDescriptorType        36
           bDescriptorSubtype      6 (FEATURE_UNIT)
           bUnitID                10
           bSourceID              51
           bmaControls( 0)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 1)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 2)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 3)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 4)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 5)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 6)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 7)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 8)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           iFeature                0
         AudioControl Interface Descriptor:
           bLength                12
           bDescriptorType        36
           bDescriptorSubtype      3 (OUTPUT_TERMINAL)
           bTerminalID            20
           wTerminalType      0x0301 Speaker
           bAssocTerminal          0
           bSourceID              10
           bCSourceID             40
           bmControls         0x0000
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      2 (INPUT_TERMINAL)
           bTerminalID             1
           wTerminalType      0x0201 Microphone
           bAssocTerminal          0
           bCSourceID             40
           bNrChannels             8
           bmChannelConfig   0x00000000
           bmControls    0x0000
           iChannelNames          33
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      9 (EXTENSION_UNIT)
         Warning: Descriptor too short
           bUnitID                52
           wExtensionCode          0
           bNrPins                 1
           baSourceID( 0)          1
           bNrChannels             8
           wChannelConfig          0
           iChannelNames           3
           bmControls        0x00
           iExtension             42
         AudioControl Interface Descriptor:
           bLength                42
           bDescriptorType        36
           bDescriptorSubtype      6 (FEATURE_UNIT)
           bUnitID                11
           bSourceID              52
           bmaControls( 0)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 1)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 2)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 3)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 4)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 5)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 6)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 7)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 8)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           iFeature                0
         AudioControl Interface Descriptor:
           bLength                12
           bDescriptorType        36
           bDescriptorSubtype      3 (OUTPUT_TERMINAL)
           bTerminalID            22
           wTerminalType      0x0101 USB Streaming
           bAssocTerminal          0
           bSourceID              11
           bCSourceID             40
           bmControls         0x0000
           iTerminal               7
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      9 (EXTENSION_UNIT)
         Warning: Descriptor too short
           bUnitID                50
           wExtensionCode          0
           bNrPins                 2
           baSourceID( 0)          2
           baSourceID( 1)          1
           bNrChannels            18
           wChannelConfig          0
           iChannelNames           3
           bmControls        0x00
           iExtension             32
         AudioControl Interface Descriptor:
           bLength                32
           bDescriptorType        36
           bDescriptorSubtype      4 (MIXER_UNIT)
           bUnitID                60
           bNrPins                 1
           baSourceID( 0)         50
           bNrChannels             8
           bmChannelConfig    0x00000000
           iChannelNames          49
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
           bmControls         00
           iMixer                 0
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x84  EP 4 IN
           bmAttributes            3
             Transfer Type            Interrupt
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0006  1x 6 bytes
           bInterval               8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              4
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       1
         bNumEndpoints           2
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              4
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink           2
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             8
           bmChannelConfig   0x00000000
           iChannelNames          15
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x01  EP 1 OUT
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x81  EP 1 IN
           bmAttributes           17
             Transfer Type            Isochronous
             Synch Type               None
             Usage Type               Feedback
           wMaxPacketSize     0x0004  1x 4 bytes
           bInterval               4
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       2
         bNumEndpoints           2
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              4
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink           2
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             8
           bmChannelConfig   0x00000000
           iChannelNames          15
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x01  EP 1 OUT
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x81  EP 1 IN
           bmAttributes           17
             Transfer Type            Isochronous
             Synch Type               None
             Usage Type               Feedback
           wMaxPacketSize     0x0004  1x 4 bytes
           bInterval               8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              5
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       1
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              5
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink          22
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             8
           bmChannelConfig   0x00000000
           iChannelNames          33
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x82  EP 2 IN
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       2
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              5
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink          22
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             4
           bmChannelConfig   0x00000000
           iChannelNames          33
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x82  EP 2 IN
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        3
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass       254 Application Specific Interface
         bInterfaceSubClass      1 Device Firmware Update
         bInterfaceProtocol      1
         iInterface             12
         Device Firmware Upgrade Interface Descriptor:
           bLength                             9
           bDescriptorType                    33
           bmAttributes                        7
             Will Not Detach
             Manifestation Tolerant
             Upload Supported
             Download Supported
           wDetachTimeout                    250 milliseconds
           wTransferSize                      64 bytes
           bcdDFUVersion                   1.10
     Configuration Descriptor:
       bLength                 9
       bDescriptorType         2
       wTotalLength          524
       bNumInterfaces          4
       bConfigurationValue     1
       iConfiguration          0
       bmAttributes         0x80
         (Bus Powered)
       MaxPower              500mA
       Interface Association:
         bLength                 8
         bDescriptorType        11
         bFirstInterface         0
         bInterfaceCount         3
         bFunctionClass          1 Audio
         bFunctionSubClass       0
         bFunctionProtocol      32
         iFunction               0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        0
         bAlternateSetting       0
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      1 Control Device
         bInterfaceProtocol     32
         iInterface              2
         AudioControl Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      1 (HEADER)
           bcdADC               2.00
           bCategory               8
           wTotalLength          257
           bmControl            0x00
         AudioControl Interface Descriptor:
           bLength                 8
           bDescriptorType        36
           bDescriptorSubtype     10 (CLOCK_SOURCE)
           bClockID               41
           bmAttributes         0x03 Internal programmable Clock
           bmControls           0x07
             Clock Frequency Control (read/write)
             Clock Validity Control (read-only)
           bAssocTerminal          0
           iClockSource            9
         AudioControl Interface Descriptor:
           bLength                 8
           bDescriptorType        36
           bDescriptorSubtype     10 (CLOCK_SOURCE)
           bClockID               43
           bmAttributes         0x00 External Clock
           bmControls           0x07
             Clock Frequency Control (read/write)
             Clock Validity Control (read-only)
           bAssocTerminal          0
           iClockSource           11
         AudioControl Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype     11 (CLOCK_SELECTOR)
           bUnitID                40
           bNrInPins               2
           baCSourceID( 0)        41
           baCSourceID( 1)        43
           bmControls           0x03
             Clock Selector Control (read/write)
           iClockSelector          8
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      2 (INPUT_TERMINAL)
           bTerminalID             2
           wTerminalType      0x0101 USB Streaming
           bAssocTerminal          0
           bCSourceID             40
           bNrChannels             8
           bmChannelConfig   0x00000000
           bmControls    0x0000
           iChannelNames          15
           iTerminal               6
         AudioControl Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      9 (EXTENSION_UNIT)
         Warning: Descriptor too short
           bUnitID                51
           wExtensionCode          0
           bNrPins                 1
           baSourceID( 0)          2
           bNrChannels             8
           wChannelConfig          0
           iChannelNames           3
           bmControls        0x00
           iExtension             42
         AudioControl Interface Descriptor:
           bLength                42
           bDescriptorType        36
           bDescriptorSubtype      6 (FEATURE_UNIT)
           bUnitID                10
           bSourceID              51
           bmaControls( 0)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 1)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 2)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 3)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 4)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 5)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 6)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 7)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 8)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           iFeature                0
         AudioControl Interface Descriptor:
           bLength                12
           bDescriptorType        36
           bDescriptorSubtype      3 (OUTPUT_TERMINAL)
           bTerminalID            20
           wTerminalType      0x0301 Speaker
           bAssocTerminal          0
           bSourceID              10
           bCSourceID             40
           bmControls         0x0000
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      2 (INPUT_TERMINAL)
           bTerminalID             1
           wTerminalType      0x0201 Microphone
           bAssocTerminal          0
           bCSourceID             40
           bNrChannels             8
           bmChannelConfig   0x00000000
           bmControls    0x0000
           iChannelNames          33
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      9 (EXTENSION_UNIT)
         Warning: Descriptor too short
           bUnitID                52
           wExtensionCode          0
           bNrPins                 1
           baSourceID( 0)          1
           bNrChannels             8
           wChannelConfig          0
           iChannelNames           3
           bmControls        0x00
           iExtension             42
         AudioControl Interface Descriptor:
           bLength                42
           bDescriptorType        36
           bDescriptorSubtype      6 (FEATURE_UNIT)
           bUnitID                11
           bSourceID              52
           bmaControls( 0)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 1)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 2)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 3)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 4)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 5)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 6)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 7)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           bmaControls( 8)      0x0000000f
             Mute Control (read/write)
             Volume Control (read/write)
           iFeature                0
         AudioControl Interface Descriptor:
           bLength                12
           bDescriptorType        36
           bDescriptorSubtype      3 (OUTPUT_TERMINAL)
           bTerminalID            22
           wTerminalType      0x0101 USB Streaming
           bAssocTerminal          0
           bSourceID              11
           bCSourceID             40
           bmControls         0x0000
           iTerminal               7
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      9 (EXTENSION_UNIT)
         Warning: Descriptor too short
           bUnitID                50
           wExtensionCode          0
           bNrPins                 2
           baSourceID( 0)          2
           baSourceID( 1)          1
           bNrChannels            18
           wChannelConfig          0
           iChannelNames           3
           bmControls        0x00
           iExtension             32
         AudioControl Interface Descriptor:
           bLength                32
           bDescriptorType        36
           bDescriptorSubtype      4 (MIXER_UNIT)
           bUnitID                60
           bNrPins                 1
           baSourceID( 0)         50
           bNrChannels             8
           bmChannelConfig    0x00000000
           iChannelNames          49
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
           bmControls         00
           iMixer                 0
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x84  EP 4 IN
           bmAttributes            3
             Transfer Type            Interrupt
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0006  1x 6 bytes
           bInterval               8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              4
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       1
         bNumEndpoints           2
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              4
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink           2
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             8
           bmChannelConfig   0x00000000
           iChannelNames          15
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x01  EP 1 OUT
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x81  EP 1 IN
           bmAttributes           17
             Transfer Type            Isochronous
             Synch Type               None
             Usage Type               Feedback
           wMaxPacketSize     0x0004  1x 4 bytes
           bInterval               4
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       2
         bNumEndpoints           2
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              4
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink           2
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             8
           bmChannelConfig   0x00000000
           iChannelNames          15
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x01  EP 1 OUT
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x81  EP 1 IN
           bmAttributes           17
             Transfer Type            Isochronous
             Synch Type               None
             Usage Type               Feedback
           wMaxPacketSize     0x0004  1x 4 bytes
           bInterval               8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              5
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       1
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              5
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink          22
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             8
           bmChannelConfig   0x00000000
           iChannelNames          33
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x82  EP 2 IN
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       2
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              5
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink          22
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             4
           bmChannelConfig   0x00000000
           iChannelNames          33
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            4
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x82  EP 2 IN
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0400  1x 1024 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         2 Decoded PCM samples
             wLockDelay              8
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        3
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass       254 Application Specific Interface
         bInterfaceSubClass      1 Device Firmware Update
         bInterfaceProtocol      1
         iInterface             12
         Device Firmware Upgrade Interface Descriptor:
           bLength                             9
           bDescriptorType                    33
           bmAttributes                        7
             Will Not Detach
             Manifestation Tolerant
             Upload Supported
             Download Supported
           wDetachTimeout                    250 milliseconds
           wTransferSize                      64 bytes
           bcdDFUVersion                   1.10
