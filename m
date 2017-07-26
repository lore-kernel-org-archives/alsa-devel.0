From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 3/3] ASoC: qcom: apq8016-sbc: enable jack detection
Date: Wed, 26 Jul 2017 17:31:28 +0100
Message-ID: <009fc5d3-9ee2-c153-f208-df10b62d7467@linaro.org>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
 <20170725175126.26578-4-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725175126.26578-4-damien.riegel@savoirfairelinux.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org



On 25/07/17 18:51, Damien Riegel wrote:
> Now that the pm8916 audio codec has support for jack detection, let the
> sound card driver use it.

> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>   sound/soc/qcom/apq8016_sbc.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
> index d084d7468299..5f03f6249397 100644
> --- a/sound/soc/qcom/apq8016_sbc.c
> +++ b/sound/soc/qcom/apq8016_sbc.c
> @@ -19,11 +19,14 @@
>   #include <linux/of.h>
>   #include <linux/clk.h>
>   #include <linux/platform_device.h>
> +#include <sound/jack.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
>   #include <sound/soc.h>
>   #include <dt-bindings/sound/apq8016-lpass.h>
>   
> +#include "../codecs/msm8916-wcd-analog.h"
> +
>   struct apq8016_sbc_data {
>   	void __iomem *mic_iomux;
>   	void __iomem *spkr_iomux;
> @@ -35,13 +38,26 @@ struct apq8016_sbc_data {
>   #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
>   #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
>   
> +static struct snd_soc_jack apq8016_jack;
> +
>   static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
>   {
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>   	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_codec *codec = rtd->codec;

This driver uses multicodec, so this will not work to start with.
Also this function is used for different codec devices on the SOC, so we 
should take care that we are might be talking to 3 different possible 
codecs.

>   	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
>   	int rval = 0;
>   
> +	if (!apq8016_jack.jack) {
> +		rval = snd_soc_card_jack_new(card, "headset",
> +					     SND_JACK_MECHANICAL,
> +					     &apq8016_jack, NULL, 0);
> +		if (rval)
> +			return rval;
> +
> +		pm8916_wcd_analog_jack_detect(codec, &apq8016_jack);
We already have an api to do this snd_soc_codec_set_jack()

> +	}
> +
>   	switch (cpu_dai->id) {
>   	case MI2S_PRIMARY:
>   		writel(readl(pdata->spkr_iomux) | SPKR_CTL_PRI_WS_SLAVE_SEL_11,
> 
