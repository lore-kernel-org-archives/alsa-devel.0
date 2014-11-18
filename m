From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] mfd: arizona: add support for WM8280/WM8281
Date: Tue, 18 Nov 2014 15:41:02 +0000
Message-ID: <20141118154102.GA13959@x1>
References: <1415901046-3391-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1415901046-3391-2-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415901046-3391-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tiwai@suse.de, perex@perex.cz, sameo@linux.intel.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Nov 2014, Richard Fitzgerald wrote:

> This adds support for the Wolfson Microelectronics
> WM8280 and WM8281 codecs.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/Kconfig              |    5 +++--
>  drivers/mfd/arizona-core.c       |   14 ++++++++++++--
>  drivers/mfd/arizona-i2c.c        |    2 ++
>  drivers/mfd/arizona-irq.c        |    1 +
>  drivers/mfd/arizona-spi.c        |    2 ++
>  include/linux/mfd/arizona/core.h |    1 +
>  6 files changed, 21 insertions(+), 4 deletions(-)

Patch looks fine.  Can I just take it?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index abef204..e00a90f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1236,10 +1236,11 @@ config MFD_WM5102
>  	  Support for Wolfson Microelectronics WM5102 low power audio SoC
> =20
>  config MFD_WM5110
> -	bool "Wolfson Microelectronics WM5110"
> +	bool "Wolfson Microelectronics WM5110 and WM8280/WM8281"
>  	depends on MFD_ARIZONA
>  	help
> -	  Support for Wolfson Microelectronics WM5110 low power audio SoC
> +	  Support for Wolfson Microelectronics WM5110 and WM8280/WM8281
> +	  low power audio SoC
> =20
>  config MFD_WM8997
>  	bool "Wolfson Microelectronics WM8997"
> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
> index bce7c07..6e6b732 100644
> --- a/drivers/mfd/arizona-core.c
> +++ b/drivers/mfd/arizona-core.c
> @@ -567,6 +567,7 @@ static int arizona_of_get_core_pdata(struct arizo=
na *arizona)
>  const struct of_device_id arizona_of_match[] =3D {
>  	{ .compatible =3D "wlf,wm5102", .data =3D (void *)WM5102 },
>  	{ .compatible =3D "wlf,wm5110", .data =3D (void *)WM5110 },
> +	{ .compatible =3D "wlf,wm8280", .data =3D (void *)WM8280 },
>  	{ .compatible =3D "wlf,wm8997", .data =3D (void *)WM8997 },
>  	{},
>  };
> @@ -671,6 +672,7 @@ int arizona_dev_init(struct arizona *arizona)
>  	switch (arizona->type) {
>  	case WM5102:
>  	case WM5110:
> +	case WM8280:
>  	case WM8997:
>  		for (i =3D 0; i < ARRAY_SIZE(wm5102_core_supplies); i++)
>  			arizona->core_supplies[i].supply
> @@ -834,11 +836,18 @@ int arizona_dev_init(struct arizona *arizona)
>  #endif
>  #ifdef CONFIG_MFD_WM5110
>  	case 0x5110:
> -		type_name =3D "WM5110";
> -		if (arizona->type !=3D WM5110) {
> +		switch (arizona->type) {
> +		case WM5110:
> +			type_name =3D "WM5110";
> +			break;
> +		case WM8280:
> +			type_name =3D "WM8280";
> +			break;
> +		default:
>  			dev_err(arizona->dev, "WM5110 registered as %d\n",
>  				arizona->type);
>  			arizona->type =3D WM5110;
> +			break;
>  		}
>  		apply_patch =3D wm5110_patch;
>  		break;
> @@ -1010,6 +1019,7 @@ int arizona_dev_init(struct arizona *arizona)
>  				      ARRAY_SIZE(wm5102_devs), NULL, 0, NULL);
>  		break;
>  	case WM5110:
> +	case WM8280:
>  		ret =3D mfd_add_devices(arizona->dev, -1, wm5110_devs,
>  				      ARRAY_SIZE(wm5110_devs), NULL, 0, NULL);
>  		break;
> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
> index 9d4156f..ff782a5 100644
> --- a/drivers/mfd/arizona-i2c.c
> +++ b/drivers/mfd/arizona-i2c.c
> @@ -44,6 +44,7 @@ static int arizona_i2c_probe(struct i2c_client *i2c=
,
>  #endif
>  #ifdef CONFIG_MFD_WM5110
>  	case WM5110:
> +	case WM8280:
>  		regmap_config =3D &wm5110_i2c_regmap;
>  		break;
>  #endif
> @@ -87,6 +88,7 @@ static int arizona_i2c_remove(struct i2c_client *i2=
c)
>  static const struct i2c_device_id arizona_i2c_id[] =3D {
>  	{ "wm5102", WM5102 },
>  	{ "wm5110", WM5110 },
> +	{ "wm8280", WM8280 },
>  	{ "wm8997", WM8997 },
>  	{ }
>  };
> diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
> index 3a3fe7c..d063b94 100644
> --- a/drivers/mfd/arizona-irq.c
> +++ b/drivers/mfd/arizona-irq.c
> @@ -211,6 +211,7 @@ int arizona_irq_init(struct arizona *arizona)
>  #endif
>  #ifdef CONFIG_MFD_WM5110
>  	case WM5110:
> +	case WM8280:
>  		aod =3D &wm5110_aod;
> =20
>  		switch (arizona->rev) {
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 5145d78..721b93f 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -44,6 +44,7 @@ static int arizona_spi_probe(struct spi_device *spi=
)
>  #endif
>  #ifdef CONFIG_MFD_WM5110
>  	case WM5110:
> +	case WM8280:
>  		regmap_config =3D &wm5110_spi_regmap;
>  		break;
>  #endif
> @@ -82,6 +83,7 @@ static int arizona_spi_remove(struct spi_device *sp=
i)
>  static const struct spi_device_id arizona_spi_ids[] =3D {
>  	{ "wm5102", WM5102 },
>  	{ "wm5110", WM5110 },
> +	{ "wm8280", WM8280 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(spi, arizona_spi_ids);
> diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/ari=
zona/core.h
> index 910e3aa..f970105 100644
> --- a/include/linux/mfd/arizona/core.h
> +++ b/include/linux/mfd/arizona/core.h
> @@ -24,6 +24,7 @@ enum arizona_type {
>  	WM5102 =3D 1,
>  	WM5110 =3D 2,
>  	WM8997 =3D 3,
> +	WM8280 =3D 4,
>  };
> =20
>  #define ARIZONA_IRQ_GP1                    0

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
