From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak4642: Make of_device_id array const
Date: Fri, 25 Jul 2014 18:21:26 +0100
Message-ID: <20140725172126.GA24306@sirena.org.uk>
References: <1406203117-2767-1-git-send-email-kiran.padwal21@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406203117-2767-1-git-send-email-kiran.padwal21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kiran Padwal <kiran.padwal21@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, s.hauer@pengutronix.de, fabio.estevam@freescale.com, kuninori.morimoto.gx@renesas.com, Li.Xiubo@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2014 at 05:28:36PM +0530, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as const

...and reverted because it fails to build.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pITAAoJELSic+t+oim90m8P/0Z6XasRx3l1R/qerJgbyDFy
UfPzmJ4vFMqWMqdFPXfqBXaI3H/Dt/3Dmeemeyqc567MghJf+eBWFYvob+EE9cmM
BM3wfp/6gxf6VlA6Oec621+g5yVpGVRfFZBgwwpB8Ao4/91xt6sejD9AP6Cl2sUy
owNrLpN1+HgeFK8ZoXkjLPqmjtNzOaQ2HRU3ZqC6Cr7WHGUVyiAO/xDzZlIx7lSo
J53VnIASPirknSny2pjAXv5Rb/SAzXm30adhTU+UCycuEI9j83OQRuw06xHmxFhE
A2vFY5Ej58U++jZAijWuBIizL8CiNNYVAqLH7C1h6q0MrABLeDDk4A5recw0jKlV
mZQW5UcTA9zeR2H6NHmLFy4pn70QXXPKWAwFv59svd0GzuJIFx1MfCpW8pNuJdCR
NT9hdkTnmTw0gCl+THXya+TfWAUGrWHjWcPcXc3TNir8A+261T/z917QNzqbBM5Z
owfp3dM8moNokbdYkEVepwu4CcxFiaLS3NvQBGfKJJAlWhW41gyuPwqlM0+JJQaZ
HfI8P4zQX6cSF4w7mnCJrOLMdmcvCdgSLOEGYxT76rQTIAAeEznvL2h2vOXPXmYk
TY8kUo1uDRnuumakkwIvKh51iW+hNrObWaoCy4ZXLIwydSmXGF/sPTHBbw3eGTvs
dbj4HkHV/4UmgMWTaVuv
=g2vR
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
