From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] drm/amd/amdgpu: Added a dwc quirk for Stoney platform
Date: Wed, 28 Jun 2017 19:02:35 +0100
Message-ID: <20170628180235.2dscruiilz37gtr3@sirena.org.uk>
References: <1498235706-31111-1-git-send-email-alexander.deucher@amd.com>
 <1498235706-31111-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1223677706=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1498235706-31111-4-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, amd-gfx@lists.freedesktop.org, rajeevkumar.linux@gmail.com, dri-devel@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1223677706==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sonvavic5w356wu"
Content-Disposition: inline


--6sonvavic5w356wu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2017 at 12:35:01PM -0400, Alex Deucher wrote:

> +	if (adev->asic_type == CHIP_STONEY) {
> +		i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
> +			DW_I2S_QUIRK_COMP_PARAM1 |
> +			DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> +	} else {
> +		i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
> +			DW_I2S_QUIRK_COMP_PARAM1;
> +	}

Quirks like this are better written as switch statements since that
makes it easier to handle further variants in future.

--6sonvavic5w356wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT7zoACgkQJNaLcl1U
h9CpWAf/QHJSDu+HhWVwhi9/9WrolKnKBDUVRvZXF7rs/nNd1aUXlxlKf1t9OTPm
1ksLAMrkU8PQ5ykIDKSb4wUVElP3HbFjujUfcEY3GX7ZgsiKd04hZac4NYlomE8X
UVWNuAAcTE2DSIJEUHQGrW+D3YPmxnfYg51B2PtfHIXdDmZ8Fngdhew9Q/P6QHa6
Hp/JKEh8EuwN1GFR8ewjJnfrMlNuij5Eg2EWfQXK3UfdsGm/YmGN3LOOWpscvImV
sy9gEpdP3SIAWrkKO2AUPNFxxcdvup0NI8siWRUyOqdO92hcAzyEWS83xoP6Xze9
ubihm420q9Gwfo/EjerEcdlGXeO2uw==
=OANU
-----END PGP SIGNATURE-----

--6sonvavic5w356wu--

--===============1223677706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1223677706==--
