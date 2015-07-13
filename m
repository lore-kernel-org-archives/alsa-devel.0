From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH - CS4349 1/2] Add support for Cirrus Logic
	CS4349
Date: Mon, 13 Jul 2015 21:18:22 +0100
Message-ID: <20150713201822.GL11162@sirena.org.uk>
References: <55a41abd.6267320a.46fe.1037@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5285337088926270341=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9BF2625ED
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 22:18:30 +0200 (CEST)
In-Reply-To: <55a41abd.6267320a.46fe.1037@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timothyc.howe@gmail.com
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============5285337088926270341==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+yydNiOxrtWvz4sx"
Content-Disposition: inline


--+yydNiOxrtWvz4sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 03:08:25PM -0500, timothyc.howe@gmail.com wrote:
> From: Tim Howe <tim.howe@cirrus.com>
>=20
> Signed-off-by: Tim Howe <tim.howe@cirrus.com>

This looks mostly good.  One nit on the submission format - please use
subject lines matching the style for the subsystem, "ASoC: cs4349: ..."
with just [PATCH 1/2] as the prefix in sending.  Also some fairly minor
issues below:

> +	if (pdata) {
> +		cs4349->pdata =3D *pdata;
> +	} else {
> +		pdata =3D devm_kzalloc(&client->dev,
> +				     sizeof(struct cs4349_platform_data),
> +				     GFP_KERNEL);
> +		if (!pdata) {
> +			dev_err(&client->dev,
> +				"could not allocate pdata\n");
> +			return -ENOMEM;
> +		}
> +		cs4349->pdata =3D *pdata;
> +	}

Why allocate the platform data if none is supplied only to copy the zero
initialized data into the driver data then never reference it again?
The entire else case can be dropped.

> +	dev_info(&client->dev,
> +		 "Cirrus Logic CS4349\n");

Remove this, it's not adding anything.

> +static int cs4349_runtime_suspend(struct device *dev)
> +{
> +	struct cs4349_private *cs4349 =3D dev_get_drvdata(dev);
> +	struct snd_soc_pcm_runtime *rtd =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Hold down reset */
> +	if (cs4349->reset_gpio)
> +		gpiod_set_value_cansleep(cs4349->reset_gpio, 0);
> +
> +	ret =3D snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 1);
> +	if (ret < 0)
> +		return ret;

Shouldn't the device be put into reset after powering it down rather
than before?  I'd expect there might be problems with the I2C I/O if the
device is held in reset...

> +static int cs4349_runtime_resume(struct device *dev)
> +{

> +	regcache_cache_only(cs4349->regmap, false);

I'd expect the device to be marked cache only on suspend?

> +static const struct of_device_id cs4349_of_match[] =3D {
> +	{ .compatible =3D "cirrus,cs4349", },
> +	{},
> +};

This is adding a compatible string but the binding is undocumented, all
new bindings must be documented.

--+yydNiOxrtWvz4sx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpB0NAAoJECTWi3JdVIfQXwcH/RHBOOm7U/8N2uEcyfTCsBg7
+v9cQHbtgVaXNV5S5Qzku0ZWAKqBKhalGYZ62VCBm5RUkuK9hhPyFP33NVHETM/m
y9Tf572HTcx3qNj21p1KuDFYHraBDGQkP6+hPAjUzem27y5dGePGvMvhNp3Ydx+1
PIXetl8V0gi0rpdQsfMrglZt6qKQamqdbE2I+gt7XFpMOgLcmoWf9xQSuUjHj4iL
T8n5GzuR4dYDsP7yrfw7YGFslTG2kYM89X2G7kuctmg64bD7QT+uCAZE3R/0EQvb
3gY4pRnvXDEC820pcfy+BxGyx9NwXGFmP8f8fursCQBz648Y2j95Gq8CvsAMv3A=
=q+Lp
-----END PGP SIGNATURE-----

--+yydNiOxrtWvz4sx--

--===============5285337088926270341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5285337088926270341==--
