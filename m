From: Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [ALSA - driver 0000955]: CN-126 - USB 5.1 Audio
	adapter
Date: Thu, 03 Mar 2005 16:24:26 +0100
Message-ID: <1109863466.13335.6.camel@ghanima>
References: <Pine.HPX.4.33n.0503031232110.20007-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YPQEt6un+rmyOcwtDMzD"
In-Reply-To: <Pine.HPX.4.33n.0503031232110.20007-100000@studcom.urz.uni-halle.de>
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


--=-YPQEt6un+rmyOcwtDMzD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-03 at 12:35 +0100, Clemens Ladisch wrote:
> Fruhwirth Clemens wrote:
> > My USB audio class device doesn't show all mixer controls in ALSA.
> > For reference, for other users searching this archive, it's a "Creative
> > USB Sound Blaster Live! 24-bit External".
> > ...
> > I wonder why the snd_usb_create_mixer code does only loop over the
> > OUTPUT_TERMINAL class,
>=20
> Because all other units are (indirectly) connected to an output
> terminal.  We get them when we recursively inspect the respective
> source units.
>=20
> > My aim is to have controls available for the Line-in mixer, both for
> > recording and for direct re-mixing into the Main Out Plug.
>=20
> Your device probably doesn't have such controls.  What is the output
> of "lsusb -v" for it?

lsusb fails :/

Bus 003 Device 002: ID 041e:3040 Creative Technology, Ltd
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x041e Creative Technology, Ltd
  idProduct          0x3040
  bcdDevice            1.00
  iManufacturer           1 Creative Technology
  iProduct                2 SB Live! 24-bit External
  iSerial                 0
  bNumConfigurations      1
cannot get config descriptor 0, Connection timed out (110)
  Language IDs: (length=3D4)
     0409 English(US)

I wonder what's the cause. Has Creative delivered a non-standard
compliant device one more time? The original EMU10K1 was also FUBAR wrt
to the PCI standard.

The kernel log is full of

Mar  3 16:17:01 ghanima kernel: usb 3-1: usbfs: USBDEVFS_CONTROL failed cmd=
 lsusb rqt 128 rq 6 len 979 ret -110
Mar  3 16:17:01 ghanima kernel: usb 3-1: lsusb timed out on ep0in

The device is connected to an UHCI hosted bus.. Linus' bitkeeper doesn't
show any relevant bug fixes in this area in the last few month.. Hmm any
ideas?

--=20
http://clemens.endorphin.org, for robots sp4mtrap@endorphin.org

--=-YPQEt6un+rmyOcwtDMzD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJywqbjN8iSMYtrsRAo6hAJ98wKbwDe6B8i5HnkupqrhgBXsyIQCffZVL
Tn6k5MFVvx2DyrzRFQeRwiY=
=45aP
-----END PGP SIGNATURE-----

--=-YPQEt6un+rmyOcwtDMzD--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
