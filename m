From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap: slimbus: add support to raw
	read/writes
Date: Thu, 5 Jul 2018 18:30:59 +0100
Message-ID: <20180705173059.GF6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
 <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8055336122817023405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5658426761D
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 19:31:00 +0200 (CEST)
In-Reply-To: <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8055336122817023405==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 06:20:50PM +0100, Srinivas Kandagatla wrote:

> Access to codec registers is done in 2 steps.

> 1> Write page number in page register.
> 2> access register within the page.

> This seems to exactly what struct regmap_range_cfg gives.

> Adding ranges to regmap_config along with read/write bus callbacks works for
> me.

OK, great - that's what I was expecting.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+VdIACgkQJNaLcl1U
h9Dwzwf7BS21OmgSCcrqCc2sl9oEx140R+UQLHXRJtXS0w1TF7H8JytRTOEle3ZI
UbZpdLxk3shYHRQpzTtauRPkfQbg4XLtPwO4WW/1bJCnOFAb2fXWZlGzHvdyy62h
+EeLJqaNZE0TIxM2AUV0VZu6FCxdWIyIdr5rq6rrBih9wmMYcB3xapZK6dryE9eu
qV0V+esNB2nU7X3SSC2nJM9aQPFwInPF9KTs1sZdnmOuklAY5N/LNQHUhRR0E2qU
5Ig8927m45O11qYffy44rq0I7EOxpW4Jw+cjcJIV3OWalUa32dJFdvg0RUqWY3NZ
Z7I530q+KUG8wvO4dKX8My7Y+HAjOA==
=RO5v
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--

--===============8055336122817023405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8055336122817023405==--
