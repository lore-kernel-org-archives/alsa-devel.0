From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Date: Wed, 8 May 2019 17:12:40 +0900
Message-ID: <20190508081240.GA14916@sirena.org.uk>
References: <1556534756-15630-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H6fQM4Loq/u8aogQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556534756-15630-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--H6fQM4Loq/u8aogQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 10:46:03AM +0000, S.j. Wang wrote:

> +	cs42xx8->gpio_reset =3D of_get_named_gpio(dev->of_node, "gpio-reset", 0=
);
> +	if (gpio_is_valid(cs42xx8->gpio_reset)) {
> +		ret =3D devm_gpio_request_one(dev, cs42xx8->gpio_reset,
> +				GPIOF_OUT_INIT_LOW, "cs42xx8 reset");

You should just be able to request the GPIO by name without going
through of_get_named_gpio() using devm_gpio_get().

> @@ -559,6 +577,7 @@ static int cs42xx8_runtime_resume(struct device *dev)
> =20
>  	regcache_cache_only(cs42xx8->regmap, false);
> =20
> +	regcache_mark_dirty(cs42xx8->regmap);
>  	ret =3D regcache_sync(cs42xx8->regmap);
>  	if (ret) {
>  		dev_err(dev, "failed to sync regmap: %d\n", ret);

This looks like an unrelated bugfix.

--H6fQM4Loq/u8aogQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSj3cACgkQJNaLcl1U
h9DXlAf+NZvbXIKXu1i3ZnsLWQy9duLtWvd5Tqm52AG4yzPuCM4MW7+jUxPLDQz/
TX/C3cXHNDXdERXQbOBIUli6xRFu/4Nom56dXbLPbWiA77RNwAC5LuX+BEJJc5xa
mEUtDpoXFU3/+V5y9iSYRTwWW0JVq06LI/lFfhC0DfB8aHVzBJAVzWGMMt4uh1fA
IZxiKXGNU53fqM9SMtb1FJ8t5lZHwqRK1Ra/2fe0yivHq3+m71ZQXkCfy5DYDlnX
m3iew6+A0bDr+z0cdJmA8jgIAGyy6Po/+iYIASerYPGH3kJoFMytubH+fB+uVieP
QZCtbRlG+JJtBuBBHjivJk2UQvyWlQ==
=nWb3
-----END PGP SIGNATURE-----

--H6fQM4Loq/u8aogQ--
