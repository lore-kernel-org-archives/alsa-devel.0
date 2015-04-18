From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Sat, 18 Apr 2015 12:36:32 +0100
Message-ID: <20150418113632.GE26185@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429134141-17924-2-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2015 at 02:42:20PM -0700, Kevin Cernekee wrote:

This looks mostly good but several things below, all of which should be
straightforward to fix.

> +static int tas571x_set_sysclk(struct snd_soc_dai *dai,
> +			      int clk_id, unsigned int freq, int dir)
> +{
> +	/*
> +	 * TAS5717 datasheet pg 21: "The DAP can autodetect and set the
> +	 * internal clock-control logic to the appropriate settings for all
> +	 * supported clock rates as defined in the clock control register."
> +	 */
> +	return 0;
> +}

Remove empty functions, at best they waste space at worst they break
things.

> +	val += (clamp(params_width(params), 16, 24) >> 2) - 4;

Please write this more clearly or comment it (preferably the former),
it's hard to tell what it's supposed to do and therefore hard to tell if
it's doing it correctly.

> +static int tas571x_set_shutdown(struct tas571x_private *priv, bool is_shutdown)
> +{
> +	return regmap_update_bits(priv->regmap, TAS571X_SYS_CTRL_2_REG,
> +		TAS571X_SYS_CTRL_2_SDN_MASK,
> +		is_shutdown ? TAS571X_SYS_CTRL_2_SDN_MASK : 0);
> +}

> +		ret = tas571x_set_shutdown(priv, false);
> +		if (ret)
> +			return ret;
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		ret = tas571x_set_shutdown(priv, true);
> +		if (ret)
> +			return ret;

This looks like it'd be clearer just as direct register updates, I'm not
sure a function to set a single bit is addinng much.

> +	case SND_SOC_BIAS_OFF:
> +		/* Note that this kills I2C accesses. */
> +		assert_pdn = 1;

No, the GPIO set associated with it kills I2C access.  I'd also expect
to see the regmap being marked cache only before we do this and a resync
of the register map when we power back up (assuming that is actually a
power down).

> +static const struct snd_kcontrol_new tas5711_controls[] = {
> +	SOC_SINGLE_TLV("Master Volume",
> +		       TAS571X_MVOL_REG,
> +		       0, 0xff, 1, tas5711_volume_tlv),

All these controls will be brokenn if the I2C access goes away.

> +static const struct snd_soc_codec_driver tas571x_codec = {
> +	.set_bias_level = tas571x_set_bias_level,
> +	.suspend_bias_off = true,

Why not idle_bias_off?  It looks like power up takes no meaningful
time.

> +static int tas571x_register_size(struct tas571x_private *priv, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TAS571X_MVOL_REG:
> +	case TAS571X_CH1_VOL_REG:
> +	case TAS571X_CH2_VOL_REG:
> +		return priv->dev_id == TAS571X_ID_5711 ? 1 : 2;

Nest switch statements please, that way things work better if another
variant turns up.

> +	/*
> +	 * This will fall back to the dummy regulator if nothing is specified
> +	 * in DT.
> +	 */

The driver doesn't care, it may not even be on a system using DT.

> +	if (devm_regulator_bulk_get(dev, TAS571X_NUM_SUPPLIES,
> +				    priv->supplies)) {
> +		dev_err(dev, "Failed to get supplies\n");
> +		return -EINVAL;
> +	}

Don't discard error codes from functions you call, log them and provide
them to calllers.  The above is broken for probe deferral for example.

> +	priv->pdn_gpio = devm_gpiod_get(dev, "pdn");
> +	if (!IS_ERR(priv->pdn_gpio)) {
> +		gpiod_direction_output(priv->pdn_gpio, 1);
> +	} else if (PTR_ERR(priv->pdn_gpio) != -ENOENT &&
> +		   PTR_ERR(priv->pdn_gpio) != -ENOSYS) {
> +		dev_warn(dev, "error requesting pdn_gpio: %ld\n",
> +			 PTR_ERR(priv->pdn_gpio));
> +	}

This should at least be handling probe deferral, it's not clear why it
doesn't just error out in the cases where it gets an error.  Similarly
for the reset GPIO.

> +		/*
> +		 * The master volume defaults to 0x3ff (mute), but we ignore
> +		 * (zero) the LSB because the hardware step size is 0.125 dB
> +		 * and TLV_DB_SCALE_ITEM has a resolution of 0.01 dB.
> +		 */
> +		if (regmap_write(priv->regmap, TAS571X_MVOL_REG, 0x3fe))
> +			return -EIO;

I don't understand this - is the LSB a mute bit or sommething?

> +#ifndef _TAS571X_H
> +#define _TAS571X_H
> +
> +#include <sound/pcm.h>

Why is this needed in the header?

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkG/AAoJECTWi3JdVIfQd60H/2iJLecnScq4pyKJMEnb4PCh
AxWBjsfTOdXlcm4uuMv5XBnSed9CMDj/4K4VjsuEYlWbVw7pnCINkaBBundlVmxW
u1LoyIKIYr2E6wNq6GIS+HV4/B0MszU0fluqrJUplnILnUx6IFltj6QgzORdTliV
AW10VDGoK5ZVoPvsOhvAElL7MWkAqGr/u8xREM2pyECTyQDAZeS3+Yh0ci6s9q9c
fFnVS4s/QS5BWD7BsbQTMXXWvCTuT+c2vornB5ujiySaC6JpHsO7IWAxjOGJ2gli
OAacPFk5fyy2uWFBC03+AgRyG1Gex5PMsQKYdG6mznvjCA6zUONPZwYElYWuwrI=
=Eklk
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
