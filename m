From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 27 Mar 2013 01:15:13 +0000
Message-ID: <20130327011511.GP18316@opensource.wolfsonmicro.com>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7425804119356255716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6981C261723
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 02:15:17 +0100 (CET)
In-Reply-To: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Johnny Hsu <johnnyhsu@realtek.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7425804119356255716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K9FEQnHYtEQyKlzu"
Content-Disposition: inline


--K9FEQnHYtEQyKlzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2013 at 05:35:38PM -0600, Stephen Warren wrote:

> Mark, a couple questions:
> * Is the custom index_reg device attr file OK, or should I remove that?
> * Do new CODEC drivers have to use regmap directly, or is using the ASoC
>   IO system still OK?

Convert to regmap please - it looks like this ought to be using the
paging support from a quick glance at what the register I/O stuff is
doing.  The device file appears to duplicate the register dump stuff and
isn't suitable for sysfs anyway as it's not one value per file, it ought
to be in debugfs.

> +/* IN1/IN2 Input Type */
> +static const char * const rt5640_input_mode[] = {
> +	"Single ended", "Differential"};

This looks like platform data.

> +static const char * const rt5640_data_select[] = {
> +	"Normal", "left copy to right", "right copy to left", "Swap"};

DAPM?

> +/* DMIC */
> +static const char * const rt5640_dmic_mode[] = {"Disable", "DMIC1", "DMIC2"};
> +
> +static const SOC_ENUM_SINGLE_DECL(rt5640_dmic_enum, 0, 0, rt5640_dmic_mode);

DAPM?

> +static int rt5640_vol_rescale_get(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	unsigned int val = snd_soc_read(codec, mc->reg);
> +
> +	ucontrol->value.integer.value[0] = VOL_RESCALE_MAX_VOL -
> +		((val & RT5640_L_VOL_MASK) >> mc->shift);
> +	ucontrol->value.integer.value[1] = VOL_RESCALE_MAX_VOL -
> +		(val & RT5640_R_VOL_MASK);

This looks like a range control.

> +static int hp_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		break;
> +
> +	case SND_SOC_DAPM_PRE_PMD:
> +		break;
> +
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}

This does nothing, it should be removed.

> +static int rt5640_set_dmic1_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(codec, RT5640_GPIO_CTRL1,
> +			RT5640_GP2_PIN_MASK | RT5640_GP3_PIN_MASK,
> +			RT5640_GP2_PIN_DMIC1_SCL | RT5640_GP3_PIN_DMIC1_SDA);
> +		snd_soc_update_bits(codec, RT5640_DMIC,
> +			RT5640_DMIC_1L_LH_MASK | RT5640_DMIC_1R_LH_MASK |
> +			RT5640_DMIC_1_DP_MASK,
> +			RT5640_DMIC_1L_LH_FALLING | RT5640_DMIC_1R_LH_RISING |
> +			RT5640_DMIC_1_DP_IN1P);
> +		snd_soc_update_bits(codec, RT5640_DMIC,
> +			RT5640_DMIC_1_EN_MASK, RT5640_DMIC_1_EN);
> +	default:
> +		return 0;

The last write there looks awfully like an enable but there's not any
corresponding disable...

> +static int rt5640_set_dmic2_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(codec, RT5640_GPIO_CTRL1,
> +			RT5640_GP2_PIN_MASK | RT5640_GP4_PIN_MASK,
> +			RT5640_GP2_PIN_DMIC1_SCL | RT5640_GP4_PIN_DMIC2_SDA);

There's a degree of overlap between these two functions...

> +static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
> +	{"IN1P", NULL, "LDO2"},
> +	{"IN2P", NULL, "LDO2"},
> +
> +	{"IN1P", NULL, "MIC1"},
> +	{"IN1N", NULL, "MIC1"},
> +	{"IN2P", NULL, "MIC2"},
> +	{"IN2N", NULL, "MIC2"},

Are MIC1 and MIC2 pins on the device?  It's a bit odd to have a single
physical input feeding both sides of a differential path internally.

> +	{"DMIC L1", NULL, "DMIC CLK"},
> +	{"DMIC L2", NULL, "DMIC CLK"},

Shouldn't the DMIC CLK widget be handling the clock enables/muxes from
the DMIC event above?

> +static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
> +{
> +	int ret = 0, val = snd_soc_read(codec, RT5640_I2S1_SDP);
> +
> +	if (codec == NULL)
> +		return -EINVAL;

No point in the NULL check immediately after a dereference.

> +	val = (val & RT5640_I2S_IF_MASK) >> RT5640_I2S_IF_SFT;
> +	switch (dai_id) {
> +	case RT5640_AIF1:
> +		if (val == RT5640_IF_123 || val == RT5640_IF_132 ||
> +			val == RT5640_IF_113)
> +			ret |= RT5640_U_IF1;
> +		if (val == RT5640_IF_312 || val == RT5640_IF_213 ||
> +			val == RT5640_IF_113)
> +			ret |= RT5640_U_IF2;
> +		if (val == RT5640_IF_321 || val == RT5640_IF_231)
> +			ret |= RT5640_U_IF3;

The tree of if ( || || ) looks like a switch statement and should
probably be written as such.

> +	frame_size = snd_soc_params_to_frame_size(params);
> +	if (frame_size < 0) {
> +		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
> +		return -EINVAL;
> +	}

The error message here is confusing as a negative code is an errno not a
frame size and it probably ought to be passed to the caller.

> +	bclk_ms = frame_size > 32 ? 1 : 0;

Grumble.

> +static int rt5640_prepare(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
> +
> +	rt5640->aif_pu = dai->id;
> +	return 0;
> +}

This looks like only one DAI can be active at once, shouldn't there be
some sort of checking for busy here?

> +	dai_sel = get_sdp_info(codec, dai->id);
> +	if (dai_sel < 0) {
> +		dev_err(codec->dev, "Failed to get sdp info: %d\n", dai_sel);
> +		return -EINVAL;
> +	}

I suspect using dai->base (or just picking a suitable value for dai->id
even) would be simpler.

> +	if (dai_sel & RT5640_U_IF1) {
> +		snd_soc_update_bits(codec, RT5640_I2S1_SDP,
> +			RT5640_I2S_MS_MASK | RT5640_I2S_BP_MASK |
> +			RT5640_I2S_DF_MASK, reg_val);
> +	}
> +	if (dai_sel & RT5640_U_IF2) {
> +		snd_soc_update_bits(codec, RT5640_I2S2_SDP,
> +			RT5640_I2S_MS_MASK | RT5640_I2S_BP_MASK |
> +			RT5640_I2S_DF_MASK, reg_val);
> +	}

This looks like switch statements again, though (not having checked) I'd
expect that there's just blocks of registers for each DAI and we could
just work in terms of a base?

> +/**
> + * rt5640_pll_calc - Calcualte PLL M/N/K code.

Typo.

> +	snd_soc_add_codec_controls(codec, rt5640_snd_controls,
> +		ARRAY_SIZE(rt5640_snd_controls));

Set in the driver structure.

> +static int rt5640_resume(struct snd_soc_codec *codec)
> +{
> +	int ret = 0 ;
> +
> +	codec->cache_sync = 1;
> +	ret = snd_soc_cache_sync(codec);
> +	if (ret) {
> +		dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
> +		return ret;
> +	}
> +	rt5640_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

We also sync the cache in the bias management code.

> +static int rt5640_i2c_probe(struct i2c_client *i2c,
> +		    const struct i2c_device_id *id)
> +{
> +	struct rt5640_priv *rt5640;
> +	int ret;
> +
> +	rt5640 = kzalloc(sizeof(struct rt5640_priv), GFP_KERNEL);
> +	if (NULL == rt5640)
> +		return -ENOMEM;

devm_kzalloc()

> +struct rt5640_pll_code {
> +	bool m_bp; /* Indicates bypass m code or not. */
> +	int m_code;
> +	int n_code;
> +	int k_code;
> +};
> +
> +struct rt5640_priv {
> +	struct snd_soc_codec *codec;

Move these into the body of the driver.

--K9FEQnHYtEQyKlzu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUkcvAAoJELSic+t+oim9PBQQAJ2TCWB/L0jtYkjHwMVfexWI
AQ2jCg6u+KEnevVRJIMYFa8x6aNv0fhll9oiU1qUzoxgecw9PvY8J87Dxy7LcdHz
1uopf3PnbBSF3W3AdQjV2sopUTeN2cEJZlrHJgh371fKNE2HUBkg8M8Mz7tDxr/q
nBG1D9+v/eoQbN80gsbkzNwke7yazGrOl9mYsbiNcL2xbkBDh+EAvKFVNMv8klA0
VSlWN4GqmqSg3ic3JUca8XfDXNQaNuSyBolgZfLmrNjqqdqjhyvWwCFbeo8vdF8J
TUDVd+tDLERm5aBs2MGry5lyEzV7dU3nClrc/aKIUeRXkV5MmZScSAXQQSet/Pdk
Dktrn8kLr/MhYiRmX77Jl0q5i+UZUTd1sSmBfCs8INqWcxejfwsJiBRC4ybw9zxy
jPdstfZEtUjn0rSyQhSCS8VSxP6eCr3PEhTa2YZ1NQ4JN02zcmZK8Wnb9LvVEjbh
PlHiOJGpo9z8ONxA4iQ/qdli1u2avDFiCAyGRHfhaL7AtEXR/wA634cG7Rv7qghE
Qo2iHdBg/JuLoBy4YQtiXue2izqGPRZlYdsMWTOJrHRGKfevWAa/dGq3jXrtJ2+O
6ZkQdPCu3VgEB9gb/3suYNszDSOwGmjXdJNccvw5TuateGOJNywh7kk57+j+DF1w
RcE81fQI50kKx7f5TCVC
=p9la
-----END PGP SIGNATURE-----

--K9FEQnHYtEQyKlzu--

--===============7425804119356255716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7425804119356255716==--
