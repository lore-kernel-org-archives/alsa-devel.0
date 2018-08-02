From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: wcd9335: add CLASS-H Controller support" to the
 asoc tree
Date: Thu, 2 Aug 2018 10:52:35 +0100
Message-ID: <20180802095235.GB9117@sirena.org.uk>
References: <20180801112000.DC6B51124241@debutante.sirena.org.uk>
 <d7c2e466-9f60-9347-bc62-7ed0dc3df91b@linaro.org>
 <20180802063130.GJ4662@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802063130.GJ4662@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 07:31:30AM +0100, Lee Jones wrote:
> On Wed, 01 Aug 2018, Srinivas Kandagatla wrote:

> > Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" It
> > would break the build.

> This is not a run-time dependency.

> Without 02/10 there is no build. :)

I reverted both patches after Srini's mail anyway (I didn't go and check
for the MFD dependency, probably should've done).

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti1GIACgkQJNaLcl1U
h9Bj6gf8CW3GQP6wh/uI0bsTgcrN3VIWuUsOzAmi9uwXXvvKpht9jBEQEvnHeW6F
4RHbLEYW6Ftf/QA4Gq9aSQkeZwtpnq7NNfDBmiNiNjt6ZQ3NDoDnJh7eJPl45rRG
oUMpqESO8grhP3Xvdn2D79zMUQbjmzxJpKmf32AxLpp+CV2HGWL07VofsmkmljoA
7AkOOHRAV5cupYkC+pKAkYZTAZsCj0TeVGDtfCO6ytZ/eGfyKPK4n0eIa+KEJUP4
4bT0GWP8bQIV5Was00DTRRaYdAIETVrTFU60Ukv+4lxw43yGhk47inx+ZT+Cw6XE
YBqxdCFtO/8ClZIK+5TLmiBdpR+kIg==
=GgCo
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
