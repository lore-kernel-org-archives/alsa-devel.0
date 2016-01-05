From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: AMD: add AMD ASoC ACP 2.x DMA driver
Date: Tue, 5 Jan 2016 18:43:43 +0000
Message-ID: <20160105184343.GL6588@sirena.org.uk>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
 <1450897275-17152-6-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0007046175=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1450897275-17152-6-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============0007046175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 02:01:13PM -0500, Alex Deucher wrote:

> --- /dev/null
> +++ b/sound/soc/amd/Kconfig
> @@ -0,0 +1,4 @@
> +config SND_SOC_AMD_ACP
> +	tristate "AMD Audio Coprocessor support"
> +	help
> +	 This option enables ACP DMA support on AMD platform.

This has no dependencies?

> +
> +	/* Designware I2S driver requries proper capabilities
> +	 * from mmACP_I2SMICSP_COMP_PARAM_1 register. The register
> +	 * reports playback and capture capabilities though the
> +	 * MIC instance of DW I2S controller supports capture only
> +	 * Provide a workaround by masking the capability into a
> +	 * scratch register and provide scratch register offset as
> +	 * though it is mmACP_I2SMICSP_COMP_PARAM_1
> +	 */
> +
> +	val = acp_reg_read(acp_mmio, mmACP_I2SMICSP_COMP_PARAM_1);
> +	val = val & ~BIT(5);
> +	acp_reg_write(val, acp_mmio, mmACP_SCRATCH_REG_0);

Ugh, right.  So the hardware doesn't actually have the register moved at
all.  Why are we doing this, if the capabilities really are buggy the
more idiomatic thing would be to provide an override for the
capabilities via platform data?  Requiring some other driver to poke the
hardware to set the capabilities is a very roundabout way to deal with
things.

We should probably revert that quirk unless I'm missing something here...

> +++ b/sound/soc/amd/acp.h
> @@ -0,0 +1,119 @@
> +#ifndef __ACP_HW_H
> +#define __ACP_HW_H
> +
> +#include "include/acp_2_2_d.h"
> +#include "include/acp_2_2_sh_mask.h"

I can't find these headers anywhere in the kernel tree or earlier in
this patch series, this will break the build.  The fact that they've got
include in the filename is also a bit interesting...

> +#define PAGE_SIZE_4K				4096

SZ_4K exists for this.

> +#define PAGE_SIZE_4K_ENABLE			0x02
> +
> +#define PLAYBACK_PTE_OFFSET			10
> +#define CAPTURE_PTE_OFFSET			0

These defines could all use namespacing, as could some of the others
later than don't mention ACP.

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJWjA7eAAoJECTWi3JdVIfQfC4H9iFpuT847/vHDKCObm8yQLFt
CDYRu9xseQHKOyzTCNbgY8iNrg+25A3w7PHcPIZEvMtRIhjqvN/poKzRHJq2KrgP
GzzWzj7TKb0+CBu/76rFqHSVtmOSPAhTNXEbK2H0boa24ighTP74/GXgR/clXMuQ
QbGb62QRibLSzQIkD4verDkKhszsxVQtDnn4Ws6xjnwObW0WBftLOGQ4CiabKP4W
nEI9BGfwbX76oOn1Fum61BxMrQWT7vRpcPLvzzlmDSda3utgTq2ze+Bmf27BFKgg
87aO4xzMSiBy/s7EPJUMno3MzhX6hu7l/1dqP/nzNK+YR97cO73qkdK1tZziww==
=jQBK
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--

--===============0007046175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0007046175==--
