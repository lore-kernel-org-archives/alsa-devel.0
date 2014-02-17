From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v4 2/4] ASoC: tlv320aic32x4: Support for
	regulators
Date: Mon, 17 Feb 2014 10:07:24 +0100
Message-ID: <20140217090724.GE31006@pengutronix.de>
References: <1392575252-9222-1-git-send-email-mpa@pengutronix.de>
 <1392575252-9222-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1750922669298947766=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AFA4C261A8C
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 10:07:32 +0100 (CET)
In-Reply-To: <1392575252-9222-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1750922669298947766==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 16, 2014 at 07:27:30PM +0100, Markus Pargmann wrote:
> Support regulators to power up the codec. This patch also enables the
> AVDD LDO if no AV regulator was found.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/tlv320aic32x4.txt    |  8 +++
>  sound/soc/codecs/tlv320aic32x4.c                   | 73 ++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/=
Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> index 352be7b..5e2741a 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt

=2E..

> @@ -699,6 +705,67 @@ static int aic32x4_parse_dt(struct aic32x4_priv *aic=
32x4,
>  	return 0;
>  }
> =20
> +static int aic32x4_i2c_setup_regulators(struct device *dev,
> +		struct aic32x4_priv *aic32x4)
> +{
> +	int ret;

This ret is uninitialized and returned later in this function. I will
fix it and send a new version for this.

Regards,

Markus

> +
> +	aic32x4->supply_ldo =3D devm_regulator_get_optional(dev, "ldoin");
> +	aic32x4->supply_iov =3D devm_regulator_get(dev, "iov");
> +	aic32x4->supply_dv =3D devm_regulator_get_optional(dev, "dv");
> +	aic32x4->supply_av =3D devm_regulator_get_optional(dev, "av");
> +
> +	/* Check if the regulator requirements are fulfilled */
> +
> +	if (IS_ERR(aic32x4->supply_iov)) {
> +		dev_err(dev, "Missing supply 'iov'\n");
> +		ret =3D -EINVAL;
> +	}
> +
> +	if (IS_ERR(aic32x4->supply_ldo)) {
> +		if (IS_ERR(aic32x4->supply_dv)) {
> +			dev_err(dev, "Missing supply 'dv' or 'ldoin'\n");
> +			ret =3D -EINVAL;
> +		}
> +		if (IS_ERR(aic32x4->supply_av)) {
> +			dev_err(dev, "Missing supply 'av' or 'ldoin'\n");
> +			ret =3D -EINVAL;
> +		}
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR(aic32x4->supply_ldo)) {
> +		ret =3D regulator_enable(aic32x4->supply_ldo);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!IS_ERR(aic32x4->supply_iov)) {
> +		ret =3D regulator_enable(aic32x4->supply_iov);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!IS_ERR(aic32x4->supply_dv)) {
> +		ret =3D regulator_enable(aic32x4->supply_dv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!IS_ERR(aic32x4->supply_av)) {
> +		ret =3D regulator_enable(aic32x4->supply_av);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!IS_ERR(aic32x4->supply_ldo) && IS_ERR(aic32x4->supply_av))
> +		aic32x4->power_cfg |=3D AIC32X4_PWR_AIC32X4_LDO_ENABLE;
> +
> +	return 0;
> +}
> +
>  static int aic32x4_i2c_probe(struct i2c_client *i2c,
>  			     const struct i2c_device_id *id)
>  {
> @@ -736,6 +803,12 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
>  		aic32x4->rstn_gpio =3D -1;
>  	}
> =20
> +	ret =3D aic32x4_i2c_setup_regulators(&i2c->dev, aic32x4);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to setup regulators\n");
> +		return ret;
> +	}
> +
>  	aic32x4->mclk =3D devm_clk_get(&i2c->dev, "mclk");
>  	if (IS_ERR(aic32x4->mclk))
>  		dev_info(&i2c->dev, "No mclk found, continuing without clock\n");
> --=20
> 1.8.5.3
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTAdFMAAoJEEpcgKtcEGQQSaQP/0VWE0jqgDcHtQ7T6nA8wb15
0pv3uYXFkNW1ouBtyRatvHxfNEiBN5bwXoPHG225BHYUfoPj2uSc6IyP052HLCxx
j8AB5w3J7ombYBidnE/8WFnzSE77CJREPlpDvBXvfa2YAHO46G3JvNM+SzQIXkby
3FHojwSsyTonfSXOFW3M04M4TwpCxDfQMU/LZurmnLgPbTXJOQJeN4PE8fasgba0
5X9nIX9L1qBwul5O1eequaLG+sUtv+GF5fm6yCXXKLXN88DaL8tce5UKnTYjzQ4R
XDb5qyjx1VQ11q0SNU9k8Tr3bwkAI9bNbrbmtE/cgdmNycu5DWlwKhZbQJuZWKwy
ok6mkaChX24L9pk8N+OlfdBKGMb3QKZsX2Aq4CYpKrp45JfL1Q/SCPFazMKHniKg
+9d1liQCv5Zl83YxnP6R1nZovz5AJojUsUhRqsQ3hUWDoMKuSGT0DHPSeSbN5EVF
Lzgxp/PC3QzD6Kk+L2MSfoHxGsVD9YCTMGH+rKkcAgonMBDnjS3wpead37dk/GzO
Q1TlTVPvT72uSI2G76GQh/AdwmGC3oUQm+Ql/WaWgvpKOMMLG2DCVQS6WEuB8got
Z47oX2EXuOc8wOSUr0Q/y3NrUZtmFjk56Z3xQQweRXmzRaTtXrsJNgAhS6+qjLwH
lPTEFXU5k2/v7GChY4ib
=gnNs
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============1750922669298947766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1750922669298947766==--
