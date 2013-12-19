From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
Date: Thu, 19 Dec 2013 12:25:27 +0000
Message-ID: <20131219122527.GX31886@sirena.org.uk>
References: <1387195916-3106-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0913721825789292025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EA49D265375
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 13:25:30 +0100 (CET)
In-Reply-To: <1387195916-3106-1-git-send-email-bardliao@realtek.com>
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


--===============0913721825789292025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3rzwkXnKuCXxoL5m"
Content-Disposition: inline


--3rzwkXnKuCXxoL5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2013 at 08:11:56PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>

This patch is far too big, it really needs to be split up into a patch
series to make it reviewable.  I'd suggest at least doing something like
splitting it into one patch adding the CODEC functionality and then a
second patch adding the DSP support.  Probably the header ought to be a
separate patch too.

Overall this looks reasonable on the CODEC side, that can probably get
merged relatively easily though some revisions are needed.  The DSP code
is less clear partly due to lack of documentation.

> +/* DSP init */
> +static unsigned short rt5670_dsp_init[][2] = {
> +	{0x2260, 0x30d9}, {0x2261, 0x30d9}, {0x2289, 0x7fff}, {0x2290, 0x7fff},
> +	{0x2288, 0x0002}, {0x22b2, 0x0002}, {0x2295, 0x0001}, {0x22b3, 0x0001},
> +	{0x22d7, 0x0008}, {0x22d8, 0x0009}, {0x22d9, 0x0000}, {0x22da, 0x0001},
> +	{0x22fd, 0x009e}, {0x22c1, 0x1006}, {0x22c2, 0x1006}, {0x22c3, 0x1007},
> +	{0x22c4, 0x1007}
> +};
> +#define RT5670_DSP_INIT_NUM \
> +	(sizeof(rt5670_dsp_init) / sizeof(rt5670_dsp_init[0]))

Use ARRAY_SIZE() rather than open coding it.

> +static unsigned short rt5670_dsp_2mic_handset[][2] = {
> +	{0x22f8, 0x8002}, {0x2301, 0x0002}, {0x2302, 0x0002}, {0x2303, 0x0710},
> +	{0x2304, 0x4332}, {0x2305, 0x206c}, {0x236e, 0x0000}, {0x236f, 0x0001},
> +	{0x237e, 0x0001}, {0x237f, 0x3800}, {0x2380, 0x3000}, {0x2381, 0x0005},
> +	{0x2382, 0x0040}, {0x2383, 0x7fff}, {0x2388, 0x2c00}, {0x2389, 0x2800},
> +	{0x238b, 0x1800}, {0x238c, 0x1800}, {0x238f, 0x2000}, {0x239b, 0x0002},
> +	{0x239c, 0x0a00}, {0x239f, 0x0001}, {0x230c, 0x0200}, {0x22fb, 0x0000}
> +};
> +#define RT5670_DSP_2MIC_HANDSET_NUM \
> +	(sizeof(rt5670_dsp_2mic_handset) / sizeof(rt5670_dsp_2mic_handset[0]))

What are all these things?  We shouldn't have huge tables of magic
numbers in the kernel...

> +/**
> + * rt5670_dsp_done - Wait until DSP is ready.
> + * @codec: SoC Audio Codec device.
> + *
> + * To check voice DSP status and confirm it's ready for next work.
> + *
> + * Returns 0 for success or negative error code.
> + */
> +static int rt5670_dsp_done(struct snd_soc_codec *codec)
> +{
> +	unsigned int count = 0, dsp_val;
> +
> +	dsp_val = snd_soc_read(codec, RT5670_DSP_CTRL1);
> +	while (dsp_val & RT5670_DSP_BUSY_MASK) {
> +		if (count > 10)
> +			return -EBUSY;
> +		dsp_val = snd_soc_read(codec, RT5670_DSP_CTRL1);
> +		count++;
> +	}

A do { } while loop would be more idiomatic.  Or a for loop with a
return.

> +static int rt5670_dsp_write(struct snd_soc_codec *codec,
> +		unsigned int addr, unsigned int data)

This probably wants to be a regmap using the custom read and write
callbacks.

> +static int rt5670_dsp_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (rt5670->dsp_sw != ucontrol->value.integer.value[0])
> +		rt5670->dsp_sw = ucontrol->value.integer.value[0];
> +
> +	return 0;
> +}

I would expect this to be doing something when it sets the value,
possibly just returning an error if the DSP is running and this can't be
reprogrammed but doing something to interact with the rest of the
system.

> +static int rt5670_dsp_rate_put(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{

Why can't this be configured automatically by the device?

> +static const struct snd_kcontrol_new rt5670_dsp_snd_controls[] = {
> +	SOC_ENUM("SRC for RxDP", rt5670_src_rxdp_enum),
> +	SOC_ENUM("SRC for TxDP", rt5670_src_txdp_enum),

These should be done with DAPM.

> +	case RT5670_DSP_AEC:
> +		dev_info(codec->dev, "AEC\n");

dev_dbg().

> +	ret = rt5670_dsp_rate(codec,
> +		rt5670->sysclk ?
> +		rt5670->sysclk : 11289600,
> +		rt5670->dsp_rate ?
> +		rt5670->dsp_rate : 16000);
> +	if (ret < 0)
> +		goto effect_err;

Don't use the ternery operator like this, just set defaults on init.

> +unsigned rt5670_pdm1_read(struct snd_soc_codec *codec, unsigned int reg)
> +{

> +EXPORT_SYMBOL(rt5670_pdm1_read);

Why is this exported at all and why is it exported non-GPL?

> +static int check_sysclk1_source(struct snd_soc_dapm_widget *source,
> +			 struct snd_soc_dapm_widget *sink)
> +{
> +	unsigned int val;
> +
> +	val = snd_soc_read(source->codec, RT5670_GLB_CLK);
> +	val &= RT5670_SCLK_SRC_MASK;
> +	if (val == RT5670_SCLK_SRC_PLL1)
> +		return 1;
> +	else
> +		return 0;
> +}

The naming of this function is non-obvious...  it looks like it's
actually checking that the chip is using the PLL.

> +static int rt5670_mono_adcl_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_update_bits(codec, RT5670_MONO_ADC_DIG_VOL,
> +			RT5670_L_MUTE, 0);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		snd_soc_update_bits(codec, RT5670_MONO_ADC_DIG_VOL,
> +			RT5670_L_MUTE,
> +			RT5670_L_MUTE);
> +		break;

Most of these events look like they should probably be using DAPM
_AUTODISABLE controls, this would save a lot of code.  If they can't do
that for some reason the functionality should definitely be factored out
into the core.

> +static int rt5670_asrc_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_write(w->codec, RT5670_ASRC_1, 0xffff);
> +		snd_soc_write(w->codec, RT5670_ASRC_2, 0x1221);
> +		snd_soc_write(w->codec, RT5670_ASRC_3, 0x0022);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		snd_soc_write(w->codec, RT5670_ASRC_1, 0);
> +		snd_soc_write(w->codec, RT5670_ASRC_2, 0);
> +		snd_soc_write(w->codec, RT5670_ASRC_3, 0);
> +	default:
> +		return 0;
> +	}

This looks an awful lot like it might be writing some use case dependant
parameters...  since it's just uncommented magic numbers it's hard to
tell but there's no obvious configuration for the ASRC anywhere in the
driver.

> +	if (RT5670_AIF2 == dai->id) {
> +		snd_soc_update_bits(codec, RT5670_GPIO_CTRL1,
> +			RT5670_I2S2_PIN_MASK, RT5670_I2S2_PIN_I2S);
> +	}

This looks like it could be done with DAPM, it's just setting this bit
while the AIF is in use.

> +	if (rt5670->pdata.asrc_en) {
> +		snd_soc_dapm_new_controls(&codec->dapm, rt5670_asrc_widgets,
> +				ARRAY_SIZE(rt5670_dapm_widgets));
> +		snd_soc_dapm_add_routes(&codec->dapm, rt5670_asrc_routes,
> +				ARRAY_SIZE(rt5670_dapm_routes));
> +	}

Why is this configured in platform data?

> +	if (rt5670->pdata.jd1_en) {
> +		regmap_update_bits(rt5670->regmap,
> +			RT5670_IRQ_CTRL2, 0x200, 0x200);
> +		snd_soc_dapm_force_enable_pin(&codec->dapm, "JD Power");
> +		snd_soc_dapm_sync(&codec->dapm);
> +	}

This should use the standard jack detection APIs.

> +void rt5670_i2c_shutdown(struct i2c_client *client)
> +{
> +	struct rt5670_priv *rt5670 = i2c_get_clientdata(client);
> +	struct snd_soc_codec *codec = rt5670->codec;
> +
> +	if (codec != NULL)
> +		rt5670_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +}

The core will do this for you, just remove it.

> +static int __init rt5670_modinit(void)
> +{
> +	return i2c_add_driver(&rt5670_i2c_driver);
> +}
> +module_init(rt5670_modinit);

module_i2c_driver().

--3rzwkXnKuCXxoL5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsuW0AAoJELSic+t+oim9n/cP/1Z7A/2xKcE58o0IwklxXhWx
hqBx9ay9U397YT/XoydMF/BUa8X3Bmg96Fv43x+gdJgIeN8ZYluGIQRWsHq/r8kF
ddgUx01Pwn6f4ucnVqXN1KHqzg1RKnHRrz+i5kh7j6u4txyrO/D1Usmeh8TsvpM+
ioxa/gipFVFcXz4WJR1Z2SpptbImgYutGxdWfeceC2lm7/o18r6MH8esXgQsUFFp
uf7XUJTUdd35zFpUSxMWAHosT54knGOy8Ewo8tU53BGrYupmB9+elJYB6Wr72ghC
/1ydVj5VD4yb7n5FjaDn1ae0Ox9uZhaf2H0KaMgNnDI665CHLifc8IwbmoDs9mFb
xTto4Xmplj4rX2RWIDAZKQ7Pr3dytCKbZLZUO/5hLuhBfMNw2fBhsu5UAM4m5JtZ
ZvAucth/xUKaa0q0fTTbHVgBqeqhZQIz+tjC4fBItMQOTFUW91as5YqoGw2GLzbx
y0NfgbtnWRGp1SEmQ/av/fpt0O8HUIaJ0emFyV+qyAJhx198f7+OWZDWquN7eC0+
yoH58Lf5zY/PCMPbZhQQJCPdwBgRJiTTjAd3nL7vvT0JW7NH5d5bn1TvnEPwQKEf
Xe8OFoYp+HNHxj1jrkDnkRgDMNx5tQ0I/wIYD3rHEtQMpoguXzlRLdJvp71XBwGl
z1Nq2CiA+8z4gW4cfeR8
=VtFG
-----END PGP SIGNATURE-----

--3rzwkXnKuCXxoL5m--

--===============0913721825789292025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0913721825789292025==--
