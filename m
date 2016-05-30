From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/49] ASoC: simple-card: remove duplicate header
Date: Mon, 30 May 2016 17:00:02 +0100
Message-ID: <20160530160002.GP29837@sirena.org.uk>
References: <87lh35rs8w.wl%kuninori.morimoto.gx@renesas.com>
 <87k2iprs5w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k2iprs5w.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 09:38:39AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> simple-card.h includes soc.h, and soc.h includes soc-dai.h
> Let's remove these header.

It's not automatically good to remove headers, one common reason for
build breaks is that a file will rely on some header including another
header for an API it uses but then the header will change and the C file
will stop building.  It's better to directly include any headers that
are being used to avoid issues like this.

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTGOBAAoJECTWi3JdVIfQnLcH/3c9tpu/ShYo7edezP+wsukL
MUNttvYLAC03WKLR8Ye4K6Vs9b5pK6tXQ8KkgTy9sTk6tA7vIuq9b8e+oLZnT3KI
gVe7fK9VHmv8rCDY4nm1pZwtYUGzLps2MHEKwVUZF9R2i5ROFTDrN/DX9T063Jd5
IMGKD/P1Lg5hGwqXPNgWgjaA40vDyOqTVqqH/v+5eZ1TdR1XekoIciRw/Txq7v0N
DgurTx3RAyN5M4z2UmEyI079wdDd6PzxR3VpxOAJp9ZWnPRp7Mt34m+sR0plkouP
gyzh3+xiJaW0RoFJbV6zlcq7wwI/0ZwlolwzBqj0qJ94JIDFPJjTtQCk0kla6Uw=
=24AM
-----END PGP SIGNATURE-----

--9pS2hy4/DrI8BQlq--
