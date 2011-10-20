From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ASoC: Set sgtl5000->ldo in ldo_regulator_register
Date: Thu, 20 Oct 2011 12:49:43 +0200
Message-ID: <20111020104943.GA2379@pengutronix.de>
References: <1319106779.8866.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319106779.8866.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Dong Aisheng <B29396@freescale.com>
List-Id: alsa-devel@alsa-project.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2011 at 06:32:59PM +0800, Axel Lin wrote:
> Otherwise calling ldo_regulator_remove() does not unregister regulator
> and free memories.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

BTW I think it is better to CC "Dong Aisheng <B29396@freescale.com>"
instead of Zeng Zhaoming; he was lately working with sgtl5000.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6f/McACgkQD27XaX1/VRvsJACgwyHXZQ5ZH8Ey1S+qG/DMSkwO
JIEAn0LTOghzpAy1Zio4k0ql7QizZ6EB
=qnpr
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
