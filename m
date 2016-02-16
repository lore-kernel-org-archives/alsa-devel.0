From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 4/9] ASoC: msm8x16: add ranges for default, readonly
Date: Tue, 16 Feb 2016 19:16:56 +0000
Message-ID: <20160216191656.GE7544@sirena.org.uk>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455643976-1784-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455643976-1784-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:32:56PM +0000, Srinivas Kandagatla wrote:

> This patch add register ranges for readonly, default and reset register
> values.

This split of the patches is really not helping at all.  The patches
cross reference each other which makes things harder to follow and it's
not like things can be treated independently or there are detaile
changelogs explaining everything separately.

> +static int __msm8x16_wcd_reg_write(struct snd_soc_codec *codec,
> +			unsigned short reg, u8 val)
> +{
> +	int ret = -EINVAL;
> +	struct msm8x16_wcd_chip *chip = dev_get_drvdata(codec->dev);
> +
> +	if (MSM8X16_WCD_IS_TOMBAK_REG(reg)) {
> +		ret = regmap_write(chip->analog_map,
> +				   chip->analog_base + reg, val);
> +	} else if (MSM8X16_WCD_IS_DIGITAL_REG(reg)) {
> +		u32 temp = val & 0x000000FF;
> +		u16 offset = (reg ^ 0x0200) & 0x0FFF;
> +
> +		ret = regmap_write(chip->digital_map, offset, temp);
> +	}
> +
> +	return ret;
> +}

I don't really know what this is supposed to be doing but it looks like
something is wrong.  It seems that it's trying to munge two different
register maps together in some undocumented reason.

> +static int msm8x16_wcd_write(struct snd_soc_codec *codec, unsigned int reg,
> +			     unsigned int value)
> +{
> +	if (reg == SND_SOC_NOPM)
> +		return 0;
> +
> +	WARN_ON(reg > MSM8X16_WCD_MAX_REGISTER);
> +	if (!msm8x16_wcd_volatile(codec, reg))
> +		msm8x16_wcd_reset_reg_defaults[reg] = value;

This appears to be obviously confused.  We're writing to a global
variable as part of the write routine, and worse that global variable is
called _reg_defaults which suggests that it's supposed to be the
register default values not what appears to be a cache implemented
outside of the existing generic cache code.

> +
> +	return __msm8x16_wcd_reg_write(codec, reg, (u8)value);
> +}

It's also not clear why this is a separate wrapper function.

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw3WnAAoJECTWi3JdVIfQLJoH/0UHZrkodiBZpllTTaCcq28+
zIDq6baNrF+fOOFKhnzFM7Jz4n1iQw+1MrGQoBTjzf4HkHmrqcOe9vLtQYT2sPOn
uB2uJGUexvDnFMpSN3Ie9vLquBNDcjC6i0ZVFpoSl/keEeD6KzYP4wgO/5FzEHdb
2bSuE9/TfwgTaF0y+/0Xd0CMaPiWO88IavRXHCXC0AnWRq5e7dIK9iwLH2QLk3Nv
+8r/0X80QrD9Rkd8fmWAMpGN2Z3q9xssXNbwZ4LvI0mdTlfqFa7AqV7ESkLuhmi2
InW5JUz8DZEVK//IWT2+4cz2qdMPe7+7W9SSsNSxQj2ywpXxO7prcgratoh7/Rw=
=4u7h
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
