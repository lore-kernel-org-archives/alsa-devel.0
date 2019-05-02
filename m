From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 2 May 2019 11:39:45 +0900
Message-ID: <20190502023945.GA19532@sirena.org.uk>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2019 at 02:24:54AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
>=20
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

This doesn't apply against for-5.2 again.  Sorry about this, I think
this one is due to some messups with my scripts which caused some
patches to be dropped for a while (and it's likely to be what happened
the last time as well).  Can you check and resend again please?  Like I
say sorry about this, I think it's my mistake.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKWHAACgkQJNaLcl1U
h9DAmAf/ZznWBwoyQXL+nQLRK1eWpBZg9ma0CiFNxH/eUHzwZYIKALZvQ/XtxTgU
loMrwMJLbC8TRCPxVnH77AQRIKS0VJMheOaYCv9wmu+hFNjnEuuhRT0wg/30oMba
gt6LFb/SdSap+9uDN0x6m6BEAoM44d9efhi8M2zc9F9TegdXH1Vehcg9Z+andnzx
0zj6hZtkD22iTm7Cc866VIvc8SfOEsn3TK7mtFUtH3dwX7uJC11HFQnlBcLqyMrV
Wxny0faTSxjZXYxrMJMd7vk7ekzyvb57Rg58Si3234fbU8yL/vOJS8xLNbWjvjYX
4+wYCtvBSLTk76eOCZIBx+Hi2ifAGw==
=YKw2
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
