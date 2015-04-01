From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel-pcm-pdc: merge atmel-pcm back in
Date: Wed, 1 Apr 2015 21:24:48 +0100
Message-ID: <20150401202448.GB6023@sirena.org.uk>
References: <1427738094-6348-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427738094-6348-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Bo Shen <voice.shen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 07:54:54PM +0200, Alexandre Belloni wrote:
> atmel-pcm.c was split into two files to create a generic framework for bo=
th PDC
> and DMA.
>=20
> atmel-pcm-dma.c is using the generic dmaengine framework since 95e0e07e71=
0e
> (ASoC: atmel-pcm: use generic dmaengine framework).

Applied, thanks.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFQPAAoJECTWi3JdVIfQiVgH/3ALlgi0IH0DDf6fq/O04EAP
nTG3kfK9j25bRDu6rtMuB3kPdZINYeeuPmgSA1xBM2yC2csixt8UpTGYe4Jk1HJu
crzNb5lWmk37zkUaqwEPuTUJYHir/w0JCGfK55zBE/YMJOF6vKvDwkEw2BOb9ZUw
I4uOcnOdAoqfnajSCQR5aMxWzpFdKf6JGENdZ0RMzBaMj8qbrC5fq6EXZS5JZ9E8
6h0Yagqcj5IyFYZojAaLZZ7iEE7Vc7Llbbmf4DO8g0th6qnIC+9yAXguE9HmRyMl
kmQyMfFBGuhNE32MoLkHZAa6sKLpcfOT5dBaBWcSrNAiB94aFru2vKgPDIGLDHs=
=QHSU
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
