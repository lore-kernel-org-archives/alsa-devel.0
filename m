From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 07/10] ARM: mxs: add sgtl5000 i2c device
Date: Wed, 13 Jul 2011 11:56:29 +0200
Message-ID: <20110713095629.GE1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310528167-25035-1-git-send-email-b29396@freescale.com>
	<20110713091314.GC1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6156608148810696404=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B528C2433F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 11:56:31 +0200 (CEST)
In-Reply-To: <20110713091314.GC1928@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6156608148810696404==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2011 at 11:13:14AM +0200, Wolfram Sang wrote:
> On Wed, Jul 13, 2011 at 11:36:07AM +0800, Dong Aisheng wrote:
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-mxs/mach-mx28evk.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
>=20
> Also needs in Kconfig:
>=20
> +       select MXS_HAVE_PLATFORM_MXS_I2C

#include <linux/i2c.h> for i2c_register_board_info() might be good,
too...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4da80ACgkQD27XaX1/VRt92gCghn1eSs4eLxOi2Beg14el7gI6
GlAAnA2EUZZxfpA8FO7MB/DPqzwuoAsH
=3rSp
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

--===============6156608148810696404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6156608148810696404==--
