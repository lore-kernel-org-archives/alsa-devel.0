From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V6 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Date: Fri, 3 May 2019 15:17:25 +0900
Message-ID: <20190503061725.GA5107@sirena.org.uk>
References: <cover.1555908545.git.shengjiu.wang@nxp.com>
 <2cea4cb992a445863e88fa7865f55a02a83e031e.1555908545.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cea4cb992a445863e88fa7865f55a02a83e031e.1555908545.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 04:52:02AM +0000, S.j. Wang wrote:
> When the output sample rate is [8kHz, 30kHz], the limitation
> of the supported ratio range is [1/24, 8]. In the driver
> we use (8kHz, 30kHz) instead of [8kHz, 30kHz].
> So this patch is to fix this issue and the potential rounding
> issue with divider.
>=20
None of this series applies either, with similar error messages:

Applying: ASoC: fsl_asrc: Fix the issue about unsupported rate
Using index info to reconstruct a base tree...
error: patch failed: sound/soc/fsl/fsl_asrc.c:282
error: sound/soc/fsl/fsl_asrc.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

(I get the same error message for your PM patch when applying without
using patchwork as my main workflow does.)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL3PUACgkQJNaLcl1U
h9AuFwf9GU1mu4UAbguaCvzQD7KN7UOFPnMm2fjMErvpmxgq/cV7aFQEJv6Kc9Z6
A2/l/TYJ+iNoJ01SPYwRKqw63mJmthjOsikQzaH3VISq6kF09ENT35Z4U1r8zOkb
6IbPno6mpS6rBk0ckEJ7TLf4dl9zDh4djeaGWVK8MFX+D2eW86vfn0qNSWVCO55O
p46Qvf2iwJJyc9HVx1AR8hJFAtadOWlmfPYUbUJ0DIJpAzT1aCFtoIGqj2Ef40hl
YMo9B11fGc9xoae/INeoJIAOInjLKeS/Pm0n4N5FJpPeke/b13n0bDJ7EuHOy+td
YCXUiBuuUhxXCy372VZHevRq1JK7hw==
=B7sO
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
