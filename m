From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Fri, 24 Feb 2012 14:12:07 +0000
Message-ID: <20120224141207.GI5450@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8600684502241279663=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1FDE1042AE
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:12:09 +0100 (CET)
In-Reply-To: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8600684502241279663==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 10:09:41PM +0800, Shawn Guo wrote:
> The fsl_ssi probe function detects the client machine name using model
> property of the device tree.  But it will not work for the ARM client
> machines which are to be added.  The model property is given as a
> descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> Instead, the compatible property gives the machine name.

The ARM machines really shouldn't be using the bindings that PowerPC is
using for the machine as they conflate the machine driver with the SSI
binding.  The idiom for new systems is that machine drivers should be
first class devices in the device tree referencing the SSI and CODEC.

The current bindings should be preserved for existing systems of course.

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR5p5AAoJEBus8iNuMP3dCBIP/jKuuvK5WmoWE0rxLRIDMM4Y
2nSAhdE5DycTNJetpCjQs0URkrCZB/KFNi/TEWB7q3QXEF3OVqOdi/+WLaFdjdCR
3RWsJimIQ3aysQpOxgFqG2aNxX/gaXFPj1f0S7Zb6D8MeDMxIJywW62+jpMxhTZe
cYMMq1nbb16Y5mMMNT3y9cQBD9c8TRR28Hmd/Wo2fd/A8Ze5xoCZr0hYO9bSqTON
NTXtPGIJedt1RtQXvz94YvWnUsdMwajpF1POlQtxeYBjZQyBXuaRcEK8oTSWOsqK
T6SYGAVX8WRaKBhxfXGQYUvCtRzfKOq+zVyJq+nRbzzKoWCuowzwc2rGUcLyEapZ
3hBvlXI5NQQ2dnr4C5zADmuv6CixDivu5XV+GHJRlmif8zh+WQIr3sNAhdyYNE3C
aBxOSVhjYq8KOPFxTI+DRSREr8LAbqsdhfWv1qHEPnSaQtRfCm5PpCx4cpqfzdNU
q6b73ABnD3PFdIwyzZySaO+KZpBQr6bP70Z314G07SPInZClpMQpEcViMtz79IfM
nZoIOON7CB9mK6dbURCmx5tb3kCygTjrNkx1f+/tIZ3irCSmA6ZiRtxr2cxTFrT4
lF4SMU0EvSKJyHqyqbQyPYWVMGRogRJ6hSxNExbDcbDCXn2RSWS8gPilZHjJZTz6
7YFy/JJq4ZFHT3/djKEp
=8xcN
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--

--===============8600684502241279663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8600684502241279663==--
