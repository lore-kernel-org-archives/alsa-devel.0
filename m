From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ASoC: Use SGTL5000_LINREG_VDDD_MASK
 instead of hardcoded mask value
Date: Thu, 20 Oct 2011 13:02:14 +0200
Message-ID: <20111020110214.GC2379@pengutronix.de>
References: <1319107769.8866.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0878172859756134052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1FAD224740
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 13:02:20 +0200 (CEST)
In-Reply-To: <1319107769.8866.3.camel@phoenix>
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
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0878172859756134052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2011 at 06:49:29PM +0800, Axel Lin wrote:
> We have defined SGTL5000_LINREG_VDDD_MASK in sgtl5000.h,
> use it instead of hardcoded (0x1 << 4) - 1 for the mask.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6f/7YACgkQD27XaX1/VRujkQCgvbBT+W0D/cvxeU1/RwizmSRl
TN4AniW36F+60OJpzwudfi4Q0q56H6+J
=A16E
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

--===============0878172859756134052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0878172859756134052==--
