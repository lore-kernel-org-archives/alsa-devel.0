From: louis@museresearch.com
Subject: Re: UAC2 clock selector for AudioBox 1818VSL
Date: Fri, 7 Sep 2012 10:58:43 -0700
Message-ID: <5ebef34ef0733756f5de571fa6068aa1.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20120907105843_90828"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.museresearch.com (master.museresearch.com [69.59.28.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 54154261981
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 19:58:47 +0200 (CEST)
Received: from localhost ([127.0.0.1]:40486 helo=master.museresearch.com)
 by master.museresearch.com with esmtpa (Exim 4.77)
 (envelope-from <louis@museresearch.com>) id 1TA2pH-0005UW-Pf
 for alsa-devel@alsa-project.org; Fri, 07 Sep 2012 10:58:43 -0700
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

------=_20120907105843_90828
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,
  Thanks for the quick reply. I am able to set the clock on my Mac, thoug=
h
I do need to do further tests and make sure that the sync is actually
reliable there. The setting is available from the built-in, standard OS X
audio setup application "Audio MIDI Setup".

There should be a S/PDIF clock signal going to the digital inputs on the
device. Some of the other controls such as per-channel mute also appear t=
o
work. I've also attached the lsusb output (attachment stripped for the
mailing list).

There are some other details that may be relevant, but I didn't want to
make my initial post too long/confusing because these extra details may
end up just being a red herring: Each mixer element name (as seen in
amixer) is prefixed with "AudioBox 1818 VSL Clock Selector" even if it is
not a clock selector. I am confident though that the control I've been
playing with is the clock selector because it lists the different clock
types as options. I also see this when I plug the device in or load the
ALSA driver:

ALSA sound/usb/mixer.c:342 cannot get ctl value: req =3D 0x83, wValue =3D
0x201, wIndex =3D 0xa00, type =3D 4
ALSA sound/usb/mixer.c:846 10:0: cannot get min/max values for control 2
(id 10)
ALSA sound/usb/mixer.c:342 cannot get ctl value: req =3D 0x83, wValue =3D
0x200, wIndex =3D 0xa00, type =3D 4
ALSA sound/usb/mixer.c:846 10:0: cannot get min/max values for control 2
(id 10)
ALSA sound/usb/mixer.c:342 cannot get ctl value: req =3D 0x83, wValue =3D
0x201, wIndex =3D 0xb00, type =3D 4
ALSA sound/usb/mixer.c:846 11:0: cannot get min/max values for control 2
(id 11)
ALSA sound/usb/mixer.c:342 cannot get ctl value: req =3D 0x83, wValue =3D
0x200, wIndex =3D 0xb00, type =3D 4
ALSA sound/usb/mixer.c:846 11:0: cannot get min/max values for control 2
(id 11)

Amixer reports the control at numid=3D2 to be a boolean, but because of t=
he
naming bug I can't see what the control really is. I'm assuming this isn'=
t
relevant, but I'm including it here anyway.

Louis

> On 06.09.2012 22:20, louis@museresearch.com wrote:
>> Hi!
>>   I'm attempting to get the "Clock Selector" mixer control to work wit=
h
>> the PreSonus AudioBox 1818VSL (a UAC2 device).
>>
>> The control shows up in amixer as an enumerated value, but I don't see=
m to
>> be able to set it (I've tried amixer, alsactl, and setting it
>> programmatically). The possible values are correct (listing Internal
Clock, S/PDIF Clock, and ADAT Clock as possible options); It just
doesn't
>> appear to take my setting, by which I mean amixer doesn't update the
settings, I still have the occasional click when the sampling rates
match
>> over S/PDIF and I attempt to use external sync. No error is returned.
>>
>> After digging around USB specs and ALSA's usb/mixer.c and being unfami=
liar
>> with both the USB audio spec and the inner workings of ALSA, I thought
it'd be best to ask the list about this: How would I check to see if
ALSA
>> is asking the device to change clock source at all?
>
> Hmm. A clock selector is handled like any other control entity on the
hardware. Some thoughts:
>
> - Are you able to control other settings like the volume?
>
> - It's fairly common for devices to not accept a new clock source
setting if they can't lock to the external source within some time. Did
you connect anything to the digital inputs?
>
> - Are you able to control that setting with the native Mac OS X driver?
(IOW, without installing a 3rd-party driver)
>
> Also, please send the output of "lsusb -v" for that device.
>
>
> Daniel
>


------=_20120907105843_90828
Content-Type: text/plain; name="lsusb_1818vsl.txt"
Content-Disposition: attachment; filename="lsusb_1818vsl.txt"
Content-Transfer-Encoding: quoted-printable


Bus 001 Device 006: ID 194f:0103 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x194f=20
  idProduct          0x0103=20
  bcdDevice            1.05
  iManufacturer           1 PreSonus
  iProduct                2 AudioBox 1818 VSL=20
  iSerial                 3 2209
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          615
    bNumInterfaces          6
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
      bFunctionClass          1 Audio
      bFunctionSubClass       0=20
      bFunctionProtocol      32=20
      iFunction               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32=20
      iInterface              2 AudioBox 1818 VSL=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               8
        wTotalLength          265
        bmControl            0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               41
        bmAttributes         0x03 Internal programmable Clock=20
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            9 AudioBox 1818 VSL Internal Clock
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               42
        bmAttributes         0x00 External Clock=20
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource           10 AudioBox 1818 VSL S/PDIF Clock
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               43
        bmAttributes         0x00 External Clock=20
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource           11 AudioBox 1818 VSL ADAT Clock
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bUnitID                40
        bNrInPins               3
        baCSourceID( 0)        41
        baCSourceID( 1)        42
        baCSourceID( 2)        43
        bmControls           0x03
          Clock Selector Control (read/write)
        iClockSelector          8 AudioBox 1818 VSL Clock Selector
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels            18
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          13 Line Out 1
        iTerminal               6 AudioBox 1818 VSL Audio 2.0 Output
      AudioControl Interface Descriptor:
        bLength                82
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
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
        bmaControls( 9)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(10)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(11)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(12)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(13)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(14)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(15)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(16)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(17)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(18)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0=20
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
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels            18
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          31 Mic/Inst 1
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                82
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                11
        bSourceID               1
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
        bmaControls( 9)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(10)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(11)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(12)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(13)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(14)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(15)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(16)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(17)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(18)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0=20
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
        iTerminal               7 AudioBox 1818 VSL Audio 2.0 Input
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
      bInterfaceProtocol     32=20
      iInterface              4 AudioBox 1818 VSL USB 2.0 Audio Out
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              4 AudioBox 1818 VSL USB 2.0 Audio Out
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            18
        bmChannelConfig   0x00000000
        iChannelNames          13 Line Out 1
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
      bInterfaceProtocol     32=20
      iInterface              4 AudioBox 1818 VSL USB 2.0 Audio Out
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            14
        bmChannelConfig   0x00000000
        iChannelNames          13 Line Out 1
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
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              5 AudioBox 1818 VSL USB 2.0 Audio In
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              5 AudioBox 1818 VSL USB 2.0 Audio In
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          22
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            18
        bmChannelConfig   0x00000000
        iChannelNames          31 Mic/Inst 1
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
      bInterfaceProtocol     32=20
      iInterface              5 AudioBox 1818 VSL USB 2.0 Audio In
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          22
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            14
        bmChannelConfig   0x00000000
        iChannelNames          31 Mic/Inst 1
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
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0=20
      iInterface              0=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength            9
        bInCollection           1
        baInterfaceNr( 0)       1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
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
        bJackID                 1
        iJack                   0=20
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0=20
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   0=20
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 4
        bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                   0=20
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       1
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0=20
      iInterface             12 AudioBox 1818 VSL DFU
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          615
    bNumInterfaces          6
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xc0
      Self Powered
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         3
      bFunctionClass          1 Audio
      bFunctionSubClass       0=20
      bFunctionProtocol      32=20
      iFunction               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32=20
      iInterface              2 AudioBox 1818 VSL=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        bCategory               8
        wTotalLength          265
        bmControl            0x00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               41
        bmAttributes         0x03 Internal programmable Clock=20
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource            9 AudioBox 1818 VSL Internal Clock
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               42
        bmAttributes         0x00 External Clock=20
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource           10 AudioBox 1818 VSL S/PDIF Clock
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (CLOCK_SOURCE)
        bClockID               43
        bmAttributes         0x00 External Clock=20
        bmControls           0x07
          Clock Frequency Control (read/write)
          Clock Validity Control (read-only)
        bAssocTerminal          0
        iClockSource           11 AudioBox 1818 VSL ADAT Clock
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype     11 (CLOCK_SELECTOR)
        bUnitID                40
        bNrInPins               3
        baCSourceID( 0)        41
        baCSourceID( 1)        42
        baCSourceID( 2)        43
        bmControls           0x03
          Clock Selector Control (read/write)
        iClockSelector          8 AudioBox 1818 VSL Clock Selector
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels            18
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          13 Line Out 1
        iTerminal               6 AudioBox 1818 VSL Audio 2.0 Output
      AudioControl Interface Descriptor:
        bLength                82
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
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
        bmaControls( 9)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(10)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(11)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(12)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(13)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(14)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(15)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(16)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(17)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(18)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0=20
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
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Microphone
        bAssocTerminal          0
        bCSourceID             40
        bNrChannels            18
        bmChannelConfig   0x00000000
        bmControls    0x0000
        iChannelNames          31 Mic/Inst 1
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                82
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                11
        bSourceID               1
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
        bmaControls( 9)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(10)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(11)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(12)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(13)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(14)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(15)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(16)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(17)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        bmaControls(18)      0x0000000f
          Mute Control (read/write)
          Volume Control (read/write)
        iFeature                0=20
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
        iTerminal               7 AudioBox 1818 VSL Audio 2.0 Input
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
      bInterfaceProtocol     32=20
      iInterface              4 AudioBox 1818 VSL USB 2.0 Audio Out
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              4 AudioBox 1818 VSL USB 2.0 Audio Out
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            18
        bmChannelConfig   0x00000000
        iChannelNames          13 Line Out 1
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
      bInterfaceProtocol     32=20
      iInterface              4 AudioBox 1818 VSL USB 2.0 Audio Out
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            14
        bmChannelConfig   0x00000000
        iChannelNames          13 Line Out 1
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
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              5 AudioBox 1818 VSL USB 2.0 Audio In
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              5 AudioBox 1818 VSL USB 2.0 Audio In
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          22
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            18
        bmChannelConfig   0x00000000
        iChannelNames          31 Mic/Inst 1
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
      bInterfaceProtocol     32=20
      iInterface              5 AudioBox 1818 VSL USB 2.0 Audio In
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink          22
        bmControls           0x00
        bFormatType             1
        bmFormats               1
          PCM
        bNrChannels            14
        bmChannelConfig   0x00000000
        iChannelNames          31 Mic/Inst 1
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
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0=20
      iInterface              0=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength            9
        bInCollection           1
        baInterfaceNr( 0)       1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 MIDI Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
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
        bJackID                 1
        iJack                   0=20
      MIDIStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (MIDI_IN_JACK)
        bJackType               2 External
        bJackID                 2
        iJack                   0=20
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               1 Embedded
        bJackID                 3
        bNrInputPins            1
        baSourceID( 0)          2
        BaSourcePin( 0)         1
        iJack                   0=20
      MIDIStreaming Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (MIDI_OUT_JACK)
        bJackType               2 External
        bJackID                 4
        bNrInputPins            1
        baSourceID( 0)          1
        BaSourcePin( 0)         1
        iJack                   0=20
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       1
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
        bRefresh                0
        bSynchAddress           0
        MIDIStreaming Endpoint Descriptor:
          bLength                 5
          bDescriptorType        37
          bDescriptorSubtype      1 (GENERAL)
          bNumEmbMIDIJack         1
          baAssocJackID( 0)       3
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        5
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0=20
      iInterface             12 AudioBox 1818 VSL DFU
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

------=_20120907105843_90828
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_20120907105843_90828--
