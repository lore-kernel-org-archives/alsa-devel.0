From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: qcom: sdm845: Create and setup
 jack in init callback
Date: Tue, 27 Nov 2018 09:17:16 +0000
Message-ID: <3036c1c3-84a6-0306-1aff-434e1087f6ad@linaro.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-2-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124110948.209019-2-cychiang@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tzungbi@chromium.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org



On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Add a callback for init ops on dai_link to create and setup jack.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/sdm845.c | 57 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 95d8d4422dae0..43c03f8e8cdc2 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -8,6 +8,8 @@
>   #include <linux/of_device.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> +#include <sound/jack.h>
> +#include <uapi/linux/input-event-codes.h>
>   #include "common.h"
>   #include "qdsp6/q6afe.h"
>   
> @@ -17,6 +19,8 @@
>   #define MI2S_BCLK_RATE		1536000
>   
>   struct sdm845_snd_data {
> +	struct snd_soc_jack jack;
> +	bool jack_setup;
>   	struct snd_soc_card *card;
>   	uint32_t pri_mi2s_clk_count;
>   	uint32_t sec_mi2s_clk_count;
> @@ -100,6 +104,54 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
>   	return ret;
>   }
>   
> +static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_component *component;
> +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> +	struct snd_soc_card *card = rtd->card;
> +	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
> +	int i, rval;
> +
> +	if (!pdata->jack_setup) {
> +		struct snd_jack *jack;
> +
> +		rval = snd_soc_card_jack_new(card, "Headset Jack",
> +				SND_JACK_HEADSET |
> +				SND_JACK_HEADPHONE |
> +				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +				SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +				&pdata->jack, NULL, 0);
> +
> +		if (rval < 0) {
> +			dev_err(card->dev, "Unable to add Headphone Jack\n");
> +			return rval;
> +		}
> +
> +		jack = pdata->jack.jack;
> +
> +		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> +		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +		pdata->jack_setup = true;
> +	}
> +
> +	for (i = 0 ; i < dai_link->num_codecs; i++) {
> +		struct snd_soc_dai *dai = rtd->codec_dais[i];
> +
> +		component = dai->component;
> +		rval = snd_soc_component_set_jack(
> +				component, &pdata->jack, NULL);
> +		if (rval != 0 && rval != -ENOTSUPP) {
> +			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
> +			return rval;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +
>   static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   {
>   	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> @@ -220,7 +272,7 @@ static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
>   	SND_SOC_DAPM_MIC("Int Mic", NULL),
>   };
>   
> -static void sdm845_add_be_ops(struct snd_soc_card *card)
> +static void sdm845_add_ops(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai_link *link;
>   	int i;
> @@ -230,6 +282,7 @@ static void sdm845_add_be_ops(struct snd_soc_card *card)
>   			link->ops = &sdm845_be_ops;
>   			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
>   		}
> +		link->init = sdm845_dai_init;
>   	}
>   }
>   
> @@ -264,7 +317,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
>   	data->card = card;
>   	snd_soc_card_set_drvdata(card, data);
>   
> -	sdm845_add_be_ops(card);
> +	sdm845_add_ops(card);
>   	ret = snd_soc_register_card(card);
>   	if (ret) {
>   		dev_err(dev, "Sound card registration failed\n");
> 
