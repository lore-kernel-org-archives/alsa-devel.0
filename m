From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: wm5100: remove bitwise operations involving
 GPIO level value
Date: Tue, 2 Jun 2015 20:45:58 +0100
Message-ID: <20150602194558.GI14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-5-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="icsXL8FABjDeMLkQ"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433200158-6890-5-git-send-email-vz@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--icsXL8FABjDeMLkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 02:09:16AM +0300, Vladimir Zapolskiy wrote:

> @@ -2244,26 +2244,27 @@ static inline struct wm5100_priv *gpio_to_wm5100(=
struct gpio_chip *chip)
>  static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset, int=
 value)
>  {
>  	struct wm5100_priv *wm5100 =3D gpio_to_wm5100(chip);
> +	unsigned int val =3D 0;
> +
> +	if (value)
> +		val =3D 0x1 << WM5100_GP1_LVL_SHIFT;

Write this as an if/else so the reader doesn't have to wonder why you've
missed the handling of the false case. =20

--icsXL8FABjDeMLkQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgf1AAoJECTWi3JdVIfQRPIH/iKrrEPcukoekmz8bTlJMPAn
NvQA4NDdu71/7yuC3nwqAd1bSDR/7eHIfyrq8d4OuDaN/TXGYhUySwC8Do3JPQRI
NkFYgya4nOWXzptmXMU/2c/YhY+aXq7vBe9u4FigpIAPM3h8sUrJ+g+SGN6nVpxh
fTTHd9Eerpc4bDu2zNCMGhuRozTMXKwVZd9kExByo6E4VmcbRejTnzKdhdgaReOY
AH+8vInuNL/KPxtoSjAO961LiNwJWnAmk9R8L6lNu560KlqsSvlofcnUqs+hNcCU
9OCU1lnRi8/RFBhDxlXkhqUFEfamirfj5TF5x40L9W3WD+tXca5LGklbObPspnE=
=s5IK
-----END PGP SIGNATURE-----

--icsXL8FABjDeMLkQ--
