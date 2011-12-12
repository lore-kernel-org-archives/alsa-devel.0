From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ASoC: Add missed MODULE_LICENSE("GPL") for
	imx-pcm-fiq
Date: Mon, 12 Dec 2011 09:53:34 +0100
Message-ID: <20111212085334.GA3485@pengutronix.de>
References: <1323676875.8204.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0689148733824710940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4EDAF24468
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 09:53:37 +0100 (CET)
In-Reply-To: <1323676875.8204.4.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0689148733824710940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2011 at 04:01:15PM +0800, Axel Lin wrote:
> This driver can be built as module and the file header indicates that
> the driver is published under the GPL.
> Thus add MODULE_LICENSE("GPL") for it.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

MODULE_AUTHOR and MODULE_DESCRIPTION should be added while we are
there (MODULE_ALIAS?)?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7lwQ4ACgkQD27XaX1/VRtanwCeOiV/qYjhfABhfxke0tDnBDpC
H2MAniz0QZgakHi0Vx2ghCtKunOmNhlx
=A0Yr
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--===============0689148733824710940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0689148733824710940==--
