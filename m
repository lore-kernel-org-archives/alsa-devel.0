From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Add ADAU1X61 and ADAU1X81 CODECs
	common code
Date: Wed, 28 Aug 2013 17:59:57 +0100
Message-ID: <20130828165957.GL10783@sirena.org.uk>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0435564184748042542=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6630426109C
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2013 19:00:04 +0200 (CEST)
In-Reply-To: <1377703214-23234-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0435564184748042542==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+FS1wzm/v+2h3Q5"
Content-Disposition: inline


--x+FS1wzm/v+2h3Q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2013 at 05:20:09PM +0200, Lars-Peter Clausen wrote:

> +static void adau17x1_check_aifclk(struct snd_soc_codec *codec)
> +{
> +	struct adau *adau = snd_soc_codec_get_drvdata(codec);
> +
> +	/* If we are in master mode we need to generate bit- and frameclock,
> +	 * regardless of whether there is an active path or not */
> +	if (codec->active && adau->master)
> +		snd_soc_dapm_force_enable_pin(&codec->dapm, "AIFCLK");
> +	else
> +		snd_soc_dapm_disable_pin(&codec->dapm, "AIFCLK");
> +	snd_soc_dapm_sync(&codec->dapm);
> +}

I think this is eminently sensible but it seems like it should be a
framework feature.  That'd have to enable an actual AIF slot though
which is a bit fun, which slot do we enable for example?

> +static int adau17x1_set_dai_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
> +{
> +	struct adau *adau = snd_soc_codec_get_drvdata(dai->codec);
> +
> +	if (div < 0 || div > 4)
> +		return -EINVAL;
> +
> +	adau->sysclk_div = div;
> +
> +	return regmap_update_bits(adau->regmap, ADAU17X1_CLOCK_CONTROL,
> +		ADAU17X1_CLOCK_CONTROL_INFREQ_MASK, (div - 1) << 1);
> +}

What's this doing?  It'd be better to have a specific ID and check that
too.

> +int adau17x1_set_micbias_voltage(struct snd_soc_codec *codec,
> +	enum adau17x1_micbias_voltage micbias)
> +{
> +	struct adau *adau = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (micbias) {
> +	case ADAU17X1_MICBIAS_0_90_AVDD:
> +	case ADAU17X1_MICBIAS_0_65_AVDD:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_write(adau->regmap, ADAU17X1_MICBIAS, micbias << 2);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(adau17x1_set_micbias_voltage);

When would a machine driver use this (as opposed to just letting it be
set by platform data)?

--x+FS1wzm/v+2h3Q5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHiyKAAoJELSic+t+oim9Uj8P/0nHcDADMa8za2gbZxgvCxGZ
t12CpHxZq/ebLjo4QVLkqa0IM6GvPVOTbvVJCknKMt6wbzlQyP8y9c8zcbZes9t9
mGX/YjYIuzwzXM/adCWFpzWWYkJgBPuwRar/Lj+KYQ75+4AmTB7qqHTVi+goNQqg
xyPk7qJypm3+9XzX7iYJV2rdl5L6dR6OQbGny4fxCk/YZa+l8uzBCYbmgHMjKjlc
mX3QNYsl5e0yVDfwwyaqklp7+jcPJdVJo9KVUhQNZ+voeVa7wx+EXMbsHg6QlGWS
85i4Z+2acfopctWTHIxQF9GYqHPC/vR62zdeRqCjdxJR++445ebPCTaHG48dn2hx
/pxke1NNqaHP2Kyjbl49iR8fMrdWbUsYgSJwIUUaxLuxgiUqPPQWs3fAbQLzTfk/
+xF65FPxVSLxzulOGzvqpZjPmtdEPBG1i7fKE1dWbBFrXiIYRP8pCyb5D0lOQiZ+
5TEuKeMyEe0zF/ENqFv2zMgHwfEWf2qtgsT4i6i8FJwovLoMAv3QXZGmDwllgZKO
TSWOsJzIxH5WvY4ZeTq9CdjgoLEcXpw5Sn9R76wNxrcGHzdU3Z1H4C141ZKShQKF
wH96LxWYfWxagl2vrr8JRsU2bEkkfzRQ0/yir/d3gHSXS3J5jgC/7F8+Gje4d+wX
xPo8OrrIxbqeI42w0iv4
=p9DK
-----END PGP SIGNATURE-----

--x+FS1wzm/v+2h3Q5--

--===============0435564184748042542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0435564184748042542==--
