From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/11] ASoC: compress: Fix memory leak from
 snd_soc_new_compress
Date: Tue, 25 Jun 2019 13:01:41 +0100
Message-ID: <20190625120141.GQ5316@sirena.org.uk>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-4-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FpiZi7hT3UZZkRL4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617113644.25621-4-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--FpiZi7hT3UZZkRL4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:36:36PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> Change kzalloc to devm_kzalloc, so compr gets automatically freed when
> it's no longer needed.
>=20
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.in=
tel.com>
> ---
>  sound/soc/soc-compress.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

This will mean it'll get freed at some point if the driver for the
device it's allocated against gets removed but it will still get
allocated every time the card gets instntiated (eg, due to deferred
probe or due to some other driver getting probed and removed).

--FpiZi7hT3UZZkRL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0SDSQACgkQJNaLcl1U
h9CaAwf8DVsk20XPT9zYetddOVSYB+aF3yUzSct7IemG29IlKRZZc/cPOycQkP92
weS9wGPzizmWuHiwwDCOsP9SooYKsYyYIRXJOldfrt4/tjnfuNNsjpF21/moUeoj
rDjJ2RZVz5qwKTkRuNxclDfo0i44/SKK+Mr5hcNGYV1G7hYngza5x45WwsY3N20F
56cNs8ct+Yd25TbrskUE+reGVIoSGrNei8tDunr9BOegLB/FAUdbFYZ61doHesf4
O+X+iNhE+/GbGAzxMUm5jZ6yDR2VEz63Kx4jtJ+auG1d5bOReWXxc/8ezeucdGMd
G4ZL2CALbTKAHgvtZu29cZaZ81T4Ew==
=m/VR
-----END PGP SIGNATURE-----

--FpiZi7hT3UZZkRL4--
