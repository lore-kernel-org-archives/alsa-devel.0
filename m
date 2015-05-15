From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v1 10/13] ASoC: qcom: Add apq8016 lpass driver support
Date: Thu, 14 May 2015 22:23:40 -0700
Message-ID: <20150515052340.GB31687@kwestfie-linux.qualcomm.com>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431518586-7709-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431518586-7709-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2015 at 05:03:06AM -0700, Srinivas Kandagatla wrote:
> This patch adds apq8016 lpass driver support. APQ8016 has 4 MI2S which
> can be routed to one internal codec and 2 external codec interfaces.
> 
> Primary, Secondary, Quaternary I2S can do Rx(playback) and Tertiary and
> Quaternary can do Tx(capture).

> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 865205e..9cc5ed7 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -20,6 +20,12 @@ config SND_SOC_LPASS_IPQ806X
>  	select SND_SOC_LPASS_CPU
>  	select SND_SOC_LPASS_PLATFORM
>  
> +config SND_SOC_LPASS_APQ8016
> +	tristate
> +	depends on SND_SOC_QCOM
> +	select SND_SOC_LPASS_CPU
> +	select SND_SOC_LPASS_PLATFORM

Continuing from my comments on patch 2/13, should an OF dependency be added
here as well?

> +
>  config SND_SOC_STORM
>  	tristate "ASoC I2S support for Storm boards"
>  	depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST

> diff --git a/sound/soc/qcom/lpass-apq8016.c
> b/sound/soc/qcom/lpass-apq8016.c
> new file mode 100644
> index 0000000..5cbf17f0
> --- /dev/null
> +++ b/sound/soc/qcom/lpass-apq8016.c

> +static int apq8016_lpass_free_dma_channel(struct lpass_data *drvdata, int
> chan)
> +{
> +	clear_bit(chan, &drvdata->rdma_ch_bit_map);
> +
> +	return 0;
> +}
> +
> +static int apq8016_lpass_init(struct platform_device *pdev)
> +{
> +	struct lpass_data *drvdata = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	drvdata->pcnoc_mport_clk = devm_clk_get(dev, "pcnoc-mport-clk");
> +	if (IS_ERR(drvdata->pcnoc_mport_clk)) {
> +		dev_err(&pdev->dev, "%s() error getting pcnoc-mport-clk:
> %ld\n",
> +				__func__,
> PTR_ERR(drvdata->pcnoc_mport_clk));
> +		return PTR_ERR(drvdata->pcnoc_mport_clk);
> +	}
> +
> +	ret = clk_prepare_enable(drvdata->pcnoc_mport_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s() Error enabling ahbix_clk: %d\n",

Please correct the clock name in the log message ...

> +				__func__, ret);
> +		return ret;
> +	}
> +
> +	drvdata->pcnoc_sway_clk = devm_clk_get(dev, "pcnoc-sway-clk");
> +	if (IS_ERR(drvdata->pcnoc_sway_clk)) {
> +		dev_err(&pdev->dev, "%s() error getting pcnoc-sway-clk:
> %ld\n",
> +				__func__,
> PTR_ERR(drvdata->pcnoc_sway_clk));
> +		return PTR_ERR(drvdata->pcnoc_sway_clk);
> +	}
> +
> +	ret = clk_prepare_enable(drvdata->pcnoc_sway_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s() Error enabling ahbix_clk: %d\n",

... here too.

> +				__func__, ret);
> +		return ret;
> +	}

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
