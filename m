From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 12:59:40 +0200
Message-ID: <20111020105940.GB2379@pengutronix.de>
References: <20111020122317.6c705289@archvile>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1163712188816474868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id BFE4A24740
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 12:59:42 +0200 (CEST)
In-Reply-To: <20111020122317.6c705289@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1163712188816474868==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

> I am writing a AC97 ASoC driver for the MPC5121e SoC from Freescale. This=
 SoC
> has almost the same PSC (Programmable Serial Controllers) as the MPC5200B=
, for
> which there already is an AC97 driver: sound/soc/fsl/mpc5200-ac97.c, so I=
'd
> like to extend that one to also support the MPC5121e.

Yes, this seems feasible. It has been done like this for the uart-driver, s=
adly
not for the spi-driver :(

> So obviously, it is supposed that the DMA driver
> somehow gets probed before the PSC driver, but I can't see where this is
> enforced. AFAIK, the order is fairly random, so it could be the other way

Check arch/powerpc/sysdev/bestcomm/bestcomm.c at the end:

/* If we're not a module, we must make sure everything is setup before  */
/* anyone tries to use us ... that's why we use subsys_initcall instead */
/* of module_init. */
subsys_initcall(mpc52xx_bcom_init);

while the mpc5121-driver has simply module_init() here. subsys_initcall() is
also often used for I2C host drivers to ensure client drivers can access th=
em
early.

> 1.- I can't test it on a MPC5200B, so therefor I need help.

I can do tests.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6f/xsACgkQD27XaX1/VRvbcgCgiWansJzOiWIdTl52TGf7DCDO
k9kAniSF1TT71jSvV+ktqFWP+euPCZOH
=6LmK
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============1163712188816474868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1163712188816474868==--
