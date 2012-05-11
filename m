From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: fix the binding of imx-sgtl5000
Date: Fri, 11 May 2012 22:52:01 +0100
Message-ID: <20120511215201.GF29835@opensource.wolfsonmicro.com>
References: <1336747463-24237-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5757945930939695602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DE031047A1
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 23:52:05 +0200 (CEST)
In-Reply-To: <1336747463-24237-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Richard Zhao <richard.zhao@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5757945930939695602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2012 at 10:44:23PM +0800, Shawn Guo wrote:
> The sgtl5000 data sheet does not particularly mention that the Mic Bias
> will internally supplies to MIC_IN, so fix the example in imx-sgtl5000
> binding document to have a better reflection of the actual circuit.

Applied, thanks.

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrYn6AAoJEBus8iNuMP3daMAQAIj/y3Ddt/D4WwbonTJ9TnAG
AsB8tOdzOF8vALqnpG0wLMJwBqeqFI8M3fsq347+ysvNtbblIMiDDxBNvpdIYZbv
SZSyrLDFSpN5k3d5vmvGGiMgSej5Pd4+t0ANZh7RviFLFgleJfEVM6AXs+zPSqM/
Zm4ves1paGk3OP5Qf0Wzh5YuxpQtuIbBhFdjPfrD6ADI3+EYAzsD2jeL8I27snUu
oHtlsJit8nNdoMo/+jZSIMtE+iFqhKaNjsZ8mcSawoprP1FZ9clL8za89wxinUDL
C/nNYVQcFoFLkhpxO+Tb0G6GsNGEH3E5gCpO/T1e8ybeBvFqn9W4LlaXOCEYtXya
y6B7zX7QyUXp7XBZJUP/CLwmkXQB16ZIJaJQqqR3oGrW3A5F0f8QDnKdPqXxh9Z2
cXiLDCFq+dxqUaHq03Rxar4DukgCzXyoxcwTy+qrkJ3Hxm2BSNI/ltnD5iNz8+Re
LgRwZMZdK2raZc6p4NsSrS7AAHU0b0QUBcUAkl+jOuTs07FrafSmmMrFG5he2joK
hkubz90GoFGMnMPGHtCMeagoXPRCuqnb2EOPE/MIT11meUCJO8PezMQjzUamnyUL
E1Zn/JUISFhN5/CNxX9IVCSOA1eXNlcg4CqM5gDfzavzv0XcxWL2o7bFHDaOCtmF
KEYx2NZ6N6Hg8mknE8Iy
=2TWq
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--

--===============5757945930939695602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5757945930939695602==--
