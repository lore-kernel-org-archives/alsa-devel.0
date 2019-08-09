From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] fix odd_ptr_err.cocci warnings
Date: Fri, 9 Aug 2019 13:31:12 +0100
Message-ID: <20190809123112.GC3963@sirena.co.uk>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908091229140.2946@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, kbuild-all@01.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:

> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/w=
ip
> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machin=
e driver wip
> :::::: branch date: 20 hours ago
> :::::: commit date: 20 hours ago
>=20
>  j721e-evm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/sound/soc/ti/j721e-evm.c
> +++ b/sound/soc/ti/j721e-evm.c
> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf

This file isn't upstream, it's only in the TI BSP.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NZ48ACgkQJNaLcl1U
h9CcMQf+Km4bvdFc5fXpozUNHkhmiDGf5UtThFctMq6C6MK4tB+cTSjQqpLPip75
hihD/NMWNNvcxkJxNaK5pDv4yEWI+F9DLhjLePmCOdUjg68CwYF2e5tLEKs7LAzo
muAywApdJXbOOd+1yGG5lKw0EEoidrU5n9rzBYSbSjKwbtFhf4C1rQ8GO7T15S7U
+0sq47MSOf3Q5fji1RcvGy98RkZbzU9gcheLcTXcQfRZ+eapGu11PmHR+OqgO/GG
owL2DpqbypT+9iLdfmR9AOxwi3ykOWtU93h8uMh1tmDxfT4Auuj5j8leIEVdoCHP
KKhhYS2X70ImKlg4SeUrEJQTcWVntw==
=ykm0
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
