From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Add SND_SOC_DAIFMT_DSP_A
 support
Date: Wed, 23 Jul 2014 18:04:15 +0800
Message-ID: <20140723100414.GC25639@MrMyself>
References: <1405334371-4248-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 by alsa0.perex.cz (Postfix) with ESMTP id DDFA52655DF
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 12:16:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1405334371-4248-1-git-send-email-shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2014 at 06:39:31PM +0800, Shengjiu Wang wrote:
> According to the spec, the definition of TDM and ONELINE_24 for
> CS42XX8_INTF_DAC and CS42XX8_INTF_ADC is wrong. correct them and enable
> SND_SOC_DAIFMT_DSP_A support.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
Nicolin

> ---
>  sound/soc/codecs/cs42xx8.c | 3 +++
>  sound/soc/codecs/cs42xx8.h | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
> index ec53ffc..02b1520 100644
> --- a/sound/soc/codecs/cs42xx8.c
> +++ b/sound/soc/codecs/cs42xx8.c
> @@ -219,6 +219,9 @@ static int cs42xx8_set_dai_fmt(struct snd_soc_dai *codec_dai,
>  	case SND_SOC_DAIFMT_RIGHT_J:
>  		val = CS42XX8_INTF_DAC_DIF_RIGHTJ | CS42XX8_INTF_ADC_DIF_RIGHTJ;
>  		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +		val = CS42XX8_INTF_DAC_DIF_TDM | CS42XX8_INTF_ADC_DIF_TDM;
> +		break;
>  	default:
>  		dev_err(codec->dev, "unsupported dai format\n");
>  		return -EINVAL;
> diff --git a/sound/soc/codecs/cs42xx8.h b/sound/soc/codecs/cs42xx8.h
> index da0b94a..b2c10e5 100644
> --- a/sound/soc/codecs/cs42xx8.h
> +++ b/sound/soc/codecs/cs42xx8.h
> @@ -128,8 +128,8 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap);
>  #define CS42XX8_INTF_DAC_DIF_RIGHTJ		(2 << CS42XX8_INTF_DAC_DIF_SHIFT)
>  #define CS42XX8_INTF_DAC_DIF_RIGHTJ_16		(3 << CS42XX8_INTF_DAC_DIF_SHIFT)
>  #define CS42XX8_INTF_DAC_DIF_ONELINE_20		(4 << CS42XX8_INTF_DAC_DIF_SHIFT)
> -#define CS42XX8_INTF_DAC_DIF_ONELINE_24		(6 << CS42XX8_INTF_DAC_DIF_SHIFT)
> -#define CS42XX8_INTF_DAC_DIF_TDM		(7 << CS42XX8_INTF_DAC_DIF_SHIFT)
> +#define CS42XX8_INTF_DAC_DIF_ONELINE_24		(5 << CS42XX8_INTF_DAC_DIF_SHIFT)
> +#define CS42XX8_INTF_DAC_DIF_TDM		(6 << CS42XX8_INTF_DAC_DIF_SHIFT)
>  #define CS42XX8_INTF_ADC_DIF_SHIFT		0
>  #define CS42XX8_INTF_ADC_DIF_WIDTH		3
>  #define CS42XX8_INTF_ADC_DIF_MASK		(((1 << CS42XX8_INTF_ADC_DIF_WIDTH) - 1) << CS42XX8_INTF_ADC_DIF_SHIFT)
> @@ -138,8 +138,8 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap);
>  #define CS42XX8_INTF_ADC_DIF_RIGHTJ		(2 << CS42XX8_INTF_ADC_DIF_SHIFT)
>  #define CS42XX8_INTF_ADC_DIF_RIGHTJ_16		(3 << CS42XX8_INTF_ADC_DIF_SHIFT)
>  #define CS42XX8_INTF_ADC_DIF_ONELINE_20		(4 << CS42XX8_INTF_ADC_DIF_SHIFT)
> -#define CS42XX8_INTF_ADC_DIF_ONELINE_24		(6 << CS42XX8_INTF_ADC_DIF_SHIFT)
> -#define CS42XX8_INTF_ADC_DIF_TDM		(7 << CS42XX8_INTF_ADC_DIF_SHIFT)
> +#define CS42XX8_INTF_ADC_DIF_ONELINE_24		(5 << CS42XX8_INTF_ADC_DIF_SHIFT)
> +#define CS42XX8_INTF_ADC_DIF_TDM		(6 << CS42XX8_INTF_ADC_DIF_SHIFT)
>  
>  /* ADC Control & DAC De-Emphasis (Address 05h) */
>  #define CS42XX8_ADCCTL_ADC_HPF_FREEZE_SHIFT	7
> -- 
> 1.8.0
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
