From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] ASoC: rt5677: clean up gpiolib callbacks
Date: Tue, 2 Jun 2015 20:38:18 +0100
Message-ID: <20150602193818.GG14071@sirena.org.uk>
References: <1433200158-6890-2-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hNweOTLwwbnii4NA"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433200158-6890-2-git-send-email-vz@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org


--hNweOTLwwbnii4NA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 02:09:13AM +0300, Vladimir Zapolskiy wrote:

> +		if (value)
> +			val = RT5677_GPIO_OUT_HI(offset);

It seems like a greater variation in variable names might be called for
here.

>  		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
> -			0x1 << (offset * 3 + 1), !!value << (offset * 3 + 1));
> +				   RT5677_GPIO_OUT_MASK(offset), val);

Besides, isn't the minimal change here just to remove the !! (or do
nothing)?  C defines a mapping between boolean and integer values.

--hNweOTLwwbnii4NA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgYpAAoJECTWi3JdVIfQtiwH/0DUGHn1jhStZSh/9Ppfm3hJ
vOaQ6AtLLg6obEzU5Ay+vueBXEaXR/dindckYezVWIdpTX/Gqd0l4o9q5Ubp6CUi
JYmVR1sfTP3PjZk048cqbnetwgyGYQTZ1k+tV1xvSE09Zm26wtXNbg+PPCwRzM2I
sJ9DfOyxmlPs0UgcLWyy9eQymywHFu2Y+b8H0yekIKKOB/QciCiXcw/o/P+2kndY
Whkndu3dk40dv9jL9gWWgkv601GFC938OjHpJtm3JhCyj2Tf3TT3O/3v/X4g6cRa
1krqjwlq/AadA9wx27u/6ilmfUXGQNdqQnbSY0T2E7rWkecWs+62HolR9A9XGjA=
=T4hH
-----END PGP SIGNATURE-----

--hNweOTLwwbnii4NA--
