From: Jeremy Nickurak <alsa-devel@atrus.rifetech.com>
Subject: Re: Altec Lansing FX5051 USB Speakers
Date: Sat, 15 Dec 2007 21:41:49 -0700
Message-ID: <20071216044149.GB26429@rifetech.com>
References: <20071113044912.GA12116@rifetech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4579545690707218804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spunkymail-a2.g.dreamhost.com (sd-green-bigip-83.dreamhost.com
	[208.97.132.83]) by alsa0.perex.cz (Postfix) with ESMTP id 7EF542474E
	for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2007 05:41:50 +0100 (CET)
Received: from kedri (d199-126-18-109.abhsia.telus.net [199.126.18.109])
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id A514A870EB
	for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2007 20:41:47 -0800 (PST)
Received: from atrus by kedri with local (Exim 4.67)
	(envelope-from <atrus@rifetech.com>) id 1J3lK1-0006tY-3q
	for alsa-devel@alsa-project.org; Sat, 15 Dec 2007 21:41:49 -0700
In-Reply-To: <20071113044912.GA12116@rifetech.com>
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


--===============4579545690707218804==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Any suggestions at all? I love this system's sound in windows, and I=20
really don't want to have to try to sell it to a non-linux user.

On Mon, Nov 12, 2007 at 09:49:12PM -0700, Jeremy Nickurak wrote:
> Some number of months ago I posted a request here for any suggestions in=
=20
> getting a set of USB speakers from Altec Lansing, model# FX5051, working=
=20
> with ALSA. I wasn't able to follow up in detail at the time, so I'm=20
> hoping try again.
>=20
> They're a set of 5.1 speakers with a built in USB sound card. Sound does=
=20
> appear to work, but the mixer is locked at 100%. There is no analog=20
> manual mixer, and the digital control dial exhibits the same problem as=
=20
> alsamixer, so I have to find a way to adjust the usb device's mixer=20
> volume in order to make the speakers usable.
>=20
> The speakers work fine in Windows XP, without installing any drivers, so=
=20
> it would seem that this device is operating based on some standard.
>=20
> In windows, adjusting the mixer via the digital control dial, or via the=
=20
> windows mixer control both result in the LED display moving in sync to=20
> indicate the new volume setting.
>=20
> In alsa, adjusting the digital control dial doesn't appear to have any=20
> effect, other then waking the LED display from its low-light mode.=20
> Attempting to adjust volume from alsamixer likewise wakes the display=20
> from low-light mode, but also fails to significantly change the mixer=20
> setting.  When I say significantly, I mean that the mixer flips between=
=20
> about 98% and 100%, when using the Up/Down keys (or PgUp or PgDown). End=
=20
> appears to drop the volume to 0%, but Home doesn't restore it.
>=20
> Pressing the device's 'Power' button also behaves strangely. I can turn=
=20
> the device off, but it is turned back on shortly afterward. No usb=20
> connect/disconnect events appear here, instead, the power button seems=20
> to function more like a mute.
>=20
> amixer -c 2 contents yields:
>=20
> atrus@kedri:~$ amixer -c 2 contents
> numid=3D3,iface=3DMIXER,name=3D'Tone Control - Bass'
>   ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D0,max=3D10,step=3D0
>   : values=3D1
> numid=3D4,iface=3DMIXER,name=3D'Tone Control - Treble'
>   ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D0,max=3D10,step=3D0
>   : values=3D3
> numid=3D1,iface=3DMIXER,name=3D'PCM Playback Switch'
>   ; type=3DBOOLEAN,access=3Drw------,values=3D1
>   : values=3Don
> numid=3D2,iface=3DMIXER,name=3D'PCM Playback Volume'
>   ; type=3DINTEGER,access=3Drw---R--,values=3D2,min=3D0,max=3D49,step=3D0
>   : values=3D48,48
>   | dBscale-min=3D-49.00dB,step=3D1.00dB,mute=3D0
>=20
>=20
>=20
> I'm attaching the contents of 'lsusb -v'.
>=20
> Any suggestions would be appreciated, and any requests for further=20
> information about this device will be accomodated ASAP.
>=20
> Thanks in advance.
>=20
> --
> Jeremy Nickurak -=3D Email/Jabber: atrus@rifetech.com =3D-

> Bus 004 Device 002: ID 04d2:5051 Altec Lansing Technologies=20
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0=20
>   bDeviceProtocol         0=20
>   bMaxPacketSize0        16
>   idVendor           0x04d2 Altec Lansing Technologies
>   idProduct          0x5051=20
>   bcdDevice            1.12
>   iManufacturer           1 Altec Lansing Technologies, Inc.
>   iProduct                2 Altec Lansing - FX5051
>   iSerial                 0=20
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          139
>     bNumInterfaces          3
>     bConfigurationValue     1
>     iConfiguration          0=20
>     bmAttributes         0x40
>       (Missing must-be-set bit!)
>       Self Powered
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      1 Control Device
>       bInterfaceProtocol      0=20
>       iInterface              0=20
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      1 (HEADER)
>         bcdADC               1.00
>         wTotalLength           44
>         bInCollection           1
>         baInterfaceNr( 0)       1
>       AudioControl Interface Descriptor:
>         bLength                12
>         bDescriptorType        36
>         bDescriptorSubtype      2 (INPUT_TERMINAL)
>         bTerminalID             1
>         wTerminalType      0x0101 USB Streaming
>         bAssocTerminal          0
>         bNrChannels             6
>         wChannelConfig     0x003f
>           Left Front (L)
>           Right Front (R)
>           Center Front (C)
>           Low Freqency Enhancement (LFE)
>           Left Surround (LS)
>           Right Surround (RS)
>         iChannelNames           0=20
>         iTerminal               0=20
>       AudioControl Interface Descriptor:
>         bLength                14
>         bDescriptorType        36
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 2
>         bSourceID               1
>         bControlSize            1
>         bmaControls( 0)      0x15
>           Mute
>           Bass
>           Treble
>         bmaControls( 1)      0x02
>           Volume
>         bmaControls( 2)      0x02
>           Volume
>         bmaControls( 3)      0x00
>         bmaControls( 4)      0x00
>         bmaControls( 5)      0x00
>         bmaControls( 6)      0x00
>         iFeature                0=20
>       AudioControl Interface Descriptor:
>         bLength                 9
>         bDescriptorType        36
>         bDescriptorSubtype      3 (OUTPUT_TERMINAL)
>         bTerminalID             3
>         wTerminalType      0x0301 Speaker
>         bAssocTerminal          0
>         bSourceID               2
>         iTerminal               0=20
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0=20
>       iInterface              0=20
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       1
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      0=20
>       iInterface              0=20
>       AudioStreaming Interface Descriptor:
>         bLength                 7
>         bDescriptorType        36
>         bDescriptorSubtype      1 (AS_GENERAL)
>         bTerminalLink           1
>         bDelay                  1 frames
>         wFormatTag              1 PCM
>       AudioStreaming Interface Descriptor:
>         bLength                11
>         bDescriptorType        36
>         bDescriptorSubtype      2 (FORMAT_TYPE)
>         bFormatType             1 (FORMAT_TYPE_I)
>         bNrChannels             6
>         bSubframeSize           2
>         bBitResolution         16
>         bSamFreqType            1 Discrete
>         tSamFreq[ 0]        48000
>       Endpoint Descriptor:
>         bLength                 9
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            9
>           Transfer Type            Isochronous
>           Synch Type               Adaptive
>           Usage Type               Data
>         wMaxPacketSize     0x0240  1x 576 bytes
>         bInterval               1
>         bRefresh                0
>         bSynchAddress           0
>         AudioControl Endpoint Descriptor:
>           bLength                 7
>           bDescriptorType        37
>           bDescriptorSubtype      1 (EP_GENERAL)
>           bmAttributes         0x01
>             Sampling Frequency
>           bLockDelayUnits         0 Undefined
>           wLockDelay              0 Undefined
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Devices
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0=20
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     172
>           Report Descriptor: (length is 172)
>             Item(Global): Usage Page, data=3D [ 0x0c ] 12
>                             Consumer
>             Item(Local ): Usage, data=3D [ 0x01 ] 1
>                             Consumer Control
>             Item(Main  ): Collection, data=3D [ 0x01 ] 1
>                             Application
>             Item(Global): Usage Page, data=3D [ 0x0c ] 12
>                             Consumer
>             Item(Local ): Usage, data=3D [ 0xe2 ] 226
>                             Mute
>             Item(Local ): Usage, data=3D [ 0xe9 ] 233
>                             Volume Increment
>             Item(Local ): Usage, data=3D [ 0xea ] 234
>                             Volume Decrement
>             Item(Local ): Usage, data=3D [ 0x52 0x01 ] 338
>                             Bass Increment
>             Item(Local ): Usage, data=3D [ 0x53 0x01 ] 339
>                             Bass Decrement
>             Item(Local ): Usage, data=3D [ 0x54 0x01 ] 340
>                             Treble Increment
>             Item(Local ): Usage, data=3D [ 0x55 0x01 ] 341
>                             Treble Decrement
>             Item(Local ): Usage, data=3D [ 0x00 ] 0
>                             Unassigned
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
>             Item(Global): Report Size, data=3D [ 0x01 ] 1
>             Item(Global): Report Count, data=3D [ 0x08 ] 8
>             Item(Main  ): Input, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Global): Usage Page, data=3D [ 0x00 0xff ] 65280
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x01 ] 1
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x3a ] 58
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x2e ] 46
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x09 ] 9
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x0a ] 10
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x3d ] 61
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x3e ] 62
>                             (null)
>             Item(Local ): Usage, data=3D [ 0xff ] 255
>                             (null)
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
>             Item(Global): Report Size, data=3D [ 0x01 ] 1
>             Item(Global): Report Count, data=3D [ 0x08 ] 8
>             Item(Main  ): Input, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Global): Usage Page, data=3D [ 0x0c ] 12
>                             Consumer
>             Item(Local ): Usage, data=3D [ 0xe2 ] 226
>                             Mute
>             Item(Local ): Usage, data=3D [ 0xe9 ] 233
>                             Volume Increment
>             Item(Local ): Usage, data=3D [ 0xea ] 234
>                             Volume Decrement
>             Item(Local ): Usage, data=3D [ 0x52 0x01 ] 338
>                             Bass Increment
>             Item(Local ): Usage, data=3D [ 0x53 0x01 ] 339
>                             Bass Decrement
>             Item(Local ): Usage, data=3D [ 0x54 0x01 ] 340
>                             Treble Increment
>             Item(Local ): Usage, data=3D [ 0x55 0x01 ] 341
>                             Treble Decrement
>             Item(Local ): Usage, data=3D [ 0x00 ] 0
>                             Unassigned
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
>             Item(Global): Report Size, data=3D [ 0x01 ] 1
>             Item(Global): Report Count, data=3D [ 0x08 ] 8
>             Item(Main  ): Output, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Global): Usage Page, data=3D [ 0x00 0xff ] 65280
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x01 ] 1
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x3a ] 58
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x09 ] 9
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x0a ] 10
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x3d ] 61
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x3e ] 62
>                             (null)
>             Item(Local ): Usage, data=3D [ 0xfe ] 254
>                             (null)
>             Item(Local ): Usage, data=3D [ 0x00 ] 0
>                             (null)
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0x01 ] 1
>             Item(Global): Report Size, data=3D [ 0x01 ] 1
>             Item(Global): Report Count, data=3D [ 0x08 ] 8
>             Item(Main  ): Output, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Local ): Usage, data=3D [ 0xf0 ] 240
>                             (null)
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0xff 0xff ] 65535
>             Item(Global): Report Size, data=3D [ 0x10 ] 16
>             Item(Global): Report Count, data=3D [ 0x01 ] 1
>             Item(Main  ): Output, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Local ): Usage, data=3D [ 0xf1 ] 241
>                             (null)
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0xff 0xff 0xff 0xff =
] -1
>             Item(Global): Report Size, data=3D [ 0x20 ] 32
>             Item(Global): Report Count, data=3D [ 0x01 ] 1
>             Item(Main  ): Output, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Local ): Usage, data=3D [ 0xf2 ] 242
>                             (null)
>             Item(Global): Logical Minimum, data=3D [ 0x00 ] 0
>             Item(Global): Logical Maximum, data=3D [ 0xff 0xff 0xff 0xff =
] -1
>             Item(Global): Report Size, data=3D [ 0x20 ] 32
>             Item(Global): Report Count, data=3D [ 0x01 ] 1
>             Item(Main  ): Output, data=3D [ 0x82 ] 130
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position Volatile Bit=
field
>             Item(Main  ): End Collection, data=3Dnone
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0002  1x 2 bytes
>         bInterval               1
> Device Status:     0x0001
>   Self Powered
>=20
> Bus 004 Device 001: ID 0000:0000 =20
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass            9 Hub
>   bDeviceSubClass         0 Unused
>   bDeviceProtocol         0 Full speed hub
>   bMaxPacketSize0        64
>   idVendor           0x0000=20
>   idProduct          0x0000=20
>   bcdDevice            2.06
>   iManufacturer           3 Linux 2.6.22-14-generic uhci_hcd
>   iProduct                2 UHCI Host Controller
>   iSerial                 1 0000:00:1d.3
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           25
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0=20
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower                0mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         9 Hub
>       bInterfaceSubClass      0 Unused
>       bInterfaceProtocol      0 Full speed hub
>       iInterface              0=20
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0002  1x 2 bytes
>         bInterval             255
> Hub Descriptor:
>   bLength               9
>   bDescriptorType      41
>   nNbrPorts             2
>   wHubCharacteristic 0x000a
>     No power switching (usb 1.0)
>     Per-port overcurrent protection
>   bPwrOn2PwrGood        1 * 2 milli seconds
>   bHubContrCurrent      0 milli Ampere
>   DeviceRemovable    0x00
>   PortPwrCtrlMask    0xff
>  Hub Port Status:
>    Port 1: 0000.0103 power enable connect
>    Port 2: 0000.0100 power
> Device Status:     0x0003
>   Self Powered
>   Remote Wakeup Enabled




> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--=20
Jeremy Nickurak -=3D Email/Jabber: atrus@rifetech.com =3D-

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZKyNtjFmtbiy5uYRAq6uAJoDtu28T73oK7+Bk+MyCO6jXXjqzQCcDPpn
PQp2lIaJJdD7kw+YNouoYn8=
=GqkG
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============4579545690707218804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4579545690707218804==--
