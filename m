From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Add support for NAU8825 codec to ASoC
Date: Fri, 10 Apr 2015 10:38:07 +0200
Message-ID: <55278BEF.5070406@metafoo.de>
References: <55277A06.3060206@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55277A06.3060206@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>, Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lgirdwood@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/10/2015 09:21 AM, Chih-Chiang Chang wrote:
> The NAU88L25 is an ultra-low power high performance audio codec designed
> for smartphone, tablet PC, and other portable devices by Nuvoton, now
> add linux driver support for it.
>
> Signed-off-by: Chih-Chiang Chang <ccchang12@nuvoton.com>
> ---
>   include/sound/nau8825_plat.h |  22 ++
>   sound/soc/codecs/Kconfig     |   5 +
>   sound/soc/codecs/Makefile    |   2 +
>   sound/soc/codecs/nau8825.c   | 593 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/codecs/nau8825.h   | 150 +++++++++++
>   5 files changed, 772 insertions(+)
>   create mode 100644 include/sound/nau8825_plat.h
>   create mode 100644 sound/soc/codecs/nau8825.c
>   create mode 100644 sound/soc/codecs/nau8825.h
>
> diff --git a/include/sound/nau8825_plat.h b/include/sound/nau8825_plat.h
> new file mode 100644
> index 0000000..87afcd3
> --- /dev/null
> +++ b/include/sound/nau8825_plat.h

the preferred place for platform_data files is include/linux/platform_data/, 
but the driver doesn't seem to use the platform data anyway, so maybe drop it?

[...]
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> new file mode 100644
> index 0000000..a8c8f59
> --- /dev/null
> +++ b/sound/soc/codecs/nau8825.c
> @@ -0,0 +1,593 @@
> +/*
> + * linux/sound/soc/codecs/nau8825.c

No need to include the file path in the header of the file, this will just 
become outdated if the file is ever moved.

[...]
> +static int nau8825_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai);
> +static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai,
> +				unsigned int fmt);
> +static int nau8825_set_bias_level(struct snd_soc_codec *codec,
> +				enum snd_soc_bias_level level);
> +static int nau8825_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				unsigned int freq, int dir);

These forward declarations don't seem to be necessary.

[...]
> +static const struct snd_kcontrol_new nau8825_snd_controls[] = {
> +

> +	SOC_SINGLE("HP Class OP", NAU8825_CLASS_G_CTRL, NAU8825_CLASS_G_SHIFT,
> +				 1, 0),

What is "Class OP"?

> +	SOC_SINGLE("DAC Right", NAU8825_DAC_CTRL, NAU8825_DAC_R_SFT, 1, 0),
> +	SOC_SINGLE("DAC Left", NAU8825_DAC_CTRL, NAU8825_DAC_L_SFT, 1, 0),

The same bits are controlled by the DAC DAPM widgets, there shouldn't be any 
controls for them.

> +	SOC_SINGLE("DAC Right Clock", NAU8825_DAC_CTRL, NAU8825_DAC_CLK_R_SFT,
> +				1, 0),
> +	SOC_SINGLE("DAC Left Clock", NAU8825_DAC_CTRL, NAU8825_DAC_CLK_L_SFT,
> +				1, 0),

The clock controls should probably not be user controllable but rather be 
DAPM supply widgets.

> +};
> +
> +static const struct snd_kcontrol_new nau8825_hpo_mix[] = {
> +	SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
> +	NAU8825_L_MUTE_SFT, 1, 1),
> +	SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
> +	NAU8825_R_MUTE_SFT, 1, 1),
> +};
> +
> +static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] = {
> +
> +	SND_SOC_DAPM_INPUT("Mic Jack"),

Input and output widgets should have the same name as the matching pin of 
the CODEC.

> +	SND_SOC_DAPM_MICBIAS("MIC BIAS", NAU8825_BOOST, NAU8825_G_BIAS_SFT, 0),

New drivers shouldn't use DAPM_MICBIAS widgets as they are known to be 
broken. Use a DAPM_SUPPLY widget instead.

> +	SND_SOC_DAPM_SUPPLY("micbias", SND_SOC_NOPM, 0, 0,
> +				NULL, SND_SOC_DAPM_PRE_PMU
> +				| SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_SUPPLY("vmid", SND_SOC_NOPM, 0, 0, NULL,
> +				SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),

Both the vmid and micbias supply seem to be unused and don't do anything either.

> +	/* ADCs */
> +	SND_SOC_DAPM_ADC("ADC L", NULL, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_ADC("ADC R", NULL, SND_SOC_NOPM, 0, 0),
> +	/* ADC IF1  */
> +	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),

This one seems to be unused, and doesn't do anything either.

> +	/* Audio Interface */
> +	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
> +	/* DACs */
> +	SND_SOC_DAPM_DAC_E("DAC L1", NULL, NAU8825_DAC_CTRL,
> +				NAU8825_DAC_L_SFT, 0, NULL,
> +				SND_SOC_DAPM_PRE_PMD),

Just use DAC instead of DAC_E if you don't have to implement a callback

> +	SND_SOC_DAPM_DAC_E("DAC R1", NULL, NAU8825_DAC_CTRL,
> +				NAU8825_DAC_R_SFT, 0, NULL,
> +				SND_SOC_DAPM_PRE_PMD),

Same here.

> +	/* SPO/HPO/LOUT/Mono Mixer */
> +	SND_SOC_DAPM_MIXER("HPO MIX", SND_SOC_NOPM, 0, 0, nau8825_hpo_mix,
> +				ARRAY_SIZE(nau8825_hpo_mix)),
> +	SND_SOC_DAPM_PGA_S("HP amp", 1, NAU8825_CLASS_G_CTRL,
> +				NAU8825_CLASS_G_SHIFT, 0, NULL, 0),

No need for _S if there is no sub-sequencing involved.

> +	/* Output Lines */
> +	SND_SOC_DAPM_OUTPUT("HPOL"),
> +	SND_SOC_DAPM_OUTPUT("HPOR"),
> +};
> +
[...
> +static int nau8825_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *tmp)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;


rtd->codec does not necessarily point to your CODEC device, use dai->codec 
instead. As rule of thumb you should never have to look at the 
snd_soc_pcm_runtime in a CODEC driver.


[...]
> +
> +static void config_fll_clk_12m(struct snd_soc_codec *codec)
> +{
> +	snd_soc_update_bits(codec, NAU8825_CLK_DIVIDER, 0x000F, 0x0003);
> +	snd_soc_update_bits(codec, NAU8825_FL_1, 0x007F, 0x0001);
> +	snd_soc_write(codec, NAU8825_FL_2, 0xC49B);
> +	snd_soc_update_bits(codec, NAU8825_FL_3, 0x03FF, 0x0020);
> +	snd_soc_update_bits(codec, NAU8825_FL_4, 0x0C00, 0x0800);
> +	snd_soc_update_bits(codec, NAU8825_FL_5, 0x2000, 0x0000);
> +	snd_soc_update_bits(codec, NAU8825_FL_6, 0x4000, 0x4000);

So what do these magic values do?

> +}
> +
> +void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)

static

> +{
> +	pr_debug("%s :: sys_clk=%x\n", __func__, sys_clk);
[...
> +static int nau8825_codec_suspend(struct snd_soc_codec *codec)
> +{
> +	nau8825_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}

set the suspend_bias_off flag in your codec driver to let the core take care 
of this.

> +
> +static int nau8825_resume(struct snd_soc_codec *codec)
> +{
> +	nau8825_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	return 0;
> +}

This is not necessary the core already takes care of it.

> +
[...]
> +static int nau8825_codec_probe(struct snd_soc_codec *codec)
> +{
> +	int i;
> +	struct nau8825_priv *nau8825;
> +
> +	nau8825 = snd_soc_codec_get_drvdata(codec);
> +	nau8825->codec = codec;
> +	/*writing initial register values to the codec*/
> +	for (i = 0; i < ARRAY_SIZE(nau8825_reg); i++)
> +		snd_soc_write(codec, nau8825_reg[i].reg, nau8825_reg[i].def);

If that is really necessary use regmap_sync() and preferably in the i2c 
probe function. But I'd expect that a soft reset should put the device in 
the default register configuration?

> +	return 0;
> +}
> +
[...]
> +static struct snd_soc_codec_driver soc_codec_driver_nau8825 = {

const

> +	.probe = nau8825_codec_probe,
> +	.remove	= nau8825_codec_remove,
> +	.suspend = nau8825_codec_suspend,
> +	.resume	= nau8825_resume,
> +	.set_bias_level	= nau8825_set_bias_level,
> +	.controls = nau8825_snd_controls,
> +	.num_controls = ARRAY_SIZE(nau8825_snd_controls),
> +	.dapm_widgets = nau8825_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(nau8825_dapm_widgets),
> +	.dapm_routes = nau8825_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(nau8825_dapm_routes),
> +};
> +

> +static struct snd_soc_dai_ops nau8825_dai_ops = {

const

> +	.hw_params	= nau8825_hw_params,
> +	.set_sysclk	= nau8825_dai_set_sysclk,
> +	.set_fmt	= nau8825_set_dai_fmt,
> +	.digital_mute	= nau8825_dac_mute,
> +};
> +
> +static struct snd_soc_dai_driver nau8825_dai_driver[] = {
> +	{
> +		.name = "nau8825-aif1",
> +			.playback = {
> +				.stream_name	 = "AIF1 Playback",
> +				.channels_min	 = 1,
> +				.channels_max	 = 2,
> +				.rates		 = NAU8825_RATES,
> +				.formats	 = NAU8825_FORMATS,
> +			},
> +			.capture = {
> +				.stream_name	 = "AIF1 Capture",
> +				.channels_min	 = 1,
> +				.channels_max	 = 2,
> +				.rates		 = NAU8825_RATES,
> +				.formats	 = NAU8825_FORMATS,
> +			},
> +		.ops = &nau8825_dai_ops,
> +	}
> +};
> +
> +
> +static int nau8825_i2c_probe(struct i2c_client *i2c,
> +				 const struct i2c_device_id *i2c_id)
> +{
> +	struct nau8825_platform_data *pdata = dev_get_platdata(&i2c->dev);
> +	struct nau8825_priv *nau8825;
> +	int ret;
> +
> +	nau8825 = devm_kzalloc(&i2c->dev, sizeof(struct nau8825_priv),

preferred form for this is sizeof(*nau8825)

[...]
> +MODULE_DESCRIPTION("ASoC NAU8825 codec driver");
> +MODULE_AUTHOR("Nuvoton");
> +MODULE_LICENSE("GPL v2");
> +
> +

No need for the extra new lines at the end

> diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
> new file mode 100644
> index 0000000..b16d4d1
> --- /dev/null
> +++ b/sound/soc/codecs/nau8825.h
> @@ -0,0 +1,150 @@
> +/*
[...]
> +
> +struct nau8825_priv {
> +	struct snd_soc_codec *codec;
> +	struct nau8825_platform_data pdata;
> +	struct regmap *regmap;
> +	struct i2c_client *i2c;
> +	struct snd_soc_jack *hp_jack;
> +	struct snd_soc_jack *mic_jack;
> +	struct delayed_work delayed_work;
> +
> +	struct workqueue_struct *workqueue;
> +	struct mutex mutex;
> +	unsigned int irq;
> +	bool jd_status;
> +	bool bp_status;
> +	int	jack_type;
> +};

It looks like pretty much all of the fields in the struct are not used by 
the driver.

> +#endif	/* _NAU8825_H */
>
