From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Hercules PC DJ Console (Windows Edition)
	information
Date: Wed, 28 Sep 2005 13:06:15 +0200
Message-ID: <20050928130615.efg7642rtdc0wccc@www3.webhosting.cx>
References: <2c746f620509271752528aa59a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620509271752528aa59a@mail.gmail.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Eric,

It looks like the Hercules only supports 48000Hz.

This is a well documented problem with USB devices that means they 
function best
at 48000Hz due to the packet size for the USB data stream. The windows and I
assume mac  drivers provide software level resampling so that the cards appear
to run at 44100Hz but that feature is not available for JACK and it appears
from my tests that the ALSA "plug"  plugin only works if the card has built in
44100Hz support anyway.

IMO USB audio and intel8x0 need a more advanced resampling plugin for 
ALSA. But
that's a different story.

FYI: I have an maudio quattro which I have only just been able to get to work
with all four ports at one time with JACK. The reason was my CPU was too slow
until now.

I use this commandline for JACK:

jackd -v -R -d alsa -d hw:0 -s -S -P -n3 -p 4096 -zt

Even then I can't do any recording via JACK because either JACK or my disks
don't like doing realtime r/w unless they are top priority in the interrupt
stack.

You may fair better as the Hercules is USB 2.0 compatible.


Cheers.


Quoting Eric Shattow <lucent@gmail.com>:

> Hello,
>
> I have a Hercules PC DJ Console (Windows Edition) that I would like to
> work with ALSA. The device outputs some sound at 48kHz after asoundrc
> configuration, but this is not easy to do or "correct"/functional with
> jackd. MIDI is not functional. I will include some information about
> the device.
>
> Note: This is a re-posting in ASCII format of an earilier HTML
> formatted email message.
>
> Output of lsusb:
>
> jnc@baker:~$ lsusb -vv -s$(lsusb | grep Guillemot | cut -d':' -f1 |
> awk '{print $2 ":" $4}')
> Bus 001 Device 007: ID 06f8:b000 Guillemot Corp.
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               1.10
>  bDeviceClass            0 (Defined at Interface level)
>  bDeviceSubClass         0
>  bDeviceProtocol         0
>  bMaxPacketSize0         8
>  idVendor           0x06f8 Guillemot Corp.
>  idProduct          0xb000
>  bcdDevice            1.00
>  iManufacturer           1
>  iProduct                2
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:
>    bLength                 9
>    bDescriptorType         2
>    wTotalLength          396
>    bNumInterfaces          9
>    bConfigurationValue     1
>    iConfiguration          0
>    bmAttributes         0x80
>    MaxPower              300mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      0
>      bInterfaceProtocol      0
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x07  EP 7 OUT
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0010  1x 16 bytes
>        bInterval               4
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass         3 Human Interface Devices
>      bInterfaceSubClass      0 No Subclass
>      bInterfaceProtocol      0 None
>      iInterface              0
>        HID Device Descriptor:
>          bLength                 9
>          bDescriptorType        33
>          bcdHID               1.10
>          bCountryCode           33 US
>          bNumDescriptors         1
>          bDescriptorType        34 Report
>          wDescriptorLength      95
>         Report Descriptors:
>           ** UNAVAILABLE **
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x83  EP 3 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0014  1x 20 bytes
>        bInterval              10
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        2
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass         3 Human Interface Devices
>      bInterfaceSubClass      0 No Subclass
>      bInterfaceProtocol      0 None
>      iInterface              0
>        HID Device Descriptor:
>          bLength                 9
>          bDescriptorType        33
>          bcdHID               1.10
>          bCountryCode           33 US
>          bNumDescriptors         1
>          bDescriptorType        34 Report
>          wDescriptorLength      56
>         Report Descriptors:
>           ** UNAVAILABLE **
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x84  EP 4 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0004  1x 4 bytes
>        bInterval              10
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        3
>      bAlternateSetting       0
>      bNumEndpoints           1
>      bInterfaceClass         3 Human Interface Devices
>      bInterfaceSubClass      0 No Subclass
>      bInterfaceProtocol      0 None
>      iInterface              0
>        HID Device Descriptor:
>          bLength                 9
>          bDescriptorType        33
>          bcdHID               1.10
>          bCountryCode           33 US
>          bNumDescriptors         1
>          bDescriptorType        34 Report
>          wDescriptorLength      41
>         Report Descriptors:
>           ** UNAVAILABLE **
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x85  EP 5 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0008  1x 8 bytes
>        bInterval              10
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        4
>      bAlternateSetting       0
>      bNumEndpoints           2
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      0
>      bInterfaceProtocol      0
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x06  EP 6 OUT
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0008  1x 8 bytes
>        bInterval               0
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x86  EP 6 IN
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0008  1x 8 bytes
>        bInterval               0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        5
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      0
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        5
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      0
>      bInterfaceProtocol      0
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x01  EP 1 OUT
>        bmAttributes            9
>          Transfer Type            Isochronous
>          Synch Type               Adaptive
>          Usage Type               Data
>        wMaxPacketSize     0x0240  1x 576 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        5
>      bAlternateSetting       2
>      bNumEndpoints           1
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      0
>      bInterfaceProtocol      0
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes           13
>          Transfer Type            Isochronous
>          Synch Type               Synchronous
>          Usage Type               Data
>        wMaxPacketSize     0x0120  1x 288 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        5
>      bAlternateSetting       3
>      bNumEndpoints           2
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      0
>      bInterfaceProtocol      0
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x01  EP 1 OUT
>        bmAttributes            9
>          Transfer Type            Isochronous
>          Synch Type               Adaptive
>          Usage Type               Data
>        wMaxPacketSize     0x0240  1x 576 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes           13
>          Transfer Type            Isochronous
>          Synch Type               Synchronous
>          Usage Type               Data
>        wMaxPacketSize     0x0120  1x 288 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        6
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      1 Control Device
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      1 (HEADER)
>        bcdADC               1.00
>        wTotalLength           88
>        bInCollection           2
>        baInterfaceNr( 0)       7
>        baInterfaceNr( 1)       8
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             5
>        wTerminalType      0x0101 USB Streaming
>        bAssocTerminal          0
>        bNrChannels             6
>        wChannelConfig     0x003f
>          Left Front (L)
>          Right Front (R)
>          Center Front (C)
>          Low Freqency Enhancement (LFE)
>          Left Surround (LS)
>          Right Surround (RS)
>        iChannelNames           0
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                14
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                 6
>        bSourceID               5
>        bControlSize            1
>        bmaControls( 0)      0x00
>        bmaControls( 1)      0x03
>          Mute
>          Volume
>        bmaControls( 2)      0x03
>          Mute
>          Volume
>        bmaControls( 3)      0x03
>          Mute
>          Volume
>        bmaControls( 4)      0x03
>          Mute
>          Volume
>        bmaControls( 5)      0x03
>          Mute
>          Volume
>        bmaControls( 6)      0x03
>          Mute
>          Volume
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>        bTerminalID             7
>        wTerminalType      0x0301 Speaker
>        bAssocTerminal          0
>        bSourceID               6
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      2 (INPUT_TERMINAL)
>        bTerminalID             1
>        wTerminalType      0x0603 Line Connector
>        bAssocTerminal          0
>        bNrChannels             2
>        wChannelConfig     0x0003
>          Left Front (L)
>          Right Front (R)
>        iChannelNames           0
>        iTerminal               0
>      AudioControl Interface Descriptor:
>        bLength                10
>        bDescriptorType        36
>        bDescriptorSubtype      6 (FEATURE_UNIT)
>        bUnitID                 2
>        bSourceID               1
>        bControlSize            1
>        bmaControls( 0)      0x80
>          Delay
>        bmaControls( 1)      0x00
>        bmaControls( 2)      0x00
>        iFeature                0
>      AudioControl Interface Descriptor:
>        bLength                12
>        bDescriptorType        36
>        bDescriptorSubtype      4 (MIXER_UNIT)
>        bUnitID                 3
>        bNrInPins               1
>        baSourceID( 0)          2
>        bNrChannels             2
>        wChannelConfig     0x0003
>          Left Front (L)
>          Right Front (R)
>        iChannelNames           0
>        bmControls         0x00
>        iMixer                  0
>      AudioControl Interface Descriptor:
>        bLength                 9
>        bDescriptorType        36
>        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>        bTerminalID             4
>        wTerminalType      0x0101 USB Streaming
>        bAssocTerminal          0
>        bSourceID               3
>        iTerminal               0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        7
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        7
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioStreaming Interface Descriptor:
>        bLength                 7
>        bDescriptorType        36
>        bDescriptorSubtype      1 (AS_GENERAL)
>        bTerminalLink           5
>        bDelay                  1 frames
>        wFormatTag              1 PCM
>      AudioStreaming Interface Descriptor:
>        bLength                11
>        bDescriptorType        36
>        bDescriptorSubtype      2 (FORMAT_TYPE)
>        bFormatType             1 (FORMAT_TYPE_I)
>        bNrChannels             6
>        bSubframeSize           2
>        bBitResolution         16
>        bSamFreqType            1 Discrete
>        tSamFreq[ 0]        48000
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x01  EP 1 OUT
>        bmAttributes            9
>          Transfer Type            Isochronous
>          Synch Type               Adaptive
>          Usage Type               Data
>        wMaxPacketSize     0x0240  1x 576 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>        AudioControl Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType        37
>          bDescriptorSubtype      1 (EP_GENERAL)
>          bmAttributes         0x01
>            Sampling Frequency
>          bLockDelayUnits         0 Undefined
>          wLockDelay              0 Undefined
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        8
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        8
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass         1 Audio
>      bInterfaceSubClass      2 Streaming
>      bInterfaceProtocol      0
>      iInterface              0
>      AudioStreaming Interface Descriptor:
>        bLength                 7
>        bDescriptorType        36
>        bDescriptorSubtype      1 (AS_GENERAL)
>        bTerminalLink           4
>        bDelay                  1 frames
>        wFormatTag              1 PCM
>      AudioStreaming Interface Descriptor:
>        bLength                11
>        bDescriptorType        36
>        bDescriptorSubtype      2 (FORMAT_TYPE)
>        bFormatType             1 (FORMAT_TYPE_I)
>        bNrChannels             2
>        bSubframeSize           2
>        bBitResolution         16
>        bSamFreqType            1 Discrete
>        tSamFreq[ 0]        48000
>      Endpoint Descriptor:
>        bLength                 9
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes           13
>          Transfer Type            Isochronous
>          Synch Type               Synchronous
>          Usage Type               Data
>        wMaxPacketSize     0x00c0  1x 192 bytes
>        bInterval               1
>        bRefresh                0
>        bSynchAddress           0
>        AudioControl Endpoint Descriptor:
>          bLength                 7
>          bDescriptorType        37
>          bDescriptorSubtype      1 (EP_GENERAL)
>          bmAttributes         0x01
>            Sampling Frequency
>          bLockDelayUnits         0 Undefined
>          wLockDelay              0 Undefined
>
> jnc@baker:~$ cat /proc/asound/cards
> 0 [CK8S           ]: NFORCE - NVidia CK8S
>                     NVidia CK8S with ALC655 at 0xe6001000, irq 19
> 1 [M8x8           ]: USB-Audio - MidiSport 8x8
>                     M-Audio MidiSport 8x8 at usb-0000:00:02.0-1, full speed
> 2 [Console        ]: USB-Audio - Hercules DJ Console
>                     Hercules Hercules DJ Console at
> usb-0000:00:02.0-3, full speed
> 3 [Keyboard       ]: USB-Audio - MK-461C USB MIDI Keyboard
>                     Evolution Electronics Ltd. MK-461C USB MIDI
> Keyboard at usb-0000:00:02.2-2.4, f
>
> jnc@baker:~$ amidi -l
> Device    Name
> hw:1,0,0  MidiSport 8x8 MIDI 1
> hw:1,0,1  MidiSport 8x8 MIDI 2
> hw:1,0,2  MidiSport 8x8 MIDI 3
> hw:1,0,3  MidiSport 8x8 MIDI 4
> hw:1,0,4  MidiSport 8x8 MIDI 5
> hw:1,0,5  MidiSport 8x8 MIDI 6
> hw:1,0,6  MidiSport 8x8 MIDI 7
> hw:1,0,7  MidiSport 8x8 MIDI 8
> hw:1,0,8  MidiSport 8x8 Control
> hw:3,0,0  MK-461C USB MIDI Keyboard MIDI
>
> jnc@baker:~$ amixer controls -c2
> numid=1,iface=MIXER,name='PCM Playback Switch'
> numid=2,iface=MIXER,name='PCM Playback Volume'
> numid=3,iface=MIXER,name='Delay Control'
>
> jnc@baker:~$ amixer scontrols -c2
> amixer: Mixer hw:2 load error: Invalid argument
>
> jnc@baker:~$ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.10rc1.
> Compiled on Sep 26 2005 for kernel 2.6.13.2-jnc2.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



--
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/ - The Linux Audio Users guide
Http://www.djcj.org/gigs - Gigs Guide Korea
========================================

Being on stage with the band in front of crowds shouting, "Get off! No!
We want normal music!", I think that was more like acting than anything
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
