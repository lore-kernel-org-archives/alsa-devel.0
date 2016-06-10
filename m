From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
Date: Fri, 10 Jun 2016 09:36:43 +0200
Message-ID: <20160610073643.GK5242@lukather>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <20160602102651.GF2282@sirena.org.uk>
 <20160609210515.GI5242@lukather>
 <20160610003755.GC7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/jkxxxtAhYIHVDuh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160610003755.GC7510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrea Venturi <ennesimamail.av-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gianfranco-25KmuZRQ+wx0ubjbjo6WXg@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--/jkxxxtAhYIHVDuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Jun 10, 2016 at 01:37:55AM +0100, Mark Brown wrote:
> > > > +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> > > > +{
> > > > +	struct sun4i_i2s *i2s =3D snd_soc_dai_get_drvdata(dai);
>=20
> > > > +	/* Enable the whole hardware block */
> > > > +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > > +		     SUN4I_I2S_CTRL_GL_EN);
>=20
> > > Runtime PM?  It also seems like this is something that ought to be
> > > covered in the suspend and resume callbacks.
>=20
> > runtime_pm is supported, and uses the regmap cache to keep those
> > changes.
>=20
> No, my point is that I'd expect to see the block powered off on suspend.

It is. The bus clock is disabled, which also puts the IP in reset.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--/jkxxxtAhYIHVDuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWm4LAAoJEBx+YmzsjxAgvIwP/A8O8UV4qXeBuFLrSdmJsFYN
sqoFcjUVTPpR1Cm2wCa6/pHitavmK3t+OOSuRMaKzDhpZLcf8NqJWU6Mx7ueyzNc
ev2FOkYJDUGWt2hqv7nsVxQLXVh2p+2h+YJ4iGj7JN90/vZVxP4qG8dp/dkTOsSN
U5sYhTJYH4QwuIrdXoEIffQDS0Koex6SnvdBVyKrJjfydLLTZ8u/+ufKUozDB2hH
9UvxpocTeyCqpoc4t6XX3+tifzqhHnAwu/apvBCKssKZELN/jI6XS0qOBh/ivQqj
9QYlfmZbDZaw6LQTJFVYS/oYiUPrqWsLwE763Zn1Imr2/zyksdrltt7bX2ryTuDy
3LvBChUYdP/5kA4T/hPbbKncHzGO199n4iZRZ52dyOAhKLaD6Kn1bgVW8awyMvIc
Wra/eH4Xo+EfZATZdcZ99wPYx0SLaLJOSOozgvcL94lBr4xqFzNrCBJnhGcbM7pG
tdrBfM0Th6YfynXi0SRvyAUNTToXsb/CvFmxeL0SEHSu2MD6Dgu6YNb75Nei8dM6
tHrB7EJi3sPMYC+nDyRlJQ8YCeeEcEOHGxc303hjXhASFmLhapzxyhxqEWG1sWoB
UZV/XkePIaVYLOt4fANgQNJr2qMC69UcANhv5rxuPHplarG0boV/AFyJKOoUiUxD
L8wPhaMJpse7daqKp4vb
=3P9E
-----END PGP SIGNATURE-----

--/jkxxxtAhYIHVDuh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
