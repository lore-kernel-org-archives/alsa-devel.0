From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: No CD mixer on Intel G35 (Asus P5E-V(M))
Date: Sun, 28 Feb 2010 20:31:28 +0100
Message-ID: <20100228193128.GA14556@darkside.12.kls.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0858569674055010589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from piggy.rz.tu-ilmenau.de (piggy.rz.tu-ilmenau.de [141.24.4.8])
	by alsa0.perex.cz (Postfix) with ESMTP id C0ED3103846
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 20:31:33 +0100 (CET)
Received: from gate.12.kls.lan (vpn1.rz.tu-ilmenau.de [141.24.172.1])
	by piggy.rz.tu-ilmenau.de (8.13.7/8.13.7/Debian-2) with ESMTP id
	o1SJVT7q025862
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 20:31:30 +0100
Received: from darkside.12.kls.lan (root@darkside.12.kls.lan
	[IPv6:2001:6f8:90c:12:21e:8cff:fecf:cfad])
	by gate.12.kls.lan (8.14.3/8.14.3) with ESMTP id o1SJVUsT007637
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 20:31:30 +0100
Received: from darkside.12.kls.lan (holbe@localhost [IPv6:::1])
	by darkside.12.kls.lan (8.14.3/8.14.3) with ESMTP id o1SJVTdk009264
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 20:31:29 +0100
Received: (from holbe@localhost)
	by darkside.12.kls.lan (8.14.3/8.14.3) id o1SJVSAx009262
	for alsa-devel@alsa-project.org; Sun, 28 Feb 2010 20:31:28 +0100
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


--===============0858569674055010589==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

on my Asus P5E-V HDMI and my Asus P5E-VM HDMI (both Intel G35) alsamixer
shows no CD mixer. Both boards have a CD audio connector and the
CD-drive connected to it.

holbe@darkside:/home/holbe% uname -a
Linux darkside 2.6.32-3-686-bigmem #1 SMP Thu Feb 25 06:54:30 UTC 2010 i686=
 GNU/Linux
holbe@darkside:/home/holbe% cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfe5f4000 irq 22
 1 [Bt878          ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xfdfff000, irq 16

alsamixer says:
Card: HDA Intel
Chip: Silicon Image SiI1392 HDMI

Same with 2.6.33.

On my P5Q-EM (Intel G45) the CD mixer appears in alsamixer.

I have no idea how to dig deeper in this, if you need more information,
please just tell me.


Thanks for your work & regards
   Mario
--=20
Do I contradict myself?
Very well, then I contradict myself, I am large, I contain multitudes.
                                                       -- Walt Whitman

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUBS4rEkBS+e2HeSPbpAQINYgf+LZ234u0TFx9KZW1m1EzL9vOyGojWpTuG
Kzpo/00/fw3Gb6LdPTdjsSti2YxSo5wLZCeiFjlD2LF3/Lz0by3WkRMndm+vfJfR
qNz7qkLdakThn/DAzwSSGa8X37fJVHRB9xzjoUdFJRdlr0icnUmEasBIw5rXr14k
gf/kWvfIw/5DxZRxgwNxsg7SXXS9P4tg4yQeUI1pO/GdW4ge11iotvRvNhx8meAS
/jTZZu+aU5dG/TZVM1yf36QjCS89CDzL8Wf1t/aoRQLNGqafCZC99LLfKtoxIwlo
Rh1zK2S3y0p5zJLnY4Hdl/wjgveiibtSJLSK784OeFzCD1x0UHDpmQ==
=7www
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--===============0858569674055010589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0858569674055010589==--
