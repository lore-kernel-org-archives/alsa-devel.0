From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
Date: Tue, 30 Jul 2019 15:58:44 +0100
Message-ID: <20190730145844.GI4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-3-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, Jerome Brunet <jbrunet@baylibre.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Marco Felsch <m.felsch@pengutronix.de>, Paul Cercueil <paul@crapouillou.net>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Annaliese McDermond <nh6z@nh6z.net>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Patrick Glaser <pglaser@tesla.com>, Rob Duncan <rduncan@tesla.com>, Nate
List-Id: alsa-devel@alsa-project.org


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:

> index 000000000000..0f82a88bc1a4
> --- /dev/null
> +++ b/sound/soc/codecs/tda7802.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tda7802.c  --  codec driver for ST TDA7802

Please make the entire comment a C++ one so this looks intentional.

> +static int tda7802_digital_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	const u8 mute_disabled = mute ? 0 : IB2_DIGITAL_MUTE_DISABLED;

Please write normal conditional statements to make the code easier to
read.

> +	case SND_SOC_BIAS_STANDBY:
> +		err = regulator_enable(tda7802->enable_reg);
> +		if (err < 0) {
> +			dev_err(component->dev, "Could not enable.\n");
> +			return err;
> +		}
> +		dev_dbg(component->dev, "Regulator enabled\n");
> +		msleep(ENABLE_DELAY_MS);

Is this delay needed by the device or is it for the regulator to ramp?
If it's for the regulator to ramp then the regulator should be doing it.

> +	case SND_SOC_BIAS_OFF:
> +		regcache_mark_dirty(component->regmap);

If the regulator is going off you should really be marking the device as
cache only.

> +		err = regulator_disable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(component->dev, "Could not disable.\n");

Any non-zero value from regulator_disable() is an error, there's similar
error checking issues in other places.

> +static const struct snd_kcontrol_new tda7802_snd_controls[] = {
> +	SOC_SINGLE("Channel 4 Tristate", TDA7802_IB0, 7, 1, 0),
> +	SOC_SINGLE("Channel 3 Tristate", TDA7802_IB0, 6, 1, 0),
> +	SOC_SINGLE("Channel 2 Tristate", TDA7802_IB0, 5, 1, 0),
> +	SOC_SINGLE("Channel 1 Tristate", TDA7802_IB0, 4, 1, 0),

These look like simple on/off switches so should have Switch at the end
of the control name.  It's also not clear to me why this is exported to
userspace - why would this change at runtime and won't any changes need
to be coordinated with whatever else is connected to the signal?

> +	SOC_ENUM("Mute time", mute_time),
> +	SOC_SINGLE("Unmute channels 1 & 3", TDA7802_IB2, 4, 1, 0),
> +	SOC_SINGLE("Unmute channels 2 & 4", TDA7802_IB2, 3, 1, 0),

These are also Switch controls.  There are *lots* of problems with
control names, see control-names.rst.

> +static const struct snd_soc_component_driver tda7802_component_driver = {
> +	.set_bias_level = tda7802_set_bias_level,
> +	.idle_bias_on = 1,

Any reason to keep the device powered up?  It looks like the power on
process is just powering things up and writing the register cache out
and there's not that many registers so the delay is trivial.

> +	tda7802->enable_reg = devm_regulator_get(dev, "enable");
> +	if (IS_ERR(tda7802->enable_reg)) {
> +		dev_err(dev, "Failed to get enable regulator\n");

It's better to print error codes if you have them and are printing a
diagnostic so people have more to go on when debugging problems.

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AWyMACgkQJNaLcl1U
h9CSRAf+JnRHblFvE8wz05/KmaqsoJ72DsJH6tOksd0/ifd52UjtRhoB3jIhVaR2
lJtx2+K9jHM8Q/tEBDNGXlzFt7MoUcvfgHfvAZ0Mfbkfvoox60KTJnh2C1B+Yr7i
TIVNSQJSN+NtdtSYs2BaFkk/Zrj7Q9kDj7BHHOBeK7fDkq8PTRdLHU1YjB+HlrTT
nRXLv1mXRa1cI+caoQRIXcQEOmW+VLlMasEFiSNS/0I3UtHgn2UHezS3Z+MHUJ4F
TOmV2MyA/S4wW70Cus6iZs7BO0aCYLQFJmFgtd0t+C3nMKvSILwBWidIzK9WYuc6
CeQAgukY5VCt+NmFvl4l2irCODm7Bg==
=Gl9u
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
