From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 2/6] ASoC: codecs: Add msm8916-wcd digital codec
Date: Tue, 6 Sep 2016 13:54:33 +0100
Message-ID: <f7dd8339-5f81-8184-9158-8c083d84c982@linaro.org>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473155865-13361-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20160906112456.GN3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160906112456.GN3950@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/09/16 12:24, Mark Brown wrote:
> On Tue, Sep 06, 2016 at 10:57:41AM +0100, Srinivas Kandagatla wrote:
>
>> +static const struct soc_enum rx_mix2_inp1_chain_enum =
>> +SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B3_CTL, 0, 3, rx_mix2_text);
>
> Indentation again.
>
Yep will fix it in next version.
>> +	case SND_SOC_DAPM_PRE_PMU:
>> +		if (++msm8916_wcd->dmic_clk_cnt == 1) {
>> +			snd_soc_update_bits(codec, dmic_clk_reg,
>
> This looks like you're open coding a supply widget.
You are correct, the clk can go in to a supply widget in this case. I 
will fix it in next version.

>
>> +		if (dmic == 1)
>> +			snd_soc_update_bits(codec, LPASS_CDC_TX1_DMIC_CTL,
>> +					    TXN_DMIC_CTL_CLK_SEL_MASK,
>> +					    TXN_DMIC_CTL_CLK_SEL_DIV3);
>> +		if (dmic == 2)
>> +			snd_soc_update_bits(codec, LPASS_CDC_TX2_DMIC_CTL,
>> +					    TXN_DMIC_CTL_CLK_SEL_MASK,
>> +					    TXN_DMIC_CTL_CLK_SEL_DIV3);
>
> This looks like you want a switch statement.
Ok, will do in next versions.
>
>> +static int msm8916_wcd_digital_enable_clock_block(struct snd_soc_codec
>> +						  *codec, int enable)
>> +{
>
>> +static int msm8916_wcd_digital_codec_remove(struct snd_soc_codec *codec)
>> +{
>> +	return 0;
>> +}
>
> Remove empty functions.
Agree.
>
>> +static int msm8916_wcd_digital_startup(struct snd_pcm_substream *substream,
>> +				       struct snd_soc_dai *dai)
>> +{
>> +	msm8916_wcd_digital_enable_clock_block(dai->codec, 1);
>> +	return 0;
>> +}
>> +
>> +static void msm8916_wcd_digital_shutdown(struct snd_pcm_substream *substream,
>> +					 struct snd_soc_dai *dai)
>> +{
>> +	msm8916_wcd_digital_enable_clock_block(dai->codec, 0);
>> +}
>
> Two problems here: one is that the power management should be in DAPM,
> the other is that the _enable_clock_block() function is totally
> pointless - it has only these two call locations and there is absolutely
> no shared code between the enable and disable paths so they should just
> be inlined.
>
Ok, I will inline the code in next verions.
>> +static int msm8916_wcd_digital_remove(struct platform_device *pdev)
>> +{
>> +	struct msm8916_wcd_digital_priv *priv = dev_get_drvdata(&pdev->dev);
>> +
>> +	clk_disable_unprepare(priv->mclk);
>> +	clk_disable_unprepare(priv->ahbclk);
>> +	snd_soc_unregister_codec(&pdev->dev);
>
> This is disabling the clocks while the CODEC is still registered and
> might be in use, you should unregister first.
Agree, Will change the order in next version.
>
>> +static const struct of_device_id msm8916_wcd_digital_match_table[] = {
>> +	{.compatible = "qcom,msm8916-wcd-digital-codec"},
>> +	{}
>
> Spaces please.
>
Yep.

>> +static struct platform_driver msm8916_wcd_digital_driver = {
>> +	.driver = {
>> +		   .name = "msm8916-wcd-digital-codec",
>> +		   .of_match_table = msm8916_wcd_digital_match_table,
>> +		   },
>
> Please line up the }.
Yep.
>
