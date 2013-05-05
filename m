From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Convert to use regmap
	directly
Date: Sun, 5 May 2013 11:21:48 +0100
Message-ID: <20130505102148.GU4945@sirena.org.uk>
References: <1367692780-23550-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2211996964953699771=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CC9CC261689
 for <alsa-devel@alsa-project.org>; Sun,  5 May 2013 12:21:53 +0200 (CEST)
In-Reply-To: <1367692780-23550-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2211996964953699771==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f6M9UaX53EEZorp0"
Content-Disposition: inline


--f6M9UaX53EEZorp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2013 at 03:39:34PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks - this can be taken a step further and

> +static const struct regmap_config sgtl5000_regmap =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 16,
> +
> +	.max_register =3D SGTL5000_MAX_REG_OFFSET,
> +	.volatile_reg =3D sgtl5000_volatile,
> +	.readable_reg =3D sgtl5000_readable,
> +
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.reg_defaults =3D sgtl5000_reg_defaults,
> +	.num_reg_defaults =3D ARRAY_SIZE(sgtl5000_reg_defaults),
> +};

Based on the comments in the commit you mentioned before do we need to
have some sort of register striding in there?

>  static int sgtl5000_i2c_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> @@ -1415,6 +1485,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *c=
lient,
>  	if (!sgtl5000)
>  		return -ENOMEM;
> =20
> +	sgtl5000->regmap =3D devm_regmap_init_i2c(client, &sgtl5000_regmap);
> +	if (IS_ERR(sgtl5000->regmap)) {
> +		ret =3D PTR_ERR(sgtl5000->regmap);
> +		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
> +		return ret;
> +	}
> +

Now we have register I/O in the probe the regulator setup, device
identification and so on can be pulled out here.  This is more idiomatic
for the device model if nothing else.

There's definitely still a bug in this driver with regard to not syncing
the cache too...

--f6M9UaX53EEZorp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRhjK5AAoJELSic+t+oim9GVkP/Av3rc4I3jYM9Y97VxrUEAuX
N8/lCZBBSXmoRHSnrjhCxtVu6xSj58kzgIE4YbRFuXnHwQyzJrbSlExeVI3xoeFz
Y/1Q/Yc7mndMW5mRh5LASeT8hLYuUY4ELhoWLwVpsb34IhqGLBJWLqrabsw1Ee8v
Xd4DhdJ+Ffi3JLc7YR8nRJbv3xFJ0kvilKpOXfz5d7oxuYaFmDn1N76x5S3erwwZ
YRWwnwvNhR1UiP8TJIDs0OJt22MxWZ61mPRsmBylBt2ee+iosyG1mq/Lh6hhugSo
WT4ci946CVbZiuZ/2hDx0atkluebnQztDxiLBe1QNDG9jE25mY+cU8pXPtRrh7KK
FWcjXRgU59GBxFeWIwRPnsQjhVdvzAJfP+/iLk2AOha3JB6584TBaaSlYARUCFZS
WQTLPYGNXQnmm7HiQqIH10EZgp8e0YrxS7tKGgIty1NplCseA/17i2hrEHQPMCH3
i9aoeQXpYYDyUyCyayBvRNfCrVVnBhx1GEmbvcwJ5VwhC9ceZTGCSa2j4EldD49m
keVlsC3uDSGREIoyqzhrtwAXTprKWwx6Il4TopZwmSgvo0bJrDr5OprH5FjXzB7I
kBqu2mzBZ7loD3LAvsg1NHPj+QFvCWBp0oRgKC4/qnwQUqSJP3NG3KOX6ztNWsH6
Y2tbrznL+QMCVV0uZNTV
=hWFt
-----END PGP SIGNATURE-----

--f6M9UaX53EEZorp0--

--===============2211996964953699771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2211996964953699771==--
