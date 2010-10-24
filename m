From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: snd-hda-intel + ad198x is broken with 2.6.36
Date: Sun, 24 Oct 2010 20:45:45 +0300
Message-ID: <201010242045.49003.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3719487632569165782=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id D87EC24407
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Oct 2010 19:46:01 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1208197ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2010 10:45:59 -0700 (PDT)
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

--===============3719487632569165782==
Content-Type: multipart/signed;
  boundary="nextPart80501060.9CyhGNmyVn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart80501060.9CyhGNmyVn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

it seems something in 2.6.36 broke sound for snd-hda-intel with ad198x code=
cs=20
(reproducible with Lenovo 3000 N100 laptop, AD1986A codec and with HP Compa=
q=20
6910p, AD1981 codec). I have no problems with 2.6.35 kernel.

Sound works right after power on, but after reboot or even driver reload it=
=20
does not work until power cycle, of course controls are unmuted. Under "doe=
s=20
not work" I mean that aplay plays nothing, but gives no errors. What info=20
would be usefull to debug this issue?

Regards
Vasily

--nextPart80501060.9CyhGNmyVn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkzEcMwACgkQRM6pQpltKE4JYgCg4D4NJIcuQ36mJLQsO6pqJNar
swAAoNp62NAJRIsMJnD/V3/J17C/6nFJ
=AuK9
-----END PGP SIGNATURE-----

--nextPart80501060.9CyhGNmyVn--

--===============3719487632569165782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3719487632569165782==--
