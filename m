From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel: fix build failure
Date: Mon, 6 Jun 2016 11:17:47 +0100
Message-ID: <20160606101747.GA7510@sirena.org.uk>
References: <1465149621-4493-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465149621-4493-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 05, 2016 at 07:00:21PM +0100, Sudip Mukherjee wrote:
> m32r allmodconfig build is failing with the error:
> ERROR: "bad_dma_ops" [sound/soc/atmel/snd-soc-atmel-pcm-pdc.ko] undefined!
>=20
> The code is using DMA but the related dependency is not mentioned in the
> Kconfig.

Rather than going through every single driver using DMA adding the
dependency might it not be simpler to provide at least a stub DMA
implementation for the architectures that don't have it?

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVU3JAAoJECTWi3JdVIfQPNwH/0lrhfXM0P6a6gG0B8RK/tlf
5XeS8yhLIhEytnmC4sY9pAHr8ZMa7365V4emZHaq767F7sHcI0bwbNffpb5EGJjC
QR6qsvVjRmwHtvZ9nQHK08uHOCyODqe/1CCNPQLEBzrdT3dRiWeV+V3aS++iQbo2
Hkbcmv38rI95lRGbqbaBaVFW1/CwwJb62zSFk2auEd2UJkFscs1NxWByzpSddKFe
RpkaibSNdvd8szab+CR+U+k7VISHzmdVJV9UO4I6CFwQJuhZH3XGAMUf4LBof421
GeoVjYRHbA0UrdMK693DtafJyVa00HvBI05DjuPnp+btkr69kMHU5oiuB+rQKKQ=
=9ugO
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
