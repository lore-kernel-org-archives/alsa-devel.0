From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support
 for loopback
Date: Tue, 13 Mar 2018 15:03:03 +0100
Message-ID: <20180313140303.wkwsxhhm5lxbzp5a@flea>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-7-codekipper@gmail.com>
 <20180312183521.GP2186@sirena.org.uk>
 <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2x7byyr6nyfj2hcd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Obbard <chris@64studio.com>
Cc: broonie@sirena.org.uk, Code Kipper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it
List-Id: alsa-devel@alsa-project.org


--2x7byyr6nyfj2hcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 01:39:44PM +0000, Chris Obbard wrote:
> >> +- loopback:  if this property is present then the dai is configured in
> >> +             loopback mode where the output fifo is redirected to the=
 input
> >> +             fifo.
> >
> > This really doesn't seem like something that ought to go into the DT
> > and hence ABI given that there's obviously no reason to use this in
> > production.  Just make it be a #define in the code or something.
>=20
> It would be nice to have this as an optional devicetree property so
> when testing JACK latency etc I don't have to manually re-compile a
> kernel...

Another one might also argue that having to recompile the DT and
reflash the whole firmware or EEPROM is overkill for just testing JACK
latency.

Can't we create a module parameter for it?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2x7byyr6nyfj2hcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqn2hYACgkQ0rTAlCFN
r3S1DRAAjhIduewFI9H4p3wDEAaXqYFAOsodCtcThLZpIZOuUHufQ2XPvhH/4LjH
e9jyynK2jmzXK/THayoEr2WkG9TsIU5pgt7tGUcTjYqC4JR4XlkeNAS7Th8XFP/Q
+mFOjIefCpEyj1acT1HWjFyuoTKK3CacYWaHbn2wr5ovqwr1p3hG9zX8KgxxGe2k
yQ6WSKDu1EfdPYeP/N2JNdfWYAPS6HC6I8LRJ2e1g0cA3t7LUbR/rd8ynTiWh2Rb
yJiS6EDgRqGBCsPr5PPz579HZRQ8JUsL6h3FWv2ZTd9QGtkynvXwY3YnfIXzk4se
qUPsT0jwg5BBEsjB6DPMrOl/hPW1TL7oaN1zn7VTsgjW1xyYEQXYanQRaZawb4Rl
yepNYVLlhDiXBTxMW4KMUM6NHCfQ5Za/HqSUNB3Chma+rODTUBPzm/MFF9wqucdc
7b/tmGsEFSxP6IXuUbQ+iCzUfSeM6TYrzYir+LnKZIFV/FB7iwiqcpwU+iIE9zWP
n4fSbHXOqeHFnSTJbWd/iuYiJmi0C2TmmjUJxV5iGrt6aTL1jx/D3X2ZUeZk/hQq
w+cSg56449LXrJ3xV5O2kDAMU4ZtTqc6SoHwVLM4lF82YazaNYC8yzKl9piQoakq
CS41wsLktRvvbatVsbx2LpyYRLvQK9ZVQBZdf9lmsQqZ1WiOhpw=
=b85g
-----END PGP SIGNATURE-----

--2x7byyr6nyfj2hcd--
