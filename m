From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/6] ASoC: codecs: Add msm8916-wcd analog codec
Date: Tue, 6 Sep 2016 13:55:26 +0100
Message-ID: <deca1ce5-ba88-b9b5-5e39-d1938dbb6567@linaro.org>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473155865-13361-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160906111710.GM3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160906111710.GM3950@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/09/16 12:17, Mark Brown wrote:
> On Tue, Sep 06, 2016 at 10:57:40AM +0100, Srinivas Kandagatla wrote:
>
>> +static const struct soc_enum hph_enum =
>> +SOC_ENUM_SINGLE_VIRT(ARRAY_SIZE(hph_text), hph_text);
>
> Coding style, let's have some indentation please.
>
I think Lindent did some mess up here, I will take of of such 
occurrences in next version.
>> +		if (w->reg == CDC_A_TX_1_EN)
>> +			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX1_CTL,
>> +					    CONN_TX1_SERIAL_TX1_MUX,
>> +					    CONN_TX1_SERIAL_TX1_ADC_1);
>> +		else if ((w->reg == CDC_A_TX_2_EN) || (w->reg == CDC_A_TX_3_EN))
>> +			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
>> +					    CONN_TX2_SERIAL_TX2_MUX,
>> +					    CONN_TX2_SERIAL_TX2_ADC_2);
>
> This looks like it should be a switch statement.
Yep, will fix this in next version.
>
>> +	for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
>> +		snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
>> +			      wcd_reg_defaults_2_0[reg].def);
>
>> +static int msm8916_wcd_analog_enable_spk_pa(struct snd_soc_dapm_widget *w,
>> +					    struct snd_kcontrol *kcontrol,
>> +					    int event)
>
> We had some DAPM operations earlier, then the probe now we're back to
> DAPM operations.  Seems a bit confused.

I agree, I will reorder these functions to make the code more readable.

>
>> +	//Path domain ???
>
> C style comments please.
Will fix it.
>
>> +static int msm8916_wcd_analog_startup(struct snd_pcm_substream *substream,
>> +				      struct snd_soc_dai *dai)
>> +{
>> +
>> +	snd_soc_update_bits(dai->codec, CDC_A_MASTER_BIAS_CTL,
>> +			    MASTER_BIAS_CTL_MASTER_BIAS_EN_MASK |
>> +			    MASTER_BIAS_CTL_V2L_BUFFER_EN_MASK,
>> +			    MASTER_BIAS_CTL_MASTER_BIAS_EN_ENABLE |
>> +			    MASTER_BIAS_CTL_V2L_BUFFER_EN_ENABLE);
>> +
>> +	snd_soc_update_bits(dai->codec, CDC_D_CDC_RST_CTL,
>> +			    RST_CTL_DIG_SW_RST_N_MASK,
>> +			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
>> +
>> +	return 0;
>> +}
>
> I'm not quite sure what this is doing but it looks like something I'd
> expect to be in DAPM and I can't see anything that undoes this on
> teardown either.

I will fix this in next version, where this thing will be teardown in 
shutdown callback.

>
>> +static int msm8916_wcd_analog_parse_dt(struct device *dev,
>> +				       struct msm8916_wcd_analog_priv *priv)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int ret, i;
>> +	u32 res[2];
>> +
>> +	ret = of_property_read_u32_array(np, "reg", res, 2);
>> +	if (ret < 0)
>> +		return ret;
>
> That's weird, why are we reading a reg property directly?  Not that we
> ever look at the value we parsed...
>
Ah.. looks like left over from my previous patches.. will get rid of 
this in next version.

>> +static const struct of_device_id msm8916_wcd_analog_spmi_match_table[] = {
>> +	{.compatible = "qcom,msm8916-wcd-analog-codec"},
>> +	{}
>> +};
>
> Coding style, let's have somme spaces please.
Ok.
>
