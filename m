From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: core: Add signed multi register
	control
Date: Mon, 23 Apr 2012 20:07:57 +0100
Message-ID: <20120423190757.GY8318@opensource.wolfsonmicro.com>
References: <1334914333-27335-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0813064882099580420=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2709D104359
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 21:08:02 +0200 (CEST)
In-Reply-To: <1334914333-27335-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0813064882099580420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R9baxdNnpTjJ7oIU"
Content-Disposition: inline


--R9baxdNnpTjJ7oIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2012 at 11:32:13AM +0200, Ola Lilja wrote:
> From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
>=20
> Added control type that can span multiple consecutive codec registers
> forming a single signed value in a MSB/LSB manner.

Applied, thanks - this is much cleaner!

--R9baxdNnpTjJ7oIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlag0AAoJEBus8iNuMP3dSz4QAI+OzXraL0lJz9MVtYBpc1qz
7mnDX0NK5er8487NQgIXdN/K8mvKJx3UV3cRWDKR5369WeI06h3EZJNk3JcD1YqZ
5p23PN3bOkoQEyVC0WYbksF/5ST2MusKo5/a/gR3R4dVIvj6tJ2fcUTf7YtV04rV
wk9GXlnY37I2DVHvRFRDKU3dCqEpfklkFBGYyIVc73wNmkqV7Z1EZJ7VpiVwR6qg
Vtemah1JX0bv86JdeDYb6ybtL8LedYE/muQCuB9BROU9zPZzKgmcTf7r6nH5J+tp
nzTtJXOSwAnvdPSlfrU9OsjARVka8iQyAM1BEqRnkFKaam63O3pClrFxteGtmWol
WX2L7ik/9SQCfdTgnZMz35UmK9kpYjtS+G7+q8wbT+CH5KyQQ51sYTWaUezqnelJ
nqveEBYMk6KD6t4V3YrJh5rjrOI5jusZZRkMHuFi6rnFwKhHbY0C8p+dyhhQvJBA
XlL6pFDHE6KTRFO2ce+q2CwZu9YUfNxluSD6BSYQxxOAS5OxlEY4KSvunvHiD2IU
sAV0fJXD3T6hPlXrtgPLxpj6wiXp4LLRIP+74dwZS34wZIj6n5Juz4ImxeYe6X0p
e+7kvJLvhLai4abulul3R8C2u54El2uR0DUZSgEysIVusw3di6ccrIkwrarBHDY/
uUfduRaleQDuHpoU7X5x
=MxdL
-----END PGP SIGNATURE-----

--R9baxdNnpTjJ7oIU--

--===============0813064882099580420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0813064882099580420==--
