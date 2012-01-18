From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ASoC: add driver for max9768 amplifier
Date: Wed, 18 Jan 2012 20:33:20 +0100
Message-ID: <20120118193320.GB13708@pengutronix.de>
References: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
	<20120118175305.GR8732@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7631022560560651065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 34B6D103891
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 20:33:22 +0100 (CET)
In-Reply-To: <20120118175305.GR8732@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7631022560560651065==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +static int max9768_write(struct snd_soc_codec *codec, unsigned int reg,
> > +		unsigned int value)
>=20
> Use regmap for register I/O please.

OK, currently negotiating this with Lars-Peter.

> > +	if (max9768->flags & MAX9768_FLAG_CLASSIC_PWM) {
> > +		ret =3D snd_soc_write(codec, MAX9768_CTRL, MAX9768_CTRL_PWM);
> > +		if (ret)
> > +			return ret;
> > +	}
>=20
> Some documentation on what this does would be nice.  Is this something
> that might usefully be changed at runtime?

It only depends on the hardware design. Will a pointer to the section of the
datasheet be enough for documentation?

> > +	ret =3D snd_soc_add_controls(codec, max9768_volume,
> > +			ARRAY_SIZE(max9768_volume));
> > +	if (ret)
> > +		return ret;
>=20
> Use the controls field in the driver.  I'd also expect to see some sort

Understood.

> of DAPM support, even if it's just mapping out the pins.  Since you're
> manually controlling the mute it'd be nice to make the unmute be (mute
> && power) to save on pops and clicks from the CODEC being amplified.

Sorry, not understood. Is there an example of what you mean here somewhere =
in
the tree?

> > +		err =3D gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768=
 Mute");
> > +		max9768->mute_gpio =3D err ?: pdata->mute_gpio;
>=20
> I really don't like the ternery operator at the best of times...

Can we agree to disagree? It is so convenient here and saves a few lines.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8XHoAACgkQD27XaX1/VRsItQCbBCxOG+ZXrZ8tWEMF6jaZhaEF
WYMAn2PWy7L/EMi7Cb0mI336slUnmaH8
=eCKA
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

--===============7631022560560651065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7631022560560651065==--
