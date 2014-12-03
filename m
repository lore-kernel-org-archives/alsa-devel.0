From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: mop500: Deletion of unnecessary checks before
 the function call "of_node_put"
Date: Wed, 3 Dec 2014 18:30:01 +0000
Message-ID: <20141203183001.GI7712@sirena.org.uk>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <547DEB6B.5000105@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LuKV14TtiCd0uvID"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547DEB6B.5000105@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org


--LuKV14TtiCd0uvID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 05:40:11PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Dec 2014 17:15:11 +0100
>=20
> The of_node_put() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.

This doesn't apply against current code, please check and resend.

--LuKV14TtiCd0uvID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf1aoAAoJECTWi3JdVIfQ2hIH/2Tk66vsqCXfOVroTBBU7WvP
zz1SsK64cg0LEaJ1+Z6KGFNtYmj99IgCMNksJkGlpMM/4wQv4cGeST+i8RI7rmbj
I2sw+o60fAxBc3FY0JvQvgKph6LJUCFPnBjJS00ggFiA4pUwqnFOKGyssxZuvKo8
MX1IitDnK7ybKT54X2t0Vma+tjaUGMUi6AkmfDfC0DLHjxeNiBqKc8ryrRBCYZkz
YDvozJjbWZ2pXIs6VZzwbQh1FX3ctzMll0sY7RO3607dycIf+u0tMy+JhWDmJpJk
neCymXy/KY8drs5mPrItfSqaUHZ7oHp2WUzPSFFKFw0EHMCMm29hgQasoqzvK6M=
=SIU2
-----END PGP SIGNATURE-----

--LuKV14TtiCd0uvID--
