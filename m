From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: Remove unnecessary
 suspend/resume bias level changes
Date: Wed, 3 Sep 2014 19:26:52 +0100
Message-ID: <20140903182652.GY29327@sirena.org.uk>
References: <1409689234-14774-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5079483570017663255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93F5426564B
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 20:27:08 +0200 (CEST)
In-Reply-To: <1409689234-14774-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============5079483570017663255==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkhOn4hPPRcnTymj"
Content-Disposition: inline


--FkhOn4hPPRcnTymj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 10:20:29PM +0200, Lars-Peter Clausen wrote:
> Hi,
>=20
> There are a handful of drivers which do set idle_bias_level =3D true, but=
 at the
> same time implement suspend and resume handlers which do bias level trans=
itions=20

Applied all, thanks.

--FkhOn4hPPRcnTymj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUB11oAAoJELSic+t+oim98NMQAIVoPXhXt/X9HjoMfnwjs7bq
xGsAGYecZZ/GdO26ZC7Nmrl3Yzvw5auKiaaOHcigsuzI0GjRoNztXygkyhjfjpvR
pfY8no6YJ4wmOlRnQINDMl+kSZXpFMkERVkAPPtU9N5Oo/uvBoJGP55XvmUIfjsM
a9rnKmsJOWsRwpvcFXzFkJ/BSH4W9CcqbW9zWWHxXDlnZfAcA+euv9VvlsBI9Kix
dz0Gt9yefgAlWO8FgzHHZkQapZymo1S6Ngob4YCcbhfP1ykwmoRSVXzkg40XiDwc
beaNTzyusumtMNTB9lVH3ij7Ho2zLJul1yhPXr4DZpkggbOR5PvsPN/jZZA0w8ui
WecCoz9pBaNyG3P5ucgTvgEKsLJTPA6f1iv+T9u5E7PeMXhBvm1TkLgHtvHSQCAZ
rlCwN8BfT0wxJXX1lTc37BVQRThy6BmSCX8zzR/uHSvOAWInRg6uSWsTFZH4Cpsh
pS+sXi9EgZpsgi8nlxXuaNZ0x4qW5+LdwVycO1FW25kZgfRzMlbSIXWv+7XMg66O
0UZijXps9g7e010y2ttWmQ4YuD/SSmYLgwE6f0rBUHoylfymZuaUhgHxPoAK/O1D
TXUp//tFX//P2jgBGRFVyY2YGUawOp2MpxPeaM+CZJInu3nZUBKnB5KMPiIgCUyw
qSCTmIK7kD4gBMT6x0h8
=hj3q
-----END PGP SIGNATURE-----

--FkhOn4hPPRcnTymj--

--===============5079483570017663255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5079483570017663255==--
