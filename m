From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/1] mx31_3ds: Add sound support
Date: Tue, 15 May 2012 21:34:20 +0200
Message-ID: <20120515193420.GN30400@pengutronix.de>
References: <1337100146-16459-1-git-send-email-philippe.retornaz@epfl.ch>
	<1337100146-16459-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DA28210430A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 21:34:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1337100146-16459-2-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-15?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: torbenh@linutronix.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 15, 2012 at 06:42:26PM +0200, Philippe R=E9tornaz wrote:
> =

> Signed-off-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>
> ---
>  arch/arm/mach-imx/Kconfig         |    1 +
>  arch/arm/mach-imx/mach-mx31_3ds.c |   22 +++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletions(-)
> =


We have no changes queued so far for this board, so you can safely push
it via the ASoC tree along with the patches adding sound for the mc13783

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0d75480..472d47b 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -151,6 +151,7 @@ config MACH_MX25_3DS
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMXDI_RTC
>  	select IMX_HAVE_PLATFORM_IMX_I2C
> +	select IMX_HAVE_PLATFORM_IMX_SSI
>  	select IMX_HAVE_PLATFORM_IMX_FB
>  	select IMX_HAVE_PLATFORM_IMX_KEYPAD
>  	select IMX_HAVE_PLATFORM_IMX_UART
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-m=
x31_3ds.c
> index 4d1aab1..4eafdf2 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -156,6 +156,11 @@ static int mx31_3ds_pins[] =3D {
>  	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
>  	MX31_PIN_CSI_D5__GPIO3_5, /* CMOS PWDN */
>  	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_GPIO), /* CMOS reset */
> +	/* SSI */
> +	MX31_PIN_STXD4__STXD4,
> +	MX31_PIN_SRXD4__SRXD4,
> +	MX31_PIN_SCK4__SCK4,
> +	MX31_PIN_SFS4__SFS4,
>  };
>  =

>  /*
> @@ -488,12 +493,23 @@ static struct mc13xxx_regulator_init_data mx31_3ds_=
regulators[] =3D {
>  };
>  =

>  /* MC13783 */
> +static struct mc13xxx_codec_platform_data mx31_3ds_codec =3D {
> +	.dac_ssi_port =3D MC13783_SSI1_PORT,
> +	.adc_ssi_port =3D MC13783_SSI1_PORT,
> +};
> +
>  static struct mc13xxx_platform_data mc13783_pdata =3D {
>  	.regulators =3D {
>  		.regulators =3D mx31_3ds_regulators,
>  		.num_regulators =3D ARRAY_SIZE(mx31_3ds_regulators),
>  	},
> -	.flags  =3D MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC,
> +	.codec =3D &mx31_3ds_codec,
> +	.flags  =3D MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC | MC13XXX_USE_COD=
EC,
> +
> +};
> +
> +static struct imx_ssi_platform_data mx31_3ds_ssi_pdata =3D {
> +	.flags =3D IMX_SSI_DMA | IMX_SSI_NET,
>  };
>  =

>  /* SPI */
> @@ -741,6 +757,10 @@ static void __init mx31_3ds_init(void)
>  	}
>  =

>  	mx31_3ds_init_camera();
> +
> +	imx31_add_imx_ssi(0, &mx31_3ds_ssi_pdata);
> +
> +	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
>  }
>  =

>  static void __init mx31_3ds_timer_init(void)
> -- =

> 1.7.0.4
> =

> =


-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
