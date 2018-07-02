From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: es7134: update DT binding with new compatible
 and supplies
Date: Mon, 2 Jul 2018 11:04:12 +0100
Message-ID: <20180702100412.GC18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
 <20180629150924.18197-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180629150924.18197-4-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2018 at 05:09:22PM +0200, Jerome Brunet wrote:
> Update the documentation to add support for the es7154 and
> optional power supplies phandles.

> +Optional properties:
> +- VDD-supply: regulator phandle for the VDD supply
> +- AVDD-supply: regulator phandle for the AVDD supply

Unless the device is able to work with a power supply missing (which
doesn't seem entirely credible) supply properties should never be
optional.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+JsACgkQJNaLcl1U
h9A6tQf/RMJFE/F2+O/Iq2z9XKnOKwVPp79wd62sg300HvCYFtp40j26jpCkqwdl
q4oEgG5TOeXTCPkeqGgjouPmGn4EGuXxPss0ZOGilYt87ZIRpa/Z/9K4rEciQV/J
i0AFst7A987fnITAZ7dh7F+Qosl3DWB+qo+ad/SknWOrMwZ4gp/AFLfB8qCD5xYO
SkoJUr9S+MMokfQYAl7J5mV0mg1WvJkMZ7LLyLCFyDH7jTcRzY185HmhJ8q0odDy
K24uVioUI8bxhoF9U3zVnbv0L2QMCcQtUMS29ojRWq9+iSEE3+y1Uqci8H1t0xlU
ZQlI2PybNkBevsgjfJZwcvn5libF0A==
=WrMn
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
