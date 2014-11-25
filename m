From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: fsl: Use dynamic slot width for ESAI.
Date: Tue, 25 Nov 2014 12:47:42 +0000
Message-ID: <20141125124742.GZ7712@sirena.org.uk>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zrEArbvrm/ur3HOL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1414193668.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: b02247@freescale.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--zrEArbvrm/ur3HOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2014 at 04:48:10PM -0700, Nicolin Chen wrote:
> This series of patches add the support of dynamic slot width for
> ESAI driver. To do this, the PATCH-1 removes the fixed width. In
> order not to break those platforms that use fixed width, there
> comes the PATCH-2 to apply an override of slot_width.

Applied both, thanks.

--zrEArbvrm/ur3HOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHpuAAoJECTWi3JdVIfQuPEH+wU2vOjKzHpwHUpL0Q6P920z
XyUuRWZaWgL/wqp6ugDRcopn41Ow4IrngI9Ju/Fx+GOM2jjUupBScqOUkh+dPLWE
lQ8kwpRw0CZld59Q2W2hBL6VmCG8njGmZ7W6Q4F0wtdPfEjk89wE35b0qSsis2G4
xovNV+kmMBozkXS0FF+26bav3k3b1Ppk+SEG77bmL7BbjWDI/QFtoSZPF+28tpkS
XbGLU9yrz8+UvvJbqlHZ+flBISzE0RsskIR+5mBU0wD1Ms3ECgAWrvvR4UE4Lgye
NOelEPmcssGqNAwprwKP8XTh0urxtNTjNFIk4TQVkKbUHaXOAWN7s7KyT66C2Os=
=wNgc
-----END PGP SIGNATURE-----

--zrEArbvrm/ur3HOL--
