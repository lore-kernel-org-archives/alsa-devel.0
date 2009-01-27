From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 15:19:39 +0200
Message-ID: <200901271519.47119.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1506844119832079618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11]) by alsa0.perex.cz (Postfix) with ESMTP id CC7D524405
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 14:22:52 +0100 (CET)
Received: by ewy4 with SMTP id 4so3598170ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 05:22:52 -0800 (PST)
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

--===============1506844119832079618==
Content-Type: multipart/signed;
  boundary="nextPart3102245.HOGK9xLhcK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3102245.HOGK9xLhcK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I'm trying to develop asoc driver for hp ipaq rx1950 (s3c24xx + uda1380).

1st question: where I can enable/disable uda1380 codec power? I need to=20
control codec power for powersave reasons.

I tried to add custom power function call to uda1380_set_bias_level in=20
uda1380.c (pointer to power function is stored in codec->private_data), as =
it=20
done for uda134x codec, but after enable-disable-enable cycle (for example,=
=20
after resuming from suspend) driver cannot communicate with codec anymore=20
(i2c bus is always busy), only reloading i2c driver helps.

I suspect, power(0) is called in inappropriate moment, when i2c-transfer st=
ill=20
is not finished.

2nd question: for some reason, driver does not produce any sound during fir=
st=20
aplay invocation, only second and later aplay invocation driver produces=20
sound. What can be the reason of this problem?

Regards
Vasily

--nextPart3102245.HOGK9xLhcK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJfwnzRM6pQpltKE4RAvAhAKCsgATrI2yH+nTQ5GCtBRNotwdjgwCgr8/d
8hNd2UNDcfTamdzNqx5vxX8=
=Fxju
-----END PGP SIGNATURE-----

--nextPart3102245.HOGK9xLhcK--

--===============1506844119832079618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1506844119832079618==--
