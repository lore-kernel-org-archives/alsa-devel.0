From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Date: Sat, 29 Mar 2014 10:10:43 +0000
Message-ID: <20140329101043.GF21628@sirena.org.uk>
References: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 03:03:17PM +0000, Ben Dooks wrote:
> As with the previous commit, before a clock can be used it must be prepar=
ed
> for use. Change from clk_enable() and clk_disable() to the versions of the
> calls which also prepare and un-prepare the clocks.
>=20
> Will fix warnings from the clock code when this is used.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  sound/soc/sh/rcar/scu.c | 4 ++--

This doesn't apply against mainline, mainline doesn't have scu.c at all.

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNpwgAAoJELSic+t+oim9g7EP/jV5lNmQeW9wktstVX23pEsb
IqdYIJ/+v5vZrGCqjbIJloaQtDkwJP7kMWlG+pX+DBsioBZuNCNPDS5ZI+v0JP8o
/ky5WF6RpCJ2QE0q4zQ4TDG+dRuQYkqFDyjK1XS/HtxiKQVLFAMvuQxgMyA5e38s
Ik4iOxNI4M+vR1T6+NwftuQIz2QBgFBHl0JlPKtknglysY0+6XE6gm61MNmHPFEl
dnBATOjqn8TSfi+LKC81WgYKymyfoQfo46gqlhL0/kfHmphkscNmcHwvIdjfFAEq
ZbGJKcwDI4vrBwgEQkixbOASu+auABuApSUMKPxIXPtrZFUlDMpXIlh6UgHwTpT3
rozyG9botacPUSWGi60hpaYNWuU5IqensKS1r1i6RQahN0gTZWB8c0zxvfPwTvXY
AUgT4xwpEb7QfRh81duHLUSQ59PN7bd3rYJO2xMJSk4hVvAQb9jO9SwCVieWoEN/
0mFar+4sFzv4r3ab+T3vcWpsHmbPhj/91/bu6glJHH5FOusUJChveXpumCTorUsB
eyOJiR92YxRN5S8MBc3aimn/JZchDEVmrVEwPTDusiZkAr4SlHp1pCG/n5DO1QuP
KDBm5wsYiePrz/+chkJo+7ujz5PizsA57qZFS4pg87tu+UBtUQnYnpEZiQPRgbZd
oUc0KLkjqk5AqGyNyYdw
=eoh0
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
