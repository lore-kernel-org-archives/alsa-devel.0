From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Wed, 22 Apr 2015 12:00:30 +0100
Message-ID: <20150422110030.GQ22845@sirena.org.uk>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1429619636-25478-8-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l8yJEXo8J9fv7OFY"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429619636-25478-8-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--l8yJEXo8J9fv7OFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 01:33:55PM +0100, Richard Fitzgerald wrote:

> +static int wm8998_in1mux_ev(struct snd_soc_dapm_widget *w,
> +				struct snd_kcontrol *kcontrol,
> +				int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
> +	unsigned int left_mux, right_mux, in1mode, old;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		/* Validate the mux configuration */
> +		left_mux = snd_soc_read(codec, ARIZONA_ADC_DIGITAL_VOLUME_1L) &
> +				  ARIZONA_IN1L_SRC_MASK;
> +		right_mux = snd_soc_read(codec, ARIZONA_ADC_DIGITAL_VOLUME_1R) &
> +				  ARIZONA_IN1R_SRC_MASK;
> +
> +		/* Only IN1A can be digital, IN1B is always analogue */
> +		in1mode = (arizona->pdata.inmode[0] & 2)
> +				<< (ARIZONA_IN1_MODE_SHIFT - 1);
> +
> +		if (in1mode != 0) {
> +			/* if IN1A is digital, the only valid mux configs
> +			 * are both channels A or both channels B.
> +			 */
> +			if (left_mux != right_mux) {
> +				dev_err(arizona->dev,
> +					"IN1=DMIC and IN1L Mux != IN1R Mux");
> +				return -EINVAL;
> +			}

This (or at least some of it) seems like something we should be doing by
registering different widgets and routing at device probe time.

> +		old = snd_soc_read(codec, ARIZONA_IN1L_CONTROL) &
> +					ARIZONA_IN1_MODE_MASK;

> +		if (old != in1mode)
> +			snd_soc_update_bits(codec, ARIZONA_IN1L_CONTROL,
> +						ARIZONA_IN1_MODE_MASK, in1mode);

Why bother with the read into old here?  Suppressing redundant updates
is part of the point of snd_soc_update_bits().

--l8yJEXo8J9fv7OFY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN39NAAoJECTWi3JdVIfQQxwH+gO2x+Li17UNOs7ycKZkQDMq
/FcusjV7wYyqJ8ykafkswXm+tLC9bMIayHlP4QWBcjEEGfHUz+pAaU6tCMwzkvJH
FpSewRbzPrBxae5IaYvuiT8E/r6lezrEGIpEmcuhuLTvryZfgpywiXssxik2K5Zu
LupmqcKWLGg6n0xbkz/6yKsSwONdW6wTPhq76rcVipzW5iLXjDcnQe/xoEreNbte
TI/QasWyOsiwDBtRdsxepNeQkpiQhDEhf0ru3IMg27gR8wGCSauW3qe+ZDyN10jR
X2hpr07kAl0Ulwr6AXhPqbqd2bKeLahGeCD5RrwDGIy7lhV6LKgxBghCqRtfhF4=
=8esy
-----END PGP SIGNATURE-----

--l8yJEXo8J9fv7OFY--
