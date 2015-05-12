From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [RFC PATCH 00/14] ASoC: qcom: add support to apq8016
 audio
Date: Tue, 12 May 2015 11:21:42 +0100
Message-ID: <5551D436.2070600@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235704.GA27804@kwestfie-linux.qualcomm.com> <20150506054758.GD5639@kwestfie-linux.qualcomm.com> <5549BA98.9080501@linaro.org> <20150512040600.GA24087@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512040600.GA24087-VfhoOQ2zEbNBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

+ adding Lars

On 12/05/15 05:06, Kenneth Westfield wrote:
> Srinivas,
>
> I was able to get audio working on the Storm board.  There were several
> issues.  First, the I2S control port was saved in the DAI driver id field
> (which was 4), but the DAI id field was used by the macro (which was 0).
> The patch below fixed it:

Ah, I did not expect that to happen, dai->id and dai->driver->id should 
be same. Surprisingly this is not true for IPQ806x platform only because 
dais count == 1. Which results in dai->id not getting assigned to 
dai->driver->id due to below code snippet in  sound/soc/soc-core.c

--------------------><------------------------------------------
/*
  * Back in the old days when we still had component-less DAIs,
  * instead of having a static name, component-less DAIs would
  * inherit the name of the parent device so it is possible to
  * register multiple instances of the DAI. We still need to keep
  * the same naming style even though those DAIs are not
  * component-less anymore.
  */
if (count == 1 && legacy_dai_naming) {
	dai->name = fmt_single_name(dev, &dai->id);
} else {
	dai->name = fmt_multiple_name(dev, &dai_drv[i]);
	if (dai_drv[i].id)
		dai->id = dai_drv[i].id;
	else
		dai->id = i;
}
--------------------><------------------------------------------

Its not clear from code, why should we enter to legacy naming if the 
dais count == 1 even-though the dai_drv has has valid name and id 
information.

Mark/Lars,

I can workaround this by using dai->driver->id in the driver, But do you 
think that dai name and id should be assigned from dai drv if present?

--srini

>
> -----------------------><---------------------------------------------
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 17ad20d..58ae8af 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -146,7 +146,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   	}
>
>   	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
> +			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
>   			   regval);
>   	if (ret) {
>   		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
> @@ -171,7 +171,7 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
>   	int ret;
>
>   	ret = regmap_write(drvdata->lpaif_map,
> -			   LPAIF_I2SCTL_REG(drvdata->variant, dai->id), 0);
> +			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id), 0);
>   	if (ret)
>   		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
>   				__func__, ret);
> @@ -186,7 +186,7 @@ static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
>   	int ret;
>
>   	ret = regmap_update_bits(drvdata->lpaif_map,
> -			LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
> +			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
>   			LPAIF_I2SCTL_SPKEN_MASK, LPAIF_I2SCTL_SPKEN_ENABLE);
>   	if (ret)
>   		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
> @@ -206,7 +206,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
>   	case SNDRV_PCM_TRIGGER_RESUME:
>   	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>   		ret = regmap_update_bits(drvdata->lpaif_map,
> -				LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
> +				LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
>   				LPAIF_I2SCTL_SPKEN_MASK,
>   				LPAIF_I2SCTL_SPKEN_ENABLE);
>   		if (ret)
> @@ -217,7 +217,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
>   	case SNDRV_PCM_TRIGGER_SUSPEND:
>   	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>   		ret = regmap_update_bits(drvdata->lpaif_map,
> -				LPAIF_I2SCTL_REG(drvdata->variant, dai->id),
> +				LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
>   				LPAIF_I2SCTL_SPKEN_MASK,
>   				LPAIF_I2SCTL_SPKEN_DISABLE);
>   		if (ret)
> @@ -247,7 +247,7 @@ int lpass_cpu_dai_probe(struct snd_soc_dai *dai)
>
>   	/* ensure audio hardware is disabled */
>   	ret = regmap_write(drvdata->lpaif_map,
> -			LPAIF_I2SCTL_REG(drvdata->variant, dai->id), 0);
> +			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id), 0);
>   	if (ret)
>   		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
>   				__func__, ret);
> -----------------------><---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
