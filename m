From: Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: SB Live 24 Ext (was: [ALSA - driver 0000955]:
	CN-126 - USB 5.1 Audio adapter)
Date: Fri, 04 Mar 2005 10:57:06 +0100
Message-ID: <1109930226.16108.11.camel@ghanima>
References: <Pine.HPX.4.33n.0503040923110.8579-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w2dHLOHsWk/znM+fLfYR"
In-Reply-To: <Pine.HPX.4.33n.0503040923110.8579-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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


--=-w2dHLOHsWk/znM+fLfYR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-04 at 09:31 +0100, Clemens Ladisch wrote:
> Fruhwirth Clemens wrote:
> > On Thu, 2005-03-03 at 12:35 +0100, Clemens Ladisch wrote:
> > > Your device probably doesn't have such controls.  What is the output
> > > of "lsusb -v" for it?
> >
> > lsusb fails :/
> >
> > Bus 003 Device 002: ID 041e:3040 Creative Technology, Ltd
> > Device Descriptor:
> > ...
> >   bNumConfigurations      1
> > cannot get config descriptor 0, Connection timed out (110)
>=20
> The kernel managed to read the descriptors, otherwise snd-usb-audio
> wouldn't have loaded.  You might try to install a newer version of
> usbutils.

I already did that (at least I thought) but obviously Gentoo hasn't
bumped the version from 0.11 to 0.70 yet.=20

Here is the lsusb (0.70) output. I removed the streaming interface
information, because this creative thing has a ton of them, full output
at http://clemens.endorphin.org/usblive-interfaces .

Bus 003 Device 002: ID 041e:3040 Creative Technology, Ltd=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x041e Creative Technology, Ltd
  idProduct          0x3040=20
  bcdDevice            1.00
  iManufacturer           1 Creative Technology
  iProduct                2 SB Live! 24-bit External
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          979
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0x80
    MaxPower              308mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0=20
      iInterface              0=20
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength           76
        bInCollection           2
        baInterfaceNr( 0)       1
        baInterfaceNr( 1)       2
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             6
        wChannelConfig     0x003f
          Left Front (L)
          Right Front (R)
          Center Front (C)
          Low Freqency Enhancement (LFE)
          Left Surround (LS)
          Right Surround (RS)
        iChannelNames           0=20
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                14
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 2
        bSourceID               1
        bControlSize            1
        bmaControls( 0)      0x03
          Mute
          Volume
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        bmaControls( 3)      0x00
        bmaControls( 4)      0x00
        bmaControls( 5)      0x00
        bmaControls( 6)      0x00
        iFeature                0=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0301 Speaker
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0603 Line Connector
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0=20
        iTerminal               0=20
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 5
        bSourceID               4
        bControlSize            1
        bmaControls( 0)      0x02
          Volume
        bmaControls( 1)      0x00
        bmaControls( 2)      0x00
        iFeature                0=20
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             6
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               5
        iTerminal               0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10

Obviously, the feature units are used for volume control solely. I
wonder, how the audio signal flow looks like..

> Well.  What is the output of "xxd -g1 /proc/bus/usb/003/002" (where
> 003 and 002 are the bus and device numbers)?

I presume lsusb has all the information, if not=20
http://clemens.endorphin.org/usb-desc-xxded

Thanks,
--=20
http://clemens.endorphin.org, for robots sp4mtrap@endorphin.org

--=-w2dHLOHsWk/znM+fLfYR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCKDDybjN8iSMYtrsRAgmwAJ4+lxBvchqccK2LpEsUIXkY76ArngCfWieO
gIt5ExRzZGl9IFgsmB15jm4=
=wwwP
-----END PGP SIGNATURE-----

--=-w2dHLOHsWk/znM+fLfYR--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
