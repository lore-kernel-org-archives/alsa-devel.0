From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Date: Fri, 26 Apr 2019 11:00:25 +0100
Message-ID: <20190426100025.GD14916@sirena.org.uk>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-3-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> Basically the same actions as for system PM, so make use
> of pm_runtime_force_suspend/pm_runtime_force_resume.

This doesn't apply against current code, please check and resend.

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzC1rgACgkQJNaLcl1U
h9AExAf7BpbUDjxFUvENyjvPWZ5XP867EfiNhim76zTqqHzpoH6NdAdYYpKqzPpl
QsTiG7FvS4/Z//RJen1ItB6wD1jGOBubB85+TgfpNdn5YaLdLDw97EzUuAli+4vD
gpmQ0oDJS1TUnSMjPD8CyHIFA5nJWvkshNRR27ljTjPDAeZuCEbSSa/LH7iQMiZQ
LSe8wuCFsmXZqjPiTvx8f/iLDFbNE+LUx/rDOJOBMi5xUEjNkCFqYSAPDVX6MR8G
ymOod7dDfcHydFiV7oZsYXADShq3m43D9q758l/5dpZcj40PRcL2S8AtJkMPpsw8
Qsu6uF/CA1cXAdH2++ECFdvG3BU10A==
=Pwh6
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
