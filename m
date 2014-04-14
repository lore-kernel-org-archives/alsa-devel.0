From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add codec driver
Date: Mon, 14 Apr 2014 21:28:37 +0100
Message-ID: <20140414202837.GA25182@sirena.org.uk>
References: <1397212459-26495-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0208393366692718316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 388D02656D2
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 22:28:55 +0200 (CEST)
In-Reply-To: <1397212459-26495-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0208393366692718316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4Dl6XKrV7PH8SJF"
Content-Disposition: inline


--F4Dl6XKrV7PH8SJF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 06:34:19PM +0800, Oder Chiou wrote:
> This patch adds the Realtek ALC5645 codec driver. It is the base
> version that because the jack detect function is not implemented to
> it, the headphone and AMIC1 are not workable. We will fill up the
> further functions later.

This looks pretty good, a few things below but none of them too big.

> +static bool rt5645_readable_register(struct device *dev, unsigned int reg)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rt5645_ranges); i++)
> +		if ((reg >= rt5645_ranges[i].window_start &&
> +		     reg <= rt5645_ranges[i].window_start +
> +		     rt5645_ranges[i].window_len) ||
> +		    (reg >= rt5645_ranges[i].range_min &&
> +		     reg <= rt5645_ranges[i].range_max))
> +			return true;

Please include some braces in these loops for legibility.

> +static int rt5645_set_dmic1_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(codec, RT5645_GPIO_CTRL1,
> +			RT5645_GP2_PIN_MASK, RT5645_GP2_PIN_DMIC1_SCL);
> +		snd_soc_update_bits(codec, RT5645_DMIC1, RT5645_DMIC_1_DP_MASK,
> +			RT5645_DMIC_1_DP_IN2N);
> +		break;

For rt5640 we've got this configued by platform data - why not do the
same here?  In general I'm seeing some similarities again, though I
didn't check to see if the same driver can be used yet.  Is that the
case?

> +static const struct snd_kcontrol_new hp_r_vol_control =
> +	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5645_HP_VOL,
> +
> +		RT5645_R_MUTE_SFT, 1, 1);
> +static void hp_amp_power(struct snd_soc_codec *codec, int on)

Coding style, your blank line is in the wrong place.

> +static int rt5645_hp_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		rt5645_pmu_depop(codec);
> +		break;
> +
> +	case SND_SOC_DAPM_PRE_PMD:
> +		rt5645_pmd_depop(codec);
> +		break;

May as well just inline the power up/down sequences?

> +	case SND_SOC_DAPM_POST_PMU:
> +		regmap_write(rt5645->regmap, RT5645_PR_BASE + 0x1c, 0xfd20);
> +		regmap_write(rt5645->regmap, RT5645_PR_BASE + 0x20, 0x611f);
> +		regmap_write(rt5645->regmap, RT5645_PR_BASE + 0x21, 0x4040);
> +		regmap_write(rt5645->regmap, RT5645_PR_BASE + 0x23, 0x0004);
> +		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
> +			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |

Either use snd_soc_ or regmap_ - either is fine but be consistent.

> +			RT5645_PWR_CLS_D_L,
> +			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
> +			RT5645_PWR_CLS_D_L);
> +		break;
> +
> +	case SND_SOC_DAPM_PRE_PMD:
> +		snd_soc_update_bits(codec, RT5645_PWR_DIG1,
> +			RT5645_PWR_CLS_D | RT5645_PWR_CLS_D_R |
> +			RT5645_PWR_CLS_D_L, 0);

It's a bit odd that the first bank of writes done with regmap_write()
isn't undone here, can it be done once on init?

> +static int rt5645_pdm1_l_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		snd_soc_update_bits(codec, RT5645_PDM_OUT_CTRL,
> +			RT5645_M_PDM1_L, 0);
> +		break;

Why are these done by an event - I'd expect this to be done using the
normal DAPM register update support?

> +	bclk_ms = frame_size > 32 ? 1 : 0;

bclk_ms = frame_size > 32.

> +static int rt5645_set_bias_level(struct snd_soc_codec *codec,
> +			enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_STANDBY:
> +		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
> +			snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
> +				RT5645_PWR_VREF1 | RT5645_PWR_MB |
> +				RT5645_PWR_BG | RT5645_PWR_VREF2,
> +				RT5645_PWR_VREF1 | RT5645_PWR_MB |
> +				RT5645_PWR_BG | RT5645_PWR_VREF2);
> +			mdelay(10);
> +			snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
> +				RT5645_PWR_FV1 | RT5645_PWR_FV2,
> +				RT5645_PWR_FV1 | RT5645_PWR_FV2);
> +			snd_soc_update_bits(codec, RT5645_GEN_CTRL1,
> +				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
> +		}
> +		break;

Since the device can power up and down very quickly it should make sense
to set idle_bias_off for a power saving when idle.

> +#ifdef CONFIG_PM
> +static int rt5645_suspend(struct snd_soc_codec *codec)
> +{
> +	rt5645_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}
> +
> +static int rt5645_resume(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}
> +#else
> +#define rt5645_suspend NULL
> +#define rt5645_resume NULL
> +#endif

If you use idle_bias_off you can remove this.

> +#if defined(CONFIG_OF)
> +static const struct of_device_id rt5645_of_match[] = {
> +	{ .compatible = "realtek,rt5645", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt5645_of_match);
> +#endif

We need device tree binding documentation for any device with DT
bindings.

> +static int rt5645_i2c_remove(struct i2c_client *i2c)
> +{
> +	snd_soc_unregister_codec(&i2c->dev);
> +	kfree(i2c_get_clientdata(i2c));
> +	return 0;
> +}

You used devm_kzalloc(), no need to free.

> +void rt5645_i2c_shutdown(struct i2c_client *client)
> +{
> +	struct rt5645_priv *rt5645 = i2c_get_clientdata(client);
> +	struct snd_soc_codec *codec = rt5645->codec;
> +
> +	if (codec != NULL)
> +		rt5645_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +}

The ASoC framework will do this for you.

--F4Dl6XKrV7PH8SJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTETyAAoJELSic+t+oim9XG0QAIUVG73uDSNYAOa53xyJEacX
QhXYX+PJSpXh+nmdX09obfi1Cp6Lcon37d8ITCmYfk6PQmUdO9eVn+Y4BLigQrmN
xNifuLQv6rQb9rgYRadVCER0QSoSNJid0zRFlsyrDGKZavUZF8yMEOV9T21pWTwY
QONOO4iGFNg92yc3/GPszeuQZ+TUxGD7sW4MX4X0Mxp2cNn9HZjdJ4/O0J5I5ibo
NB1FIdYV6UfGc5feqh1ofpHC7vY3ssuPV7jKolJ+34ewlEp6BhcfRS4oW78RsuBK
UHE2d7lOTJreIQcM6rxNqATYIYyxt5+PjkByoIZftCbIwssWsDwPhbZJ4EivpwR3
4J2iwleEG7ecG+zRSaQBdSCdL4TLUcA4A01aV1NpwbwnK5VxeBmgEYgsgPTlWQMH
eQLeDgzIrLh8VGrwNB0AQDYXsEcRFPOEypeXcpKk2fA2gTYC6y9rrUg8UCwgkX7+
U3kzgi+yl+JmTJzi6qPblcZNDp6VQevWoHIcNCMPbnD5xpiTqRBnl1ofZDC2clhk
VxD89m6TKvGBgI5SqF9o/4ePyiS5Cln7H77tDx9RlyxQQodOpIcidoozhB0z85C/
eWeYitEg7LmzVWsi9ubdKVi3l+3cht2ilU/N8d/3AvdxYdYUnkb38r9N1RXG6bDc
F048q/bNtE+NWtNeOMGB
=b/D0
-----END PGP SIGNATURE-----

--F4Dl6XKrV7PH8SJF--

--===============0208393366692718316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0208393366692718316==--
