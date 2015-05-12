From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RFC PATCH 00/14] ASoC: qcom: add support to apq8016
 audio
Date: Tue, 12 May 2015 14:11:55 +0100
Message-ID: <5551FC1B.8000800@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235704.GA27804@kwestfie-linux.qualcomm.com> <20150506054758.GD5639@kwestfie-linux.qualcomm.com> <5549BA98.9080501@linaro.org> <20150512040600.GA24087@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150512040600.GA24087@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Kenneth,

On 12/05/15 05:06, Kenneth Westfield wrote:
> On Tue, May 05, 2015 at 11:54:16PM -0700, Srinivas Kandagatla wrote:
>> Hi Kenneth,
>>
>> On 06/05/15 06:47, Kenneth Westfield wrote:
>>>>>
>>>>> I will test the patches and let you know by Wednesday.  Also, I posted
>>>>> some comments, but Patrick should be posting his comments separately
>>>>> later next week.
>>> Srinivas,
>>>
>>> After applying the patches, audio playback is no longer functional on
>>> the storm board.  Give me some time to debug this and I will get back
>>> to you.
>> I found atleast one issue with rdma audif bits in ipq806x lpass
>>
>> could you try change, this will be fixed properly in next version.
>>
>> -----------------------><---------------------------------------------
>> diff --git a/sound/soc/qcom/lpass-ipq806x.c
>> b/sound/soc/qcom/lpass-ipq806x.c
>> index 11a7053..2b00355 100644
>> --- a/sound/soc/qcom/lpass-ipq806x.c
>> +++ b/sound/soc/qcom/lpass-ipq806x.c
>> @@ -69,6 +69,7 @@ struct lpass_variant ipq806x_data = {
>>          .rdma_reg_base          = 0x6000,
>>          .rdma_reg_stride        = 0x1000,
>>          .rdma_channels          = 4,
>> +       .rdmactl_audif_start    = 4,
>>          .dai_driver             = &lpass_cpu_dai_driver,
>>          .num_dai                = 1,
>>
>> -----------------------><---------------------------------------------
>
> Srinivas,
>
> I was able to get audio working on the Storm board.  There were several
> issues.  First, the I2S control port was saved in the DAI driver id field
> (which was 4), but the DAI id field was used by the macro (which was 0).
> The patch below fixed it:
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
>

> In addition to your patch above, I also needed to correct the rdma_port
> assignment by removing the i2s port reference:


>
> -----------------------><---------------------------------------------
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index c5907d5..580cae1 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
>   	unsigned int channels = params_channels(params);
>   	unsigned int regval;
>   	int bitwidth;
> -	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
> +	int ret, rdma_port = v->rdmactl_audif_start;
>
>   	bitwidth = snd_pcm_format_width(format);
>   	if (bitwidth < 0) {
> -----------------------><---------------------------------------------
>
> Please incorporate these fixes into your next patch series.
>
I think my patch and above change for rdma port are not necessary as the 
rdma_port existing calculation would result 4 anyway, for 
rdmactl_audif_start= 0 and dai->driver->id = 4. Which is correct in MI2S 
case.

Only replacing dai->id to dai->driver->id should fix the issue on storm 
board. So I will drop these two changes in next verion.
--srini
