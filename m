From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: rt5670: add set_bclk_ratio in dai
 ops
Date: Tue, 12 Sep 2017 09:53:35 -0500
Message-ID: <81332721-16ed-2442-61e3-8483df66258d@linux.intel.com>
References: <1505203979-12794-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 4794D26704A
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 16:53:38 +0200 (CEST)
In-Reply-To: <1505203979-12794-1-git-send-email-bardliao@realtek.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 9/12/17 3:12 AM, Bard Liao wrote:
> We need to set a specific bit for 50 bclk rate. So add set_bclk_ratio
> function to set the bit.

When is this supposed to be used? the cht_bsw_rt5672 machine driver uses 
a 19.2MHz MCLK/2.4 MHz bclk, so there's a typical 50x ratio.

> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
> v2:
> * add define for tdm data format select bit.
> ---
>   sound/soc/codecs/rt5670.c | 19 +++++++++++++++++++
>   sound/soc/codecs/rt5670.h |  4 ++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
> index 9545764..da7614c 100644
> --- a/sound/soc/codecs/rt5670.c
> +++ b/sound/soc/codecs/rt5670.c
> @@ -2582,6 +2582,24 @@ static int rt5670_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
>   	return 0;
>   }
>   
> +static int rt5670_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
> +	if (dai->id != RT5670_AIF1)
> +		return 0;
> +
> +	if (ratio == 50)
> +		snd_soc_update_bits(codec, RT5670_GEN_CTRL3,
> +			RT5670_TDM_DATA_MODE_SEL, RT5670_TDM_DATA_MODE_50FS);
> +	else
> +		snd_soc_update_bits(codec, RT5670_GEN_CTRL3,
> +			RT5670_TDM_DATA_MODE_SEL, RT5670_TDM_DATA_MODE_NOR);
> +
> +	return 0;
> +}
> +
>   static int rt5670_set_bias_level(struct snd_soc_codec *codec,
>   			enum snd_soc_bias_level level)
>   {
> @@ -2712,6 +2730,7 @@ static const struct snd_soc_dai_ops rt5670_aif_dai_ops = {
>   	.set_fmt = rt5670_set_dai_fmt,
>   	.set_tdm_slot = rt5670_set_tdm_slot,
>   	.set_pll = rt5670_set_dai_pll,
> +	.set_bclk_ratio = rt5670_set_bclk_ratio,
>   };
>   
>   static struct snd_soc_dai_driver rt5670_dai[] = {
> diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
> index 5ba485c..265df80 100644
> --- a/sound/soc/codecs/rt5670.h
> +++ b/sound/soc/codecs/rt5670.h
> @@ -1816,6 +1816,10 @@
>   #define RT5670_ZCD_HP_DIS			(0x0 << 15)
>   #define RT5670_ZCD_HP_EN			(0x1 << 15)
>   
> +/* General Control 3 (0xfc) */
> +#define RT5670_TDM_DATA_MODE_SEL		(0x1 << 11)
> +#define RT5670_TDM_DATA_MODE_NOR		(0x0 << 11)
> +#define RT5670_TDM_DATA_MODE_50FS		(0x1 << 11)
>   
>   /* Codec Private Register definition */
>   /* 3D Speaker Control (0x63) */
> 
