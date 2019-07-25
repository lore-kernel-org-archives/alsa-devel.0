From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: codec2codec: deal with params when necessary
Date: Thu, 25 Jul 2019 13:55:34 +0100
Message-ID: <20190725125534.GB4213@sirena.org.uk>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
 <20190724162405.6574-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190724162405.6574-4-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2019 at 06:24:02PM +0200, Jerome Brunet wrote:

> Also, params does not need to be dynamically allocated as it does not
> need to survive the event.

It's dynamically allocated because it's a pretty large structure and so
the limited stack sizes the kernel has make it a bit uncomfortable to
put it on the stack.

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl05psUACgkQJNaLcl1U
h9BPRQf/TWxfdv1adKppGIBtuqwmpBS+DoFYnHcZDpi77bESSWpws7sxnJQocVHi
R4/NkWuIBihp5crQr4F1z7G68tmtVTxFRDni9rutYtQxaVloBZ9OFkesJLaaLG5Y
7e/uDcl2Q7Dlw7jo7NsboC1WTLq3vCDRpioZja9GjL6X/YNxLAmcoQEA3EeWvwtp
2cvDAI/Ah34hsYvfQwyaIFKPzS5UNcPdkb3MN03010mqR3xmVTnJTvWQp7A0l2sd
tliUrBzMtpqW3gTD5ZCjI6dHOp6eeI7BZ26v49WUJtOpawsibdFpkGI4PdZeeuf0
1wJevZvP7lpr4zNMaCWpLwA5LkAY3A==
=XabL
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
