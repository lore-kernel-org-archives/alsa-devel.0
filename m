From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Tue, 14 Apr 2009 15:27:19 +0200
Message-ID: <1239715639.22047.0.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6118308105573680120=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C28F24355
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 15:27:51 +0200 (CEST)
In-Reply-To: <s5hocuz2xau.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6118308105573680120==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-3Tnr5oaHrJMcmDo/vkCI"


--=-3Tnr5oaHrJMcmDo/vkCI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> Could you run alsa-info.sh (with --no-upload option) before and after
> hibernate and attach the generated files to compare?

Sure, here's the diff:

--- before.txt	2009-04-14 15:20:29.145662920 +0200
+++ alsa-info.txt	2009-04-14 15:24:42.535653015 +0200
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.56
 !!################################
=20
-!!Script ran on: Tue Apr 14 13:20:28 UTC 2009
+!!Script ran on: Tue Apr 14 13:24:41 UTC 2009
=20
=20
 !!Linux Distribution
@@ -207,7 +207,7 @@
      0x02 0x0b
 Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
-  Amp-In vals:  [0x00 0x00] [0x00 0x00]
+  Amp-In vals:  [0x80 0x80] [0x00 0x00]
   Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
   Amp-Out vals:  [0x25 0x25]
   Connection: 2

johannes

--=-3Tnr5oaHrJMcmDo/vkCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5I80AAoJEKVg1VMiehFYSRUQALa1/ad2AdAE/zkATN4oh0dB
xrnS8jxw8OibCIEyuUcRlr2ykHjqUWlgJEYUso6laFPmltQPup16lfstYMeCcBU4
oqOm2+6aPfi2QEZsf0Aba5lHY35k1jxRLX8iwreodfEkfRWgscua3ghjPwYAkm33
SY/7UDvlDk0sDWA1mbCMi9kHoSaVLdCj/m1I/QBP0H9DcMFv4ESnnoMo+TPzULoG
Hqjleqg2w9qPEV7460IpUbJQ0HcYY0jSxa9Tq5CNlZ+JBdn+hPg/DMzqZVGYZqHb
IjOAaqVMGMU69jnsF9pzvN2Q/s+3RsAMN3EWPfGd1lF94J7XlHS/d7fPeMhBC1JO
KxJy821sN+K0qm0RrtZoO36+2lW6/rRnn15n2EWx4aUfNpLjHbyzPCUk1jj9DJU5
r0Dt5FbTFiGbSvILjYzGP0j5/ZGoy/GvtHemyDizQvkj8prUW6zPQ3mpJ34SNOPy
Sz7suyIExblvocyG9Ux5aYUoMDaMOXuRYzRQcAmOV3W/lEaqS6hk5/obZuvKLdZ3
LAYerStS/15WSPXhyT+0+Te/EW3Id28qCTVTThcFuYh4xajkvxtF0tHmYK1Jn6Ro
DovdIVIFj1ZGnMvAS6yUqagML5eFGKcfh3F8REa/zVDZWogfDU0147+mTTsCUWVd
UuhYBvbARutuenixo22P
=8BTG
-----END PGP SIGNATURE-----

--=-3Tnr5oaHrJMcmDo/vkCI--


--===============6118308105573680120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6118308105573680120==--
