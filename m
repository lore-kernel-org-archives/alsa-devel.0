From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: max9892x: Add documentation for reset-gpio
 support
Date: Wed, 12 Sep 2018 13:28:18 +0100
Message-ID: <20180912122818.GH6062@sirena.org.uk>
References: <20180912121955.33048-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912121955.33048-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 08:19:54PM +0800, Cheng-Yi Chiang wrote:
> max98927 codec driver will support reset-gpio binding so it can toggle
> reset line in its probe function.

All GPIO properties are supposed to end -gpios even if there can only
ever be a single GPIO.

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluZBmIACgkQJNaLcl1U
h9BtAwf/W569laNPEtSJDjZPojzO9JM3hTP+83xOgBSvB5xBu81+4NxbNDxHbmVY
nQhGwx926DP+P6Lq2a93i88OPzuqL4av6Ox5TqRQnSQ6eIKagvo0g1pVicxO2Oiz
7sP/xY35CM5EvAwsZ7EJliSp+T3yGg9RSDldwsoJ1a/jrUBSASGZgnVuxFHYupve
BDIL1uXgmlDvAsGhsxUk+esoegPr2mssGLbvzYySIigjH6ABPIUVM7Hq5QshiGAW
0FztykdUG/NGBNFPK+JRudbFzolHQk6DCM7wpruculdc2e5VjVc2x+mmny8yUXvt
CozQJW7RZVUBE688gFrM0tET6DFtug==
=Ld/T
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
