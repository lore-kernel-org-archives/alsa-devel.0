From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Wed, 12 Jun 2002 14:16:13 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D06D91D.1080104@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090107090008070704040408"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090107090008070704040408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> 
> most of debug messages have been moved to snd_printdd().  that is,
> to show such debug messages, you'll need to configure alsa-driver with
> --with-debug=detect.  if your usb device doesn't work try this, and
> send me the output of kernel messages together with the output of
> lsusb.
> 

Using the latest code this is all the info I can get for this card.

To refresh your memory.

It appears that the card is being correctly found and registered but 
that alsa cannot set up the pcm devices.

There are two obvious things that are possibly directly related. One is 
that the card is created in /proc/asound three times and the other is 
the  AS_GENERAL descriptor not found error.


----
#cat: /proc/asound/dev/controlC2: File descriptor in bad state
----
#more /var/log/messages

Jun 12 13:52:27 mahine kernel: usb.c: registered new driver snd-usb-audio
Jun 12 13:52:27 mahine kernel: ALSA usbaudio.c:1718: adding an output 
interface
3:0:%%j
Jun 12 13:52:27 mahine kernel: ALSA usbaudio.c:1712: adding an input 
interface 3
:0:%%j
Jun 12 13:52:27 mahine kernel: ALSA usbaudio.c:1718: adding an output 
interface
3:3:%%j
Jun 12 13:52:27 mahine kernel: ALSA usbaudio.c:1712: adding an input 
interface 3
:3:%%j
Jun 12 13:52:27 mahine kernel: ALSA usbaudio.c:1718: adding an output 
interface
3:6:%%j
Jun 12 13:52:27 mahine kernel: ALSA usbaudio.c:1712: adding an input 
interface 3
:6:%%j
-----
usb.c: registered new driver snd-usb-audio
ALSA usbaudio.c:1718: adding an output interface 3:0:%j
ALSA usbaudio.c:1712: adding an input interface 3:0:%j
ALSA usbaudio.c:1296: 3:1:1 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1296: 3:2:1 : AS_GENERAL descriptor not found
devfs_register(unknown): could not append to parent, err: -17
ALSA usbaudio.c:1718: adding an output interface 3:3:%j
ALSA usbaudio.c:1712: adding an input interface 3:3:%j
ALSA usbaudio.c:1381: 3:4:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1296: 3:4:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1381: 3:4:3 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1381: 3:5:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1296: 3:5:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1381: 3:5:3 : non-supported sample bit 1 in 3 bytes
devfs_register(unknown): could not append to parent, err: -17
ALSA usbaudio.c:1718: adding an output interface 3:6:%j
ALSA usbaudio.c:1712: adding an input interface 3:6:%j
ALSA usbaudio.c:1381: 3:7:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1296: 3:7:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1381: 3:7:3 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1381: 3:8:1 : non-supported sample bit 1 in 3 bytes
ALSA usbaudio.c:1296: 3:8:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1381: 3:8:3 : non-supported sample bit 1 in 3 bytes
devfs_register(unknown): could not append to parent, err: -17
----

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

--------------090107090008070704040408
Content-Type: text/plain;
 name="lsusb-120602.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb-120602.txt"


Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI-alt Root Hub
  iSerial                 1 d400
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI-alt Root Hub
  iSerial                 1 cc00
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))

Bus 001 Device 002: ID 09da:0006 A4 Tech Co., Ltd. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x09da A4 Tech Co., Ltd.
  idProduct          0x0006 
  bcdDevice            1.00
  iManufacturer           1 A4Tech
  iProduct                2 USB Optical Mouse
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      54
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          4
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 003: ID 0763:2001 Midiman 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0763 Midiman
  idProduct          0x2001 
  bcdDevice            1.01
  iManufacturer           1 M Audio
  iProduct                2 USB AudioSport Quattro (tm)
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          974
    bNumInterfaces         10
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
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
      iInterface              2 USB AudioSport Quattro (tm)
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           52
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
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
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0601 Analog Connector
        bAssocTerminal          0
        bSourceID               5
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0601 Analog Connector
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
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               1
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
        bTerminalLink           5
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        192
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
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            3 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        192
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
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              2 USB AudioSport Quattro (tm)
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           52
        bInCollection           2
        baInterfaceNr( 0)       4
        baInterfaceNr( 1)       5
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
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0601 Analog Connector
        bAssocTerminal          0
        bSourceID               5
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0601 Analog Connector
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
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
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
        bTerminalLink           5
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        88200
        tSamFreq[ 1]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        576
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
      bInterfaceNumber        4
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
        bTerminalLink           5
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        288
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
      bInterfaceNumber        4
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
        bTerminalLink           5
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        192
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
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
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
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        88200
        tSamFreq[ 1]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        576
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
      bInterfaceNumber        5
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
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        288
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
      bInterfaceNumber        5
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
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x85  EP 5 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        192
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
      bInterfaceNumber        6
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              2 USB AudioSport Quattro (tm)
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           52
        bInCollection           2
        baInterfaceNr( 0)       7
        baInterfaceNr( 1)       8
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             7
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
        bTerminalID             8
        wTerminalType      0x0601 Analog Connector
        bAssocTerminal          0
        bSourceID               7
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0601 Analog Connector
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
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               3
        iTerminal               0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        7
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        7
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
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        88200
        tSamFreq[ 1]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        576
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
      bInterfaceNumber        7
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
        bTerminalLink           7
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        288
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
      bInterfaceNumber        7
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
        bTerminalLink           7
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x04  EP 4 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
        wMaxPacketSize        192
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
      bInterfaceNumber        8
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        8
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
        bTerminalLink           4
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            2 Discrete
        tSamFreq[ 0]        88200
        tSamFreq[ 1]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        576
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
      bInterfaceNumber        8
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
        bTerminalLink           4
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        288
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
      bInterfaceNumber        8
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
        bTerminalLink           4
        bDelay                  1 frames
        wFormatTag              1 PCM
      AudioControl Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        11025
        tSamFreq[ 1]        22050
        tSamFreq[ 2]        44100
        tSamFreq[ 3]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes           13
          Transfer Type            Isochronous
          Synch Type               Synchronous
        wMaxPacketSize        192
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
      bInterfaceNumber        9
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         32
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         32
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         32
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)

--------------090107090008070704040408
Content-Type: text/plain;
 name="descr.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="descr.txt"

M Audio USB AudioSport Quattro (tm)

00: 09 02 ce 03 0a 01 00 40 00 09 04 00 00 00 01 01
10: 00 02 0a 24 01 00 01 34 00 02 01 02 0c 24 02 05
20: 01 01 00 02 03 00 00 00 09 24 03 06 01 06 00 05
30: 00 0c 24 02 01 01 06 00 02 03 00 00 00 09 24 03
40: 02 01 01 00 01 00 09 04 01 00 00 01 02 00 00 09
50: 04 01 04 01 01 02 00 00 07 24 01 05 01 01 00 11
60: 24 02 01 02 02 10 03 11 2b 00 22 56 00 44 ac 00
70: 09 05 03 09 c0 00 01 00 00 07 25 01 01 00 00 00
80: 09 04 02 00 00 01 02 00 00 09 04 02 04 01 01 02
90: 00 00 07 24 01 02 01 01 00 11 24 02 01 02 02 10
a0: 03 11 2b 00 22 56 00 44 ac 00 09 05 85 0d c0 00
b0: 01 00 00 07 25 01 01 00 00 00 09 04 03 00 00 01
c0: 01 00 02 0a 24 01 00 01 34 00 02 04 05 0c 24 02
d0: 05 01 01 00 02 03 00 00 00 09 24 03 06 01 06 00
e0: 05 00 0c 24 02 01 01 06 00 02 03 00 00 00 09 24
f0: 03 02 01 01 00 01 00 09 04 04 00 00 01 02 00 00
100: 09 04 04 01 01 01 02 00 00 07 24 01 05 01 01 00
110: 0e 24 02 01 02 03 18 02 88 58 01 00 77 01 09 05
120: 03 09 40 02 01 00 00 07 25 01 01 00 00 00 09 04
130: 04 03 01 01 02 00 00 07 24 01 05 01 01 00 14 24
140: 02 01 02 03 18 04 11 2b 00 22 56 00 44 ac 00 80
150: bb 00 09 05 03 09 20 01 01 00 00 07 25 01 01 00
160: 00 00 09 04 04 04 01 01 02 00 00 07 24 01 05 01
170: 01 00 14 24 02 01 02 02 10 04 11 2b 00 22 56 00
180: 44 ac 00 80 bb 00 09 05 03 09 c0 00 01 00 00 07
190: 25 01 01 00 00 00 09 04 05 00 00 01 02 00 00 09
1a0: 04 05 01 01 01 02 00 00 07 24 01 02 01 01 00 0e
1b0: 24 02 01 02 03 18 02 88 58 01 00 77 01 09 05 85
1c0: 0d 40 02 01 00 00 07 25 01 01 00 00 00 09 04 05
1d0: 03 01 01 02 00 00 07 24 01 02 01 01 00 14 24 02
1e0: 01 02 03 18 04 11 2b 00 22 56 00 44 ac 00 80 bb
1f0: 00 09 05 85 0d 20 01 01 00 00 07 25 01 01 00 00
200: 00 09 04 05 04 01 01 02 00 00 07 24 01 02 01 01
210: 00 14 24 02 01 02 02 10 04 11 2b 00 22 56 00 44
220: ac 00 80 bb 00 09 05 85 0d c0 00 01 00 00 07 25
230: 01 01 00 00 00 09 04 06 00 00 01 01 00 02 0a 24
240: 01 00 01 34 00 02 07 08 0c 24 02 07 01 01 00 02
250: 03 00 00 00 09 24 03 08 01 06 00 07 00 0c 24 02
260: 03 01 06 00 02 03 00 00 00 09 24 03 04 01 01 00
270: 03 00 09 04 07 00 00 01 02 00 00 09 04 07 01 01
280: 01 02 00 00 07 24 01 07 01 01 00 0e 24 02 01 02
290: 03 18 02 88 58 01 00 77 01 09 05 04 09 40 02 01
2a0: 00 00 07 25 01 01 00 00 00 09 04 07 03 01 01 02
2b0: 00 00 07 24 01 07 01 01 00 14 24 02 01 02 03 18
2c0: 04 11 2b 00 22 56 00 44 ac 00 80 bb 00 09 05 04
2d0: 09 20 01 01 00 00 07 25 01 01 00 00 00 09 04 07
2e0: 04 01 01 02 00 00 07 24 01 07 01 01 00 14 24 02
2f0: 01 02 02 10 04 11 2b 00 22 56 00 44 ac 00 80 bb
300: 00 09 05 04 09 c0 00 01 00 00 07 25 01 01 00 00
310: 00 09 04 08 00 00 01 02 00 00 09 04 08 01 01 01
320: 02 00 00 07 24 01 04 01 01 00 0e 24 02 01 02 03
330: 18 02 88 58 01 00 77 01 09 05 86 0d 40 02 01 00
340: 00 07 25 01 01 00 00 00 09 04 08 03 01 01 02 00
350: 00 07 24 01 04 01 01 00 14 24 02 01 02 03 18 04
360: 11 2b 00 22 56 00 44 ac 00 80 bb 00 09 05 86 0d
370: 20 01 01 00 00 07 25 01 01 00 00 00 09 04 08 04
380: 01 01 02 00 00 07 24 01 04 01 01 00 14 24 02 01
390: 02 02 10 04 11 2b 00 22 56 00 44 ac 00 80 bb 00
3a0: 09 05 86 0d c0 00 01 00 00 07 25 01 01 00 00 00
3b0: 09 04 09 00 03 ff 00 00 00 07 05 81 03 20 00 01
3c0: 07 05 82 02 20 00 00 07 05 02 02 20 00 00 

--------------090107090008070704040408--


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
