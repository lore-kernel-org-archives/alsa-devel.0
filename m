From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH 0/2] ALSA: ASoC for Au1000/1500/1100
Date: Thu, 21 Jul 2011 10:08:23 +0200
Message-ID: <1311235703.3538.6.camel@mattotaupa>
References: <1311231134-16437-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9214892858838063203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id F3F251038A4
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 10:08:26 +0200 (CEST)
Received: from f053034050.adsl.alicedsl.de ([78.53.34.50]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QjoJp-0001iB-10
	for alsa-devel@alsa-project.org; Thu, 21 Jul 2011 08:09:17 +0000
In-Reply-To: <1311231134-16437-1-git-send-email-manuel.lauss@googlemail.com>
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


--===============9214892858838063203==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pDHZmDIsQJc3h/gg67MV"


--=-pDHZmDIsQJc3h/gg67MV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Manuel,


Am Donnerstag, den 21.07.2011, 08:52 +0200 schrieb Manuel Lauss:

> These 2 patches implement ASoC drivers for the AC97 controller
> found on early Alchemy chips.  They are largely based on the
> old mips/au1x00.c driver which they replace.
>=20
> Tested on a Db1500 development board.
>=20
> Manuel Lauss (2):
>   ALSA: Alchemy AC97C audio support
>   ALSA: delete MIPS au1x00 driver

thank you for your patches. ALSA ASoC want to be CCed on patches. Please
resend your queue with Mark Brown and Liam Girdwood included in CC.

Additionally ASoC patches need to have =C2=BBASoC=C2=AB prepended in the pa=
tch
summary, i. e. the subject line.


Thanks,

Paul

--=-pDHZmDIsQJc3h/gg67MV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4n3nIACgkQPX1aK2wOHVhojACfYaL9lph/E7ZJl+D74rgzI3YC
K1QAoIZ/mnMY9jYOK5cFtdwqkGD08FEQ
=cTUu
-----END PGP SIGNATURE-----

--=-pDHZmDIsQJc3h/gg67MV--


--===============9214892858838063203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9214892858838063203==--
