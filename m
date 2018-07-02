From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: es7241: add dt-bindings documentation for
 the es7241 adc
Date: Mon, 2 Jul 2018 11:06:45 +0100
Message-ID: <20180702100645.GE18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
 <20180630172241.10806-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630172241.10806-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 30, 2018 at 07:22:40PM +0200, Jerome Brunet wrote:

> +Optional properties:
> +- VDDP-supply: regulator phandle for the VDDA supply
> +- VDDA-supply: regulator phandle for the VDDP supply
> +- VDDD-supply: regulator phandle for the VDDD supply

Same issue as with the other binding: power isn't optional in the
hardware so shouldn't be optional in the binding.

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+TQACgkQJNaLcl1U
h9Cc6wf+NZEPaRFu73AMwKwM3gRUSniFTZwz4wGM7Gc/fZIQDORCh96O01cl2eev
EzzT8jy5qZLpRTae4Dth7r2jhMkrk+DUVDeitb/47p53ownbhJnLkj2nOTfo+HIP
4Uv8mXb7nk5pQ7/u1s7cIse45X12DDKipsMbdlqa4N84N0Yu6k2IMyNd1TXFKsSi
/XXJ+vHEbCjZOEODe1FAMTElgwb57fJzSJsV+4xRaz+icVNH+9NwbXK6+wbsHXls
/rdejm5M5OMUsOCbVNmqasS1ey69RtuiyXzH4fPNaav9bsNraEVm8JTcPdyWMmsS
IVzkHIf1yrdYSXxYb5LcaLeFDHnDjA==
=lr+8
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
