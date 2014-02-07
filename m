From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] ASoC: da9055: Fix device registration of PMIC and
 CODEC devices
Date: Fri, 7 Feb 2014 10:56:57 +0000
Message-ID: <20140207105657.GL14727@lee--X1>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391705989.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> Currently the I2C device Ids conflict for the MFD and CODEC so
> cannot be both instantiated on one platform. This patch updates
> the Ids and names to make them unique from each other.
>=20
> It should be noted that the I2C addresses for both PMIC and CODEC
> are modifiable so instantiation of the two are kept as separate
> devices, rather than instantiating the CODEC from the MFD code.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mfd/da9055-i2c.c  |   12 ++++++++++--
>  sound/soc/codecs/da9055.c |   11 +++++++++--
>  2 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
> index 13af7e5..8103e43 100644
> --- a/drivers/mfd/da9055-i2c.c
> +++ b/drivers/mfd/da9055-i2c.c
> @@ -53,17 +53,25 @@ static int da9055_i2c_remove(struct i2c_client *i=
2c)
>  	return 0;
>  }
>=20
> +/*
> + * DO NOT change the device Ids. The naming is intentionally specifi=
c as both
> + * the PMIC and CODEC parts of this chip are instantiated separately=
 as I2C
> + * devices (both have configurable I2C addresses, and are to all int=
ents and
> + * purposes separate). As a result there are specific DA9055 ids for=
 PMIC
> + * and CODEC, which must be different to operate together.
> + */

I'm not sure this comment is required.

Most device IDs are named this way.

>  static struct i2c_device_id da9055_i2c_id[] =3D {
> -	{"da9055", 0},
> +	{"da9055-pmic", 0},
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
>=20
>  static struct i2c_driver da9055_i2c_driver =3D {
>  	.probe =3D da9055_i2c_probe,
>  	.remove =3D da9055_i2c_remove,
>  	.id_table =3D da9055_i2c_id,
>  	.driver =3D {
> -		.name =3D "da9055",
> +		.name =3D "da9055-pmic",
>  		.owner =3D THIS_MODULE,
>  	},
>  };
> diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
> index 52b79a4..4228126 100644
> --- a/sound/soc/codecs/da9055.c
> +++ b/sound/soc/codecs/da9055.c
> @@ -1523,8 +1523,15 @@ static int da9055_remove(struct i2c_client *cl=
ient)
>  	return 0;
>  }
>=20
> +/*
> + * DO NOT change the device Ids. The naming is intentionally specifi=
c as both
> + * the CODEC and PMIC parts of this chip are instantiated separately=
 as I2C
> + * devices (both have configurable I2C addresses, and are to all int=
ents and
> + * purposes separate). As a result there are specific DA9055 Ids for=
 CODEC
> + * and PMIC, which must be different to operate together.
> + */

And here, really, no need.

>  static const struct i2c_device_id da9055_i2c_id[] =3D {
> -	{ "da9055", 0 },
> +	{ "da9055-codec", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
> @@ -1532,7 +1539,7 @@ MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
>  /* I2C codec control layer */
>  static struct i2c_driver da9055_i2c_driver =3D {
>  	.driver =3D {
> -		.name =3D "da9055",
> +		.name =3D "da9055-codec",
>  		.owner =3D THIS_MODULE,
>  	},
>  	.probe		=3D da9055_i2c_probe,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
