From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [RFC PATCH 09/14] ASoC: qcom: Add ability to handle interrupts
 per dma channel
Date: Sat, 2 May 2015 17:00:22 -0700
Message-ID: <20150502235950.GE27804@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414262-11252-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430414262-11252-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 06:17:42PM +0100, Srinivas Kandagatla wrote:
> This patch adds ablity to lpass driver to handle interrupt per dma
> channel. Without this patch its not possible to use multipl ports on the
> lpass.
 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 8ab0ac1..c5907d5 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c

> -static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
> +static irqreturn_t lpass_dma_interrupt_handler(
> +			struct snd_pcm_substream *substream,
> +			struct lpass_data *drvdata,
> +			int chan, u32 interrupts)
>  {
> -	struct snd_pcm_substream *substream = data;
>  	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
> -	struct lpass_data *drvdata =
> -		snd_soc_platform_get_drvdata(soc_runtime->platform);
>  	struct lpass_variant *v = drvdata->variant;
> -	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
> -	unsigned int interrupts;
>  	irqreturn_t ret = IRQ_NONE;
> -	int rv, chan = pcm_data->rdma_ch;
> -
> -	rv = regmap_read(drvdata->lpaif_map,
> -			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &interrupts);
> -	if (rv) {
> -		dev_err(soc_runtime->dev, "%s() error reading from irqstat reg: %d\n",
> -				__func__, rv);
> -		return IRQ_NONE;
> -	}
> -
> -	interrupts &= LPAIF_IRQ_ALL(chan);
> +	int rv;
>  
>  	if (interrupts & LPAIF_IRQ_PER(chan)) {
>  		rv = regmap_write(drvdata->lpaif_map,
> @@ -422,6 +410,30 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
>  	return ret;

You are returning the ISR result here...

>  }
>  
> +static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
> +{
> +	struct lpass_data *drvdata = data;
> +	struct lpass_variant *v = drvdata->variant;
> +	unsigned int irqs;
> +	int rv, chan;
> +
> +	rv = regmap_read(drvdata->lpaif_map,
> +			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
> +	if (rv) {
> +		pr_err("%s() error reading from irqstat reg: %d\n",
> +				__func__, rv);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Handle per channel interrupts */
> +	for (chan = 0; chan < LPASS_MAX_DMA_CHANNELS; chan++)
> +		if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->substream[chan])
> +			lpass_dma_interrupt_handler(drvdata->substream[chan],
> +						    drvdata, chan, irqs);

...but ignoring the result here and always returning HANDLED.

> +
> +	return IRQ_HANDLED;
> +}
> +

>  int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
>  {
>  	struct lpass_data *drvdata = platform_get_drvdata(pdev);
> +	struct lpass_variant *v = drvdata->variant;
> +	int ret;
>  
>  	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
>  	if (drvdata->lpaif_irq < 0) {
> @@ -553,6 +553,25 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	ret = devm_request_irq(&pdev->dev, drvdata->lpaif_irq,
> +			lpass_platform_lpaif_irq, IRQF_TRIGGER_RISING,
> +			"lpass-irq-lpaif", drvdata);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s() irq request failed: %d\n",
> +				__func__, ret);
> +		return ret;
> +	}
> +
> +	/* ensure audio hardware is disabled */
> +	ret = regmap_write(drvdata->lpaif_map,
> +			LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s() error writing to irqen reg: %d\n",
> +				__func__, ret);
> +		return ret;
> +	}

Looking at this, it may be safer to disable the interrupt sources before
getting/enabling the interrupt, i.e. do the regmap_write first, then
devm_request_irq.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
