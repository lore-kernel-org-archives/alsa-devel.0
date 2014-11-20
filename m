From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Thu, 20 Nov 2014 13:36:38 +0100
Message-ID: <546DE056.3070601@metafoo.de>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org> <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Bryan Huntsman <bryanh@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 11/19/2014 07:52 PM, Kenneth Westfield wrote:
[...]
> +static struct clk *lpaif_mi2s_bit_clk;
> +static struct clk *lpaif_mi2s_osr_clk;
> +static struct mi2s_hw_params mi2s_params;

Again, no global state please.
[...]
> +static int lpass_cpu_mi2s_prepare(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
[...]
> +static int lpass_cpu_mi2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	return 0;
> +}

There is no need to implement empty dummy functions the core handles it just 
fine if the callbacks are NULL.

> +
[...]
> +
> +static struct snd_soc_dai_driver lpass_cpu_dais[] = {
> +	{
> +		.playback = {
> +			.rates		= SNDRV_PCM_RATE_8000_192000,
> +			.formats	= SNDRV_PCM_FMTBIT_S16 |
> +					SNDRV_PCM_FMTBIT_S24 |
> +					SNDRV_PCM_FMTBIT_S32,
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +			.rate_min	= 8000,
> +			.rate_max	= 192000,
> +		},
> +		.ops    = &lpass_cpu_mi2s_ops,
> +		.name = "lpass-mi2s-dai"
> +	},
> +};


If there is only one DAI no need to make this a array.

> +
> +static const struct snd_soc_component_driver lpass_cpu_component = {
> +	.name           = DRV_NAME,
> +};
> +
> +static int lpass_cpu_dai_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = snd_soc_register_component(&pdev->dev, &lpass_cpu_component,
> +			lpass_cpu_dais, ARRAY_SIZE(lpass_cpu_dais));

devm_

> +	if (ret)
> +		dev_err(&pdev->dev, "%s: error registering soc dais\n",
> +				__func__);
> +
> +	return ret;
> +}
[...]
