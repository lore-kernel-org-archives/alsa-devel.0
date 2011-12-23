From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/8] ASoC: imx: Add .owner to struct
 snd_soc_card
Date: Fri, 23 Dec 2011 08:39:23 +0100
Message-ID: <20111223073923.GA5090@pengutronix.de>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2100604954540388637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 70B93103EEF
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 08:39:28 +0100 (CET)
In-Reply-To: <1324622828.2295.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2100604954540388637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2011 at 02:47:08PM +0800, Axel Lin wrote:
> Add missing .owner of struct snd_soc_card. This prevents the module from =
being
> removed from underneath its users.
>=20
> Reported-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk70MCsACgkQD27XaX1/VRv7rwCgskmGbdXjt2+6qLpLRBkeWSNX
peAAoKCBtOVu8jrf8OwHALgMjhCZhm6R
=UbD/
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--===============2100604954540388637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2100604954540388637==--
