From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] ASoC: wm8903: simplify gpiolib callbacks
Date: Tue, 2 Jun 2015 20:41:53 +0100
Message-ID: <20150602194153.GH14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-4-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yJLks8MEB0SlUFSu"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433200158-6890-4-git-send-email-vz@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--yJLks8MEB0SlUFSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 02:09:15AM +0300, Vladimir Zapolskiy wrote:

> @@ -1783,18 +1783,13 @@ static int wm8903_gpio_direction_in(struct gpio_c=
hip *chip, unsigned offset)
>  {
>  	struct wm8903_priv *wm8903 =3D gpio_to_wm8903(chip);
>  	unsigned int mask, val;
> -	int ret;
> =20
>  	mask =3D WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK;
>  	val =3D (WM8903_GPn_FN_GPIO_INPUT << WM8903_GPn_FN_SHIFT) |
>  		WM8903_GPn_DIR;
> =20
> -	ret =3D regmap_update_bits(wm8903->regmap,
> -				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return regmap_update_bits(wm8903->regmap,
> +				  WM8903_GPIO_CONTROL_1 + offset, mask, val);
>  }
> =20
>  static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)

This appears to be an unrelated coding style change.

--yJLks8MEB0SlUFSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgcAAAoJECTWi3JdVIfQcScIAIV37uo+gW2QpXJrHJRqF8E1
M2FOrN06RpVNxRnDFfHuyZ6oxT9Jx3nMiYSk/LiZAMGN7oytWbije87+KCufi3VF
IL5NXzxOiL+qv5IYEkMAWEvdDrz7+WZ09CsP2oMMC/pQsEuDBY69UbOjhip3KHp1
r6e/7Iydi5GDjNGjwvKTYKH+OzOFMNbMOUoQPQjIVww5d0RY6zZpQ+eHLcnuPh/H
jpcSDimA2hMfgEHBJeXLL2ggpM2lz6Oub44MigyWEVPwiJv9E6laW7MJSJN8NOAh
PfLJlXtOxkNtHFtRSYpB4E9smyDr5xOWDeP4tf4uWU9yd9itSKGMsOsb7qKEdEk=
=V2Kk
-----END PGP SIGNATURE-----

--yJLks8MEB0SlUFSu--
