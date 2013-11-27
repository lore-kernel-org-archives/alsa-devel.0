From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT286 CODEC driver
Date: Wed, 27 Nov 2013 17:43:09 +0000
Message-ID: <20131127174309.GO14725@sirena.org.uk>
References: <1385457091-25556-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1914293453009090581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 19EFE264F23
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 18:43:14 +0100 (CET)
In-Reply-To: <1385457091-25556-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1914293453009090581==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="STF7jECzLQM6/suL"
Content-Disposition: inline


--STF7jECzLQM6/suL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 05:11:31PM +0800, bardliao@realtek.com wrote:

> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 983d087a..56748d4 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -313,6 +313,9 @@ config SND_SOC_PCM1792A
>  config SND_SOC_PCM3008
>         tristate
> =20
> +config SND_SOC_RT286
> +	tristate
> +

This needs to be added to ALL_CODECS too.

> +#define DEBUG

No, not in mainline.

> +static int hp_amp_time =3D 100;
> +module_param(hp_amp_time, int, 0644);

No module parameters.  Make a sysfs tunable for this if it's required,
or make it platform data.

> +#define RT_SUPPORT_COMBO_JACK 1

No compile time configuration please, platform data.

> +#define VERSION "0.0.1-beta3 alsa 1.0.25"

The kernel is already versioned, don't try to maintian an individual
driver version.

> +static unsigned long rt286_read(struct snd_soc_codec *codec,
> +					   unsigned int vid,
> +					   unsigned int nid,
> +					   unsigned int data)

You should be implementing this in regmap using the reg_read and
reg_write operations.

> +static int rt286_index_write(struct snd_soc_codec *codec,
> +	unsigned int WidgetID, unsigned int index, unsigned int data)

Coding style - no CamelCase.

> +static const struct reg_default rt286_reg[TOTAL_NODE_ID + 1] =3D {
> +	{ NODE_ID_DAC_OUT1, 0x7f7f },
> +	{ NODE_ID_DAC_OUT2, 0x7f7f },
> +	{ NODE_ID_SPDIF, 0x0000 },
> +	{ NODE_ID_ADC_IN1, 0x4343 },
> +	{ NODE_ID_ADC_IN2, 0x4343 },
> +	{ NODE_ID_MIC1, 0x0002 },
> +	{ NODE_ID_MIXER_IN, 0x000b },
> +	{ NODE_ID_MIXER_OUT1, 0x0002 },
> +	{ NODE_ID_MIXER_OUT2, 0x0000 },
> +	{ NODE_ID_SPK_OUT, 0x0000 },
> +	{ NODE_ID_HP_OUT, 0x0000 },
> +	{ NODE_ID_MIXER_IN1, 0x0005 },
> +	{ NODE_ID_MIXER_IN2, 0x0005 },
> +};

Why is there a size specified for this array?

> +static bool rt286_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	return 0;
> +}

This is the default when caching, no need to have this function.

> +static bool rt286_readable_register(struct device *dev, unsigned int reg)
> +{

> +	case NODE_ID_MIXER_IN2:
> +		return 1;
> +	default:
> +		return 0;

Return true and false for booleans.

> +int rt286_jack_detect(struct snd_soc_codec *codec, bool *bHP, bool *bMIC)
> +{

Again, coding style.  This should also be a static function (which
presumably will be used by some jack detection code further down)?

> +static int rt286_playback_vol_get(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)

> +static int rt286_playback_vol_put(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)


> +static int rt286_capture_vol_get(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)

> +static int rt286_capture_vol_put(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)

There should be some code reuse between all these things, they seem to
just differ in bits of data from a quick scan through.

> +	SOC_SINGLE_EXT_TLV("AMIC Gain", NODE_ID_MIC1, 0, 0x3, 0,
> +			   rt286_mic_gain_get, rt286_mic_gain_put,
> +			   mic_vol_tlv),

Volume.

> +static void hwCodecConfigure(struct snd_soc_codec *codec)

Coding style yet again.

> +	rt286_write(codec, AC_VERB_SET_POWER_STATE,
> +		NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D3);
> +	for (i =3D 0; i < RT286_POWER_REG_LEN; i++) {
> +		rt286_write(codec, AC_VERB_SET_POWER_STATE,
> +		rt286_support_power_controls[i], AC_PWRST_D3);
> +	}
> +
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x4F, 0xb029);
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x09, 0xc400);
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x0A, 0x0120);
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x33, 0x020A);
> +
> +#if !RT_SUPPORT_COMBO_JACK
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x50, 0x0000);
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x19, 0x0816);
> +	rt286_index_write(codec, NODE_ID_VENDOR_REGISTERS, 0x20, 0x0000);
> +#endif

This is writing a bunch of apparently configuration dependant magic
numbers into the device.  The configuration should come from platform
data or be done at runtime and we should have some visibility of what
the magic numbers are up to.

> +	/* Sync volume */
> +	regmap_read(rt286->regmap, NODE_ID_ADC_IN1, &val);
> +	val =3D (val >> 8) & 0x7f;
> +	rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> +			NODE_ID_ADC_IN1, 0x6000 | val);

It's not clear what any of this is doing but the general policy is to
use the hardware defaults.

> +/* HP-OUT source */
> +static const char * const rt286_hpo_src[] =3D {
> +	"Front", "Surr"
> +};

Spell out Surround fully to help readabiity.

> +		rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> +			NODE_ID_SPK_OUT, 0xb000);

Wasn't there a separate speaker mute control?

> +static int rt286_hp_pow_event(struct snd_soc_dapm_widget *w,
> +			   struct snd_kcontrol *kcontrol, int event)

It looks like a lot of these events should be sharing code as well.

> +	switch (params_rate(params)) {
> +	/* bit 14 0:48K 1:44.1K */
> +	case 48000:
> +		val &=3D ~0x4000;
> +		break;
> +	case 44100:
> +		val |=3D 0x4000;
> +		break;

Use snd_soc_update_bits() when writing out.

> +	default:
> +		pr_err("unsportted sample rate %d\n", params_rate(params));
> +		return -EINVAL;

dev_err().

> +	} else {
> +		pr_err("unsportted channels %d\n", params_channels(params));

Unsupported.

> +	/* bit 15 Stream Type 0:PCM 1:Non-PCM */
> +	val_dac &=3D ~0x8000;
> +	val_adc &=3D ~0x8000;
> +	rt286_write(codec, AC_VERB_SET_STREAM_FORMAT,
> +		NODE_ID_DAC_OUT1, val_dac);
> +	rt286_write(codec, AC_VERB_SET_STREAM_FORMAT,
> +		NODE_ID_ADC_IN1, val_adc);

update_bits here too.

> +
> +	switch (freq) {
> +	case 19200000:
> +	case 24000000:
> +		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
> +			0x63, 0x4, 0x4);
> +		rt286_index_update_bits(codec, NODE_ID_VENDOR_REGISTERS,
> +			0x49, 0x20, 0x0);
> +		break;

This doesn't look right - you've got multiple clock rates but are
writing the same value out (and similarly for everything else).  Do you
need to add a constraint limiting what sample rates can be used
depending on the system clock?

Too many magic numbers too as with the rest of the code.

> +static int rt286_set_dai_dfs(struct snd_soc_dai *dai, unsigned int fs)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +
> +	pr_debug("%s fs=3D%d\n", __func__, fs);
> +	if (50 =3D=3D fs)
> +		rt286_index_update_bits(codec,
> +			NODE_ID_VENDOR_REGISTERS, 0x09, 0x1000, 0x1000);
> +
> +
> +	return 0;
> +}

This looks buggy, if the fs value happens to be 50 you write something
otherwise you write nothing - what happens if we move from 50 to another
value?

> +static ssize_t rt286_codec_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)

Use the framework support for this.

> +static int rt286_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		pr_debug("In case SND_SOC_BIAS_ON:\n");

Remove noisy stuff like this, you're duplicating the core.

> +#ifdef CONFIG_PM
> +static int rt286_suspend(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Remove empty functions.

> +	regcache_cache_only(rt286->regmap, true);

Nothing ever clears the cache_only flag in the driver so register writes
won't be happening.  Has this code been tested?

> +	ret =3D snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
> +				     rt286_dai, ARRAY_SIZE(rt286_dai));

devm_snd_soc_register_codec().

> +static void rt286_i2c_shutdown(struct i2c_client *client)
> +{
> +	struct rt286_priv *rt286 =3D i2c_get_clientdata(client);
> +	struct snd_soc_codec *codec =3D rt286->codec;
> +
> +	if (codec !=3D NULL)
> +		rt286_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +}

The core should be dealing with this.

--STF7jECzLQM6/suL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSli8qAAoJELSic+t+oim9EaoP/2C773NA3AgcL1wtQ42DQ3Pi
DdFmLzAD1HeHYQzrOHpkwJwAjZpG9xX6wlIBliywg4Q0OuI/+6skCFaaViP3dDTA
g24eS2Zc55djDrUwtO6EaYX4bDeLAggT8Of9TyL8EEhn38hgxE7JE8c2xmaoUPEw
fIY17GGYBAxC50NXfB2hcD92SdhW+8oB3kPJREemp9sSc3g20Tk95sgVLVRYMlgw
ASKbh/pWONdkbopK0jGJS3uec2veMX4mcX/hWI1xD1GyUHlrsAITvTVBIfiFWkT3
9GukMOcfUIIoA7mYgQhowPg4ruhPevtEM00YLoCn5k4tfXNvHvmoX3Uy2bjs1DrR
dAXBo/NGYX5+cYvVvK8p8jEh50j1rHhKl3Adq0QdTuBH9vRUbBl1ZWkkEd2PVxe/
wCf+K8IWuY8aMYz3KFWvNPrI5z58fxc1Ws/k4gV2iyINwktjUjwNCgyJ2lmnX9iZ
1WxQlpnKI1A0cbeUdfqDqXIAO5HfAVQtZQ4c09ZmrgjD5EdmSlK5FMKQGb0blFlt
jx4QywwrXChzLpH15Uv3uvHGIY7Iu+Ehkt7wt7WF6ZmUttCfrm/axjstCMQBVPrh
LDhEkYZiiky/UYbDDlR4hHkzUNEuQBO69w34/X1wHy11yRp1wGeaCAA6lxUIILJE
LWmQh6uI4X2O1aXXsKOj
=oxJ/
-----END PGP SIGNATURE-----

--STF7jECzLQM6/suL--

--===============1914293453009090581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1914293453009090581==--
