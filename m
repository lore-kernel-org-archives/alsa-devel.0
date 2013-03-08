From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: add codec driver for TI TAS5086
Date: Fri, 8 Mar 2013 19:42:54 +0800
Message-ID: <20130308114251.GF28481@opensource.wolfsonmicro.com>
References: <1362740833-15704-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7105992686153579340=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB7AD26170F
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 12:53:18 +0100 (CET)
In-Reply-To: <1362740833-15704-1-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7105992686153579340==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 12:07:13PM +0100, Daniel Mack wrote:
> This patch adds a driver for TI's TA5086 6-channel PWM processor.
>=20
> This chip has a very unusual register layout, specifically because the
> registers are of unequal size, and multi-byte registers require bulk
> writes to take effect. Regmap does not support these kind of mappings.

Well, now we have the no-bus mechanism so...  doesn't matter anyway
though given that in this version the funky registers aren't used.

> Currently, the driver does not touch any of the registers >=3D 0x20, so
> it doesn't matter, because the register map is mapped to an 8-bit array.
> In case more features will be added in the future that require access
> to higher registers, the entire regmap H/W I/O routines have to be
> open-coded.

We should be able to interoperate with regmap for this somehow, though
it'll need us to add lock/unlock access to ensure that the core won't
interfere.

> +static bool tas5086_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	return reg =3D=3D TAS5086_DEV_ID ||
> +	       reg =3D=3D TAS5086_ERROR_STATUS;
> +}

switch please.

> +static int tas5086_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				  int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec =3D codec_dai->codec;
> +	struct tas5086_private *priv =3D snd_soc_codec_get_drvdata(codec);
> +
> +	switch (clk_id) {
> +	case 0:		/* MCLK */
> +		priv->mclk =3D freq;
> +		break;
> +	case 1:		/* SCLK */
> +		priv->sclk =3D freq;
> +		break;

Defines in a header please.

> +static int tas5086_digital_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	struct tas5086_private *priv =3D snd_soc_codec_get_drvdata(codec);
> +
> +	return regmap_write(priv->regmap, TAS5086_SOFT_MUTE,
> +			    mute ? 0x3f : 0x00);

Please avoid the ternery operator.  It'd be nice to switch over to
mute_stream() too.

> +#ifdef CONFIG_PM
> +static int tas5086_soc_suspend(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Empty functions can just be omitted, though it might make sense to hold
the device in reset over suspend.

> +		/* Codec needs ~15ms to wake up */
> +		msleep(15);
> +	}
> +msleep(300);
> +	priv->gpio_nreset =3D gpio_nreset;

Indentation.

> +static int tas5086_i2c_probe(struct i2c_client *i2c,
> +			     const struct i2c_device_id *id)
> +{
> +	struct tas5086_private *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap =3D devm_regmap_init_i2c(i2c, &tas5086_regmap);
> +	if (IS_ERR(priv->regmap)) {
> +		ret =3D PTR_ERR(priv->regmap);
> +		dev_err(&i2c->dev, "Failed to create regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(i2c, priv);
> +
> +	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
> +		&tas5086_dai, 1);

I'd expect things like checking the device ID (and probably most if not
all of the basic setup and GPIO free stuff) to be pulled out to the I2C
level.

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROc6GAAoJELSic+t+oim9rUgP+wdYdAWAwNPQ+Ih0oiWjjKG3
yi6w554hDTZ3Rwb+iB3E6DQFLMvWfSQ+MYQS0FtrUi/owBmwVL0YSwPfi/5S3wsJ
xBfU3pMC3eAYH+VYHP8KD32gyvbHIkx4LG/youian9LBWs02DtKa0C7vLIr4TvFp
6yy3+qdOjhp5Cxyuvl2PZQOpgbr35TGAxICP8fwwzyZ4qYe1dg+b2C7ON421CX4o
Ije/dK6e2WBYuITtnYiMBOG50mBfzrD5cYgBxq73UBUwOlZBQ6S5oxzYGKGbtkr+
UKIkWHrKE7leT/gOyeMn2qrlHwg/Z6JT5q5Hif4nKqaHRsc0maTlMUA6INeWQnpj
eBb74dZ6CoRvXoL5Zapz4SL6VzxScCSwv1xYRTUZdQ8S1eaG7A6H/1cJEoHPCJlN
xblizhk59iBoEYh329oZnGaHeggXUgU7Z5beIqjVi5xHblusY/hIhiCU9VY8PhKD
Bax/sjgJ/Z6jqIHt9ftC5z5Sp80pf1ljjmfnMP8uqKaKkHf/bzHgx92F03NWd5EC
eddwov8jvNPZrKEfsBXzWMpL43WffyNTUL2Rsn1m2/pBsLD9tJaQIYyAbkSNgw9Q
ITLbkrAGXe+Muv/j0jnwKj/WdAS5DL5dePkJpAskheHDL4iQ2SY+UpASuA6k4IIh
56wGNvm/tZYhV2onW8v1
=u3Mf
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--

--===============7105992686153579340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7105992686153579340==--
