From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH 1/4] ASoC: wm8960: Let wm8960 driver
 configure its bit clock and frame clock
Date: Tue, 12 May 2015 20:05:52 +0100
Message-ID: <20150512190552.GV3066@sirena.org.uk>
References: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: tiwai@suse.de, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 02:58:08PM +0800, Zidan Wang wrote:
> wm8960 codec driver missing configure its bit clock and frame clock for codec
> master mode, so add support for it. It will calculate a appropriate frequency
> dividing ratio according to the system clock, bit clock and frame clock, then
> set the corresponding registers.

Applied all, thanks.

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUk8PAAoJECTWi3JdVIfQpm8H/0WHj3lzl/fqSgNAt928SSHm
WyIaUQG+eVUTFKHllvwsdjhyli6pKI2k/RdyY0grz/v7PyInhknhYP9f4qdC22Wq
bMN1Mb6cAb0dsvP0Rcm/jFTJg4aZ7LDbG7GIm5ywGXL3pIguENWRV3G27aMse8FU
rYitnUWfQQw+7KxIJGWTwGnhK3eIeUv5jmCarlKpcpfHojeHpWrEcMydSYPfu8KW
kA91HdskhNZ+3mgn4H/o+MYzydyxxbPvQvX9M+Wz1QGPqLNNBPy43/Qz8Zwnjk0R
ihXAfWp9/TjJOA5CDNQ5NScF73ZxQQELzPFljTW8gQMyz7/pX60leX7wv7ph/z0=
=6D6t
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
