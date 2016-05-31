From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC v2 3/3] ASoC: msm8916: Add msm8916-wcd codec driver
Date: Tue, 31 May 2016 09:52:13 +0100
Message-ID: <574D50BD.2010407@linaro.org>
References: <1464356746-29610-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1464356746-29610-4-git-send-email-srinivas.kandagatla@linaro.org>
 <20160530230133.GB4004@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530230133.GB4004@kwestfie-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Kenneth for Review,

On 31/05/16 00:01, Kenneth Westfield wrote:
> On Fri, May 27, 2016 at 02:45:46PM +0100, Srinivas Kandagatla wrote:
>> This patch adds support to msm8916-wcd codec.
>>
>> msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
>> This codec IP is split in to two parts(Digital & Analog), Analog part
>> is integrated in to PMIC PM8916 and the digital part is integrated into
>> Application processor. Register access to the analog part is done via
>> SPMI interface to PMIC, and registers on the Application processor are
>> memory mapped. Data transfer between Analog and Digital Die is done via
>> a internal bus called PDM.
>>
>> This codec support includes:
>>   - 3 Microphones: Primary Mic(Handset mic), Headset Mic and Secondary Mic.
>>   - 2 Digital Microphones.
>>   - 2 Mic Bias Circuits.
>>   - Earpiece
>>   - Headset
>>   - Loud Speaker.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/dt-bindings/sound/msm8916-wcd.h  |    7 +
>>   sound/soc/codecs/Kconfig                 |    4 +
>>   sound/soc/codecs/Makefile                |    3 +-
>>   sound/soc/codecs/msm8916-wcd-registers.h |  710 ++++++++++++++
>>   sound/soc/codecs/msm8916-wcd.c           | 1582 ++++++++++++++++++++++++++++++
>>   sound/soc/codecs/msm8916-wcd.h           |  308 ++++++
>>   6 files changed, 2613 insertions(+), 1 deletion(-)
>>   create mode 100644 include/dt-bindings/sound/msm8916-wcd.h
>>   create mode 100644 sound/soc/codecs/msm8916-wcd-registers.h
>>   create mode 100644 sound/soc/codecs/msm8916-wcd.c
>>   create mode 100644 sound/soc/codecs/msm8916-wcd.h
>
>> diff --git a/sound/soc/codecs/msm8916-wcd.c b/sound/soc/codecs/msm8916-wcd.c
>> new file mode 100644
>> index 0000000..fb4d0ad
>> --- /dev/null
>> +++ b/sound/soc/codecs/msm8916-wcd.c
>
>> +#define MSM8916_WCD_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
>> +			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
>
> The rates listed here don't match the rates supported in the DAIs
> defined later.
>

Thanks, I will fix that in next version.
>> +static unsigned long rx_gain_reg[] = {
>> +	LPASS_CDC_RX1_VOL_CTL_B2_CTL,
>> +	LPASS_CDC_RX2_VOL_CTL_B2_CTL,
>> +	LPASS_CDC_RX3_VOL_CTL_B2_CTL,
>> +};
>
> Is there a reason this struct (and others that follow) don't have static
> const qualifiers?
>
No reason, I can make them static const i guess.
>> +
>> +static unsigned long tx_gain_reg[] = {
>> +	LPASS_CDC_TX1_VOL_CTL_GAIN,
>> +	LPASS_CDC_TX2_VOL_CTL_GAIN,
>> +};
>
> ditto.
>
>> +static int msm8916_wcd_codec_enable_dec(struct snd_soc_dapm_widget *w,
>> +					struct snd_kcontrol *kcontrol,
>> +					int event)
>> +{
>> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
>> +	unsigned int decimator;
>> +	char *dec_name = NULL;
>> +	char *widget_name = NULL;
>> +	char *temp;
>> +	int ret = 0;
>> +	u16 dec_reset_reg, tx_vol_ctl_reg, tx_mux_ctl_reg;
>> +	u8 dec_hpf_cut_of_freq;
>> +	char *dec_num;
>> +
>> +	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
>> +	if (!widget_name)
>> +		return -ENOMEM;
>> +	temp = widget_name;
>> +
>> +	dec_name = strsep(&widget_name, " ");
>> +	widget_name = temp;
>> +	if (!dec_name) {
>> +		dev_err(codec->dev, "Invalid decimator = %s\n", w->name);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	dec_num = strpbrk(dec_name, "12");
>> +	if (dec_num == NULL) {
>> +		dev_err(codec->dev, "Invalid Decimator\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = kstrtouint(dec_num, 10, &decimator);
>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "Invalid decimator = %s\n", dec_name);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	dec_reset_reg = LPASS_CDC_CLK_TX_RESET_B1_CTL;
>> +	tx_vol_ctl_reg = LPASS_CDC_TX1_VOL_CTL_CFG + 32 * (decimator - 1);
>> +	tx_mux_ctl_reg = LPASS_CDC_TX1_MUX_CTL + 32 * (decimator - 1);
>> +
>> +	switch (event) {
>> +	case SND_SOC_DAPM_PRE_PMU:
>> +		/* Enableable TX digital mute */
>
> typo.

Ok,
>
>> +static int msm8916_wcd_codec_parse_dt(struct platform_device *pdev,
>> +				      struct msm8916_wcd_chip *chip)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	int ret;
>> +	struct regulator_bulk_data regs[2];
>> +	const char *ext1_cap = "qcom,micbias1-ext-cap";
>> +	const char *ext2_cap = "qcom,micbias2-ext-cap";
>
> IMO, Since these strings are used just once below, simply use the string
> literals.
>
Ok, I will do that .

>> +	u32 res[2];
>> +
>> +	ret = of_property_read_u32_array(np, "reg", res, 2);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (of_property_read_bool(pdev->dev.of_node, ext1_cap))
>> +		chip->micbias1_cap_mode = MICB_1_EN_EXT_BYP_CAP;
>> +	else
>> +		chip->micbias1_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;
>> +
>> +	if (of_property_read_bool(pdev->dev.of_node, ext2_cap))
>> +		chip->micbias2_cap_mode = MICB_1_EN_EXT_BYP_CAP;
>> +	else
>> +		chip->micbias2_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;
>> +
>> +	chip->analog_offset = res[0];
>> +	chip->digital_map = syscon_regmap_lookup_by_phandle(np,
>> +							    "qcom,lpass-codec-core");
>> +	if (IS_ERR(chip->digital_map))
>> +		return PTR_ERR(chip->digital_map);
>> +
>> +	chip->mclk = devm_clk_get(dev, "mclk");
>> +	if (IS_ERR(chip->mclk)) {
>> +		dev_err(dev, "failed to get mclk\n");
>> +		return PTR_ERR(chip->mclk);
>> +	}
>> +
>> +	regs[0].supply = "vddio";
>> +	regs[1].supply = "vdd-tx-rx";
>> +
>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(regs), regs);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
>> +		return ret;
>> +	}
>> +	chip->vddio = regs[0].consumer;
>> +	chip->vdd_tx_rx = regs[1].consumer;
>> +
>> +	return 0;
>> +}
>
>> +static int msm8916_wcd_device_up(struct snd_soc_codec *codec)
>
> Since this is a small code block that is only called once,
> just embed it into the codec_probe function.
>
Will give it a try and see how it looks.

>> +{
>> +	struct msm8916_wcd_chip *msm8916_wcd = snd_soc_codec_get_drvdata(codec);
>> +	u32 reg;
>> +
>> +	snd_soc_write(codec, CDC_D_PERPH_RESET_CTL4, 0x01);
>> +	snd_soc_write(codec, CDC_A_PERPH_RESET_CTL4, 0x01);
>> +
>> +	for (reg = 0; reg < ARRAY_SIZE(msm8916_wcd_reg_init_val); reg++)
>> +		snd_soc_update_bits(codec,
>> +				    msm8916_wcd_reg_init_val[reg].reg,
>> +				    msm8916_wcd_reg_init_val[reg].mask,
>> +				    msm8916_wcd_reg_init_val[reg].val);
>> +
>> +	if (TOMBAK_IS_1_0(msm8916_wcd->pmic_rev)) {
>> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults); reg++)
>> +			snd_soc_write(codec, wcd_reg_defaults[reg].reg,
>> +				      wcd_reg_defaults[reg].val);
>> +	} else {
>> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
>> +			snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
>> +				      wcd_reg_defaults_2_0[reg].val);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int msm8916_wcd_codec_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
>> +	int err;
>> +
>> +	err = regulator_enable(chip->vddio);
>> +	if (err < 0) {
>> +		dev_err(codec->dev, "failed to enable VDDIO regulator\n");
>
> Print the error value here, and any other places where it is missing too.
Good point, will do that.
>
>> +		return err;
>> +	}
>> +
>> +	err = regulator_enable(chip->vdd_tx_rx);
>> +	if (err < 0) {
>> +		dev_err(codec->dev, "failed to enable VDD_TX_RX regulator\n");
>> +		return err;
>
> Does the vddio regulator need to be disabled on error?  or it this
> handled elsewhere?
Yes, we should I guess. I will fix it too in next version.
>
>> +	}
>> +
>> +	snd_soc_codec_set_drvdata(codec, chip);
>> +	chip->pmic_rev = snd_soc_read(codec, CDC_D_REVISION1);
>> +	chip->codec_version = snd_soc_read(codec, CDC_D_PERPH_SUBTYPE);
>> +	dev_info(codec->dev, "PMIC REV: %d\t CODEC Version: %d\n",
>> +		 chip->pmic_rev, chip->codec_version);
>> +
>> +	msm8916_wcd_device_up(codec);
>> +	/* Set initial cap mode */
>> +	msm8916_wcd_configure_cap(codec, false, false);
>> +
>> +	return 0;
>> +}
>> +
>> +static int msm8916_wcd_hw_params(struct snd_pcm_substream *substream,
>> +				 struct snd_pcm_hw_params *params,
>> +				 struct snd_soc_dai *dai)
>> +{
>> +	u8 tx_fs_rate;
>> +
>> +	switch (params_rate(params)) {
>> +	case 8000:
>> +		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_8_KHZ;
>> +		break;
>> +	case 16000:
>> +		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_16_KHZ;
>> +		break;
>> +	case 32000:
>> +		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_32_KHZ;
>> +		break;
>> +	case 48000:
>> +		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_48_KHZ;
>> +		break;
>> +	case 96000:
>> +		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_96_KHZ;
>> +		break;
>> +	case 192000:
>> +		tx_fs_rate = TX_I2S_CTL_TX_I2S_FS_RATE_F_192_KHZ;
>> +		break;
>
> Supported rates need to match (mentioned above).
>
>> +static const struct snd_soc_dapm_route audio_map[] = {
>
> Please use consistent name prefixes for variables
> (msm8916_wcd_audio_map).
>
>> +static struct snd_soc_dai_driver msm8916_wcd_codec_dai[] = {
>> +	[0] = {
>> +	       .name = "msm8916_wcd_i2s_rx1",
>> +	       .id = MSM8916_WCD_PLAYBACK_DAI,
>> +	       .playback = {
>> +			    .stream_name = "AIF1 Playback",
>> +			    .rates = MSM8916_WCD_RATES,
>> +			    .formats = MSM8916_WCD_FORMATS,
>> +			    .rate_max = 192000,
>
> Supported rates...
Yep, Will fix this too.
>
>> +static int msm8916_wcd_probe(struct platform_device *pdev)
>> +{
>> +	struct msm8916_wcd_chip *chip;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->analog_map = dev_get_regmap(dev->parent, NULL);
>> +	if (!chip->analog_map)
>> +		return -ENXIO;
>
> Does the analog_map need to be deallocated on later errors in this
> function?  or is dev_get_regmap a devm_ type function?
Thanks, I will have a relook at the error handling in the probe.

>
--srini
