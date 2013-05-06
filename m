From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 12/13] ASoC: fsl: imx-audmux: Let device
 core handle pinctrl
Date: Mon, 6 May 2013 23:08:22 +0100
Message-ID: <20130506220822.GK7478@sirena.org.uk>
References: <1367872748-9544-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4378261624866965943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 89BB1260866
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 00:08:27 +0200 (CEST)
In-Reply-To: <1367872748-9544-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4378261624866965943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 05:39:08PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Since commit ab78029 (drivers/pinctrl: grab default handles from device c=
ore),
> we can rely on device core for handling pinctrl.

Applied.  Please do remember that patch series numbers should only be
used when actually posting a patch series, they only serve to order
within the series.  Adding them at other times makes it look like
there's some dependencies that have been delayed.

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiCnTAAoJELSic+t+oim9MSgP/1rzK/fBBvR3P58as1nt7lUP
uvEUoCHHSgYUtd624VpVjA8wML2iy9GOnbJN/qv6m+DAibLdhmH7EPvYELY9gTyn
Ls4ojZKp4dhQd7o9xfdK2J+vMqwTdQnXgmMIMjSmAUYDgbHGHMPQ0Bx5X03GIgst
sPSuU5jRqQSD/IC77bD3RIHTb9I2awUwGdpx6wZAu8l1e7+3e17zO0PyjxGGMtZG
3N046sPbZ5Qly8dyl1fi9dQ28pFK0HRM6LtcDVhfUydzxwnA2MIyuGTWwMAFFgei
UfjM3grIolSk/FLOQP6st72GapmR59cNej+wvi4OL9ZkUriea7GyExykdRvUL3iT
rWei0xtE/90Ht4wpRYy/l9+PafnEVwU0bXja6dkzUXbxXdNLAH5fKZOk0wVfQltH
BkWxa2zfLCoeNmTgIBtGLo6/9L9R+1In9oTV99TyyG8XGyqb6kY0rUIvAYU/9+rc
tFS13rnPR1IjiWEg8Tih2UHZVWlovckEcG9H5fuL2sRKSbDC3LasDsMv1l3jLO0J
P4ird2Ey/Ju55dPhoAM36vNABvesmPvN9a+iPaJTgjBbZmg7vX4Q0pWQV6R6OhMz
8VC5S/nZr06zO5OVGnMeL77w1L4RK3tzqwZs2IypY4bmDl89l1CZXXmqVNg/qwiK
rnGPAcIq3a7TSsd4rqR9
=jW+l
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--

--===============4378261624866965943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4378261624866965943==--
