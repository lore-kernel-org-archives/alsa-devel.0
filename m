From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Date: Fri, 26 Apr 2019 10:57:06 +0100
Message-ID: <20190426095706.GB14916@sirena.org.uk>
References: <0320f04ac785a6046a6f9baec591d36a4a6189ec.1555899304.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0320f04ac785a6046a6f9baec591d36a4a6189ec.1555899304.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
>=20
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

This doesn't apply against current code, please check and resend.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzC1fEACgkQJNaLcl1U
h9D8ugf/a57E7R0SaMmoq+3MoDHMiNdRtpJl6HAus9MmbdIFUbWvldlAob3AD6He
JMm76QgN0Af2NsTmLRhGAmLhrZQ2Bp+Wo/MP0lgSOrs2CdAFzseekjzOllajPGzX
1gL8JWRIYZ9fkRU6i87AaMJDctynIkGCaEhRqUbulbj0QD/0l8CJ1PfNfyugcFN8
WGEdEgD8DQ/ynwk6DUOkWC2HPiRWCB20kzZQH0b2mF6qTQL0YvAtfDot6XZQgWRV
veIRjLGv9koPdiNOOLVjN/QGD4x+op/M4w7e8SaHERWl0Yp9aUBeFUTrhFhhCWc9
qqFth3rvLMMRv/FZFgr2GMYhtAU92A==
=dqQx
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
