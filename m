From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Creamware Noah, snd-usb-audio capable?
Date: 06 Feb 2004 20:06:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076094393.2688.2.camel@chief.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello devels,

just a "short" question.

I own a piece of hardware called Noah EX. It's a "tactive instrument
modeller". Wich means, that it calculates the behaviour and sound of 
instruments with help of loadable software plugins.
This is well done by the device so far.Because that works without any
help from a computer.

My question is based on the matter, that this device owns an
usb-interface, that is capable of transmitting audio and midi data.
It supports:
	Sampling Rate 44,1khz (this is the only one)
	Internal audio data width 32 Bit; (might be 16 external)
	USB Audio In: 2 channels
	USB Audio Out: 6 channels
	USB Midi In
	USB Midi Out
	ADAT Out: 8 channels
	Wordclock In

My goal is to get this device working with the alsa usb driver, because
the output of lsusb -v leads me to the hope, that it has a standard usb
audio interface.

My configuration:
Mainboard: Asus A7N8X
Kernel: 2.6.2 Vanilla (vanilla means unpatched from kernel.org? that's
right, isn't it?)
I only applied the changes in capability.h to "satisfy" the  jack-audio-
connection-kit.


Just plugging it to an usb port on my linux box results in an output in
/var/log/messages, that reads:

Feb  5 00:28:33 chief kernel: hub 1-2:1.0: port 4, status 101, change 1,
12 Mb/s
Feb  5 00:28:33 chief kernel: hub 1-2:1.0: debounce: port 4: delay 100ms
stable 4 status 0x101
Feb  5 00:28:33 chief kernel: hub 1-2:1.0: port 4 not reset yet, waiting
10ms
Feb  5 00:28:33 chief kernel: hub 1-2:1.0: new USB device on port 4,
assigned address 4
Feb  5 00:28:33 chief kernel: usb 1-2.4: new device strings: Mfr=1,
Product=2, SerialNumber=0
Feb  5 00:28:33 chief kernel: drivers/usb/core/message.c: USB device
number 4 default language ID 0x409
Feb  5 00:28:33 chief kernel: usb 1-2.4: Product: CreamWare Noah
Synthesizer
Feb  5 00:28:33 chief kernel: usb 1-2.4: Manufacturer: CreamWare GmbH
Feb  5 00:28:33 chief kernel: drivers/usb/core/usb.c: usb_hotplug
Feb  5 00:28:33 chief kernel: usb 1-2.4: configuration #1 chosen from 2
choices
Feb  5 00:28:33 chief kernel: usb 1-2.4: registering 1-2.4:1.0 (config
#1, interface 0)
Feb  5 00:28:33 chief kernel: drivers/usb/core/usb.c: usb_hotplug
Feb  5 00:28:33 chief usb.agent[7039]: Keeping default configuration
with /sys//devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2.4
Feb  5 00:28:33 chief usb.agent[7038]: ... no modules for USB product
1107/102/100

What I discoverd yet, is that the device is offering two configurations.
And the second is the audio and midi related one. The first seems to be
the configuration "channel".

snd-usb-audio is enabled (and working), because of having an M-Audio
Midisport 4x4 as an additional Midi-In and Out device to my other
soundcards, using the drivers emu10k1, intel8x0, ice1712 and virmidi.
(With the fact, that Midi-In on the Midisport is only working with USB
2.0 disabled in the BIOS, but this may be a bug in the ehci part of the
kernel. Not talking about unplugging the Midisport blocks the usb part
of the kernel; even with only USB 1.1 enabled in the BIOS.) 

I was gathering around for some information about the usb-audio driver,
but couldn't get the information, I was looking for.
Is it always a requirement, that an usb audio(midi) device has an entry
in usbquirks.h or is that only for special(non standard usb audio 
compling devices)?

For the reason, that it requires an entry in usbquirks.h, I attached the
output of lsusb -v. Maybe it might help.

I'm also willing to do some testing with any hints.

 
Hartmut

--------------->8--Start of lsusb-------------------------------------

Bus 001 Device 003: ID 1107:0102
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1107
  idProduct          0x0102
  bcdDevice            1.00
  iManufacturer           1 CreamWare GmbH
  iProduct                2 CreamWare Noah Synthesizer
  iSerial                 0
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           60
    bNumInterfaces          1
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
      bNumEndpoints           6
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              7 Noah Synth
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         32
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          381
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
      bNumEndpoints           4
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              7 Noah Synth
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         32
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x06  EP 6 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              3 Noah Audio
      AudioControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           53
        bInCollection           3
        baInterfaceNr( 0)       2
        baInterfaceNr( 1)       3
        baInterfaceNr( 2)       4
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            17
        wTerminalType      0x0101 USB Streaming
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
        bTerminalID            18
        wTerminalType      0x0601 Analog Connector
        bAssocTerminal          0
        bSourceID              17
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            19
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID              20
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0601 Analog Connector
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              4 Noah Audio Out
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              4 Noah Audio Out
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          17
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
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x08  EP 8 OUT
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
        wMaxPacketSize        184
        bInterval               1
        bRefresh                0
        bSynchAddress         137
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          3
        bInterval               1
        bRefresh                1
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
      iInterface              5 Noah Audio In
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              5 Noah Audio In
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          19
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
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        184
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
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              5 Noah Audio In
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           0
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
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
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        368
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
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              5 Noah Audio In
      AudioControl Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           0
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
        tSamFreq[ 0]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        552
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
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 Non Streaming
      bInterfaceProtocol      0
      iInterface              6 Noah Midi
      MIDIStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           65
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               1 Embedded
        bJackID                11
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                12
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                13
        bNrInputPins            1
        baSourceID( 0)         12
        BaSourcePin( 0)         1
        iJack                   0
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                14
        bNrInputPins            1
        baSourceID( 0)         11
        BaSourcePin( 0)         1
        iJack                   0
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)      13
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize          8
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)      11
  Language IDs: (length=4)
     0409 English(US)

--------------->8--End of lsusb-------------------------------------
-- 
Hab ich was verpasst und die Judaeische Volxfront, Chapter Bodensee hat
die Eidgenossen ueberrannt?
Tim Heinemann in drm




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
