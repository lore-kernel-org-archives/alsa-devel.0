From: "Demian Martin" <demianm_1-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: RE: Problem with USB Class 2 Audio Driver
Date: Mon, 6 Sep 2010 11:31:09 -0700
Message-ID: <003801cb4df1$ad160670$07421350$@com>
References: <20100823191209.GF17833@buzzloop.caiaq.de> <Pine.LNX.4.44L0.1008241050320.1652-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1008241050320.1652-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Content-Language: en-us
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Alan Stern' <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, 'Daniel Mack' <daniel-rDUAYElUppE@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "'J. Gordon Rankin'" <waudio-P3U7sUXGDiZeoWH0uzbU5w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Sorry for the slow response, the communications were trapped by Yahoo's=
 spam
filter. More details to follow.

=46irst, I switched to a more powerful platform (slightly) the Intel At=
om
D945GSEJT.
I have managed to get Win & to run on this and it allowed me to test th=
e
same hardware doing the same task (as much as Windows permits). I can u=
sing
adjacent USB ports boot Win & and play 192 KHz content through to the
Wavelink 192 KHz USB audio interface without problems. This suggests (b=
ut
isn't absolute proof) that the hardware is not a restriction.

Second, trying the suggestions below I noticed an error making this mor=
e
difficult. When connecting the Wavelink I see its accessible from ALSA:
auraliti-player:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 1: SPDIF [WaveLink HS SPDIF], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

But invisible to lsusb. Its device 009 below:
auraliti-player:~# lsusb
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 006: ID 413c:3012 Dell Computer Corp. Optical Wheel Mous=
e
Bus 002 Device 005: ID 413c:2006 Dell Computer Corp.
Bus 002 Device 004: ID 10d5:000d Uni Class Technology Co., Ltd
Bus 002 Device 003: ID 413c:1004 Dell Computer Corp.
Bus 002 Device 002: ID 058f:9254 Alcor Micro Corp. Hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 009: ID 21b4:0210
Bus 001 Device 003: ID 1307:0163 Transcend Information, Inc. 256MB/512M=
B/1GB
=46lash Drive
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Here is the message when its installed:
Sep  6 17:22:29 localhost vmunix: [ 1537.716042] usb 1-7: new high spee=
d USB
device using ehci_hcd and address 9
Sep  6 17:22:29 localhost vmunix: [ 1537.830436] usb 1-7: config 1 has =
an
invalid interface number: 3 but max is 2
Sep  6 17:22:29 localhost vmunix: [ 1537.830518] usb 1-7: config 1 has =
no
interface number 2
Sep  6 17:22:29 localhost vmunix: [ 1537.830804] usb 1-7: config 1 has =
an
invalid interface number: 3 but max is 2
Sep  6 17:22:29 localhost vmunix: [ 1537.830884] usb 1-7: config 1 has =
no
interface number 2
Sep  6 17:22:29 localhost vmunix: [ 1537.833069] usb 1-7: configuration=
 #1
chosen from 2 choices

 Here is the detailed output from lsusb -v -s 001:009 | tee usb.txt

Bus 001 Device 009: ID 21b4:0210 =20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x21b4=20
  idProduct          0x0210=20
  bcdDevice            1.51
  iManufacturer           1 Wavelength Audio, ltd.
  iProduct                2 WaveLink HS SPDIF
  iSerial                 3 (C) 2010 XMOS/Wavelength Audio
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          168
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0=20
      bFunctionProtocol      32=20
      iFunction               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32=20
      iInterface              7 WaveLink HS SPDIF
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        wTotalLength        31496
        bInCollection           0
        junk at descriptor end: 00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (unknown)
        Invalid desc subtype: 28 01 07 00 01
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels            40
        wChannelConfig     0x0302
          Right Front (R)
          Surround (S)
          Side Left (SL)
        iChannelNames           0=20
        iTerminal               0=20
        junk at descriptor end: 00 00 00 00 02
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bControlSize            0
        iFeature                0=20
        junk at descriptor end: 00 00 00 00 00 00 00 00 00 00 0f
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              10
        iTerminal              40 =CB=CC
        junk at descriptor end: 00 00 05
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              8 WaveLink HS SPDIF
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              9 WaveLink HS SPDIF
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bDelay                  0 frames
        wFormatTag            257 undefined
        junk at descriptor end: 00 00 00 02 03 00 00 00 00
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
      Warning: Descriptor too short
        bFormatType             1 (FORMAT_TYPE_I)
      Warning: Descriptor too short
        bNrChannels             4
        bSubframeSize          24
        bBitResolution          0
        bSamFreqType            0 Continuous
        tLowerSamFreq           0
        tUpperSamFreq       12544
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
          bLockDelayUnits         0 Undefined
          wLockDelay           2050 Undefined
        junk at descriptor end: 00
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
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0=20
      iInterface              0=20
      Device Firmware Upgrade Interface Descriptor:
        bLength                             7
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          168
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0=20
      bFunctionProtocol      32=20
      iFunction               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol     32=20
      iInterface              7 WaveLink HS SPDIF
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               2.00
        wTotalLength        31496
        bInCollection           0
        junk at descriptor end: 00
      AudioControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype     10 (unknown)
        Invalid desc subtype: 28 01 07 00 01
      AudioControl Interface Descriptor:
        bLength                17
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels            40
        wChannelConfig     0x0302
          Right Front (R)
          Surround (S)
          Side Left (SL)
        iChannelNames           0=20
        iTerminal               0=20
        junk at descriptor end: 00 00 00 00 02
      AudioControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                10
        bSourceID               2
        bControlSize            0
        iFeature                0=20
        junk at descriptor end: 00 00 00 00 00 00 00 00 00 00 0f
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID            20
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID              10
        iTerminal              40 =CB=CC
        junk at descriptor end: 00 00 05
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              8 WaveLink HS SPDIF
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol     32=20
      iInterface              9 WaveLink HS SPDIF
      AudioStreaming Interface Descriptor:
        bLength                16
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bDelay                  0 frames
        wFormatTag            257 undefined
        junk at descriptor end: 00 00 00 02 03 00 00 00 00
      AudioStreaming Interface Descriptor:
        bLength                 6
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
      Warning: Descriptor too short
        bFormatType             1 (FORMAT_TYPE_I)
      Warning: Descriptor too short
        bNrChannels             4
        bSubframeSize          24
        bBitResolution          0
        bSamFreqType            0 Continuous
        tLowerSamFreq           0
        tUpperSamFreq       12544
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
          bLockDelayUnits         0 Undefined
          wLockDelay           2050 Undefined
        junk at descriptor end: 00
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
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0=20
      iInterface              0=20
      Device Firmware Upgrade Interface Descriptor:
        bLength                             7
        bDescriptorType                    33
        bmAttributes                        7
          Will Not Detach
          Manifestation Tolerant
          Upload Supported
          Download Supported
        wDetachTimeout                    250 milliseconds
        wTransferSize                      64 bytes
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

I need to figure out how to install usbmon on this debian platform befo=
re I
can get a trace. I may be able to borrow a USB sniffer if that helps.
      -Demian

-----Original Message-----
=46rom: Alan Stern [mailto:stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org]=20
Sent: Tuesday, August 24, 2010 7:56 AM
To: Daniel Mack
Cc: Demian Martin; alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; 'J. Gordon Rankin';
linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: Problem with USB Class 2 Audio Driver

On Mon, 23 Aug 2010, Daniel Mack wrote:

> Hi,
>=20
> FWIW, I currently have no clue what could be the reason for this issu=
e.
> I copied the linux-usb mailing list, maybe anyone over there has an
> idea.
>=20
> Summary is: Demian is trying to play back an audio file over an USB
> connected soundcard, and the file itself is also stored on a media
> connected via USB. The transfer alone seems to be reasonably fast
> (tested with 'dd'), and the card itself also works fine (tested with =
a
> file stored on a different media), but the combination of them both
> fails. At least for high sample rates - iow, high data throughput.
>=20
> Could there be anything wrong with the isochronous bandwith reservati=
on?

I doubt it.  But we have seen reports of problems before from people=20
trying to do high-bandwidth transfers to multiple devices concurrently.

To start, let's see the "lsusb -v" output for the audio card and the
storage device, together with the dmesg log showing the two devices
being plugged in.

=46or tracking down the exact problem, it will help to have a usbmon
trace showing what happens during playback.  (Stop the playback after
the first underrun occurs.)  Instructions are in
Documentation/usb/usbmon.txt.

Alan Stern



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
