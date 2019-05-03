From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: avoid Oops if DMA setup fails
Date: Fri, 3 May 2019 13:34:06 +0900
Message-ID: <20190503043406.GZ14916@sirena.org.uk>
References: <0b030b85-00c8-2e35-3064-bb764aaff0f6@linux.intel.com>
 <20190429182517.210909-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p+/4B2pcxE3X6xU6"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190429182517.210909-1-zwisler@google.com>
Sender: stable-owner@vger.kernel.org
To: Ross Zwisler <zwisler@chromium.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--p+/4B2pcxE3X6xU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 12:25:17PM -0600, Ross Zwisler wrote:
> Currently in sst_dsp_new() if we get an error return from sst_dma_new()
> we just print an error message and then still complete the function
> successfully.  This means that we are trying to run without sst->dma

Please don't bury patches in the replies to existing threads, it makes
it harder to spot them.

--p+/4B2pcxE3X6xU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzLxL4ACgkQJNaLcl1U
h9Bf5gf/b4Rd4TJAVsVpVmu3GoujrMqNu/jOVgDjPKDNLE70Cj/x4nvuVMvV6YAA
1W93C0kngsJWKhAgw3gvDsW2iIBGRLOCxB0JaHXntb5bO1ruAMKvyDfy1E09038c
RvoJg8367XfDLvnJKgoaktPKu+d4yPf73shGOVgEpSEvT5vs4bl5/zV1tB3NNHMG
U5QkmT8AoRhkDRWOrIETSfPaZJwk01VI7qjp9UxSqszBvbcxhwMbuDPyCcr5reXn
Q5aYlCH8a1mZoW4Az6NHsykSi8NyqPt1rvKYStPQn4WsasuXkV406EddfJL98bI1
I/gMNH5m5xTM4wPel4/Bi8jxQQ+V5w==
=A4ke
-----END PGP SIGNATURE-----

--p+/4B2pcxE3X6xU6--
