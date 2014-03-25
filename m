From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Tue, 25 Mar 2014 13:30:17 +0000
Message-ID: <20140325133017.GY2269@sirena.org.uk>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8124870506456902182=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C709026260F
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 14:30:25 +0100 (CET)
In-Reply-To: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oder_chiou@realtek.com
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8124870506456902182==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VIFPKPeEU/ajvd6j"
Content-Disposition: inline


--VIFPKPeEU/ajvd6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2014 at 10:16:37AM +0800, oder_chiou@realtek.com wrote:
> From: Oder Chiou <oder_chiou@realtek.com>
>=20
> This patch adds the RT5639 codec driver.

Looking at the level of code similiarity between this and the rt5640
driver I can't help but think that these should be supported from a
single driver - a few quick spot checks of the register map suggests
that there's at least some overlap.  There will need to be some device
specific handling but it looks like there's more shared than not shared.
What are the issues that prevent the code being shared, there may be
something I've missed?

There's also a few issues below that should be fixed, most of them
should be fixed in rt5640 too.

> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		val_len |=3D RT5639_I2S_DL_20;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		val_len |=3D RT5639_I2S_DL_24;
> +		break;
> +	case SNDRV_PCM_FORMAT_S8:
> +		val_len |=3D RT5639_I2S_DL_8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This should be converted to use params_width().

> +static int rt5639_set_bias_level(struct snd_soc_codec *codec,
> +			enum snd_soc_bias_level level)
> +{
> +	struct rt5639_priv *rt5639 =3D snd_soc_codec_get_drvdata(codec);
> +	switch (level) {
> +	case SND_SOC_BIAS_STANDBY:
> +		if (SND_SOC_BIAS_OFF =3D=3D codec->dapm.bias_level) {
> +			regcache_cache_only(rt5639->regmap, false);

=2E..

> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_write(codec, RT5639_DEPOP_M1, 0x0004);
> +		snd_soc_write(codec, RT5639_DEPOP_M2, 0x1100);
> +		snd_soc_update_bits(codec, RT5639_DUMMY1, 0x1, 0);
> +		snd_soc_write(codec, RT5639_PWR_DIG1, 0x0000);
> +		snd_soc_write(codec, RT5639_PWR_DIG2, 0x0000);
> +		snd_soc_write(codec, RT5639_PWR_VOL, 0x0000);
> +		snd_soc_write(codec, RT5639_PWR_MIXER, 0x0000);
> +		snd_soc_write(codec, RT5639_PWR_ANLG1, 0x0000);
> +		snd_soc_write(codec, RT5639_PWR_ANLG2, 0x0000);
> +		break;

I'd expect to see the regmap being made cache_only in _OFF given that it
is resynced in _STANDBY when exiting _OFF, or alternatively to see the
cache restore moved to the resume to mirror where it's currently made
cache only.

> +static int rt5639_probe(struct snd_soc_codec *codec)
> +{
> +	struct rt5639_priv *rt5639 =3D snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	rt5639->codec =3D codec;
> +	codec->control_data =3D rt5639->regmap;
> +
> +	ret =3D snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
> +	if (ret !=3D 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}

There have been some API changes here this release cycle, you should be
able to just remove the cache_io() and regmap setting code here.

> +	if (rt5639->pdata.in1_diff)
> +		regmap_update_bits(rt5639->regmap, RT5639_IN1_IN2,
> +					RT5639_IN_DF1, RT5639_IN_DF1);
> +
> +	if (rt5639->pdata.in2_diff)
> +		regmap_update_bits(rt5639->regmap, RT5639_IN3_IN4,
> +					RT5639_IN_DF2, RT5639_IN_DF2);

Why not have platform data to register if the DMICs are in use rather
than twiddling the GPIOs in an event?  It'd be more idiomatic.

--VIFPKPeEU/ajvd6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMYTmAAoJELSic+t+oim9OrAP/2o1mxvsGoWmUoVpE8PhkZbN
G4/ygqnnlzqjpPWUS+cuaY1/HKfKNqRMXPrOKN9SOH3KBHKhTucnA1tL/0UxN6qq
Rm4wTFfMMH8pYJx6eFK08KG0FdenmTGTzqs6Rf1RezaZ/U1yY10OJOljd0Y6dJOI
YK/JZ5hSgWvsXYgrmpQYM+qM9YAaHvGNIsVBLsivdFxDoT6vTsbJigixGPx13y2y
4FUuJGLbhumOELZHkmFG/YQ2WUd6fUJqpSJttCHTx221AOo5kC0nNSeDcBwdf+Eb
Hj6zFbwzQG/cLDAQnlgFwDppDJg1ZURaEB4KOG3pdD+nfb7Majc+f9Or+cZupOgy
RcK82k4T8MzsxNwy2t47gKH3rjgZ0ZXpsw6APe3A/ql5H30fuNCelexobcv3u1wx
4K/9WOxI27kEHPwx4FMso7aW59MeC09ov610vZLZTeRyTXWSWM5Y8yiesyK3B3M5
A/D+0Bz8FJxL/t/q7qoLh0HOEdUwG2gBoJ4FyPS34/ucXLZ9rKVrTa2gaSsV1BEg
f84v8/65AKRchxcfjWDJmEXF3Mi9QR/gep54PYKP9n7WaZdKqCDCWqlW1X4TagKw
K9yStC3DTejRg7SdaSCZiqqCjDVB0I/VnZuXqgni9NWaa+tHprwM54yEeoNffdJp
U24U5fKXgZSVnISwjO4l
=/y/j
-----END PGP SIGNATURE-----

--VIFPKPeEU/ajvd6j--

--===============8124870506456902182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8124870506456902182==--
