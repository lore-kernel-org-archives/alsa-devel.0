From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Date: Thu, 5 Jul 2018 16:08:57 +0100
Message-ID: <20180705150857.GA6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 12:37:00PM +0100, Srinivas Kandagatla wrote:

> SLIMbus supports upto 16 bytes in value management messages,
> so add support to raw read/writes upto 16 bytes.

That's not what raw access is.  It's unmediated access to existing
registers, not some other thing with completely different register sizes
which you can't see through the register map.  The intended use is for
things like fast firmware downloads.  If it's not part of the register
map we shouldn't be going through regmap to get to it.

> Also useful for paged register access on SLIMbus interfaced codecs.

That needs a bunch more explanation...  in what way does raw access
relate to paged register maps?

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+NIkACgkQJNaLcl1U
h9CgaAf+O/7Vv1B6FBGkyZAWEtgbx7kuUHRjw+gL5RkucN53bfq4VCnb7HuogOul
4/70MYrtH+++epGz/Vkojs+D8rmRPpytYT+vdVbw3dPhX4G/y37DV8DLunb9EpAs
qr8SJVqfSbXEpNwxEiRLNRvlWQAUf+kFpx370jaJlJOY0TqZH6Hx3RVzYq6GMZ7J
Z0Im0Y/pVpjyh+qK+z/gsMbMCsppMhFPcZLDVqNeqIPHqZeWeiXkDnU+jvWvH7wO
h40Whn/X4ZepvpdsJ/vroqqaleSrpQ7LWQfLm5DIdL/rlUcmyMHUn09vx3lwkKDx
PwCGf0V+0864OXeiWJtWjCCt7lN20A==
=uxp1
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
