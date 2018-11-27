From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: qcom: sdm845: Add codec related
 configuration for sdm845
Date: Tue, 27 Nov 2018 09:32:22 +0000
Message-ID: <4f8debc0-40f3-6195-8acb-de9ae3335671@linaro.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-3-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124110948.209019-3-cychiang@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tzungbi@chromium.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

Thanks for the patch Jimmy,

On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Set TDM time slots and DAI format for speaker codec.
> Set DAI format and clock for headset. >
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Overall the patch looks good for me, but this needs to be split into two 
patches + few more minor nits!
> ---
>   sound/soc/qcom/sdm845.c | 82 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 43c03f8e8cdc2..d815040e98dc9 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -6,12 +6,15 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_device.h>
> +#include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
>   #include <sound/jack.h>
> +#include <sound/soc.h>
>   #include <uapi/linux/input-event-codes.h>
>   #include "common.h"
>   #include "qdsp6/q6afe.h"
> +#include "../codecs/rt5663.h"
>   
>   #define DEFAULT_SAMPLE_RATE_48K		48000
>   #define DEFAULT_MCLK_RATE		24576000
> @@ -34,7 +37,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> -	int ret = 0;
> +	int ret = 0, j;
>   	int channels, slot_width;
>   
>   	switch (params_format(params)) {
> @@ -81,6 +84,31 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
>   			goto end;
>   		}
>   	}
> +
> +	for (j = 0; j < rtd->num_codecs; j++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
> +
> +		if (!strcmp(codec_dai->component->name_prefix, "Left")) {
> +			ret = snd_soc_dai_set_tdm_slot(
> +					codec_dai, 0x30, 0x3, 8, slot_width);

These constants needs some kind of defines to make the code more readable!

> +			if (ret < 0) {
> +				dev_err(rtd->dev,
> +					"DEV0 TDM slot err:%d\n", ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (!strcmp(codec_dai->component->name_prefix, "Right")) {
> +			ret = snd_soc_dai_set_tdm_slot(
> +					codec_dai, 0xC0, 0x3, 8, slot_width);
> +			if (ret < 0) {
> +				dev_err(rtd->dev,
> +					"DEV1 TDM slot err:%d\n", ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
>   end:
>   	return ret;
>   }
> @@ -90,9 +118,26 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>   	int ret = 0;
>   
>   	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX:
> +	case PRIMARY_MI2S_TX:
> +		/*
> +		 * Use ASRC for internal clocks, as PLL rate isn't multiple
> +		 * of BCLK.
> +		 */
> +		rt5663_sel_asrc_clk_src(
> +			codec_dai->component,
> +			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
> +			RT5663_CLK_SEL_I2S1_ASRC);
> +		ret = snd_soc_dai_set_sysclk(codec_dai,
> +				RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);

Use DEFAULT_MCLK_RATE here.


> +		if (ret < 0)
> +			dev_err(rtd->dev,
> +				"snd_soc_dai_set_sysclk err = %d\n", ret);
> +		break;
>   	case QUATERNARY_TDM_RX_0:
>   	case QUATERNARY_TDM_TX_0:
>   		ret = sdm845_tdm_snd_hw_params(substream, params);
> @@ -155,14 +200,20 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
>   static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   {
>   	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> +	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_card *card = rtd->card;
>   	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
Unnecessary New line here.

> +	int j;
> +	int ret;
>   
>   	switch (cpu_dai->id) {
>   	case PRIMARY_MI2S_RX:
>   	case PRIMARY_MI2S_TX:
> +		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
>   		if (++(data->pri_mi2s_clk_count) == 1) {
>   			snd_soc_dai_set_sysclk(cpu_dai,
>   				Q6AFE_LPASS_CLK_ID_MCLK_1,
> @@ -172,6 +223,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>   		}
>   		snd_soc_dai_set_fmt(cpu_dai, fmt);
> +		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
>   		break;
>   
>   	case SECONDARY_MI2S_TX:
> @@ -190,6 +242,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
>   				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>   		}
> +
> +		codec_dai_fmt |= SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
> +
> +		for (j = 0; j < rtd->num_codecs; j++) {
> +			codec_dai = rtd->codec_dais[j];
> +
> +			if (!strcmp(codec_dai->component->name_prefix,
> +				    "Left")) {
> +				ret = snd_soc_dai_set_fmt(
> +						codec_dai, codec_dai_fmt);
> +				if (ret < 0) {
> +					dev_err(rtd->dev,
> +						"Left TDM fmt err:%d\n", ret);
> +					return ret;
> +				}
> +			}
> +
> +			if (!strcmp(codec_dai->component->name_prefix,
> +				    "Right")) {
> +				ret = snd_soc_dai_set_fmt(
> +						codec_dai, codec_dai_fmt);
> +				if (ret < 0) {
> +					dev_err(rtd->dev,
> +						"Right TDM slot err:%d\n", ret);
> +					return ret;
> +				}
> +			}
> +		}
>   		break;
>   
>   	default:
> 
