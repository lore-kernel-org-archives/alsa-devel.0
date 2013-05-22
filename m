From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add ssm2518 support
Date: Wed, 22 May 2013 12:57:05 -0500
Message-ID: <20130522175705.GU1627@sirena.org.uk>
References: <1369242013-27672-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5936394929545295078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B1E2260899
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:57:32 +0200 (CEST)
In-Reply-To: <1369242013-27672-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Grant Likely <grant.likely@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============5936394929545295078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XbOGSHoyTtRSevGh"
Content-Disposition: inline


--XbOGSHoyTtRSevGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 07:00:13PM +0200, Lars-Peter Clausen wrote:
> This patch adds a ASoC CODEC driver for the SSM2516. The SSM2516 is a ste=
reo
> Class-D audio amplifier with an I2S interface for audio in and a built-in
> dynamic range control processor.

I'll apply this but=20

> +	if (slots =3D=3D 0) {
> +		return regmap_update_bits(ssm2518->regmap,
> +			SSM2518_REG_SAI_CTRL1, SSM2518_SAI_CTRL1_SAI_MASK,
> +			SSM2518_SAI_CTRL1_SAI_I2S);
> +	}

You've got quite a few single statement if () blocks with { } which
shouldn't be there.

> +	codec->control_data =3D ssm2518->regmap;
> +	ret =3D snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_update_bits(ssm2518->regmap, SSM2518_REG_POWER2,
> +				SSM2518_POWER2_APWDN, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return ssm2518_set_bias_level(codec, SND_SOC_BIAS_OFF);

The power down stuff shouild probably be done in the I2C probe so that
the device is in a low power state if unused.

> +	switch (freq) {
> +	case 2048000:

Looks like the user can't select 0 for the SYSCLK, I'd expect that to be
possible for systems that can reprogram the clock so that they can avoid
having constraints set when they don't need them.

> +static bool ssm2518_register_volatile(struct device *dev, unsigned int r=
eg)
> +{
> +	return false;
> +}

Hrm, this should be the default...

> +	} else if (i2c->dev.of_node) {
> +		ssm2518->enable_gpio =3D of_get_gpio(i2c->dev.of_node, 0);
> +		if (ssm2518->enable_gpio =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

Why are other errors being ignored here?

--XbOGSHoyTtRSevGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnQbuAAoJELSic+t+oim93ecP/ifa3C73VStW30XIA/EqkYiV
Szjh1GLzH026HKNmCcQcsxafZ/H484pK0M4Iy2416AuUWitvf9s7bwljnUq1VWUn
znqKDGtz+pcNtScnW2IRY/LaAlGHizBG7YQ4XlWvys1M3safIpT15pS2vCFooIT1
kG36cy+DZeCleM6b+RVsko3VT26qdUIibNAQQYin3zFjFBFgeKVdiQHnXPteo5Lt
/cvq/Um1y4TlQjK+AHMZu+ySKUyZ5Q4SBJU7T47y1OKXB/yf5YPR+PpfmKOF325t
TFHlDaPXlpM3s/1gIesvJRsfCQHq7kmCIwbPn45r0DSp9/8ZCu4sqLBV7dHbArdR
lv3HH/kc5e0K6U+ftBqsebl68rZMELAxaG2iQkhzTEBtQb2NCpQI90zuvWXztbkh
0dCeu+AiehXka1tDqJVrXUro4Lul00Tn19NS/yshnZdpLiZ/TU+KU3rWYxMyhRhT
X7VNH5ZnByonbmnohvLu3M8eiFWbuXifEXix/ii/bHiKV9RyI2InKVOGqlaeUeFv
FAmAlQuZsu7tph0BhoFOzElziQaKOHLIbU4tQfFvPuyOooqS7dOWNQY7P52Tifme
kk4iAHYFIcsZv97xMeDN/Pgms2M7bH8yw2eg8GQb+KT+FwF0q2pIOrHW6t1NUjbz
Xp1TXceegoW1idXF0mcP
=0IWW
-----END PGP SIGNATURE-----

--XbOGSHoyTtRSevGh--

--===============5936394929545295078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5936394929545295078==--
