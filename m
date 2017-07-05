From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/3] ASoC: sun4i-i2s: Get startup to call
	set_fmt
Date: Wed, 5 Jul 2017 18:02:58 +0200
Message-ID: <20170705160258.3lzrfmoi4kmbmzb5@flea>
References: <20170705154324.14565-1-codekipper@gmail.com>
 <20170705154324.14565-3-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8442160435417030468=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E55E26698E
 for <alsa-devel@alsa-project.org>; Wed,  5 Jul 2017 18:02:59 +0200 (CEST)
In-Reply-To: <20170705154324.14565-3-codekipper@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: codekipper@gmail.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, be17068@iperbole.bo.it, linux-sunxi@googlegroups.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8442160435417030468==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aux54oqjn7u3izik"
Content-Disposition: inline


--aux54oqjn7u3izik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 05:43:23PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> The set_fmt function pointer is called during probing and this is whilst
> the block is disabled. It is over writing the default register values with
> the same settings so isn't noticed.
> This wasn't a problem with the older SoCs but with the desire to reuse as
> much functionlity as possible for the newer devices then set_fmt needs to
> be called whilst the block is enabled.

The driver while the block is disabled will use the cache, and will
flush it when the block is enabled so it won't make any difference.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--aux54oqjn7u3izik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZXQ2yAAoJEBx+YmzsjxAgq8kP/j++BuqDxIdpY3lAK2uQtwvc
AB9zAqaeD36j8x9HDah91WRBP7h2F94O0gac3bLVOoRy9vuQvJCkFbudYQUveVQl
3sA6o2WFBP8rpnwOxwnRfJno50j339/LJLmL8gBS3AMC+DAfjMAQUXVdbLX2X69J
XgzMogF8I5BP9hh3VoU5QwBT6QdAF3MIwDXcgRecQw3rmdi+qCjEbbkqnNEAx4ks
szK0YTrDnVuyJmrzGSn4TARNYZopsqeLpGlomH3SEW7FzNua6hXN9vsRY5jtvhnv
7RW3xGtV4OofrM+8SLe1Rh/liOqZBqv20pYawZv7nCj3JPlD/FWrRVytZO7WdN6R
RUcnY2OPIMTAtEfc7Ivt3IM6xvYgxjWcy4Qnryy21XcIorQO1lW13ci66qbj1uZa
wun7mygfaG/ZhtWtflg3bcS9IVNGlPtUAZkzZXoDLakK0e56IjSGE1ENBwAUDyPx
zr+Z/omzsA9dzB0PRJ4kO12akBxutIMlroNhCHCdrqvf0eEy+3PxYahBMa/mRdbQ
j4W5f7MIhoqm/bzLqf0mrLFyxDqqGiHUTJvzWHQBYvw7nnEqlTsxUk9ew6JU4bQY
Gk4qwM4UPo7H8GPEqGm8kP8Dvws6e+tT82+LYxtOL2ioy1SH3yOscdc/ECGsRCT3
HyvunMlFTMT4cYADqAiH
=vqaU
-----END PGP SIGNATURE-----

--aux54oqjn7u3izik--

--===============8442160435417030468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8442160435417030468==--
