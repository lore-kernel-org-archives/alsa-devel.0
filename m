From: Simon Wood <simon@mungewell.org>
Subject: snd-usb-audio: adding support for X-Box Wireless
	Communicator
Date: Thu, 28 Dec 2006 00:35:15 -0700
Message-ID: <20061228003515.4d13b77f.simon@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0837803784=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0837803784==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__28_Dec_2006_00_35_15_-0700_GbBlox9SUvGaBuvZ"

--Signature=_Thu__28_Dec_2006_00_35_15_-0700_GbBlox9SUvGaBuvZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,
I'm trying to get Alsa to recognise this device, which is actually a USB so=
und chip (UAC3640) coupled with a CSR BlueCore2 wireless link to the headse=
t. I believe (although might be misguided) that this should 'just work' onc=
e Alsa recognises the USB ID's.

I've added it's details to usbquirks.h, but Alsa still does not find it (no=
thing listed by arecord --list-devices). Where else do/might I need to chan=
ge?

The other 'interesting' point is that the deviceClass is '120', rather than=
 the more usual '1' (audio device). Again I believe that this is just Micro=
soft dicking around....

The device has been modified with a USB cable soldered on, there are detail=
s (and a lsusb -vvv) at http://www.qbik.ch/usb/devices/showdev.php?id=3D395=
2.

I am doing all this on (X)ubuntu 6.06. Thanks for any comments.
Simon.


The stuff I added to usbquirks.h reads:
---
{
        /*
         * SDW hack for X-Box Communicator
         */
        USB_DEVICE(0x045e, 0x0283),
        .driver_info =3D (unsigned long) & (const snd_usb_audio_quirk_t) {
                .vendor_name =3D "Microsoft Corp.",
                .product_name =3D "",
                .ifnum =3D QUIRK_ANY_INTERFACE,
                .type =3D QUIRK_COMPOSITE,
                .data =3D (const snd_usb_audio_quirk_t[]) {
                        {
                                .ifnum =3D 0,
                                .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum =3D 1,
                                .type =3D QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum =3D -1
                        }
                }
        }
},
---

--Signature=_Thu__28_Dec_2006_00_35_15_-0700_GbBlox9SUvGaBuvZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFk3O6wKmfLVdeh4MRAlC2AKCI2YpzQ14k86ipfQUwkX5CUxvTTgCfS0Dw
q0Q/KdjPKGGDcahJ5A0Cl9k=
=nBGT
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Dec_2006_00_35_15_-0700_GbBlox9SUvGaBuvZ--


--===============0837803784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0837803784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0837803784==--
