From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090 - Expose HP out enable.
Date: Tue, 1 Aug 2017 14:25:10 +0100
Message-ID: <20170801132510.qqet67hab5fjcf2f@sirena.org.uk>
References: <20170724090525.12710-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tzgy4bbp4y346g3u"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724090525.12710-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org


--tzgy4bbp4y346g3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 11:05:25AM +0200, Enric Balletbo i Serra wrote:
> From: Hsin-Yu Chao <hychao@chromium.org>
>=20
> Expose the headphone output enables to user space.  This will allow
> userspace to ensure that there is stable output before the headphones
> are turned on, avoiding a pop on insertion.

If the user needs to force the headphones on for some reason they should
be using the existing DAPM mechanisms to do it, either just playing
audio continuously or having the machine driver force enable things.

--tzgy4bbp4y346g3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAgTUACgkQJNaLcl1U
h9AcsAf/UEfQHWCyn7yKK95PaSIIoSEa6LLFa+hGbPYgh9kr3Qrx2tzZA1xDd0JT
o6G0BcpQDFH1KHtoYGHdurkSeNnRxfXrCnSF8hexV6zR0pDFlR4O3KlfTaFAKcRx
lsjHPnhJtBRmKWZTqQO2fegY9DkZwyCSK993L6QFE5oCacRHwnSqngTqWKOp9WnT
Dxsc5c1OQynRLTH0mbbRRq6WGmPVuKN/T321s4AVevRz9ngEzEzlwpyd5+cJyuCt
Tk4/Op/bg+WLRvS7RvtoznYr1ZVtp0ofWQgZ1RWeqQP6CtjaM/6mv+pa+xAOSbGa
IBZsyrTu5s1kIzmrXVIlZscQHa5hcQ==
=IHXN
-----END PGP SIGNATURE-----

--tzgy4bbp4y346g3u--
