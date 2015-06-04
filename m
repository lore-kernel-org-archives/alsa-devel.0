From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: wm8903: generalize GPIO control register bits
Date: Thu, 4 Jun 2015 10:19:24 +0100
Message-ID: <20150604091924.GZ14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-3-git-send-email-vz@mleia.com>
 <CACRpkdaGf+oQA3OF5HnVGXh5exz2L8RSye1Fj=r-=wzsMay_ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fis3l7cGi4BLWycj"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaGf+oQA3OF5HnVGXh5exz2L8RSye1Fj=r-=wzsMay_ag@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Liam Girdwood <lgirdwood@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--fis3l7cGi4BLWycj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 10:30:10AM +0200, Linus Walleij wrote:

> > +#define WM8903_GPn_PU_MASK                      0x0004  /* GPn_PU */
> > +#define WM8903_GPn_PU_SHIFT                          2  /* GPn_PU */
> > +#define WM8903_GPn_PU_WIDTH                          1  /* GPn_PU */

> Pull-down/pull-up?

> That is pin control, not GPIO.

Those register definition defines are just an automatically generated
dump of the complete CODEC register map, the GPIO pins have some pin
control type functionality in there.

> I know I should probably be a bit relaxed on enforcing strict frameworks
> on ASoC and DRI/DRM alike, because the drivers are complex and sometimes
> need to be on top of things rather than split things apart and set up
> complex cobwebs of subsystem cross-dependencies, but I'd
> like to know a bit more about the design philisophy here.

> I guess this dates back to the time before the pin control subsystem?

There's that as well, but more generally I'm not sure if there's even
any use of those defines for the driver (without looking at the source
to check).

--fis3l7cGi4BLWycj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcBgbAAoJECTWi3JdVIfQwJMH/1SXyU1MR158DRZhxZw+6J/R
vio+BBOFiFOrSBLQNesA+oN9dgf8a6dJMvYmg067csP94AvmAIcgA7OSN3+mdhLG
5zRgO/V4JeAeKwrE+GdPYonvzsqbokht0MfUCe7g50ZUZsYMc6GRPg6VNIYvlBXz
MK7ZKIpwD0C19QhefrhO7SgKnnr4EeWUWXNGp8KcpLuUYnXxjjtvJmBXvldlYE+r
ETeWe1KLbmljZ4mQqC2TjwzUdAkLc2MOkmeMp0tSn+DHdst+dY/ec/BrWDHMR1g1
dLHoERLXA0RggABCO4sz9t6obBoVXKiKh4CtRoKkUjNzr7YQNa9g0yWr5nSpWgk=
=kYpM
-----END PGP SIGNATURE-----

--fis3l7cGi4BLWycj--
