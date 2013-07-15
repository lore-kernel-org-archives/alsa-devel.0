From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/2] ASoC: dmaengine-pcm: Add support for querying DMA
 capabilities
Date: Mon, 15 Jul 2013 18:26:43 +0100
Message-ID: <20130715172643.GZ11538@sirena.org.uk>
References: <1373906531-6938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L4xCDQ7GT+ph8Lmk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373906531-6938-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--L4xCDQ7GT+ph8Lmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2013 at 06:42:10PM +0200, Lars-Peter Clausen wrote:

> +	hw.period_bytes_min = 16;
> +	hw.period_bytes_max = dma_caps.max_sg_len;

We can't read the minimum period size from dmaengine? Seems like
something might have a restriction other than 16 bytes here.

--L4xCDQ7GT+ph8Lmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5DDQAAoJELSic+t+oim98J0P/jfbAkSfH0v3cADhreQ1fGsY
gVrWblwtEBtaP1GNZ4hv/c0IDw/lm0vuEcfwG0wDO7S/0v362YxfxSYhYvJ+voX9
ukvfd/23JkcH/FwlC0KSshYV6CkjU0DDN11P0A6NrXzXbml/gzMo2g6/lYlfE2LD
71Z+BfuWXzZN7x0QVNx1ad4jH1qkbtcLUTB3l7VAa1giYicSqM3mxRxCs2AK2w4H
bwDoBp7re0Tj2AdHGw8orJrowRZD4BwYCHVX+oUtF4Jat1lFdSTahLNdMwuxU1sW
tIYyfSFLjUrl5e+kacPzY2X2uP65ZawPlIhMR1B2yUfVvAUpWCDmvmY/tRA/Ul2f
h2UHSPIrJm7vEuMs1vqOgIOJyAEaYoHdOrOk2o8z+sXSnthk131xtd+mNTrz95Z5
2J56xD9G+st+2PiDWQUOTwSvDvaYQPDnVL0zErRo7g+x8swjZqu/o2DKzukLP3Sd
wC9tJ6CjPL1vuA7PAxrzmcrSR3AEjZnZa8C7afRlLaDAuA78EPzFODEsvWZKpvaJ
NNh9ebVzOQ/dWJZ+LRQQ+qDIgwXbxSDy4IMy/8as0i8O0oyBnDBlbmYrqMHLCzkZ
GvfsyO9SbOSRSl39wx9ZT2O0RnNaY8CMV1bkXVO+pkbJJ20meEPKZhq20pzoPn5J
8w9NdXPI/hIVNwrEs1cS
=8Qj6
-----END PGP SIGNATURE-----

--L4xCDQ7GT+ph8Lmk--
