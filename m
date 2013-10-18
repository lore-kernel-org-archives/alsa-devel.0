From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [Patch v2][ 16/37] ASoC: eukrea-tlv320: Add DT support.
Date: Fri, 18 Oct 2013 11:19:51 +0200
Message-ID: <20131018111951.7508b5d1@ipc1.ka-ro>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
	<1382022155-21954-17-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382022155-21954-17-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric =?UTF-8?B?QsOpbmFyZA==?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org> wrote:
> diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv=
320.c
> index 9a4a0ca..975af57 100644
> --- a/sound/soc/fsl/eukrea-tlv320.c
> +++ b/sound/soc/fsl/eukrea-tlv320.c
[...]
> @@ -26,24 +28,33 @@
> =20
>  #include "../codecs/tlv320aic23.h"
>  #include "imx-ssi.h"
> +#include "fsl_ssi.h"
>  #include "imx-audmux.h"
> =20
>  #define CODEC_CLOCK 12000000
> =20
> +struct eukrea_tlv320 {
> +	char of;
> +};
> +
>  static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substre=
am,
>  			    struct snd_pcm_hw_params *params)
>  {
>  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct eukrea_tlv320 *priv =3D snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>  	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>  	int ret;
> =20
> -	ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> -				  SND_SOC_DAIFMT_NB_NF |
> -				  SND_SOC_DAIFMT_CBM_CFM);
> -	if (ret) {
> -		pr_err("%s: failed set cpu dai format\n", __func__);
>
dev_err(cpu_dai->dev,...);?

> -		return ret;
> +	/* fsl_ssi lacks the set_fmt ops. */
> +	if (!priv->of) {
> +		ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +					  SND_SOC_DAIFMT_NB_NF |
> +					  SND_SOC_DAIFMT_CBM_CFM);
> +		if (ret) {
> +			pr_err("%s: failed set cpu dai format\n", __func__);
> +			return ret;
> +		}
>  	}
> =20
>  	ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> @@ -60,15 +71,18 @@ static int eukrea_tlv320_hw_params(struct snd_pcm=
_substream *substream,
>  		pr_err("%s: failed setting codec sysclk\n", __func__);
>
dev_err(codec_dai->dev,...);?

>  		return ret;
>  	}
> -	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
> =20
> -	ret =3D snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
> -				SND_SOC_CLOCK_IN);
> -	if (ret) {
> -		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
dto.

> -		return ret;
> -	}
> +	/* fsl_ssi lacks the set_sysclk ops */
> +	if (!priv->of) {
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
> =20
> +		ret =3D snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
> +					SND_SOC_CLOCK_IN);
> +		if (ret) {
> +			pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
dto.

> @@ -97,8 +110,56 @@ static int eukrea_tlv320_probe(struct platform_de=
vice *pdev)
>  {
>  	int ret;
>  	int int_port =3D 0, ext_port;
> +	struct platform_device *ssi_pdev;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *ssi_np;
> +	struct eukrea_tlv320 *priv;
> +
> +	priv =3D devm_kzalloc(&pdev->dev,
> +				sizeof(struct eukrea_tlv320), GFP_KERNEL);
> +	if (priv =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	if (np) {
> +		ssi_np =3D of_parse_phandle(pdev->dev.of_node,
> +					  "ssi-controller", 0);
> +		ssi_pdev =3D of_find_device_by_node(ssi_np);
> +		if (!ssi_pdev) {
> +			dev_err(&pdev->dev, "ssi-controller missing or "
> +				"invalid.\n");
>
Please don't line wrap error message strings as it makes it harder to
grep the kernel source for messages appearing in a logfile.

 [...]
> @@ -149,10 +229,17 @@ static int eukrea_tlv320_remove(struct platform=
_device *pdev)
>  	return 0;
>  }
> =20
> +static const struct of_device_id imx_tlv320_dt_ids[] =3D {
> +	{ .compatible =3D "eukrea,eukrea-tlv320"},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_tlv320_dt_ids);
> +
>  static struct platform_driver eukrea_tlv320_driver =3D {
>  	.driver =3D {
>  		.name =3D "eukrea_tlv320",
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D imx_tlv320_dt_ids,
>  	},
>  	.probe =3D eukrea_tlv320_probe,
>  	.remove =3D eukrea_tlv320_remove,};

While at it you could fix the position of the '}' in the last line.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
