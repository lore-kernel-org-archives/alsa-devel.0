From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] ASoC: sun4i-codec: Rework and fix headphone routing
Date: Mon, 5 Oct 2015 12:25:50 +0200
Message-ID: <20151005102550.GI2696@lukather>
References: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
 <20151005094435.GI12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151005094435.GI12635@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Emilio Lopez <emilio@elopez.com.ar>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, Oct 05, 2015 at 10:44:35AM +0100, Mark Brown wrote:
> On Sun, Oct 04, 2015 at 03:38:16PM +0200, Maxime Ripard wrote:
>=20
> > Most of the boards have their headphone jack directly connected to the
> > matching pins of the SoCs. Since most of the time we will have the same
> > routing path, it makes sense to put that in the driver, and only have a
> > property describing whether that route is enabled or not.
>=20
> What is the value in having just a dumb jack with no detection
> configured?  It doesn't actually do anything...

Well, it's how it's wired on most boards. The jack is directly
connected to the SoC, without any detection mechanism, not even a
GPIO, so we can only assume it's always there if we want it to work
properly.

> > It also fixes the following warning messages that were seen so far:
> > sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> > sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct =
-> Headphone Jack
> > sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> > sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct=
 -> Headphone Jack
>=20
> Why are these routes being added separately to adding the jack?  Just
> remove the broken routes.

I'm not sure I understand here. The former DT bindings example was
adding this route, which was broken because of the missing output
widget for the headphone jack.

My patch here adds both if the DT says that the headphone jack is
actually used on that board, so it should fix both issues: no broken
route, and no missing widgets. right?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWElAuAAoJEBx+YmzsjxAgzMUP/3mUnto4PEDHu0V5k5+S8v9w
EBsueMc2TdKlRUvHv+49fhw7Run9HnVuWsGZHdR5DzpZNEk7hx7Itd3Tj/QvRQaQ
LryCZ9EB3IiAPtVBdkA6WoQZEKyeBNTo4kgDE+JBd0BjQvoasBSYzAzPQcplOlMF
j6NmSUy7ZjmCkUwUj1VSTRfbyPNklZKwoJzjC84RzPaahbuiUJ/VVvbj+ap8aGhO
UdqVWCK1WafTH12dpymn28ZQLSl8EKV5cM0nAkejQOpicn0NZ9W54slfFR6fvX53
gb/DPVdcZxj6MXJoBLXV7AQWTw0QsZRiY5L7CuQMcG2jEVCrJR1MDRZeNQXc9W8d
aa6aABGpuz2GZZWyoEs2Rg3vAdwcQu0Kpb550xS5+1rZ+X4jUqM+XJR6k0+HYRaL
AtSg21X0j40B/KxVS+vUuMsvTdHeabHUoUd8BIYFJj7Ha2+OUU3zaA0ST6Gok3tv
rStUenvOZD7+S8vCb+VZ6tVHnpu0hrNNGKZ1g7QS5vxyquRSL5JxOCm0av1gGexl
r7xmnPTICtnhJsW3sZmNZBwICaFONBQp4AFijXvvu+zk/7xtrj6phrWEAFhJ9Roj
Msp5GOgfpVQV06NoRcHgHpEMkMDavr6ZZeDSKzYD6Vl+EOToHkaqTIAXElEbQKaC
x4B8t+ZDIoFtzb/c4vVT
=dYFk
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
