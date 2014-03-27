From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sta350: Add codec driver
Date: Thu, 27 Mar 2014 17:21:27 +0000
Message-ID: <20140327172127.GS30768@sirena.org.uk>
References: <1395937082-28202-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0562912654111158577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 43F8D26546B
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 18:21:58 +0100 (CET)
In-Reply-To: <1395937082-28202-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, neumann@teufel.de, brandau@gmx.de
List-Id: alsa-devel@alsa-project.org


--===============0562912654111158577==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8DtChEGCcMdSgkU2"
Content-Disposition: inline


--8DtChEGCcMdSgkU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 05:18:02PM +0100, Daniel Mack wrote:
> From: Sven Brandau <brandau@gmx.de>
>=20
> The TI STA350 is an integrated 2.1-channel power amplifier that is
> controllable over I2C. This patch adds an ASoC driver for it.
>=20
> At a glance, this chip is very similar to the STA320 for which a driver
> already exists. In details, however, the register maps contain subtle
> differences which made a whole new driver easier to write and maintain.

A few issues below, some may already be present in the sta320 driver,
generally newer idioms and so on, but that's no reason to not fix them
here!

>=20
> [daniel@zonque.org: cleanups, DT property rework, rebased on asoc-next]
> Signed-off-by: Sven Brandau <brandau@gmx.de>
> ---
> I'm sending this patch on behalf of Sven Brandau, who wrote the driver,
> based on earlier bits for the STA320.

You need to add a Signed-off-by if you're the one sending it.

> +config SND_SOC_STA350
> +	tristate
> +

DT capable drivers should be visible in Kconfig so they can be used with
simple-audio.

> +/* regulator power supply names */
> +static const char const *sta350_supply_names[] =3D {
> +	"vdd-dig",	/* digital supply, 3.3V */
> +	"vdd-pll",	/* pll supply, 3.3V */
> +	"vcc"		/* power amp supply, 5V - 26V */
> +};

These should be documented as mandatory properties in the DT binding but
weren't mentioned at all.

> +static const char const *sta350_noise_shaper_type[] =3D {
> +	"Third order", "Forth order"
> +};

Fourth.

> +static const struct soc_enum sta350_limiter2_release_rate_enum =3D
> +	SOC_ENUM_SINGLE(STA350_L2AR, STA350_LxR_SHIFT,
> +			16, sta350_limiter_release_rate);

Use SOC_ENUM_SINGLE_DECL if you can, it makes things a bit less error
prone.

> +static int sta350_coefficient_get(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +	struct sta350_priv *sta350 =3D snd_soc_codec_get_drvdata(codec);
> +	int numcoef =3D kcontrol->private_value >> 16;
> +	int index =3D kcontrol->private_value & 0xffff;
> +	unsigned int cfud, val;
> +	int i;
> +
> +	/* preserve reserved bits in STA350_CFUD */
> +	regmap_read(sta350->regmap, STA350_CFUD, &cfud);
> +	cfud &=3D 0xf0;
> +	/*
> +	 * chip documentation does not say if the bits are self clearing,
> +	 * so do it explicitly
> +	 */
> +	regmap_write(sta350->regmap, STA350_CFUD, cfud);
> +
> +	regmap_write(sta350->regmap, STA350_CFADDR2, index);
> +	if (numcoef =3D=3D 1)
> +		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x04);
> +	else if (numcoef =3D=3D 5)
> +		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x08);
> +	else
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < 3 * numcoef; i++) {
> +		regmap_read(sta350->regmap, STA350_B1CF1 + i, &val);
> +		ucontrol->value.bytes.data[i] =3D val;
> +	}

You need some sort of locking around these windows I think?

> +SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),

Don't specify a stream on the DAC, use DAPM to connect the DAI to the
DAC (the DAI name is a DAPM widget name).

> +static int sta350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				 int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec =3D codec_dai->codec;
> +	struct sta350_priv *sta350 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	pr_debug("mclk=3D%u\n", freq);
> +	sta350->mclk =3D freq;
> +

dev_dbg() here and for some of the rest of the code too.

> +	regmap_read(sta350->regmap, STA350_CONFB, &confb);

Or just use _update_bits() at the end?

> +	for (i =3D 0; i < ARRAY_SIZE(interpolation_ratios); i++)
> +		if (interpolation_ratios[i].fs =3D=3D rate) {
> +			ir =3D interpolation_ratios[i].ir;
> +			break;
> +		}
> +	if (ir < 0) {

Can we have some braces around the for () loop please - it'd be easier
to read (similarly for others).

> +	regmap_read(sta350->regmap, STA350_CONFB, &confb);
> +	confb &=3D ~(STA350_CONFB_SAI_MASK | STA350_CONFB_SAIFB);
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +	case SNDRV_PCM_FORMAT_S24_BE:
> +	case SNDRV_PCM_FORMAT_S24_3LE:
> +	case SNDRV_PCM_FORMAT_S24_3BE:
> +		pr_debug("24bit\n");
> +		/* fall through */

Use params_width() and this all gets shorter.

> +static int sta350_startup_sequence(struct sta350_priv *sta350)
> +{
> +	if (gpio_is_valid(sta350->gpio_power_down))
> +		gpio_set_value(sta350->gpio_power_down, 1);
> +
> +	if (gpio_is_valid(sta350->gpio_nreset)) {
> +		gpio_set_value(sta350->gpio_nreset, 1);
> +		mdelay(1);
> +		gpio_set_value(sta350->gpio_nreset, 0);
> +		mdelay(1);
> +		gpio_set_value(sta350->gpio_nreset, 1);
> +		mdelay(1);
> +	}

That sequence looks odd - we bring the device out of reset, reset it
again and then bring it back to reset.  It'd be more normal to leave the
device in reset when idle and then just bring it out of reset rather
than something like this.  Why the odd sequence?

> +static int sta350_probe(struct snd_soc_codec *codec)
> +{
> +	struct sta350_priv *sta350 =3D snd_soc_codec_get_drvdata(codec);
> +	struct sta350_platform_data *pdata =3D sta350->pdata;
> +	int i, ret =3D 0, thermal =3D 0;
> +
> +	if (gpio_is_valid(sta350->gpio_nreset))
> +		if (devm_gpio_request_one(codec->dev, sta350->gpio_nreset,
> +					  GPIOF_OUT_INIT_HIGH,
> +					  "ST350 Reset"))
> +			sta350->gpio_nreset =3D -EINVAL;
> +
> +	if (gpio_is_valid(sta350->gpio_power_down))
> +		if (devm_gpio_request_one(codec->dev, sta350->gpio_power_down,
> +					  GPIOF_OUT_INIT_HIGH,
> +					  "ST350 Power-Down"))
> +			sta350->gpio_power_down =3D -EINVAL;

This doesn't handle probe deferral - it needs to special case
-EPROBE_DEFER (or just pass back the error it gets).  The driver should
also be doing this at the I2C level probe not the ASoC level one.

> +
> +	ret =3D sta350_startup_sequence(sta350);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to startup device\n");
> +		return ret;
> +	}
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(sta350->supplies),
> +				    sta350->supplies);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}

I would have expected to run through the startup sequence after applying
power rather than before otherwise the startup sequence may not be
observed.

> +	/*
> +	 * Tell ASoC what kind of I/O to use to read the registers.  ASoC will
> +	 * then do the I2C transactions itself.
> +	 */
> +	codec->control_data =3D sta350->regmap;

Shouldn't be required any more, dev_get_regmap() will DTRT.

> +	/*
> +	 * Chip documentation explicitly requires that the reset values
> +	 * of reserved register bits are left untouched.
> +	 * Write the register default value to cache for reserved registers,
> +	 * so the write to the these registers are suppressed by the cache
> +	 * restore code when it skips writes of default registers.
> +	 */
> +	regcache_cache_only(sta350->regmap, true);
> +	regmap_write(sta350->regmap, STA350_CONFC, 0xc2);
> +	regmap_write(sta350->regmap, STA350_CONFE, 0xc2);
> +	regmap_write(sta350->regmap, STA350_CONFF, 0x5c);
> +	regmap_write(sta350->regmap, STA350_MMUTE, 0x10);
> +	regmap_write(sta350->regmap, STA350_AUTO1, 0x60);
> +	regmap_write(sta350->regmap, STA350_AUTO3, 0x00);
> +	regmap_write(sta350->regmap, STA350_C3CFG, 0x40);
> +	regcache_cache_only(sta350->regmap, false);

I don't understand this?  If defaults are provided (and they are) we
will already default to them so this should have no effect.

> +static int sta350_remove(struct snd_soc_codec *codec)
> +{
> +	struct sta350_priv *sta350 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	if (gpio_is_valid(sta350->gpio_nreset))
> +		gpio_set_value(sta350->gpio_nreset, 0);
> +
> +	if (gpio_is_valid(sta350->gpio_power_down))
> +		gpio_set_value(sta350->gpio_power_down, 0);
> +
> +	sta350_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);

I'd expect the GPIO and regulator stuff to be happening over suspend
too.  _BIAS_OFF does the power down but not the reset.

> +#ifdef CONFIG_OF
> +	if (of_match_device(st350_dt_ids, &i2c->dev)) {
> +		ret =3D sta350_probe_dt(&i2c->dev, sta350);
> +		if (ret < 0)
> +			return ret;
> +	}
> +#endif

This is weird - normally we just go and try to parse the DT?

--8DtChEGCcMdSgkU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNF4UAAoJELSic+t+oim9S2AQAI60+oR560t8YOiJn4gDpa/J
kvLJQRS4mMqq/eC4fasZ9f+CTT9/NQo84qlILCuevpJKsGH425WxsU6LG2NSkvtQ
79AKJ7xLboTXIyC8V/bNAQ8fsYP9AlaSYdfGNntTSVOvTirJ8DJrM+WgBDuQ3kbt
SaviQVWlrk3wvpIcI/c6iLkQ8WjS6DUPtlRIiSwOSIkObnM3rM4fkitCoZAGRqBf
HQhsFNYxd0R96eHhNi9H2HUaKCU2H9Vgf+9uQS3+0Na6R8SN4UmsldPZ5cC1c4VL
a4bdZ1DeUj1iUHyjH2LqLHreDyiMR+hUgLZ5wyR/iBkFH4jixwkef9sNSpj+9p2Z
5I7VDvyqGyr5TaRhWH8OR0y4qRyprH6AwkBTyU9cyoZ+tY911paG50EA3UMpV1pe
yDhFrVqSqz7M9pMrzp+8d5rRclScEnchuwZ2remC1uhgYlEPPAemCioLkxfVAzzo
cvqOBRDXXn6/fkgSV+Vr6DUjpT7XNzLmeHg70B9HynYGRjvNBovSnVCj+7GDwwiC
xL3RoBhw2HekJNDWHeyzUhXjcfR98kDRKtYcBHCMudHQ3k/dzIzDiiQaUF3hFHQe
rO7CyFWkZFFr+Xvz95tgld2RH7TFMMmJUD4B6H+SenP7ypZ4etk7w/8BwtTBrHYJ
gbKR/MzR5btBctpBlZNm
=63cQ
-----END PGP SIGNATURE-----

--8DtChEGCcMdSgkU2--

--===============0562912654111158577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0562912654111158577==--
