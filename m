From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v4 1/2] extcon: arizona: Add support for
 select accessory detect mode when headphone detection
Date: Thu, 30 Apr 2015 11:16:41 +0100
Message-ID: <20150430101641.GF1815@x1>
References: <1430357878-22859-1-git-send-email-ideal.song@samsung.com>
 <1430357878-22859-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430357878-22859-2-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Apr 2015, Inha Song wrote:

> This patch add support for select accessory detect mode to HPDETL or =
HPDETR.
> Arizona provides a headphone detection circuit on the HPDETL and HPDE=
TR pins
> to measure the impedance of an external load connected to the headpho=
ne.
>=20
> Depending on board design, headphone detect pins can change to HPDETR=
 or HPDETL.
>=20
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  drivers/extcon/extcon-arizona.c   | 38 +++++++++++++++++++++++++++++=
+--------
>  include/dt-bindings/mfd/arizona.h |  8 ++++++++
>  include/linux/mfd/arizona/pdata.h |  3 +++
>  3 files changed, 41 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/mfd/arizona.h
>=20
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-=
arizona.c
> index 63f01c4..d251e92 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -32,13 +32,10 @@
>  #include <linux/mfd/arizona/core.h>
>  #include <linux/mfd/arizona/pdata.h>
>  #include <linux/mfd/arizona/registers.h>
> +#include <dt-bindings/mfd/arizona.h>
> =20
>  #define ARIZONA_MAX_MICD_RANGE 8
> =20
> -#define ARIZONA_ACCDET_MODE_MIC 0
> -#define ARIZONA_ACCDET_MODE_HPL 1
> -#define ARIZONA_ACCDET_MODE_HPR 2
> -
>  #define ARIZONA_MICD_CLAMP_MODE_JDL      0x4
>  #define ARIZONA_MICD_CLAMP_MODE_JDH      0x5
>  #define ARIZONA_MICD_CLAMP_MODE_JDL_GP5H 0x9
> @@ -653,9 +650,9 @@ static void arizona_identify_headphone(struct ari=
zona_extcon_info *info)
>  	ret =3D regmap_update_bits(arizona->regmap,
>  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
>  				 ARIZONA_ACCDET_MODE_MASK,
> -				 ARIZONA_ACCDET_MODE_HPL);
> +				 arizona->pdata.hpdet_channel);
>  	if (ret !=3D 0) {
> -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
>  		goto err;
>  	}
> =20
> @@ -705,9 +702,9 @@ static void arizona_start_hpdet_acc_id(struct ari=
zona_extcon_info *info)
>  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
>  				 ARIZONA_ACCDET_SRC | ARIZONA_ACCDET_MODE_MASK,
>  				 info->micd_modes[0].src |
> -				 ARIZONA_ACCDET_MODE_HPL);
> +				 arizona->pdata.hpdet_channel);
>  	if (ret !=3D 0) {
> -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
>  		goto err;
>  	}
> =20
> @@ -1103,6 +1100,26 @@ static void arizona_micd_set_level(struct ariz=
ona *arizona, int index,
>  	regmap_update_bits(arizona->regmap, reg, mask, level);
>  }
> =20
> +static int arizona_extcon_of_get_pdata(struct arizona *arizona)
> +{
> +	struct arizona_pdata *pdata =3D &arizona->pdata;
> +	unsigned int val =3D ARIZONA_ACCDET_MODE_HPL;
> +
> +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel", &v=
al);
> +	switch (val) {
> +	case ARIZONA_ACCDET_MODE_HPL:
> +	case ARIZONA_ACCDET_MODE_HPR:
> +		pdata->hpdet_channel =3D val;
> +		break;
> +	default:
> +		dev_err(arizona->dev,
> +			"Wrong wlf,hpdet-channel DT value %d\n", val);
> +		pdata->hpdet_channel =3D ARIZONA_ACCDET_MODE_HPL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int arizona_extcon_probe(struct platform_device *pdev)
>  {
>  	struct arizona *arizona =3D dev_get_drvdata(pdev->dev.parent);
> @@ -1120,6 +1137,11 @@ static int arizona_extcon_probe(struct platfor=
m_device *pdev)
>  	if (!info)
>  		return -ENOMEM;
> =20
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		if (!dev_get_platdata(arizona->dev))
> +			arizona_extcon_of_get_pdata(arizona);
> +	}
> +
>  	info->micvdd =3D devm_regulator_get(&pdev->dev, "MICVDD");
>  	if (IS_ERR(info->micvdd)) {
>  		ret =3D PTR_ERR(info->micvdd);
> diff --git a/include/dt-bindings/mfd/arizona.h b/include/dt-bindings/=
mfd/arizona.h
> new file mode 100644
> index 0000000..9ecff78
> --- /dev/null
> +++ b/include/dt-bindings/mfd/arizona.h
> @@ -0,0 +1,8 @@
> +#ifndef __DT_BINDINGS_ARIZONA_H__
> +#define __DT_BINDINGS_ARIZONA_H__
> +
> +#define ARIZONA_ACCDET_MODE_MIC 0
> +#define ARIZONA_ACCDET_MODE_HPL 1
> +#define ARIZONA_ACCDET_MODE_HPR 2
> +
> +#endif /* __DT_BINDINGS_ARIZONA_H__ */
> diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/ar=
izona/pdata.h
> index 4578c72..2473a67 100644
> --- a/include/linux/mfd/arizona/pdata.h
> +++ b/include/linux/mfd/arizona/pdata.h
> @@ -139,6 +139,9 @@ struct arizona_pdata {
>  	/** GPIO used for mic isolation with HPDET */
>  	int hpdet_id_gpio;
> =20
> +	/** Channel to use for headphone detection */
> +	unsigned int hpdet_channel;
> +

Not sure why this file is using kerneldoc comments.

Acked-by: Lee Jones <lee.jones@linaro.org>

>  	/** Extra debounce timeout used during initial mic detection (ms) *=
/
>  	int micd_detect_debounce;
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
