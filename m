From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add a sanity check before using dai driver name
Date: Wed, 23 Aug 2017 12:06:28 +0100
Message-ID: <20170823110628.xergjdexrmxyqrza@sirena.org.uk>
References: <20170822144512.12976-1-jeffy.chen@rock-chips.com>
 <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk>
 <599CC17F.90806@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yyiw6y75zp5h6myn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <599CC17F.90806@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeffy <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, dolinux.peng@gmail.com, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--yyiw6y75zp5h6myn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 07:42:55AM +0800, jeffy wrote:

> i think the original check is allowing NULL dlc dai_name to be a match...
> so we basically did:
> reject when dlc dai_name is valid, but not match the dai name

So it is, but this still looks like the wrong thing - it'll match on an
empty DAI name over an explicit match on the driver name which seems
like it's the wrong way round.

>=20
> and my patch is:
> accept when dlc dai_name is invalid
> accept when match dai name
> accept when match dai driver name(only when it is valid)
>=20
> so it's a "if (a && b) reject" to "if (!a || !b) accept" case..
>=20
> >=20
> > > +			if (dai->driver->name &&
> > > +			    !strcmp(dai->driver->name, dlc->dai_name))
> >=20
>=20
>=20

--yyiw6y75zp5h6myn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmdYbMACgkQJNaLcl1U
h9D2yQgAg+HQNTRpKe2q39tnugk9vrNn9zEwfVbzLRQGO6CCewH3Lh4PasHUYdP0
YeY9WxeyKTItg7hqOc9RF0ASU6iThlLIWPHC3r9cVtksmO8etKqvwJV+DCOYdyiY
D/W1f3ZU2dk2ZtGXMFQAUr4cq78qbY3HOHXk7BdM3TabV6FqUknF9Te8EosXtowf
xPd9wBlXTPkCg76j5Tdh/PR8PrGXGtPzglmjm86M5XHihVibTV9zOzgROYfNhWv0
LrwOaDUD6pcWB8lVSxnyyZ4pXj95e9jCdryDXGjIKe+/wBtfcyoVyHhwpW/XQWVB
Eiobw7S9GvT9j8nSeVqT8j+b6UiX8A==
=OMoU
-----END PGP SIGNATURE-----

--yyiw6y75zp5h6myn--
