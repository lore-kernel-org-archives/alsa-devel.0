From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: move ipq806x specific bits out
 of lpass driver.
Date: Tue, 05 May 2015 08:16:46 +0100
Message-ID: <55486E5E.4010601@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414213-10997-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235738.GB27804@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150502235738.GB27804@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 03/05/15 00:57, Kenneth Westfield wrote:
> On Thu, Apr 30, 2015 at 06:16:53PM +0100, Srinivas Kandagatla wrote:
>> This patch tries to make the lpass driver more generic by moving the
>> ipq806x specific bits out of the cpu and platform driver, also allows the
>> SOC specific drivers to add the correct register offsets.
>>
>> This patch also renames the register definition header file into more
>> generic header file.
>
>> diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
>> new file mode 100644
>> index 0000000..8e9a427
>> --- /dev/null
>> +++ b/sound/soc/qcom/lpass-ipq806x.c
>
>> +static const struct of_device_id ipq806x_lpass_cpu_device_id[] = {
>> +	{ .compatible = "qcom,lpass-cpu", .data = &ipq806x_data },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, ipq806x_lpass_cpu_device_id);
>
> Surround with #ifdef CONFIG_OF?

I was more of thinking adding "depends OF" in Kconfig.
Is there any possibility that the driver would support non-DT?

>
>> diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
>> new file mode 100644
>> index 0000000..5541b14
>> --- /dev/null
>> +++ b/sound/soc/qcom/lpass-lpaif-reg.h
>
>> +#define LPAIF_I2SCTL_REG_ADDR(v, addr, port) \
>> +	(v->i2sctrl_reg_base + (addr) + v->i2sctrl_reg_stride * (port))
>
> Could all of these variant-related macros be eliminated by using the
> regmap_fields_* accessor functions, instead of the regmap_* functions?
Possible, I will give it a try.

>
>> +enum lpaif_i2s_ports {
>> +	LPAIF_I2S_PORT_MIN		= 0,
>> +
>> +	LPAIF_I2S_PORT_CODEC_SPK	= 0,
>> +	LPAIF_I2S_PORT_CODEC_MIC	= 1,
>> +	LPAIF_I2S_PORT_SEC_SPK		= 2,
>> +	LPAIF_I2S_PORT_SEC_MIC		= 3,
>> +	LPAIF_I2S_PORT_MI2S		= 4,
>> +
>> +	LPAIF_I2S_PORT_MAX		= 4,
>> +	LPAIF_I2S_PORT_NUM		= 5,
>> +};
>
> These port mappings here...
>
>> +enum lpaif_irq_ports {
>> +	LPAIF_IRQ_PORT_MIN		= 0,
>> +
>> +	LPAIF_IRQ_PORT_HOST		= 0,
>> +	LPAIF_IRQ_PORT_ADSP		= 1,
>> +
>> +	LPAIF_IRQ_PORT_MAX		= 2,
>> +	LPAIF_IRQ_PORT_NUM		= 3,
>> +};
>
> ...here...
>
>> +enum lpaif_dma_channels {
>> +	LPAIF_RDMA_CHAN_MIN		= 0,
>> +
>> +	LPAIF_RDMA_CHAN_MI2S		= 0,
>> +	LPAIF_RDMA_CHAN_PCM0		= 1,
>> +	LPAIF_RDMA_CHAN_PCM1		= 2,
>> +
>> +	LPAIF_RDMA_CHAN_MAX		= 4,
>> +	LPAIF_RDMA_CHAN_NUM		= 5,
>> +};
>
> ...and here can be SOC-specific.  Should move them to the SOC-specific
> files.
Yes, I agree, i will move them to soc specific header file.

>
>> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
>> index 5c99b3d..5bd2a90 100644
>> --- a/sound/soc/qcom/lpass.h
>> +++ b/sound/soc/qcom/lpass.h
>
>>   /* register the platform driver from the CPU DAI driver */
>>   int asoc_qcom_lpass_platform_register(struct platform_device *);
>> +int lpass_cpu_platform_remove(struct platform_device *pdev);
>> +int lpass_cpu_platform_probe(struct platform_device *pdev);
>> +int lpass_cpu_dai_probe(struct snd_soc_dai *dai);
>> +extern struct snd_soc_dai_ops lpass_cpu_dai_ops;
>
> Prefix with asoc_qcom_ to reduce chance of collisions.
>
Sounds sensible, Will fix it in next version.

--srini
