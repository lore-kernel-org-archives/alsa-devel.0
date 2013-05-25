From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: ux500: Drop pinctrl sleep support
Date: Sat, 25 May 2013 15:59:13 -0400
Message-ID: <20130525195913.GA32043@sirena.org.uk>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
 <1369391960-27320-2-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369391960-27320-2-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2013 at 12:39:15PM +0200, Fabio Baltieri wrote:
> Drop pinctrl default/sleep state switching code, as it was breaking the
> capture interface by putting the I2S pins in hi-z mode regardless of its
> usage status, and not giving any real benefit.

Applied all, thanks, but please do look into fixing the other issues
with these functions.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRoRgOAAoJELSic+t+oim9AawP/i6ocmv9a6sK7lg3FjHG+JoK
nUuQS1jXOt/DNTdSsBGXkcDecXOrNtJJhNPWI7L79/9129EPi6aRsKmL/wnWyZh6
ILDRoyHTx4QKP8RPM1iqa+pnjES0qvuSN2014jtRHkA5dWsO0lYTdLg3oJ3P0ifb
bAZXTlE1DXGLFT4ZKrniMZlhdc//1s1U6waAzBbQyaau3NY7Ja6IJIORzWnIedb8
2s0nP0pgFbf4frZ6crgDsXY6VIrqrFO+Uk62VBvFHWRb6aHIsxI1kFLF4J8rYslR
xWdBAenCXpl79t4yxGkZHwLfykiRGauzRwFa+luyL5c6WzVJBLp0+Hnu8xM7TwHN
33/P2c8rly+qUigTt4NZ4a1fslmUZN2Z+T8LLoVh3PVaNn9+ensdWfJIAHFK5JVR
w/9ATAO9+lAPeH9A/PQgONBS1Emk9LLqHhJJNRK/x5nLXq/2voSwnS+Os/uzo6RI
zsY0hznUoxRJt9ITvJJtmcIZFbEDq8fvYMbnZ3T2Pu6RZRBBBobk2PQwMpMYziqc
iaKmtvMATUiD0otU5S/KuDJq9oN4xxRC0IUoD3cIvz+G3dNpv+Lprxiu9c9bXc/f
1e2Hjps2LH2C1STwStIRDYQUuDMGrL03d8I7v130C9EYuDGBiTnwVm+0edFfPr0e
Dj7Lm0wLLYGExCfLnCn7
=mFBs
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
