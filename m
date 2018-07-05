From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Date: Thu, 5 Jul 2018 18:47:24 +0100
Message-ID: <20180705174724.GG6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
 <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
 <20180705173059.GF6227@sirena.org.uk>
 <2d2ea16e-c8b4-53b9-259e-d75e6ead4362@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d2ea16e-c8b4-53b9-259e-d75e6ead4362@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 06:39:14PM +0100, Srinivas Kandagatla wrote:

> Are reg_read/reg_write callbacks in bus regmap redundant to read/write
> callbacks?

> By the looks of it, it seems redundant, reg_read/reg_write will never be
> used if bus regmap has read/write callbacks. Just wanted reconfirm before
> replacing them with just read/write callbacks.

Yes.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+WasACgkQJNaLcl1U
h9Ctsgf/W5M95JNkGApzOvZ1t8G6afSlQUw5P4gMTVdYIC7qb3ewSW3Hb/3LcNDQ
N/b+lDAi9Ec3huoqgHg322AmcxzxTZhSVNgckJtmgSSQm+ShUfKOWQh3bTdSLo4f
BHKeNVGrdOtaONNCkVlShsUrvA5esrjoblXZ6XScaqAoaRDN9sR9DmtL2jkFDI6T
blKuzjnuxbM+ZpGC4C4+t3JoQ4W/+CACXf5nEKTi9yvGoDiw8BZUtPjKiWCaaM64
rEl3S+kO3iHbLrGo0662P7haWkKcXDnS3BbSkJWGXrlXu1NZKCHpazKzvBhqWETQ
u9XBILy6MsCsY113GJ5Ul5DUomIBZg==
=jnsz
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
