From: Luke Yelavich <luke@audioslack.com>
Subject: Re: MAYA44 USB audio device doesn't work with
  1.0.4.
Date: Sat, 22 May 2004 06:49:54 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <6.0.0.22.2.20040522064829.01dafe50@mail.audioslack.com>
References: <6.0.0.22.2.20040521233857.01e078e0@mail.audioslack.com>
 <Pine.HPX.4.33n.0405211759120.20016-100000@studcom.urz.uni-halle.de> <Pine.HPX.4.33n.0405211759120.20016-100000@studcom.urz.uni-
 halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405211759120.20016-100000@studcom.urz.uni-
 halle.de>
References: <6.0.0.22.2.20040521233857.01e078e0@mail.audioslack.com>
 <Pine.HPX.4.33n.0405211759120.20016-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok, lsusb -v is below.

WHen the unit is plugged in, it doesn't even appear in /proc/asound, 
although snd-usb-audio is loaded. I tried it with and without hotplug.

Luke

Bus 004 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000 Virtual
   idProduct          0x0000 Hub
   bcdDevice            2.06
   iManufacturer           3 Linux 2.6.6-ThinkPad uhci_hcd
   iProduct                2 Intel Corp. 82801DB USB (Hub #3)
   iSerial                 1 0000:00:1d.2
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
         wMaxPacketSize          2
         bInterval             255
   Language IDs: (length=4)
      0409 English(US)

Bus 003 Device 003: ID 0a92:0091
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0a92
   idProduct          0x0091
   bcdDevice            1.00
   iManufacturer           1 AUDIOTRAK
   iProduct                2 MAYA44 USB
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          295
     bNumInterfaces          4
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x00
     MaxPower              250mA
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
         wTotalLength          142
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
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 4
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
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             1
         wTerminalType      0x0603 Line Connector
         bAssocTerminal          9
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
         bmaControls( 0)      0x01
           Mute
         bmaControls( 0)      0x02
           Volume
         bmaControls( 0)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                15
         bDescriptorType        36
         bDescriptorSubtype      4 (MIXER_UNIT)
         bUnitID                 6
         bNrInPins               3
         baSourceID( 0)          5
         baSourceID( 1)          4
         baSourceID( 2)          2
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         bmControls         0x00
         iMixer                  0
         junk at descriptor end: 00
       AudioControl Interface Descriptor:
         bLength                10
         bDescriptorType        36
         bDescriptorSubtype      6 (FEATURE_UNIT)
         bUnitID                 7
         bSourceID               6
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 0)      0x02
           Volume
         bmaControls( 0)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         bTerminalID             8
         wTerminalType      0x0301 Speaker
         bAssocTerminal          0
         bSourceID               7
         iTerminal               0
       AudioControl Interface Descriptor:
         bLength                12
         bDescriptorType        36
         bDescriptorSubtype      2 (INPUT_TERMINAL)
         bTerminalID             9
         wTerminalType      0x0603 Line Connector
         bAssocTerminal          1
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
         bUnitID                10
         bSourceID               9
         bControlSize            1
         bmaControls( 0)      0x01
           Mute
         bmaControls( 0)      0x02
           Volume
         bmaControls( 0)      0x02
           Volume
         iFeature                0
       AudioControl Interface Descriptor:
         bLength                11
         bDescriptorType        36
         bDescriptorSubtype      4 (MIXER_UNIT)
       Warning: Descriptor too short
         bUnitID                11
         bNrInPins               1
         baSourceID( 0)         10
         bNrChannels             2
         wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         bmControls         0x00
         iMixer                  9
       AudioControl Interface Descriptor:
         bLength                 9
         bDescriptorType        36
         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
         bTerminalID            12
         wTerminalType      0x0101 USB Streaming
         bAssocTerminal          0
         bSourceID              11
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
         bNrChannels             4
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            9
           Transfer Type            Isochronous
           Synch Type               Adaptive
         wMaxPacketSize        384
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
       AudioControl Interface Descriptor:
         bLength                 7
         bDescriptorType        36
         bDescriptorSubtype      1 (AS_GENERAL)
         bTerminalLink          12
         bDelay                  1 frames
         wFormatTag              1 PCM
       AudioControl Interface Descriptor:
         bLength                14
         bDescriptorType        36
         bDescriptorSubtype      2 (FORMAT_TYPE)
         bFormatType             1 (FORMAT_TYPE_I)
         bNrChannels             4
         bSubframeSize           2
         bBitResolution         16
         bSamFreqType            2 Discrete
         tSamFreq[ 0]        44100
         tSamFreq[ 1]        48000
       Endpoint Descriptor:
         bLength                 9
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes           13
           Transfer Type            Isochronous
           Synch Type               Synchronous
         wMaxPacketSize        384
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
           wDescriptorLength      52
cannot get report descriptor
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          8
         bInterval              16
   Language IDs: (length=4)
      0409 English(US)

Bus 003 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000 Virtual
   idProduct          0x0000 Hub
   bcdDevice            2.06
   iManufacturer           3 Linux 2.6.6-ThinkPad uhci_hcd
   iProduct                2 Intel Corp. 82801DB USB (Hub #2)
   iSerial                 1 0000:00:1d.1
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
         wMaxPacketSize          2
         bInterval             255
   Language IDs: (length=4)
      0409 English(US)

Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000 Virtual
   idProduct          0x0000 Hub
   bcdDevice            2.06
   iManufacturer           3 Linux 2.6.6-ThinkPad uhci_hcd
   iProduct                2 Intel Corp. 82801DB USB (Hub #1)
   iSerial                 1 0000:00:1d.0
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
         wMaxPacketSize          2
         bInterval             255
   Language IDs: (length=4)
      0409 English(US)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         1
   bMaxPacketSize0         8
   idVendor           0x0000 Virtual
   idProduct          0x0000 Hub
   bcdDevice            2.06
   iManufacturer           3 Linux 2.6.6-ThinkPad ehci_hcd
   iProduct                2 Intel Corp. 82801DB USB2
   iSerial                 1 0000:00:1d.7
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
         wMaxPacketSize          2
         bInterval              12
   Language IDs: (length=4)
      0409 English(US)


At 01:59 AM 22/05/2004, Clemens Ladisch wrote:
>Luke Yelavich wrote:
> > As above. The vendor and product IDs given are 0xa92 and 0x91 respectively.
> >
> > If there is any more information I can give, please let me know.
>
>Output of "lsusb -v"?
>
>And what exactly does "doesn't work" mean?
>
>
>Regards,
>Clemens

--
Luke Yelavich
http://www.audioslack.com
luke@audioslack.com




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
