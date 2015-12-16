From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-pdmic: add the Pulse Density Modulation
 Interface Controller
Date: Wed, 16 Dec 2015 12:27:27 +0000
Message-ID: <20151216122727.GI5727@sirena.org.uk>
References: <1450080940-4123-1-git-send-email-songjun.wu@atmel.com>
 <1450080940-4123-2-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YszDAcSgCu6rDIlP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450080940-4123-2-git-send-email-songjun.wu@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--YszDAcSgCu6rDIlP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 14, 2015 at 04:15:39PM +0800, Songjun Wu wrote:

> Add driver for the Pulse Density Modulation Interface
> Controller. It comes with digitallly controlled gain,
> a High-Pass and a SINCC filter.

This looks basically OK but there's a *lot* of weird coding style issues
in here.  It's really all that, nothing too serious that I noticed -
I've pointed out some of the patterns below not every individual issue.

> +	for (i = 0; i < ARRAY_SIZE(mic_gain_table); i++) {
> +		if ((mic_gain_table[i].dgain == dgain_val)
> +		&& (mic_gain_table[i].scale == scale_val))
> +			ucontrol->value.integer.value[0] = i;
> +	}

This indentation is really weird, why is the && aligned with the if?

> +	snd_soc_update_bits(codec, PDMIC_DSPR1,
> +		PDMIC_DSPR1_OFFSET_MASK,
> +		(u32)(dd->pdata->mic_offset << PDMIC_DSPR1_OFFSET_SHIFT));

These are weird too, I'd expect the second line to be part of the first.

> +static struct regmap *atmel_pdmic_codec_get_remap(struct device *dev)
> +{
> +	return dev_get_regmap(dev, NULL);
> +}

This is (or should be) the default in the core.

> +	if ((fs < rate_min) || (fs > rate_max)) {
> +		dev_err(codec->dev,
> +		"sample rate is %dHz, min rate is %dHz, max rate is %dHz\n",
> +		fs, rate_min, rate_max);

This too, alignment after the (.

> +	if (bits == 16)
> +		dspr0_val = (PDMIC_DSPR0_SIZE_16_BITS
> +				<< PDMIC_DSPR0_SIZE_SHIFT);
> +	else if (bits == 32)
> +		dspr0_val = (PDMIC_DSPR0_SIZE_32_BITS
> +				<< PDMIC_DSPR0_SIZE_SHIFT);
> +	else
> +		return -EINVAL;

This looks like it should be a switch statement.

--YszDAcSgCu6rDIlP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcViuAAoJECTWi3JdVIfQDGgH/2LqoeERFkN89u2uz+87BjdX
wUzYpxg9bdFhPgilhibZkd8qpOPCVYJ8/k/kc/nAX57JdyNIkX7pjuNKOLcq5T17
3S7UQzJsWjtC0iXNJ6q3t+rbHe6IdfQWkhXHcbv86eZZgjeLGx6BUTcQHo0M8D2S
WO6KsTCqRNVlzsB3dr5mazW/EBNMwABoYXRsgTuJvhvP+9rzf9rpKWA5iiLgnbC2
49nDboe1GYXVt3RBUXHL/wSCnrCI0NBRcXpg1yIuK5n1NGla6mH3WrIVa2Cxcovp
aTiek8sX8IZ6VDs0WrWHWait9nl7OD39+cbjoIby0zsKEDx3SDHRdB9ita3m6xI=
=MICX
-----END PGP SIGNATURE-----

--YszDAcSgCu6rDIlP--
