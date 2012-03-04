From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/20] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Sun, 4 Mar 2012 13:32:42 +0000
Message-ID: <20120304133242.GC3083@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3167796267602256103=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFD252459D
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 14:32:45 +0100 (CET)
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
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


--===============3167796267602256103==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 03, 2012 at 11:19:41PM +0800, Shawn Guo wrote:
> It's the full series adding imx-sgtl5000 machine driver which works
> with fsl_ssi driver on DT based imx platforms.
>  - Patches 1 ~ 5: Convert audmux driver to a platform driver and move
>    it into ASoC folder.
>  - Patches 6 ~ 12: Merge ASoC imx and fsl folders.

This also contains a bunch of random cleanups and refactorings which
*really* should have been at the start of the series so they could be
applied without dependencies on the other stuff...

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU27bAAoJEBus8iNuMP3dWuwP+QHcaMKv48LCpjZwwHUE98tU
7+CPEJmzy2WQGj+vx+d67kl2/FKGeEX7rfFSdOLlr/UoUxigqVUvDjo2C0RZxs9q
eVY6e3KcrPgsFHHCAH3y/6RbohT1IWv6jgNHQEgKDgZblNnOmpzFs1wLWWP0umWx
HvbeFYj2K8g0A4OV55t6HfyfxZT54juey7j3XOuUZEudUnqiZXXwkJbxF+ewIpKv
Ke/cuKOCNlPC4LSLb9GSdpPX9au5lAWP3T1kRGqkvDRZl+ub85Wu8drR/sCB3MIp
uOLiXavAiyLLbHhujGzWp8SDCLR9jq/6yHHjGbxCFrpVABK9HNeW0Qq8qBPiYwba
Hb533oyMlmT/BIvp5Ag36n1Mw0KG8j6ikr6m64KhZ2mAzszhbZ0qOl9M1qFSHIUt
vsA03ApgsCE2Jo6feSnC4MVoehDWz8eThenbqdHViAqIY2ukyKG7TK8CJ5+qbopG
LZ9GMkr0rYY5m/BqakR8Fa1R2pbmTyC0ieSkKkJyMLHM7RR0dZ1yFNEUq0LwDUie
ScvIH+7gT+Qs9hgeanHYHff3HRlIdred4oDW50arWITzDTkpkjxilcvT+u14UFV8
JhZwAq0YXwH+34RHek6XcT/Gg5jGNYi7uc6YCrtmU5YPsHHTcfAQRQknrSfHdfzS
s2rBvLa2GnHk5MSgGOyU
=dgVH
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--

--===============3167796267602256103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3167796267602256103==--
