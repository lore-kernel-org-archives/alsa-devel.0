From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v7 0/3] ARM: mxs: add recording support for
	saif
Date: Thu, 24 Nov 2011 08:49:38 +0100
Message-ID: <20111124074938.GA8439@pengutronix.de>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
	<20111124073605.GI17979@S2100-06.ap.freescale.net>
	<20111124074619.GJ17979@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6251882380389478446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B69BE10384C
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:49:43 +0100 (CET)
In-Reply-To: <20111124074619.GJ17979@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6251882380389478446==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2011 at 03:46:20PM +0800, Shawn Guo wrote:
> On Thu, Nov 24, 2011 at 03:36:05PM +0800, Shawn Guo wrote:
> > During the testing, the saif driver's dependency on
> > REGULATOR_FIXED_VOLTAGE was found.  I guess it should be resolved
> > in sound/soc/mxs/Kconfig rather than leaving it to users.
> >=20
> Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.

Please explain.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7N9xIACgkQD27XaX1/VRsPGgCdFVo1nTMJ8Kchn49BSwnR2hXn
Yd0AoJYx1t3z+wCtoi3rfFz3tb1HYxIb
=P+YX
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============6251882380389478446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6251882380389478446==--
