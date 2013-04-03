From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/8] ASoC: dmaengine_pcm: Setup device_fc
 in snd_hwparams_to_dma_slave_config
Date: Wed, 3 Apr 2013 18:04:49 +0100
Message-ID: <20130403170448.GE11305@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979780-15364-1-git-send-email-lars@metafoo.de>
 <1364979780-15364-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7409770235019469835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4E6E265DCB
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 19:04:50 +0200 (CEST)
In-Reply-To: <1364979780-15364-2-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7409770235019469835==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:02:56AM +0200, Lars-Peter Clausen wrote:
> Usually device_fc should be set to false for audio DMAs. Initialize it in a
> common place so drivers don't have to do this manually.

Applied, thanks.

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXGEqAAoJELSic+t+oim9KqUQAJ5F0t9I+GceJGlEG/nGkQ+f
7AGIvmczTj1rGXTF5YjK0Ebl0cynzC+6MgQPtaYEvqW6jlkVbSITcE/38AbrMVyl
NLRvbaztNmB+M7fSGHMVR5fXu0GgA2178p3DvZ3HgyFxzKnkkuqMncMnsF5sqVdd
DZa16suzGnZMxKx5nrRR57AYPSYpNCealgr25+R2qK7s0IDeG+qpckWQ897Wz2KX
++0rTCaHukuIA26vLw6CGTAzOOcfB2U0i1xUVN6Ld04T1cJstTF0BZ/VOezNubv3
Qs5qoxb2VqULJllaRSGaWkCLToUozLH13F1Le+x7UJycFfCajVxPj1yey8DeRrBr
BJPSFc+Dhq/5wqGWm4Cagm49jLCw4x9XgWWJJO5U26IJ7pgYQ32v4XBzfS5sow/b
d6oJl/R5ves/n0OQsIqYL5q8jk2hJPO3L0HSIECtoOSmr2gXOruSVr2BM8sU1sNP
xQcEAj6s6eN57b5IhmoeECyW+49IWWXGIpyu+hscT8fF++g8aDp/5uS4Th1GdWH3
YxmpG/P4NIh4Snf8jHpoMXbSTkar6DR6UpMoXi0QH/bQLnMwYC7Guo1zZSTVLSmM
H3biPgksl9AzAQZd/UgjoB25ocSA0CvPUVJri8kUtC1o4VzLPIolEhOfnoEjRnyl
N18ONwRRiUUl/vdmWgM1
=RmFz
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--

--===============7409770235019469835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7409770235019469835==--
