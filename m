From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Add DA732x codec driver
Date: Wed, 23 May 2012 12:14:34 +0100
Message-ID: <20120523111434.GL4085@opensource.wolfsonmicro.com>
References: <2E89032DDAA8B9408CB92943514A03372E3F5F40@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6147937296196722097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDF621043FC
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 13:21:08 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03372E3F5F40@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Software Maintainer <software.maintainer@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michal Hajduk <Michal.Hajduk@diasemi.com>, Adam Thomson <Adam.Thomson@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============6147937296196722097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B92bTrfKjyax39gr"
Content-Disposition: inline


--B92bTrfKjyax39gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2012 at 12:57:35PM +0000, Software Maintainer wrote:

> +static void da732x_set_charge_pump(struct snd_soc_codec *codec, int state)
> +{
> +	switch (state) {
> +	case DA732X_ENABLE_CP:

You only ever enable this and it seems like it should be a widget - why
is it not a widget?

> +static const char *da732x_eq_text[] = {
> +	"Disable", "Enable",
> +};

This should be a switch not an enum.

> +static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
> +			  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int reg = enum_ctrl->reg;
> +	unsigned int sel = ucontrol->value.integer.value[0];
> +	unsigned int bits;
> +
> +	switch (sel) {
> +	case DA732X_HPF_DISABLED:
> +		bits = DA732X_HPF_DIS;
> +		break;
> +	case DA732X_HPF_VOICE:
> +		bits = DA732X_HPF_VOICE_EN;
> +		break;
> +	case DA732X_HPF_MUSIC:
> +		bits = DA732X_HPF_MUSIC_EN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	snd_soc_update_bits(codec, reg, DA732X_HPF_MASK, bits);

Why is this not done using a normal enum?

> +	if ((val & DA732X_HPF_MUSIC_EN) == DA732X_HPF_MUSIC_EN)
> +		ucontrol->value.integer.value[0] = DA732X_HPF_MUSIC;
> +	else if ((val & DA732X_HPF_VOICE_EN) == DA732X_HPF_VOICE_EN)
> +		ucontrol->value.integer.value[0] = DA732X_HPF_VOICE;
> +	else
> +		ucontrol->value.integer.value[0] = DA732X_HPF_DISABLED;

Similarly here, and this looks like a switch statement.

> +static int da732x_info_volsw(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_info *uinfo)
> +{
> +	struct soc_mixer_control *mc =
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int platform_max;
> +	int min = mc->min;
> +
> +	if (!mc->platform_max)
> +		mc->platform_max = mc->max;
> +	platform_max = mc->platform_max;
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = 0;
> +	uinfo->value.integer.max = platform_max - min;

This should be generic code, there's nothing device specific about this
control type and it'd be useful for other devices.

> +	/* MICs */
> +	SOC_SINGLE("MIC1 Mute Switch", DA732X_REG_MIC1, DA732X_MIC_MUTE_SHIFT,
> +		   DA732X_SWITCH_MAX, DA732X_INVERT),

Just MIC1 Switch.

> +	/* ADCs */
> +	SOC_SINGLE_TLV("ADC1 L Capture", DA732X_REG_ADC1_SEL,
> +		       DA732X_ADCL_VOL_SHIFT, DA732X_ADC_VOL_VAL_MAX,
> +		       DA732X_INVERT, adc_pga_tlv),

All these should be Volumes, and really they should be stereo controls.

> +	/* DACs */
> +	SOC_DOUBLE_R_TLV("Digital Playback Volume DAC12", DA732X_REG_DAC1_L_VOL,
> +			 DA732X_REG_DAC1_R_VOL, DA732X_DAC_VOL_SHIFT,
> +			 DA732X_DAC_VOL_VAL_MAX, DA732X_INVERT, dac_pga_tlv),

Volume needs to be the last thing in the name.

> +static int da732x_adc_event(struct snd_soc_dapm_widget *w,
> +			    struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_update_bits(codec, w->reg, 1 << w->shift,
> +				    1 << w->shift);
> +		snd_soc_update_bits(codec, w->reg,
> +				    DA732X_ADC_ACT_MASK(w->shift),
> +				    DA732X_ADC_ACT_EN(w->shift));
> +		snd_soc_update_bits(codec, w->reg + DA732X_ADC_REG_SHIFT,
> +				    DA732X_ADC_MASK(w->shift),
> +				    DA732X_ADC_EN(w->shift));
> +		break;

This looks like you perhaps need some supply widgets.  Similarly for
most of your events.

> +	/* Micbias */
> +	SND_SOC_DAPM_MICBIAS("MICBIAS1", DA732X_REG_MICBIAS1,
> +			     DA732X_MICBIAS_EN_SHIFT, 0),
> +	SND_SOC_DAPM_MICBIAS("MICBIAS2", DA732X_REG_MICBIAS2,
> +			     DA732X_MICBIAS_EN_SHIFT, 0),

Don't use MICBIAS widgets for new code, use supply widgets.


> +	{"MICBIAS1", "NULL", "MIC1"},
> +	{"MICBIAS2", "NULL", "MIC2"},

The MICBIASes should be connected on the board.

> +	switch (dai->id) {
> +	case DA732X_DAI_ID1:
> +		reg_aif = DA732X_REG_AIFA1;
> +		break;

Use dai->base.

> +	aif = snd_soc_read(codec, reg_aif);
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		aif |= DA732X_AIF_WORD_16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		aif |= DA732X_AIF_WORD_20;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		aif |= DA732X_AIF_WORD_24;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		aif |= DA732X_AIF_WORD_32;
> +		break;

Use snd_soc_update_bits, this will fix the issue where you don't
currently clear the register.  You're also missing error handling in the
default: case.


> +	switch (params_rate(params)) {
> +	case SR_8000:

Don't make up private defines for generic things like this.  Though
really a define like this is a bit silly...

> +static int da732x_set_dai_pll(struct snd_soc_codec *codec, int pll_id,
> +			      int source, unsigned int freq_in,
> +			      unsigned int freq_out)
> +{
> +	struct da732x_priv *da732x = snd_soc_codec_get_drvdata(codec);
> +	int fref, indiv;
> +	u8 div_lo, div_mid, div_hi;
> +	u64 frac_div;
> +
> +	if (da732x->pll_en)
> +		return 0;

This should either stop and restart the PLL or return an error if it's
already enabled.

> +	if (source == DA732X_SRCCLK_MCLK) {
> +		snd_soc_write(codec, DA732X_REG_PLL_CTRL, DA732X_PLL_BYPASS);
> +		return 0;
> +	}

This doesn't validate against the sysclk rate...

> +	indiv = da732x_get_input_div(codec, da732x->sysclk);
> +	if (indiv < 0)
> +		return -EINVAL;

Pass back the error code.

> +	snd_soc_update_bits(codec, DA732X_REG_PLL_CTRL, DA732X_PLL_EN,
> +			    DA732X_PLL_EN);
> +
> +	da732x->pll_en = true;

This means there's no way to stop the PLL.

> +	if (mute) {
> +		snd_soc_update_bits(codec, DA732X_REG_DAC1_SOFTMUTE,
> +				    DA732X_SOFTMUTE_MASK,
> +				    1 << DA732X_SOFTMUTE_SHIFT);
> +		snd_soc_update_bits(codec, DA732X_REG_DAC2_SOFTMUTE,
> +				    DA732X_SOFTMUTE_MASK,
> +				    1 << DA732X_SOFTMUTE_SHIFT);
> +		snd_soc_update_bits(codec, DA732X_REG_DAC3_SOFTMUTE,
> +				    DA732X_SOFTMUTE_MASK,
> +				    1 << DA732X_SOFTMUTE_SHIFT);

This appears to mute all the DACs but you have two audio interfaces and
also had some other code which also managed the mutes...  If there's no
mutes on the actual audio interfaces just don't implement this.

> +#define DA732X_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
> +		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
> +		      SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

SNDRV_PCM_RATE_8000_48000

> +	/* Init Codec */
> +	snd_soc_write(codec, DA732X_REG_REF1, DA732X_VMID_FASTCHG);
> +	snd_soc_write(codec, DA732X_REG_BIAS_EN, DA732X_BIAS_EN);
> +
> +	mdelay(DA732X_STARTUP_DELAY);

Almost all of this sequence looks like it should be in set_bias_level(),
it'll be needed every time the chip is powered up and sequencing looks
important.

> +	/* Enable Charge Pump */
> +	da732x_set_charge_pump(codec, DA732X_ENABLE_CP);

Shouldn't this be a supply, or again in set_bias_level()?

> +	/* Initialize all clocks */
> +	snd_soc_write(codec, DA732X_REG_CLK_EN1,
> +		      DA732X_SYS3_CLK_EN | DA732X_PC_CLK_EN);
> +	snd_soc_write(codec, DA732X_REG_CLK_EN3,
> +		      DA732X_ADCA_BB_CLK_EN | DA732X_ADCC_BB_CLK_EN);
> +	snd_soc_write(codec, DA732X_REG_CLK_EN4,
> +		      DA732X_DACA_BB_CLK_EN | DA732X_DACC_BB_CLK_EN);
> +	snd_soc_write(codec, DA732X_REG_CLK_EN5, DA732X_DACE_BB_CLK_EN);

Should be dynamically managed.

> +	da732x->regmap = regmap_init_i2c(i2c, &da732x_regmap);

devm_regmap_init_i2c().

> +static const struct i2c_device_id da732x_i2c_id[] = {
> +	{ "da732x-i2c", 0},

Remove the i2c, devices connected by I2C are generally i2c devices...

> +		.name	= "da732x-i2c",

Similarly here.

> +static int __init da732x_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = i2c_add_driver(&da732x_i2c_driver);

module_i2c_driver().

> +/* DAPM helper macros */
> +#define	DA732X_ADC_REG_SHIFT		4
> +#define	DA732X_ADC_ACT_MASK(v)		(1 << ((v) - 2))
> +#define	DA732X_ADC_ACT_EN(v)		(1 << ((v) - 2))
> +#define	DA732X_ADC_ACT_DIS(v)		(0 << ((v) - 2))
> +#define	DA732X_ADC_EN_SHIFT(v)		(((v) - 2) ? 7 : 3)
> +#define	DA732X_ADC_MASK(v)		(1 << DA732X_ADC_EN_SHIFT(v))
> +#define	DA732X_ADC_EN(v)		(1 << DA732X_ADC_EN_SHIFT(v))
> +#define	DA732X_ADC_DIS(v)		(0 << DA732X_ADC_EN_SHIFT(v))
> +#define	DA732X_DAC_EN_MUTED_MASK(v)	((1 << (v)) | (1 << ((v) - 1)))
> +#define	DA732X_DAC_EN_MUTED(v)		DA732X_DAC_EN_MUTED_MASK(v)
> +#define DA732X_DAC_MUTE_MASK(v)		(1 << ((v) - 1))
> +#define DA732X_DAC_EN_MASK(v)		(1 << (v))
> +#define	DA732X_DAC_DIS(v)		(0 << (v))
> +#define	DA732X_DAC_UNMUTE(v)		(0 << ((v) - 1))
> +#define	DA732X_DAC_MUTE(v)		(1 << ((v) - 1))

Really not sure how helpful I found any of these reading the code.

--B92bTrfKjyax39gr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPvMZ8AAoJEBus8iNuMP3daDcP/2CSgBStwBguj3LcU4qbqHYm
hQSES3k4z87lHy58DZjrBJTkqA/fJHvw5aT3Qe4zu8dQ5rvf/h79RGp+SwQYcFh4
tHaC08vBqSIL2YzQOBO+UbyPQfjLHWYW3TfBrekiCbLR0TZvwN3VnHAjGNwM4VpR
Dm71TpvacCATV4azkdl12hiq3FZwC1peJ/x1aIVT1dAha2AtlqkWGNFlcYYdfdei
KOY0ILi6N6cZcaGpvF4fl680kIpz1YqbOpDFkXTijoYheLaKbMn/7Tqkrs1/wNs3
u6f0M0UyJp4z0SOSs9+A9bOLkehaWnxwgSWYuUZOOB3Ft6lvE5w2OY2kr6B228P1
Ni9l6Lfx1hK6hG8lV15E7ZNBKR3RbZ70SODkDs6NzyFzXfrUcaInTXfH6sOnHRCD
oMpdekzzG1vgV/ZBh3XDvtQO9o/lY4nnu+tPFE+EgKiIYX6LeQsxJny+oq35821/
qqmACXuKpsb3lzEzHK4QU2OU2Qif+CUANEdkonDcfy5vuSO9LMYDe4ANv8D9+9qc
1O/d3sLRATbXgMWv95g3gPMdRE/hT/+XYGQsWAxSf/8S56dDRZrx0hlC3Rh5PSgK
0TKG8xebFb+1MLMIurySDABipUlfot730vxLCk09+B7kYtd4bssron8PaTMJMBCX
ut6o3S0Co93dJFvbyGjj
=TksP
-----END PGP SIGNATURE-----

--B92bTrfKjyax39gr--

--===============6147937296196722097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6147937296196722097==--
