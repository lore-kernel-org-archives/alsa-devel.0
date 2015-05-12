From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: add sai master mode support
Date: Tue, 12 May 2015 19:44:26 +0100
Message-ID: <20150512184426.GQ3066@sirena.org.uk>
References: <cover.1431337606.git.zidan.wang@freescale.com>
 <1431339894-4248-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vIXBmblrD40XNCy4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431339894-4248-1-git-send-email-zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--vIXBmblrD40XNCy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 06:24:41PM +0800, Zidan Wang wrote:
> When sai works on master mode, set its bit clock and frame clock.
>=20
> SAI has 4 MCLK source, bus clock, MCLK1, MCLK2 and MCLK3. fsl_sai_set_bclk
> will select proper MCLK source, then calculate and set the bit clock divi=
der.

Applied, thanks.

--vIXBmblrD40XNCy4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkoJAAoJECTWi3JdVIfQSTsH/1ZgL0iXjDVdC1pXGJxbjvPC
Qokgb8JoHr/G9YXh/Ff0ai8dEMsmF7OEIosGJ3D9oNamJ6y1xYL2MyKesFJhyc7T
4+kOWw8JIX7IxDMcJ4E515EkqX+jCHXc05rZfqTu35iQ2icfydwLLuIm/62b0LbA
O22bE21U6V9DAzavVTVqncKdaJ4bNIozvjkQRjqHM/aUwHFWnIsk/zH8wKDvCp1a
7hlCajIIN/z0EkB0hjI7p16XBtfS+iFpb3FIs/eK7Ndsw8nhz/zdknwYS5d54YdC
mO3FZRvSIwhtSgzDl/FqC1oxWfigFW3VMdzz4DiGhFDJpQ3Fn5aExCzC9A2TgVw=
=Qg2i
-----END PGP SIGNATURE-----

--vIXBmblrD40XNCy4--
