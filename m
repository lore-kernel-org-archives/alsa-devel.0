From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 06/10] ARM: mxs: add saif device
Date: Fri, 15 Jul 2011 15:32:41 +0200
Message-ID: <20110715133241.GG2021@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-7-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5896656323746757950=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1B29D244A1
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 15:32:43 +0200 (CEST)
In-Reply-To: <1310483085-31442-7-git-send-email-b29396@freescale.com>
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


--===============5896656323746757950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

just noticed this one...

> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx=
28evk.c
> index eaaf6ff..7837a87 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -40,6 +40,8 @@
>  #define MX28EVK_MMC0_SLOT_POWER		MXS_GPIO_NR(3, 28)
>  #define MX28EVK_MMC1_SLOT_POWER		MXS_GPIO_NR(3, 29)
> =20
> +#define DIGCTRL_BASE_ADDR      MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
> +

Hmm, maybe define a function mx28_set_saif_clkmux(val)?

> +	mx28_add_saif(0);
> +	mx28_add_saif(1);
> +
> +	/*set the saif clk mux, both saif0/saif1 use saif0 clk*/
> +	__raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);

You might overwrite previous settings here. The hardcoded numbers need
defines, too.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4gQXkACgkQD27XaX1/VRveyACffFNERSmxsqQbWT9jIPAToB+n
Uh8AoLj8IFUv3FVSWkYYIaZPN7A7aHuY
=8HB/
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--

--===============5896656323746757950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5896656323746757950==--
