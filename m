From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5663: Add documentation for power supply
 support
Date: Thu, 15 Nov 2018 11:32:08 -0800
Message-ID: <20181115193208.GO2089@sirena.org.uk>
References: <20181115041334.79446-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0MVPm7EaLRZfIY9d"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115041334.79446-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, oder_chiou@realtek.com, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org


--0MVPm7EaLRZfIY9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 12:13:33PM +0800, Cheng-Yi Chiang wrote:

> +++ b/Documentation/devicetree/bindings/sound/rt5663.txt
> @@ -36,6 +36,9 @@ Optional properties:
>    "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges=
 of
>    impedance in the impedance sensing function.
> =20
> +- avdd-supply: Power supply for AVDD, providing 1.8V.
> +- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
> +

These should be mandatory properties, the device is going to need power
to work.  The regulator API will handle incompletely specified boards
for you, that's not a problem.

--0MVPm7EaLRZfIY9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvtybcACgkQJNaLcl1U
h9CoJQf/VdQDU6fQnTd8fQFAhMHF7OlBxmiyfzkgRvOmPDLMSMTfV2zJcLfMT2XB
Z/FhyT0K5yMmPTbtIPBSrM4v0ECaQyOxHtUAomZQAQ32umS9ap5IiH1m8LTboKD/
K19ektcrbWvmg3CwQRW+KZy4QwDdbyCoFjWxfMNz4aelzcKReenOtnicQ/DvZ4R3
VVqLIK3IXKxOwW9gjx2/6GQDMR40xiNw8f1wCx7tbbX531on686Kwculduepbd0T
87AjYOI3JtgbzYDzVSJYzgkN/fP81pV7JzKwglcG0Qg5C1BuBW0pvjXIMvULMtk/
Gngq6BUSnmvtwz8Ye4hrE63kymarqw==
=4gfH
-----END PGP SIGNATURE-----

--0MVPm7EaLRZfIY9d--
