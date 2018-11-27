From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: qcom: sdm845: Add board specific
 dapm widgets
Date: Tue, 27 Nov 2018 09:17:00 +0000
Message-ID: <f6d2c5d7-ac18-d95a-4814-14365a0a63e7@linaro.org>
References: <20181124110948.209019-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181124110948.209019-1-cychiang@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tzungbi@chromium.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org



On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Add board specific dapm widgets so these widgets can be used
> in the route.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/sdm845.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 58593db2ab151..95d8d4422dae0 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -212,6 +212,14 @@ static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>   	return 0;
>   }
>   
> +static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +	SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +	SND_SOC_DAPM_SPK("Left Spk", NULL),
> +	SND_SOC_DAPM_SPK("Right Spk", NULL),
> +	SND_SOC_DAPM_MIC("Int Mic", NULL),
> +};
> +
>   static void sdm845_add_be_ops(struct snd_soc_card *card)
>   {
>   	struct snd_soc_dai_link *link;
> @@ -243,6 +251,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
>   		goto data_alloc_fail;
>   	}
>   
> +	card->dapm_widgets = sdm845_snd_widgets;
> +	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
>   	card->dev = dev;
>   	dev_set_drvdata(dev, card);
>   	ret = qcom_snd_parse_of(card);
> 
