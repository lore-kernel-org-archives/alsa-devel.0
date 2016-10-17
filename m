From: Chris Webb <chris@arachsys.com>
Subject: Yamaha Montage class-compliant USB MIDI
Date: Mon, 17 Oct 2016 13:28:13 +0100
Message-ID: <B1273193-2473-43AB-8A25-62B41776BC13@arachsys.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 82CE6266ABD
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 14:28:18 +0200 (CEST)
Received: from [81.171.254.94] (helo=chris.lan)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>) id 1bw71c-0006js-8O
 for alsa-devel@alsa-project.org; Mon, 17 Oct 2016 13:28:17 +0100
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

I have a Yamaha Montage synthesiser sitting on my desk, which supports MIDI  
and multi-channel audio over USB. I'd like to get it talking to Linux ALSA.

To my surprise, it offers two USB configurations, the normal Yamaha  
vendor-specific one (presumably very similar to the MOX defined in  
quirks-table.h:362) but also a class-compliant one.

The class-complaint configuration nearly works out of the box. Audio and  
MIDI in (to the computer) work fine, but MIDI out (i.e. to the synth) is  
broken, at least in kernel 4.9-rc1 and 4.8. Here's the lsusb output:

   # lsusb -v -s 001:002

   Bus 001 Device 002: ID 0499:1707 Yamaha Corp.
   Device Descriptor:
     bLength                18
     bDescriptorType         1
     bcdUSB               2.00
     bDeviceClass          239 Miscellaneous Device
     bDeviceSubClass         2 ?
     bDeviceProtocol         1 Interface Association
     bMaxPacketSize0        64
     idVendor           0x0499 Yamaha Corp.
     idProduct          0x1707
     bcdDevice            1.02
     iManufacturer           1 Yamaha Corporation
     iProduct                2 MONTAGE
     iSerial                 0
     bNumConfigurations      2
     Configuration Descriptor:
       bLength                 9
       bDescriptorType         2
       wTotalLength          349
       bNumInterfaces          4
       bConfigurationValue     1
       iConfiguration          0
       bmAttributes         0xc0
         Self Powered
       MaxPower                0mA
       Interface Association:
         bLength                 8
         bDescriptorType        11
         bFirstInterface         0
         bInterfaceCount         4
         bFunctionClass          1 Audio
         bFunctionSubClass       0
         bFunctionProtocol      32
         iFunction               0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        0
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      1 Control Device
         bInterfaceProtocol     32
         iInterface              0
         AudioControl Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      1 (HEADER)
           bcdADC               2.00
           bCategory               8
           wTotalLength           75
           bmControl            0x00
         AudioControl Interface Descriptor:
           bLength                 8
           bDescriptorType        36
           bDescriptorSubtype     10 (CLOCK_SOURCE)
           bClockID                1
           bmAttributes         0x03 Internal programmable Clock
           bmControls           0x03
             Clock Frequency Control (read/write)
           bAssocTerminal          0
           iClockSource            0
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      2 (INPUT_TERMINAL)
           bTerminalID             2
           wTerminalType      0x0101 USB Streaming
           bAssocTerminal          0
           bCSourceID              1
           bNrChannels             6
           bmChannelConfig   0x00000000
           bmControls    0x0000
           iChannelNames          16 Main L
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                12
           bDescriptorType        36
           bDescriptorSubtype      3 (OUTPUT_TERMINAL)
           bTerminalID             3
           wTerminalType      0x0603 Line Connector
           bAssocTerminal          0
           bSourceID               2
           bCSourceID              1
           bmControls         0x0000
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                17
           bDescriptorType        36
           bDescriptorSubtype      2 (INPUT_TERMINAL)
           bTerminalID             4
           wTerminalType      0x0603 Line Connector
           bAssocTerminal          0
           bCSourceID              1
           bNrChannels            32
           bmChannelConfig   0x00000000
           bmControls    0x0000
           iChannelNames          48 USB Main L
           iTerminal               0
         AudioControl Interface Descriptor:
           bLength                12
           bDescriptorType        36
           bDescriptorSubtype      3 (OUTPUT_TERMINAL)
           bTerminalID             5
           wTerminalType      0x0101 USB Streaming
           bAssocTerminal          0
           bSourceID               4
           bCSourceID              1
           bmControls         0x0000
           iTerminal               0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       1
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              0
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink           2
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels             6
           bmChannelConfig   0x00000000
           iChannelNames          16 Main L
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            3
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x07  EP 7 OUT
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0075  1x 117 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         0 Undefined
             wLockDelay              0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       1
         bNumEndpoints           1
         bInterfaceClass         1 Audio
         bInterfaceSubClass      2 Streaming
         bInterfaceProtocol     32
         iInterface              0
         AudioStreaming Interface Descriptor:
           bLength                16
           bDescriptorType        36
           bDescriptorSubtype      1 (AS_GENERAL)
           bTerminalLink           5
           bmControls           0x00
           bFormatType             1
           bmFormats         0x00000001
             PCM
           bNrChannels            32
           bmChannelConfig   0x00000000
           iChannelNames          48 USB Main L
         AudioStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (FORMAT_TYPE)
           bFormatType             1 (FORMAT_TYPE_I)
           bSubslotSize            3
           bBitResolution         24
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x86  EP 6 IN
           bmAttributes           37
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Implicit feedback Data
           wMaxPacketSize     0x0271  1x 625 bytes
           bInterval               1
           AudioControl Endpoint Descriptor:
             bLength                 8
             bDescriptorType        37
             bDescriptorSubtype      1 (EP_GENERAL)
             bmAttributes         0x00
             bmControls           0x00
             bLockDelayUnits         0 Undefined
             wLockDelay              0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        3
         bAlternateSetting       0
         bNumEndpoints           2
         bInterfaceClass         1 Audio
         bInterfaceSubClass      3 MIDI Streaming
         bInterfaceProtocol      0
         iInterface              0
         MIDIStreaming Interface Descriptor:
           bLength                 7
           bDescriptorType        36
           bDescriptorSubtype      1 (HEADER)
           bcdADC               1.00
           wTotalLength          129
         MIDIStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (MIDI_IN_JACK)
           bJackType               2 External
           bJackID                 1
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (MIDI_IN_JACK)
           bJackType               2 External
           bJackID                 2
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (MIDI_IN_JACK)
           bJackType               2 External
           bJackID                 3
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (MIDI_IN_JACK)
           bJackType               1 Embedded
           bJackID                33
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (MIDI_IN_JACK)
           bJackType               1 Embedded
           bJackID                34
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 6
           bDescriptorType        36
           bDescriptorSubtype      2 (MIDI_IN_JACK)
           bJackType               1 Embedded
           bJackID                35
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      3 (MIDI_OUT_JACK)
           bJackType               2 External
           bJackID                65
           bNrInputPins            1
           baSourceID( 0)         33
           BaSourcePin( 0)         1
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      3 (MIDI_OUT_JACK)
           bJackType               2 External
           bJackID                66
           bNrInputPins            1
           baSourceID( 0)         34
           BaSourcePin( 0)         1
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      3 (MIDI_OUT_JACK)
           bJackType               2 External
           bJackID                67
           bNrInputPins            1
           baSourceID( 0)         35
           BaSourcePin( 0)         1
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      3 (MIDI_OUT_JACK)
           bJackType               1 Embedded
           bJackID                97
           bNrInputPins            1
           baSourceID( 0)          1
           BaSourcePin( 0)         1
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      3 (MIDI_OUT_JACK)
           bJackType               1 Embedded
           bJackID                98
           bNrInputPins            1
           baSourceID( 0)          2
           BaSourcePin( 0)         1
           iJack                   0
         MIDIStreaming Interface Descriptor:
           bLength                 9
           bDescriptorType        36
           bDescriptorSubtype      3 (MIDI_OUT_JACK)
           bJackType               1 Embedded
           bJackID                99
           bNrInputPins            1
           baSourceID( 0)          3
           BaSourcePin( 0)         1
           iJack                   0
         Endpoint Descriptor:
           bLength                 9
           bDescriptorType         5
           bEndpointAddress     0x01  EP 1 OUT
           bmAttributes            2
             Transfer Type            Bulk
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0200  1x 512 bytes
           bInterval               0
           bRefresh                0
           bSynchAddress           0
           MIDIStreaming Endpoint Descriptor:
             bLength                 7
             bDescriptorType        37
             bDescriptorSubtype      1 (GENERAL)
             bNumEmbMIDIJack         3
             baAssocJackID( 0)      33
             baAssocJackID( 1)      34
             baAssocJackID( 2)      35
         Endpoint Descriptor:
           bLength                 9
           bDescriptorType         5
           bEndpointAddress     0x82  EP 2 IN
           bmAttributes            2
             Transfer Type            Bulk
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0200  1x 512 bytes
           bInterval               0
           bRefresh                0
           bSynchAddress           0
           MIDIStreaming Endpoint Descriptor:
             bLength                 7
             bDescriptorType        37
             bDescriptorSubtype      1 (GENERAL)
             bNumEmbMIDIJack         3
             baAssocJackID( 0)      97
             baAssocJackID( 1)      98
             baAssocJackID( 2)      99
     Configuration Descriptor:
       bLength                 9
       bDescriptorType         2
       wTotalLength          290
       bNumInterfaces          5
       bConfigurationValue     2
       iConfiguration          0
       bmAttributes         0xc0
         Self Powered
       MaxPower                0mA
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        0
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass      1
         bInterfaceProtocol      0
         iInterface              0
         ** UNRECOGNIZED:  0a 24 01 00 01 34 00 02 01 02
         ** UNRECOGNIZED:  0c 24 02 01 01 01 00 02 03 00 00 00
         ** UNRECOGNIZED:  09 24 03 02 01 03 00 01 00
         ** UNRECOGNIZED:  0c 24 02 03 03 06 00 02 03 00 00 00
         ** UNRECOGNIZED:  09 24 03 04 01 01 00 03 00
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass      2
         bInterfaceProtocol      0
         iInterface              0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        1
         bAlternateSetting       1
         bNumEndpoints           1
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass      2
         bInterfaceProtocol      0
         iInterface              0
         ** UNRECOGNIZED:  07 24 01 01 01 01 00
         ** UNRECOGNIZED:  0b 24 02 01 06 03 18 01 44 ac 00
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x07  EP 7 OUT
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0075  1x 117 bytes
           bInterval               1
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       0
         bNumEndpoints           0
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass      2
         bInterfaceProtocol      0
         iInterface              0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        2
         bAlternateSetting       1
         bNumEndpoints           1
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass      2
         bInterfaceProtocol      0
         iInterface              0
         ** UNRECOGNIZED:  07 24 01 04 01 01 00
         ** UNRECOGNIZED:  0b 24 02 01 20 03 18 01 44 ac 00
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x86  EP 6 IN
           bmAttributes            5
             Transfer Type            Isochronous
             Synch Type               Asynchronous
             Usage Type               Data
           wMaxPacketSize     0x0271  1x 625 bytes
           bInterval               1
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        3
         bAlternateSetting       0
         bNumEndpoints           2
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass      3
         bInterfaceProtocol    255
         iInterface              0
         ** UNRECOGNIZED:  07 24 01 00 01 42 00
         ** UNRECOGNIZED:  06 24 02 02 01 00
         ** UNRECOGNIZED:  06 24 02 02 02 00
         ** UNRECOGNIZED:  06 24 02 02 03 00
         ** UNRECOGNIZED:  09 24 03 02 01 01 01 01 00
         ** UNRECOGNIZED:  09 24 03 02 02 01 01 01 00
         ** UNRECOGNIZED:  09 24 03 02 03 01 01 01 00
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x01  EP 1 OUT
           bmAttributes            2
             Transfer Type            Bulk
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0200  1x 512 bytes
           bInterval               0
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x82  EP 2 IN
           bmAttributes            2
             Transfer Type            Bulk
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0200  1x 512 bytes
           bInterval               0
       Interface Descriptor:
         bLength                 9
         bDescriptorType         4
         bInterfaceNumber        4
         bAlternateSetting       0
         bNumEndpoints           2
         bInterfaceClass       255 Vendor Specific Class
         bInterfaceSubClass    255 Vendor Specific Subclass
         bInterfaceProtocol    255 Vendor Specific Protocol
         iInterface              0
         ** UNRECOGNIZED:  07 24 01 00 01 24 00
         ** UNRECOGNIZED:  06 24 02 02 01 00
         ** UNRECOGNIZED:  09 24 03 02 01 01 01 01 00
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x03  EP 3 OUT
           bmAttributes            2
             Transfer Type            Bulk
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0200  1x 512 bytes
           bInterval               0
         Endpoint Descriptor:
           bLength                 7
           bDescriptorType         5
           bEndpointAddress     0x84  EP 4 IN
           bmAttributes            2
             Transfer Type            Bulk
             Synch Type               None
             Usage Type               Data
           wMaxPacketSize     0x0200  1x 512 bytes
           bInterval               0
   Device Qualifier (for other device speed):
     bLength                10
     bDescriptorType         6
     bcdUSB               2.00
     bDeviceClass            0 (Defined at Interface level)
     bDeviceSubClass         0
     bDeviceProtocol         0
     bMaxPacketSize0        64
     bNumConfigurations      2
   Device Status:     0x0001
     Self Powered
   #

Doing an aplaymidi -p 20:0 test.mid hangs without receiving the test notes  
at the synth end, and the kernel eventually reports:

   sound midiC1D0: rawmidi drain error (avail = 3700, buffer_size = 4096)

Monitoring the USB traffic while this happens,

   # cat /sys/kernel/debug/usb/usbmon/1u
   ffff995b59da2780 93721891 S Bo:1:002:1 -115 16 = 0990404c 0991404c 0992404c 0993404c
   ffff995b59da2780 93721978 C Bo:1:002:1 0 16 >
   ffff995b59da2b40 93915884 S Bo:1:002:1 -115 12 = 09904000 09914000 09924000
   ffff995b59da2b40 93915967 C Bo:1:002:1 0 12 >
   ffff995b59e563c0 93917882 S Bo:1:002:1 -115 4 = 09934000
   ffff995b59e56540 94057875 S Bo:1:002:1 -115 4 = 09903e4a
   ffff995b59e56600 94059872 S Bo:1:002:1 -115 12 = 09913e4a 09923e4a 09933e4a
   ffff995b59e56780 94238881 S Bo:1:002:1 -115 16 = 09903e00 09913e00 09923e00 09933e00
   ffff995b59e56840 94418886 S Bo:1:002:1 -115 16 = 09903c46 09913c46 09923c46 09933c46
   ffff995b59da2780 94632882 S Bo:1:002:1 -115 4 = 0dd00800
   ffff995b59da2b40 94633887 S Bo:1:002:1 -115 12 = 0dd10800 0dd20800 0dd30800
   [hangs]

so it looks like we stop getting callbacks for URBs after the first couple?

This class-compliant interface apparently works okay on macOS/iOS, although  
macOS uses the vendor-specific interface when the proprietary drivers are  
installed. But I don't know how to get a dump of the USB traffic on either  
of those platforms for comparison.

Looking at where the callbacks stop, I (naively) wonder if macOS serialises  
USB MIDI URBs or something like that, and I'm seeing a Yamaha bug with  
multiple URBs in flight?

Is there anything more I can usefully do to further diagnose what's going on?

Would it be better to attempt to support the (presumably very similar to  
existing MOX and more heavily tested) vendor-specific USB configuration? Is  
it possible to write a quirk that prefers this configuration, assuming  
similar structure to MOX and earlier Yamaha audio and MIDI devices?

Best wishes,

Chris.
