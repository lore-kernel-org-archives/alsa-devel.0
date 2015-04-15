From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: Re: [PATCH] ASoC: Add support for NAU8825 codec to ASoC
Date: Wed, 15 Apr 2015 17:26:39 +0800
Message-ID: <552E2ECF.8000801@nuvoton.com>
References: <55277A06.3060206@nuvoton.com> <55278BEF.5070406@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55278BEF.5070406@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 2015/4/10 =E4=B8=8B=E5=8D=88 04:38, Lars-Peter Clausen wrote:
> On 04/10/2015 09:21 AM, Chih-Chiang Chang wrote:
>> The NAU88L25 is an ultra-low power high performance audio codec desi=
gned
>> for smartphone, tablet PC, and other portable devices by Nuvoton, no=
w
>> add linux driver support for it.
>>
>> Signed-off-by: Chih-Chiang Chang <ccchang12@nuvoton.com>
>> ---
>>   include/sound/nau8825_plat.h |  22 ++
>>   sound/soc/codecs/Kconfig     |   5 +
>>   sound/soc/codecs/Makefile    |   2 +
>>   sound/soc/codecs/nau8825.c   | 593 +++++++++++++++++++++++++++++++=
++++++++++++
>>   sound/soc/codecs/nau8825.h   | 150 +++++++++++
>>   5 files changed, 772 insertions(+)
>>   create mode 100644 include/sound/nau8825_plat.h
>>   create mode 100644 sound/soc/codecs/nau8825.c
>>   create mode 100644 sound/soc/codecs/nau8825.h
>>
>> diff --git a/include/sound/nau8825_plat.h b/include/sound/nau8825_pl=
at.h
>> new file mode 100644
>> index 0000000..87afcd3
>> --- /dev/null
>> +++ b/include/sound/nau8825_plat.h
>=20
> the preferred place for platform_data files is include/linux/platform=
_data/,=20
> but the driver doesn't seem to use the platform data anyway, so maybe=
 drop it?

The data is reserved for future use, so drop it now.

=46or the preferred place for platform_data files, there are more than =
300
files in the sound/soc/codecs folder. But I find only few files refer
the platform_data files in include/linux/platform_data/ folder,
most files put platform_data files in include/sound/ folder.

	cczhang@MS00-Linux:~/broonie_linux/sound/sound/soc/codecs$ grep -nr
"linux/platform_data/" *
	adau1761.c:20:#include <linux/platform_data/adau17x1.h>
	adau1781.c:20:#include <linux/platform_data/adau17x1.h>
	adau17x1.h:5:#include <linux/platform_data/adau17x1.h>
	adau1977.c:16:#include <linux/platform_data/adau1977.h>
	ssm2518.c:17:#include <linux/platform_data/ssm2518.h>

>=20
> [...]
>> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
>> new file mode 100644
>> index 0000000..a8c8f59
>> --- /dev/null
>> +++ b/sound/soc/codecs/nau8825.c
>> @@ -0,0 +1,593 @@
>> +/*
>> + * linux/sound/soc/codecs/nau8825.c
>=20
> No need to include the file path in the header of the file, this will=
 just=20
> become outdated if the file is ever moved.

Removed the file path in source.

>=20
> [...]
>> +static int nau8825_hw_params(struct snd_pcm_substream *substream,
>> +				struct snd_pcm_hw_params *params,
>> +				struct snd_soc_dai *dai);
>> +static int nau8825_set_dai_fmt(struct snd_soc_dai *codec_dai,
>> +				unsigned int fmt);
>> +static int nau8825_set_bias_level(struct snd_soc_codec *codec,
>> +				enum snd_soc_bias_level level);
>> +static int nau8825_dai_set_sysclk(struct snd_soc_dai *dai, int clk_=
id,
>> +				unsigned int freq, int dir);
>=20
> These forward declarations don't seem to be necessary.

Removed.

>=20
> [...]
>> +static const struct snd_kcontrol_new nau8825_snd_controls[] =3D {
>> +
>=20
>> +	SOC_SINGLE("HP Class OP", NAU8825_CLASS_G_CTRL, NAU8825_CLASS_G_SH=
IFT,
>> +				 1, 0),
>=20
> What is "Class OP"?

"Class OP" means amplifier. The code is removed due to DAC DAPM widgets
have the same bit control for NAU8825_CLASS_G_CTRL.

>=20
>> +	SOC_SINGLE("DAC Right", NAU8825_DAC_CTRL, NAU8825_DAC_R_SFT, 1, 0)=
,
>> +	SOC_SINGLE("DAC Left", NAU8825_DAC_CTRL, NAU8825_DAC_L_SFT, 1, 0),
>=20
> The same bits are controlled by the DAC DAPM widgets, there shouldn't=
 be any=20
> controls for them.

Removed.

>=20
>> +	SOC_SINGLE("DAC Right Clock", NAU8825_DAC_CTRL, NAU8825_DAC_CLK_R_=
SFT,
>> +				1, 0),
>> +	SOC_SINGLE("DAC Left Clock", NAU8825_DAC_CTRL, NAU8825_DAC_CLK_L_S=
=46T,
>> +				1, 0),
>=20
> The clock controls should probably not be user controllable but rathe=
r be=20
> DAPM supply widgets.

The code is not used, removed.

>=20
>> +};
>> +
>> +static const struct snd_kcontrol_new nau8825_hpo_mix[] =3D {
>> +	SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
>> +	NAU8825_L_MUTE_SFT, 1, 1),
>> +	SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
>> +	NAU8825_R_MUTE_SFT, 1, 1),
>> +};
>> +
>> +static const struct snd_soc_dapm_widget nau8825_dapm_widgets[] =3D =
{
>> +
>> +	SND_SOC_DAPM_INPUT("Mic Jack"),
>=20
> Input and output widgets should have the same name as the matching pi=
n of=20
> the CODEC.

Modified as below.

	SND_SOC_DAPM_INPUT("MIC"),

>=20
>> +	SND_SOC_DAPM_MICBIAS("MIC BIAS", NAU8825_BOOST, NAU8825_G_BIAS_SFT=
, 0),
>=20
> New drivers shouldn't use DAPM_MICBIAS widgets as they are known to b=
e=20
> broken. Use a DAPM_SUPPLY widget instead.

Modified as below.

	SND_SOC_DAPM_SUPPLY("MIC BIAS", NAU8825_BOOST, NAU8825_G_BIAS_SFT, 0,
				NULL, 0),

>=20
>> +	SND_SOC_DAPM_SUPPLY("micbias", SND_SOC_NOPM, 0, 0,
>> +				NULL, SND_SOC_DAPM_PRE_PMU
>> +				| SND_SOC_DAPM_POST_PMD),
>> +	SND_SOC_DAPM_SUPPLY("vmid", SND_SOC_NOPM, 0, 0, NULL,
>> +				SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>=20
> Both the vmid and micbias supply seem to be unused and don't do anyth=
ing either.

Removed.

>=20
>> +	/* ADCs */
>> +	SND_SOC_DAPM_ADC("ADC L", NULL, SND_SOC_NOPM, 0, 0),
>> +	SND_SOC_DAPM_ADC("ADC R", NULL, SND_SOC_NOPM, 0, 0),
>> +	/* ADC IF1  */
>> +	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
>=20
> This one seems to be unused, and doesn't do anything either.

Removed.

>=20
>> +	/* Audio Interface */
>> +	SND_SOC_DAPM_AIF_IN("AIF1RX", "AIF1 Playback", 0, SND_SOC_NOPM, 0,=
 0),
>> +	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0,=
 0),
>> +	/* DACs */
>> +	SND_SOC_DAPM_DAC_E("DAC L1", NULL, NAU8825_DAC_CTRL,
>> +				NAU8825_DAC_L_SFT, 0, NULL,
>> +				SND_SOC_DAPM_PRE_PMD),
>=20
> Just use DAC instead of DAC_E if you don't have to implement a callba=
ck

Modified as below.

	SND_SOC_DAPM_DAC("DAC L1", NULL, NAU8825_DAC_CTRL,
				NAU8825_DAC_L_SFT, 0),

>=20
>> +	SND_SOC_DAPM_DAC_E("DAC R1", NULL, NAU8825_DAC_CTRL,
>> +				NAU8825_DAC_R_SFT, 0, NULL,
>> +				SND_SOC_DAPM_PRE_PMD),
>=20
> Same here.

Modified as below.

	SND_SOC_DAPM_DAC("DAC R1", NULL, NAU8825_DAC_CTRL,
				NAU8825_DAC_R_SFT, 0),

>=20
>> +	/* SPO/HPO/LOUT/Mono Mixer */
>> +	SND_SOC_DAPM_MIXER("HPO MIX", SND_SOC_NOPM, 0, 0, nau8825_hpo_mix,
>> +				ARRAY_SIZE(nau8825_hpo_mix)),
>> +	SND_SOC_DAPM_PGA_S("HP amp", 1, NAU8825_CLASS_G_CTRL,
>> +				NAU8825_CLASS_G_SHIFT, 0, NULL, 0),
>=20
> No need for _S if there is no sub-sequencing involved.

Modified as below.

	SND_SOC_DAPM_SUPPLY("HP amp", NAU8825_CLASS_G_CTRL,
				NAU8825_CLASS_G_SHIFT, 0, NULL, 0),

>=20
>> +	/* Output Lines */
>> +	SND_SOC_DAPM_OUTPUT("HPOL"),
>> +	SND_SOC_DAPM_OUTPUT("HPOR"),
>> +};
>> +
> [...
>> +static int nau8825_hw_params(struct snd_pcm_substream *substream,
>> +				struct snd_pcm_hw_params *params,
>> +				struct snd_soc_dai *tmp)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
>> +	struct snd_soc_codec *codec =3D rtd->codec;
>=20
>=20
> rtd->codec does not necessarily point to your CODEC device, use dai->=
codec=20
> instead. As rule of thumb you should never have to look at the=20
> snd_soc_pcm_runtime in a CODEC driver.
>=20

Modified as below.

static int nau8825_hw_params(struct snd_pcm_substream *substream,
				struct snd_pcm_hw_params *params,
				struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec =3D dai->codec;

>=20
> [...]
>> +
>> +static void config_fll_clk_12m(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_update_bits(codec, NAU8825_CLK_DIVIDER, 0x000F, 0x0003);
>> +	snd_soc_update_bits(codec, NAU8825_FL_1, 0x007F, 0x0001);
>> +	snd_soc_write(codec, NAU8825_FL_2, 0xC49B);
>> +	snd_soc_update_bits(codec, NAU8825_FL_3, 0x03FF, 0x0020);
>> +	snd_soc_update_bits(codec, NAU8825_FL_4, 0x0C00, 0x0800);
>> +	snd_soc_update_bits(codec, NAU8825_FL_5, 0x2000, 0x0000);
>> +	snd_soc_update_bits(codec, NAU8825_FL_6, 0x4000, 0x4000);
>=20
> So what do these magic values do?

Modified as below, add definition and remark.

static void config_fll_clk_12m(struct snd_soc_codec *codec)
{
	struct nau8825_priv *nau8825 =3D snd_soc_codec_get_drvdata(codec);

	regmap_update_bits(nau8825->regmap, NAU8825_CLK_DIVIDER,
				NAU8825_CLK_MCLK_SRC_MASK, 0x0003);
	regmap_update_bits(nau8825->regmap, NAU8825_FLL_1,
				NAU8825_FLL_RATIO_MASK, 0x0001);
	/* FLL 16-bit fractional input */
	regmap_write(nau8825->regmap, NAU8825_FLL_2, 0xC49B);
	/* FLL 10-bit integer input */
	regmap_update_bits(nau8825->regmap, NAU8825_FLL_3,
				NAU8825_FLL_INTEGER_MASK, 0x0020);
	/* FLL pre-scaler */
	regmap_update_bits(nau8825->regmap, NAU8825_FLL_4,
				NAU8825_FLL_REF_DIV_MASK, 0x0800);
	/* select divied VCO input */
	regmap_update_bits(nau8825->regmap, NAU8825_FLL_5,
				NAU8825_FLL_FILTER_SW_MASK, 0x0000);
	/* FLL sigma delta modulator enable */
	regmap_update_bits(nau8825->regmap, NAU8825_FLL_6,
				NAU8825_SDM_EN_MASK, 0x4000);

>=20
>> +}
>> +
>> +void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
>=20
> static

Modified as below.

static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)

>=20
>> +{
>> +	pr_debug("%s :: sys_clk=3D%x\n", __func__, sys_clk);
> [...
>> +static int nau8825_codec_suspend(struct snd_soc_codec *codec)
>> +{
>> +	nau8825_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +	return 0;
>> +}
>=20
> set the suspend_bias_off flag in your codec driver to let the core ta=
ke care=20
> of this.

Removed nau8825_codec_suspend() and added suspend_bias_off flag in
soc_codec_driver_nau8825.

        .remove =3D nau8825_codec_remove,
-       .suspend =3D nau8825_codec_suspend,
-       .resume =3D nau8825_resume,
+       .suspend_bias_off =3D true,
        .set_bias_level =3D nau8825_set_bias_level,
        .controls =3D nau8825_snd_controls,
        .num_controls =3D ARRAY_SIZE(nau8825_snd_controls),

>=20
>> +
>> +static int nau8825_resume(struct snd_soc_codec *codec)
>> +{
>> +	nau8825_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +	return 0;
>> +}
>=20
> This is not necessary the core already takes care of it.

Removed.

>=20
>> +
> [...]
>> +static int nau8825_codec_probe(struct snd_soc_codec *codec)
>> +{
>> +	int i;
>> +	struct nau8825_priv *nau8825;
>> +
>> +	nau8825 =3D snd_soc_codec_get_drvdata(codec);
>> +	nau8825->codec =3D codec;
>> +	/*writing initial register values to the codec*/
>> +	for (i =3D 0; i < ARRAY_SIZE(nau8825_reg); i++)
>> +		snd_soc_write(codec, nau8825_reg[i].reg, nau8825_reg[i].def);
>=20
> If that is really necessary use regmap_sync() and preferably in the i=
2c=20
> probe function. But I'd expect that a soft reset should put the devic=
e in=20
> the default register configuration?

About the regmap_sync(), I cannot find it in Linux. Do you mean the
regcache_sync()? But it is used to sync the register cache with the
hardware, not set reg_defaults array to hardware.

Remove nau8825_codec_probe() and add below code in nau8825_i2c_probe().

                dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", r=
et);
                goto err_enable;
        }
+       /* software reset */
+       regmap_write(nau8825->regmap, NAU8825_RESET, 0x01);
+       regmap_write(nau8825->regmap, NAU8825_RESET, 0x02);
+       /*writing initial register values to the codec*/
+       for (i =3D 0; i < ARRAY_SIZE(nau8825_reg); i++)
+               regmap_write(nau8825->regmap, nau8825_reg[i].reg,
+               nau8825_reg[i].def);
+
        ret =3D snd_soc_register_codec(&i2c->dev, &soc_codec_driver_nau=
8825,
                                nau8825_dai_driver,
                                ARRAY_SIZE(nau8825_dai_driver));

>=20
>> +	return 0;
>> +}
>> +
> [...]
>> +static struct snd_soc_codec_driver soc_codec_driver_nau8825 =3D {
>=20
> const

Modified as below.

static const struct snd_soc_codec_driver soc_codec_driver_nau8825 =3D {

>=20
>> +	.probe =3D nau8825_codec_probe,
>> +	.remove	=3D nau8825_codec_remove,
>> +	.suspend =3D nau8825_codec_suspend,
>> +	.resume	=3D nau8825_resume,
>> +	.set_bias_level	=3D nau8825_set_bias_level,
>> +	.controls =3D nau8825_snd_controls,
>> +	.num_controls =3D ARRAY_SIZE(nau8825_snd_controls),
>> +	.dapm_widgets =3D nau8825_dapm_widgets,
>> +	.num_dapm_widgets =3D ARRAY_SIZE(nau8825_dapm_widgets),
>> +	.dapm_routes =3D nau8825_dapm_routes,
>> +	.num_dapm_routes =3D ARRAY_SIZE(nau8825_dapm_routes),
>> +};
>> +
>=20
>> +static struct snd_soc_dai_ops nau8825_dai_ops =3D {
>=20
> const

Modified as below.

static const struct snd_soc_dai_ops nau8825_dai_ops =3D {

>=20
>> +	.hw_params	=3D nau8825_hw_params,
>> +	.set_sysclk	=3D nau8825_dai_set_sysclk,
>> +	.set_fmt	=3D nau8825_set_dai_fmt,
>> +	.digital_mute	=3D nau8825_dac_mute,
>> +};
>> +
>> +static struct snd_soc_dai_driver nau8825_dai_driver[] =3D {
>> +	{
>> +		.name =3D "nau8825-aif1",
>> +			.playback =3D {
>> +				.stream_name	 =3D "AIF1 Playback",
>> +				.channels_min	 =3D 1,
>> +				.channels_max	 =3D 2,
>> +				.rates		 =3D NAU8825_RATES,
>> +				.formats	 =3D NAU8825_FORMATS,
>> +			},
>> +			.capture =3D {
>> +				.stream_name	 =3D "AIF1 Capture",
>> +				.channels_min	 =3D 1,
>> +				.channels_max	 =3D 2,
>> +				.rates		 =3D NAU8825_RATES,
>> +				.formats	 =3D NAU8825_FORMATS,
>> +			},
>> +		.ops =3D &nau8825_dai_ops,
>> +	}
>> +};
>> +
>> +
>> +static int nau8825_i2c_probe(struct i2c_client *i2c,
>> +				 const struct i2c_device_id *i2c_id)
>> +{
>> +	struct nau8825_platform_data *pdata =3D dev_get_platdata(&i2c->dev=
);
>> +	struct nau8825_priv *nau8825;
>> +	int ret;
>> +
>> +	nau8825 =3D devm_kzalloc(&i2c->dev, sizeof(struct nau8825_priv),
>=20
> preferred form for this is sizeof(*nau8825)

Modified as below.

	nau8825 =3D devm_kzalloc(&i2c->dev, sizeof(*nau8825),

>=20
> [...]
>> +MODULE_DESCRIPTION("ASoC NAU8825 codec driver");
>> +MODULE_AUTHOR("Nuvoton");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +
>=20
> No need for the extra new lines at the end

Removed the new lines.

>=20
>> diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
>> new file mode 100644
>> index 0000000..b16d4d1
>> --- /dev/null
>> +++ b/sound/soc/codecs/nau8825.h
>> @@ -0,0 +1,150 @@
>> +/*
> [...]
>> +
>> +struct nau8825_priv {
>> +	struct snd_soc_codec *codec;
>> +	struct nau8825_platform_data pdata;
>> +	struct regmap *regmap;
>> +	struct i2c_client *i2c;
>> +	struct snd_soc_jack *hp_jack;
>> +	struct snd_soc_jack *mic_jack;
>> +	struct delayed_work delayed_work;
>> +
>> +	struct workqueue_struct *workqueue;
>> +	struct mutex mutex;
>> +	unsigned int irq;
>> +	bool jd_status;
>> +	bool bp_status;
>> +	int	jack_type;
>> +};
>=20
> It looks like pretty much all of the fields in the struct are not use=
d by=20
> the driver.

Removed some field and modified as below.

@@ -136,15 +163,7 @@ struct nau8825_priv {
        struct nau8825_platform_data pdata;
        struct regmap *regmap;
        struct i2c_client *i2c;
-       struct snd_soc_jack *hp_jack;
-       struct snd_soc_jack *mic_jack;
-       struct delayed_work delayed_work;
-
-       struct workqueue_struct *workqueue;
-       struct mutex mutex;
-       unsigned int irq;
-       bool jd_status;
-       bool bp_status;
-       int     jack_type;
+       struct snd_soc_jack *jack;
+       struct delayed_work jack_detect_work;
 };

>=20
>> +#endif	/* _NAU8825_H */
>>
>=20
