From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [patch] ASoC: sun4i-i2s: remove some dead code
Date: Wed, 8 Feb 2017 09:58:41 +0100
Message-ID: <20170208085841.rilib45uhwgu24j4@lukather>
References: <20170207131934.GD28207@mwanda>
 <20170207134215.f47cufvs7tngrabk@lukather>
 <20170207135008.GL11103@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6pzwnqrcusgh623"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170207135008.GL11103@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--a6pzwnqrcusgh623
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:50:08PM +0300, Dan Carpenter wrote:
> On Tue, Feb 07, 2017 at 02:42:15PM +0100, Maxime Ripard wrote:
> > > -	if (!IS_ERR(i2s->rst)) {
> > > -		ret =3D reset_control_deassert(i2s->rst);
> > > -		if (ret) {
> > > -			dev_err(&pdev->dev,
> > > -				"Failed to deassert the reset control\n");
> > > -			return -EINVAL;
> > > -		}
> > > +	ret =3D reset_control_deassert(i2s->rst);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev,
> > > +			"Failed to deassert the reset control\n");
> > > +		return -EINVAL;
> >=20
> > In the case where has_reset is false, rst is NULL and will trigger a
> > WARN_ON in reset_control_deassert.
> >=20
>=20
> No it won't.  reset_control_deassert(NULL) just returns success
> immediately.

Not in current Linus' tree at least:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driver=
s/reset/core.c#n217

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--a6pzwnqrcusgh623
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmt29AAoJEBx+YmzsjxAgXewP/2KmuF9oNCy1ehalSGbHLdBE
qPvbd+Vfjl0bGgrZFjZhFZ8u1M82Lit83T1Ib2a9oM+iNy0ebb1WkR0KGgEmNV9U
h49n6gK85b4CEXW1m3FJF7VuqvIe0RpU/JKSX1iMs6yw5DyYjbDkz50l/YLC+h/F
tShMPu+DrRj5RprjV8xkgwA1aHb9anZH3hGfxuxfBFnJiMvrzV8nJgAgxubjtEDv
TouiAkpQZP/clHJke+vLhLQoJy94CNbXIFDqHb1Aa5VUhQz6MvNTnB/mIuo4HRUA
fFpgI8DlYsesBuUuxaRkEYvCfQp7VGNeycj5wDL9RODFNDZvYP2eeLm8Ylf26eBA
sjFeyiqpvQo4vSizU2K5shLfr8sD1/RRnDMcaJVpDgimdx4SCBRrmobZTG9IUU1B
U+0eD/0YE0T30g2bm059Hhw1MDqpTue5nfTeGI1Dhpj6pY3O8m0hH13eJnRWz88p
6flKWP6Z7LqI6TCrMV4BjdcTugNfYyh0+/rpHY/K+2uz3z4oJc/Zxg9vZtxFP5d6
/tx5UNnb+rvM9xs4IGDIYRe/9fOzGKsLw8yz8VGu3rD+rkRudyZwAmdF0oajzmT/
GoMfZm/K/K7xlpn3xyr8drs0BFyDJKhCwRA1+PaE9RivQBhd0qSY7a+G8g1sCX/H
g35gdmeXXjGohOEG8pDG
=kmLJ
-----END PGP SIGNATURE-----

--a6pzwnqrcusgh623--
