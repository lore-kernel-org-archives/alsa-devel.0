From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: fsl_sai: add of_match data
Date: Tue, 23 Jul 2019 18:00:35 +0100
Message-ID: <20190723170035.GO5365@sirena.org.uk>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-2-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-2-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, l.stach@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> New revisions of the SAI IP block have even more differences that need
> be taken into account by the driver. To avoid sprinking compatible
> checks all over the driver move the current differences into of_match_dat=
a.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  sound/soc/fsl/fsl_sai.c | 22 ++++++++++++++--------

You need to supply your own signoff if you're sending someone else's
patch - see submitting-patches.rst for details on what signoffs mean and
why they're required.

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03PTIACgkQJNaLcl1U
h9Ce4wf9FPwW9YoTZLNQAPLcH2tdxWqllpH3ZIAiKSDjWkeH9SHfV2iiH1AAMTIL
yM/q6mJxSQPQ4MLekLosnBJXVMkh6/2U8t2pX6YsLFs//vvguPT5XnBZ3VGti2vo
/jvnayUvKMLs/KhI6EvTT+6UVOBnPos0aFMsLkNbdVzb76jIOPX4kVy/TTiqoSjY
sAtGZkl3m0hfwBlOxWPRgkuJdsckLcRLAvVV99ZopDdsWDo2m0KLEXDCm/81P0F6
oVukPsYlmNfOuU5XpKC+/droD+XBK4AO9gy42C4aFkeSsA8eRmFvLlGjEHXlqBU9
DWoy0wiEwu0NjI5w/kgYiLSufz+TTA==
=kOOi
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
