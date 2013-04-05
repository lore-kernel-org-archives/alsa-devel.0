From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: fsl: Use common DAI DMA data
	struct
Date: Fri, 5 Apr 2013 11:26:04 +0100
Message-ID: <20130405102603.GH6597@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8449803371204732385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1197F2616E1
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 12:26:06 +0200 (CEST)
In-Reply-To: <1364979965-15776-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============8449803371204732385==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:06:04AM +0200, Lars-Peter Clausen wrote:
> Use the common DAI DMA data struct for fsl/imx, this allows us to use the common
> helper function to configure the DMA slave config based on the DAI DMA data.

Applied, thanks.

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXqa1AAoJELSic+t+oim9lKQP/0IZcI8gAJSDEqnwRPRgCKHT
piMa/CDSLx7ENGbl2sB9wkZuG2h3lBKhlJSvuga7E6l2hXHPJDwzSC3zvLicthOn
YdHQc7613doHnmm8b8siB2coxq9B4bqXiSEGBiLImNAnCJVkOFVP59YXFcE2Bdku
v2PxBnE8dPzbSwtvpByLHDs1wn39YWs3X5WPHYZYlk25tp3Fu6lb80RR6UxyIRMR
N9NKjmrbIess0fxi6c6xOu1kwhnhk4ORpmFAh1Qr/4YEpOG3jQQg/HF3RM7zOWKk
VrDMFvpb7SmCJKO6yL8RMfeHDp7LPqWJ7ZyzWu8foCaMIY/5XUS1D+RCofismNO1
8c6w6AzuWEnPKZq6H6hM5uLJ5jew19eT/2aOuQ2PIfIF8Mrfv+zKJrfBGZrDIf9D
Ldmy5URuAkBTvXNH9eoyg7CiBVOZdkxQgmXOqgb+f1wcudR8cbbbWNXquauihacP
p2jPrYU5w3ZQQ5pd+RspImvCASlkdSC9/Sn9Xw4LJAMgvd/4DU0jLKiqlDqooz4Z
cf3GCPpwtvmshTFSpfvg/F9Pd8i3auS9EaCI4elfyow/Miu4RHzodpKdYFyMwsFI
ZcTSazXtX6QTOFLODwANLmMpxtV0ZL2Qdpu05QPhKPFpVwxlpe3ZWFZQUo9R+QUr
6GaBye7HsvTM+yi+SxgR
=f783
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--

--===============8449803371204732385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8449803371204732385==--
