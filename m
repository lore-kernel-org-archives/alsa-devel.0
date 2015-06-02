From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/7] ASoC: wm8903: simplify gpiolib callbacks
Date: Tue, 2 Jun 2015 21:31:30 +0100
Message-ID: <20150602203130.GU14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-4-git-send-email-vz@mleia.com>
 <20150602194153.GH14071@sirena.org.uk>
 <556E0F8F.1050307@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gb4bweTRjl1pQhan"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556E0F8F.1050307@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--gb4bweTRjl1pQhan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 11:18:23PM +0300, Vladimir Zapolskiy wrote:
> On 02.06.2015 22:41, Mark Brown wrote:
> > On Tue, Jun 02, 2015 at 02:09:15AM +0300, Vladimir Zapolskiy wrote:

> >> @@ -1783,18 +1783,13 @@ static int wm8903_gpio_direction_in(struct gpi=
o_chip *chip, unsigned offset)
> >>  {
> >>  	struct wm8903_priv *wm8903 =3D gpio_to_wm8903(chip);
> >>  	unsigned int mask, val;
> >> -	int ret;
> >> =20
> >>  	mask =3D WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK;
> >>  	val =3D (WM8903_GPn_FN_GPIO_INPUT << WM8903_GPn_FN_SHIFT) |
> >>  		WM8903_GPn_DIR;
> >> =20
> >> -	ret =3D regmap_update_bits(wm8903->regmap,
> >> -				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> >> -	return 0;
> >> +	return regmap_update_bits(wm8903->regmap,
> >> +				  WM8903_GPIO_CONTROL_1 + offset, mask, val);
> >>  }
> >> =20
> >>  static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)

> > This appears to be an unrelated coding style change.

> this particular patch is named "simplify gpiolib callbacks".

> Do you prefer to separate the change here in .direction_in
> implementation from the rest?

It doesn't appear to make any changes related to boolean variables
(AFAICT it's just removing the ret variable) so it shouldn't be in a
change about boolean variables.

--gb4bweTRjl1pQhan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbhKhAAoJECTWi3JdVIfQFrkH/iYpMNEAi3oE+tmmDIZh3Zmy
f/k/LGDUsX2yKDhjWRAtVhNj8dTST3kTtAhLcJeXAPdZ2WuT4smtBS5Ewrh5Fsjq
lbBqCnfx6pd3Yx06Pnd0D02pR7BtzpuOaYDHM9OHeszPZc6QiwD48c4+qLHcXLQe
AsTHhe/p89FVJbsf1Eu08rlci/phPkrJNofcMRfb3rZHF2eml380gTk2RXXKH0a/
zxHmKE4W38MkZJZuoEPgwHhIUDUZqBXqEETD0pV4Efxtj+CigcLg7IwgFmhCUQnJ
aSztd0PWwdGVB8c94P1hFGcPDickEVQV3kmcpgE1gX0spRD/QXA0vqDDHlpT5UI=
=8cQr
-----END PGP SIGNATURE-----

--gb4bweTRjl1pQhan--
