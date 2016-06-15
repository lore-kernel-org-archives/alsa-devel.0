From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 2/2] ASoC: msm8916: Add msm8916-wcd codec driver
Date: Wed, 15 Jun 2016 10:16:27 +0100
Message-ID: <57611CEB.4030401@linaro.org>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20160614155938.GS2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160614155938.GS2282@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for review comments,

On 14/06/16 16:59, Mark Brown wrote:
> On Fri, Jun 10, 2016 at 07:18:45PM +0100, Srinivas Kandagatla wrote:
>
>> +config SND_SOC_MSM8916_WCD
>> +	tristate "Qualcomm MSM8916 WCD"
>> +	depends on SPMI && MFD_SYSCON
>> +
>
> Normally users select MFD_SYSCON.
>
This driver is child of spmi bus so, we need SPMI dependency here along 
with SYSCON.

>> @@ -208,7 +209,6 @@ snd-soc-wm9705-objs := wm9705.o
>>   snd-soc-wm9712-objs := wm9712.o
>>   snd-soc-wm9713-objs := wm9713.o
>>   snd-soc-wm-hubs-objs := wm_hubs.o
>> -
>>   # Amp
>>   snd-soc-max9877-objs := max9877.o
>>   snd-soc-tpa6130a2-objs := tpa6130a2.o
>
> Spurious whitespace change.
Yep will fix it.
>
>> +#include "msm8916-wcd-registers.h"
>> +#include "msm8916-wcd.h"
>> +#include "dt-bindings/sound/msm8916-wcd.h"
>
> What's in here?  There weren't any constants in the bindings.
>
Yes, there are DAI id's which are used in device trees.

>> +struct msm8916_wcd_chip {
>> +	struct regmap *analog_map;
>> +	struct regmap *digital_map;
>> +	unsigned int analog_offset;
>> +	u16 pmic_rev;
>> +	u16 codec_version;
>
> Why is this one device and not two devices?  The description indicated
> that this was two separate bits of silicon.

In theory there are 3 devices,
one is the pmic-spmi driver, which provides regmap access to analog part 
of codec registers.
second is syscon driver which provides regmap access to digital parts of 
codec to codec driver.
third is the codec driver which uses both the above.

Codec registers range is just split into two, range 0x0- 0x200 sits in 
pmic address space and range 0x201 - 0x4ff in the SOC address space,

Are there any other better ways to model this kinda driver?

>
>> +static int msm8916_wcd_write(struct snd_soc_codec *codec, unsigned int reg,
>> +			     unsigned int val)
>> +{
>> +	int ret = -EINVAL;
>> +	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
>> +	u8 *cache = codec->reg_cache;
>> +
>> +	if (!msm8916_wcd_reg_readonly[reg])
>> +		cache[reg] = val;
>
> Why is the driver open coding a cache?  Don't do that!
>
Yep Will remove it. I guess this is already done in the core..
>> +	case SND_SOC_DAPM_POST_PMU:
>> +		if (w->shift == 5)
>> +			snd_soc_update_bits(codec, LPASS_CDC_RX1_B6_CTL,
>> +					    RXn_B6_CTL_MUTE_MASK, 0);
>> +		else if (w->shift == 4)
>> +			snd_soc_update_bits(codec, LPASS_CDC_RX2_B6_CTL,
>> +					    RXn_B6_CTL_MUTE_MASK, 0);
>
> Switch statement.
>
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
>
> I'm not terribly clear what this is doing, it probably needs some
> comments explaining what's going on at the very least.
I will make sure that I comment it properly in next version.

>
>> +	/*RX stuff */
>> +	SND_SOC_DAPM_AIF_IN("I2S RX1", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("I2S RX2", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("I2S RX3", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
>
> Use DAPM routes to connect the widgets in, don't name the DAI in the
> widget.
Yep, I will relook at this.
>
>> +		mclk_rate = clk_get_rate(msm8916_wcd->mclk);
>> +
>> +		if (mclk_rate == 12288000)
>> +			snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
>> +					    TOP_CTL_DIG_MCLK_FREQ_MASK,
>> +					    TOP_CTL_DIG_MCLK_FREQ_F_12_288MHZ);
>> +
>> +		else if (mclk_rate == 9600000)
>> +			snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
>> +					    TOP_CTL_DIG_MCLK_FREQ_MASK,
>> +					    TOP_CTL_DIG_MCLK_FREQ_F_9_6MHZ);
>
> Switch statement, and this should also handle unexpected rates.
Yep, sounds good, Will fix it in next version.

>
>> +static int msm8916_wcd_codec_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
>> +	int err, reg;
>> +
>> +	err = regulator_enable(chip->vddio);
>> +	if (err < 0) {
>> +		dev_err(codec->dev,
>> +			"failed to enable VDDIO regulator (%d)\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = regulator_enable(chip->vdd_tx_rx);
>> +	if (err < 0) {
>> +		dev_err(codec->dev,
>> +			"failed to enable VDD_TX_RX regulator (%d)\n", err);
>> +		regulator_disable(chip->vddio);
>> +		return err;
>> +	}
>
> Why is this not using regulator_bulk_enable()?  I'd also expect to see
> most if not all of this initial setup stuff in the main device probe.
Yep, we can move to using bulk* apis.
>
>> +	if (TOMBAK_IS_1_0(chip->pmic_rev)) {
>> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults); reg++)
>> +			snd_soc_write(codec, wcd_reg_defaults[reg].reg,
>> +				      wcd_reg_defaults[reg].val);
>> +	} else {
>> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
>> +			snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
>> +				      wcd_reg_defaults_2_0[reg].val);
>> +	}
>
> Please reset the chip properly.
Yep. I will re-order the
>
>> +	ret = clk_prepare_enable(chip->mclk);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to enable mclk %d\n", ret);
>> +		return ret;
>> +	}
>
> Runtime PM?

I will re-look at runtime pm stuff before I send the next version.
>
>> +static const struct of_device_id msm8916_wcd_match_table[] = {
>> +	{.compatible = "qcom,msm8916-pmic-wcd-codec"},
>> +	{}
>> +};
>
> We were peering inside the parent for the register map, why does this

I think that's the only way/interface to access PMIC spmi registers I guess.
> appear in the device tree as a separate device?  Both the patch

This node is child of spmi bus, like the other spmi devices.

> description and that code suggest that it doesn't really have a separate
> existence independent of the broader IP.
>
Yes, the code is written in a way that there is no separate existence 
hiding the register map split in the read/write wrappers.

thanks,
srini
