From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 04/10] ASoc: mxs: add asoc configuration
	files
Date: Wed, 13 Jul 2011 11:08:19 +0200
Message-ID: <20110713090819.GB1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-5-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0427738966650888342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C2B0810394A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 11:08:22 +0200 (CEST)
In-Reply-To: <1310483085-31442-5-git-send-email-b29396@freescale.com>
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


--===============0427738966650888342==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +if SND_MXS_SOC
> +
> +config SND_SOC_MXS_SGTL5000
> +	tristate "SoC Audio support for i.MX boards with sgtl5000"

depends on I2C

> +	select SND_SOC_SGTL5000
> +	help
> +	  Say Y if you want to add support for SoC audio on an MXS board with
> +	  a sgtl5000 codec.
> +
> +endif	# SND_MXS_SOC

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4dYIMACgkQD27XaX1/VRtnZwCgoEm5wSEIeeUnKVj7O5fDuVgv
xq8An2THFrlIDkViaiV8EnPWgN0VFv62
=beAj
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

--===============0427738966650888342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0427738966650888342==--
