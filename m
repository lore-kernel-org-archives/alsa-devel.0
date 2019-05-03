From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8516: register ADDA DAI
Date: Fri, 3 May 2019 15:11:11 +0900
Message-ID: <20190503061111.GA32229@sirena.org.uk>
References: <20190502131214.24009-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502131214.24009-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 03:12:14PM +0200, Fabien Parent wrote:

> This patch depends on patch serie:
> 	[PATCH 0/5] ASoC: mediatek: Add basic PCM driver for MT8516
>=20
> v2:
> 	* Register ADDA before memif to fix ordering issue.

This is v2 of a single patch which depends on an in review patch series?
Please don't do things like this, it makes it much more confusing to
follow what's going on - unless there's some strong reason to do
otherwise it's better to either wait for the existing patch series to be
reviewed or to resend the whole thing.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL234ACgkQJNaLcl1U
h9DlYAf+NB6GD7ylQBBA7/swvGJd8bxeuqc3fRRWHfYBVXV1nkAQOhs5IoTziCE3
W2b1ACZX9lv2scdJ/8/OwxN10Q4/i30ShHMTIPeY2/hEn6dnPcYoTQg8n+W+Ca5e
Aa0ixg+VrXMYV7mSo8qYtuVULeOK1H8drM8pA61is2RlupNHtdwdFwfiCXO6uKRU
1FKvToH0OGsohgfGXdfGlz1JpSLNZrWefcyo2talqy3GTpXnMpROsGGZyNNx0EyF
bWLfdfuArrauf4kXhF559nMoWTIuA2/paZFVNNxZrmC5C8ViyU51Yh+nAz4iLFbg
f+dC4E1ARwca+ZyOMN/7V06nYMyx0A==
=dh9z
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
