From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98925 codec driver
Date: Sat, 14 Feb 2015 14:14:07 +0900
Message-ID: <20150214051407.GH9110@finisterre.sirena.org.uk>
References: <1423884301-13292-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3679861011064335367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5C062604BB
 for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2015 06:15:09 +0100 (CET)
In-Reply-To: <1423884301-13292-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <yesanishhere@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, Maxwell.McKinnon@maximintegrated.com, alsa-devel@alsa-project.org, lars@metafoo.de, nitin.mittal@maximintegrated.com
List-Id: alsa-devel@alsa-project.org


--===============3679861011064335367==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Content-Disposition: inline


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 13, 2015 at 07:25:01PM -0800, Anish Kumar wrote:

> +config SND_SOC_MAX98925
> +	bool "Support MAX98925 stereo system"

Why bool?  Also "stereo system" should be "audio CODEC" or similar.

> +	depends on I2C
> +	help
> +	MAX98925 is a high-efficiency mono
> +	Class DG audio amplifier. Use this
> +	option to enable the system consisting
> +	of left and right power amplifier.
> +

Please fix the formatting to look like other Kconfig entries
(indentation of the help text).

> +static int max98925_hpf_l;
> +static int max98925_hpf_r;
> +static int max98925_dai_sel_l;
> +static int max98925_dai_sel_r;
> +static struct max98925_priv *max98925;

Why global variables not values in the private data structure for the
device?

> +static const char *const dai_text[] = {
> +		"L_Data", "R_Data", "LR_Data", "LR_Data_Div2",
> +};

> +static const char *const hpf_text[] = {
> +		"hpf_disable", "hpf_dc_block", "hpf_enable_100",
> +		"hpf_enable_200", "hpf_enable_400", "hpf_enable_800",
> +};

These have strange indentation and the names should be more human
readable - look at how the names are written for enums in other drivers.

> +static struct reg_default max98925_reg[] = {
> +	{ 0x00, 0x00 }, /* Battery Voltage Data */
> +	{ 0x01, 0x00 }, /* Boost Voltage Data */
> +	{ 0x02, 0x00 }, /* Live Status0 */
> +	{ 0x03, 0x00 }, /* Live Status1 */
> +	{ 0x04, 0x00 }, /* Live Status2 */

These look like they should be volatile registers, why do they have
cache defaults defined?

> +	switch (ucontrol->value.integer.value[0]) {
> +	case 0:
> +		regmap_update_bits(max98925->regmap_l, reg, mask,
> +				M98925_DAC_HPF_DISABLE);
> +		break;
> +	case 1:
> +		regmap_update_bits(max98925->regmap_l, reg, mask,
> +				M98925_DAC_HPF_DC_BLOCK);
> +		break;

These look like magic numbers from an enum - why not use the standard
enum control?  In general a *lot* of the code around here looks like
it's open coding core functionality.

> +static int max98925_dac_ev_r(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
> +	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
> +
> +	regmap_update_bits(max98925->regmap_r, MAX98925_R036_BLOCK_ENABLE,
> +			M98925_SPK_EN_MASK, M98925_SPK_EN_MASK);
> +	return 0;
> +}

This should check the event or just be a normal DAPM widget.  Looking at
where it's getting used it appears to be the latter.

> +static const struct snd_kcontrol_new dai_sel_mux[2] = {

No magic numbers, just let the compiler figure it out.

> +void max98925_regmap_write_stereo(struct max98925_priv *max98925,
> +	unsigned int reg, unsigned int val)
> +{
> +	regmap_write(max98925->regmap_l, reg, val);
> +	regmap_write(max98925->regmap_r, reg, val);
> +}

You had another "stereo write" function further up - what's this all
about?

> +	switch (reg) {
> +	case MAX98925_R000_VBAT_DATA:

Putting the register numbers in the define for the register name seems
to defeat some of the point of the defines...

> +static bool max98925_readable_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MAX98925_R00E_IRQ_CLEAR0:
> +	case MAX98925_R00F_IRQ_CLEAR1:
> +	case MAX98925_R010_IRQ_CLEAR2:
> +	case MAX98925_R033_ALC_HOLD_RLS:
> +		return false;
> +	default:
> +		return true;
> +	}
> +};

So the volatile registers aren't readable?

> +DECLARE_TLV_DB_SCALE(max98925_spk_tlv, -600, 100, 0);
> +static int reg_set_optimum_mode_check(struct regulator *reg, int load_ua)
> +{
> +	return (regulator_count_voltages(reg) > 0) ?
> +		regulator_set_optimum_mode(reg, load_ua) : 0;
> +}

I'm not 100% sure what this is intended to do but it it's not at all
obvious that it's sensible...  it at least needs some documentation.

> +	if (pullup) {
> +		pr_info("%s: i2c pull up\n", __func__);

If this were useful it should be a dev_ print, though I'm not convinced
it isn't just noise.

> +		max98925_vcc_i2c = regulator_get(&i2c->dev, "vcc_i2c");
> +		if (IS_ERR(max98925_vcc_i2c)) {

Why not devm_?

> +			rc = PTR_ERR(max98925_vcc_i2c);
> +			pr_err("%s: regulator get failed rc=%d\n",
> +						__func__, rc);

Similarly here and for all the other error prints.

> +		if (regulator_count_voltages(max98925_vcc_i2c) > 0) {
> +			rc = regulator_set_voltage(max98925_vcc_i2c,
> +				VCC_I2C_MIN_UV, VCC_I2C_MAX_UV);
> +			if (rc) {

All the stuff being done with regulator_count_voltages() looks broken,
and the fact that the driver is setting a single specific I/O voltage
is also highly unusual.  Normally the board would do that.

If the regulator code doesn't look like the regulator code for other
CODEC drivers it needs to be clear why, and it's *very* suspicious to
see a driver with a single optional regulator called "vcc_i2c".

> +static void max98925_set_sense_data(struct max98925_priv *max98925)
> +{
> +	/*
> +	 * 1. set VMON slots
> +	 */
> +	regmap_update_bits(max98925->regmap_l,
> +		MAX98925_R022_DOUT_CFG_VMON,
> +		M98925_DAI_VMON_EN_MASK, M98925_DAI_VMON_EN_MASK);
> +	regmap_update_bits(max98925->regmap_l,
> +		MAX98925_R022_DOUT_CFG_VMON,
> +		M98925_DAI_VMON_SLOT_MASK, M98925_DAI_VMON_SLOT_00_01);
> +	/*
> +	 * 2. set IMON slots
> +	 */
> +	regmap_update_bits(max98925->regmap_l,
> +		MAX98925_R023_DOUT_CFG_IMON,
> +		M98925_DAI_IMON_EN_MASK, M98925_DAI_IMON_EN_MASK);
> +	regmap_update_bits(max98925->regmap_l,
> +		MAX98925_R023_DOUT_CFG_IMON,
> +		M98925_DAI_IMON_SLOT_MASK, M98925_DAI_IMON_SLOT_02_03);
> +}

Why is this hard coded in the driver and not platform data - if this is
configurable presumably other boards might need it set differently?

> +static void max98925_set_slave(struct max98925_priv *max98925)
> +{
> +	/*
> +	 * 1. use BCLK instead of MCLK
> +	 */
> +	max98925_regmap_update_bits_stereo(max98925,
> +			MAX98925_R01A_DAI_CLK_MODE1,
> +			M98925_DAI_CLK_SOURCE_MASK, M98925_DAI_CLK_SOURCE_MASK);
> +	/*
> +	 * 2. set DAI to slave mode
> +	 */
> +	max98925_regmap_update_bits_stereo(max98925,
> +			MAX98925_R01B_DAI_CLK_MODE2,
> +			M98925_DAI_MAS_MASK, 0);
> +	/*
> +	 * 3. set BLCKs to LRCLKs to 64
> +	 */
> +	max98925_regmap_update_bits_stereo(max98925,
> +			MAX98925_R01B_DAI_CLK_MODE2,
> +			M98925_DAI_BSEL_MASK, M98925_DAI_BSEL_64);

This looks to be a mix of setting slave mode and setting some clocking
configuration that ought to be configurable - for example I'd expect
clock sources to be configured via set_sysclk().

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		break;

This is setting the same configuration for multiple formats, that can't
be right.

> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		max98925_regmap_update_bits_stereo(max98925,
> +				MAX98925_R020_FORMAT,
> +				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
> +		dev_dbg(codec->dev, "%s: (really set to 32 bits)\n", __func__);
> +		break;

This looks broken...

> +	if (mute) {
> +		max98925_regmap_update_bits_stereo(max98925, MAX98925_R02D_GAIN,
> +			M98925_SPK_GAIN_MASK, 0x00);
> +
> +		max98925_regmap_update_bits_stereo(max98925,
> +			MAX98925_R038_GLOBAL_ENABLE,
> +			M98925_EN_MASK, 0x0);
> +	} else	{
> +		max98925_regmap_update_bits_stereo(max98925,
> +			MAX98925_R036_BLOCK_ENABLE,
> +			M98925_BST_EN_MASK |
> +			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK,
> +			M98925_BST_EN_MASK |
> +			M98925_ADC_IMON_EN_MASK | M98925_ADC_VMON_EN_MASK);
> +
> +		max98925_regmap_write_stereo(max98925,
> +			MAX98925_R038_GLOBAL_ENABLE, M98925_EN_MASK);
> +	}

This doesn't look like it's muting, it looks like it's doing a whole
bunch of other things.  The mute operation should mute and only mute
(and then only if the device usefully supports it).

> +	/* can be configured to any other value supported by this chip */
> +	max98925->sysclk = 12288000;
> +	max98925->spk_gain = 0x14;
> +	cdata = &max98925->dai[0];
> +	cdata->rate = (unsigned)-1;
> +	cdata->fmt  = (unsigned)-1;

Don't hard code board specific configuration in the driver.  Just let
the user set it at runtime.

> +	ret = regmap_read(max98925->regmap_l,
> +			MAX98925_R0FF_VERSION, &reg);
> +	if ((ret < 0) ||
> +		((reg != MAX98925_VERSION) &&
> +		(reg != MAX98925_VERSION1))) {
> +		dev_err(codec->dev,
> +			"L device initialization error (%d 0x%02X)\n",
> +			ret, reg);
> +		goto err_access;
> +	}
> +	dev_info(codec->dev, "L device version 0x%02X\n", reg);
> +
> +	reg = 0;
> +	ret = regmap_read(max98925->regmap_r,
> +			MAX98925_R0FF_VERSION, &reg);

This looks like the driver is trying to support two physical devices in
a single driver.  Don't do that, write a driver which controls one
instance of the device and let the subsystem worry about how they're
connected on the board.

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3tmeAAoJECTWi3JdVIfQQhkH/3+SGYE/PxH8W6bR2GgThQQ5
dobnlBLSS7k2Hu4dfCSSyvhYjI7MzqZO9rTRY2G/peQWTNB/URDURvuwDFIDu609
NO3AVxBQ5xDg+hw8rsTNo9bN2tlbKUL0ss2pPHhxIvNvxldFtXwu8Vro2qacmRjm
HYYGKIPyQ67Acl7y/1yEFT8FfZ12G2c3Kkh1MVR8I+iCRW235ID36Azsrt5zWuRn
nQMvrn131nZQLerL3sOqiZjRBpW6bjP0DYJG7LWaR/eBRrcFpUsiXBYXEJbm7yJc
VXmZ9TIjL4Xn+i+/so6k3c/d7AvHbUc9ZS8V25kVYnTgdQwiHEzJngvhqxuM83s=
=8Cx+
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--

--===============3679861011064335367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3679861011064335367==--
