From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ASoC: add driver for max9768 amplifier
Date: Wed, 18 Jan 2012 20:26:25 +0100
Message-ID: <20120118192625.GA13708@pengutronix.de>
References: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
	<4F17005C.9000507@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7100074259704120046=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id BE12C246BC
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 20:26:27 +0100 (CET)
In-Reply-To: <4F17005C.9000507@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7100074259704120046==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +struct max9768 {
> > +	struct i2c_client *client;
> > +	int mute_gpio;
> > +	int shdn_gpio;
>=20
> The shutdown gpio is requested, but never used.

It is initialized to HIGH, otherwise the chip won't do a thing. The pin can=
 be
later used for PM, but I don't need that now.

> > +	ret =3D snd_soc_cache_write(codec, reg, value);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data =3D (reg << 6) | value;
>=20
>=20
> Adding support for this register type to regmap and use regmap then is the
> way to go. regmap should also be used for the cache instead of the legacy
> ASoC cache.

Okay, are you already at it? Otherwise I'll try adding this tomorrow.

> > +	ret =3D snd_soc_add_controls(codec, max9768_volume,
> > +			ARRAY_SIZE(max9768_volume));
> > +	if (ret)
> > +		return ret;
>=20
> Use the controls/num_controls fields of your codec_driver to register the=
se
> controls.

OK.

> > +static struct snd_soc_codec_driver soc_codec_dev_max9768 =3D {
>=20
> max9768_codec_driver would be a better name.

OK.

> > +	return snd_soc_register_codec(&client->dev, &soc_codec_dev_max9768, N=
ULL, 0);
>=20
> GPIOs are not freed in case of an error.
>=20
> > +}
> > +
> > +static int __devexit max9768_i2c_remove(struct i2c_client *client)
> > +{
> > +	snd_soc_unregister_codec(&client->dev);
>=20
>=20
> GPIOs are never freed.

Eeeks, right, damn. Thanks!

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8XHOEACgkQD27XaX1/VRtvJQCfbCCZMDNht/Q1tgcVc/jX/JfE
xasAn1RlBIjZEjV2kAtmhVBvQNAqbDlF
=HTFr
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============7100074259704120046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7100074259704120046==--
