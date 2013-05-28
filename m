From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Do not read registers
 prior to turning on the supplies
Date: Tue, 28 May 2013 10:32:55 -0400
Message-ID: <20130528143255.GK3660@sirena.org.uk>
References: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6492301215001704625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5142610BA
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 16:33:11 +0200 (CEST)
In-Reply-To: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6492301215001704625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Content-Disposition: inline


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 11:04:18AM -0300, Fabio Estevam wrote:
> Commit b871f1ad (ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe()) pl=
aced
> the code for reading the codec revision prior to turning on the power sup=
plies.
>=20
> Even though this works on some systems that always have the codec power s=
upplies
> enabled, this is not correct, so revert this commit.

It seems like a better fix for this is to just enable the supplies while
doing the device identification?

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpMAUAAoJELSic+t+oim9nG4P/3YOsWRJWlMM6Eze/rK50YqF
IHI4hOyUwSqtvedVNDGI6+nZbTXClrc8ksChjwAyiAUaiRxJiYrlv1x3XhCKUUT9
+EySxijDnp6TyahyY2HhZi8wKsSoI0E3zDJ/5N5ZTvghGgl+SzqM7mF6BoKYtryO
niv2Vj3/uFbx4bbM8oyZsWBS5uSjuWYw0e4cj8IZv9xD3qqHdEv7RGCwEOtJzn4m
kmwBSuPy2dN1VIEYIyyex7FIzwTqI0x0vTHN+Dd/6yXF3v87sUtHgPMsTpoOHivI
h38Q7Jzn3zmYz/p9+xDfus6p2I2C6GoqwbcGu8DYgyZAwWzvUeKJYq9NUsKpbDjz
VPQrMDatslGqsTULBY5yH7fYP+gC4Rw0AMtDs0u7R6G5AdybY3jwxhPAoyt46v2r
H+CD8FdoWMxpgKMy2RixhWqZt6rNJULYhkNEmzd2hiqrBhAE1kQqYiYDRK4J7RmV
F9dsvHQgXmsd9Vi/u3YN6mkONCWKciZXCWIywQEQYcmSpjTA3/F88QuYVwDA5v4l
/ApYcsWqWcWD8o1H48LskP32+ihrc3fBKLG2ZSaR/WNRaMK7+DODRKtRNnmw2Xy5
1Z717sc28v3UDwqdtKRl3KijC+/iHIVlwdGaDW8SGRdbOuFV4Zxmo/PvWBPDFzVf
ckBbZDq1VvWzcu0bvyS/
=Xt6i
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--

--===============6492301215001704625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6492301215001704625==--
