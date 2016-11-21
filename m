From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: wm8580: Remove #if
	IS_ENABLED(CONFIG_I2C)
Date: Mon, 21 Nov 2016 19:26:08 +0000
Message-ID: <20161121192608.tzgj77gf7xigk2ms@sirena.org.uk>
References: <87d1hu7vz4.wl%kuninori.morimoto.gx@renesas.com>
 <878tsi7vv1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0286687861408360606=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66FD1266552
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 20:26:16 +0100 (CET)
In-Reply-To: <878tsi7vv1.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============0286687861408360606==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdc4c3q4k3beh2ci"
Content-Disposition: inline


--fdc4c3q4k3beh2ci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2016 at 01:13:18AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> wm8580 driver doesn't work without CONFIG_I2C anyway.
> Let's remove #if IS_ENABLED(CONFIG_I2C), and use module_i2c_driver().

This doesn't apply against current code, please check and resend.

--fdc4c3q4k3beh2ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYM0pQAAoJECTWi3JdVIfQGTQH/0Kt37+MdQixeBCgem2p9sXO
DapmZ/wl9/AKqhJhkY6EmriG5JG7DmeZ0tkzYZYKGNcGLvpnUzA7tJBRLozwMPi1
lhAgus8APs7ZgBuV65zwOUa3LQ6I+sJiHD+QjhD3mx0xvT+XaTbO5vhYsVGh/edd
oWmQ8He3mCWAAx7yOkAb02eRH05chZkmPMZPjuJEt21AywxAsdulwshV1UGtNgoT
1+2cj5VYRBRqQzP2wct7Llu8l53M+YHv/N9YTWYIwgThIXk2U88+3Ix+hj1VYSpZ
tYkj/iehChdcChP7Pggs66uqD2XxHxMwXbW4qr4dYU+zSQEMXTwWAxZhdneoo9g=
=PYWx
-----END PGP SIGNATURE-----

--fdc4c3q4k3beh2ci--

--===============0286687861408360606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0286687861408360606==--
