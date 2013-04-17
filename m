From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/17] ASoC: dmaengine_pcm: Add support for
 compat platforms
Date: Wed, 17 Apr 2013 14:21:57 +0100
Message-ID: <20130417132156.GG13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4942373390365467268=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4241261666
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:21:58 +0200 (CEST)
In-Reply-To: <1366046404-8759-5-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4942373390365467268==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:19:51PM +0200, Lars-Peter Clausen wrote:
> Add support for platforms which don't use devicetree yet or have to optionally
> support a non-devicetree way to request the DMA channel. The patch adds the

Applied, thanks.

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqHuAAoJELSic+t+oim9zH4QAIcUKZZJsvKR58OeekYqio5V
/7xHapMNO/PzdRikjy0cJBpvBXX93ZWPMQ8Whc2txdN1lcqvPSLm4bc3CshdpD4p
NQMmeSqraGw0/KmtQ14FcOohXT4st6k2C0IZayoCnOIzQVBqb6SL1njnuqcSx2Ze
0KE1heOmY6zjRE8WJAtQitWxe0EGITDaBY6FGEbmUhdES5PCVWC1uuQkIjKRnlAa
oUk22ghdfyoAMv2JcBf6xa3qa6jeISM/4Ahe4jiMmAKkjn+8GI6IJBkxf0m35nBe
U58WqK3I+w4OGp8KMmxdiQ6txTZD1vdzY4NDEozZsTZJmo/rh9mMvxB7NJoBF21U
x4SLM8NYa9ckNuaOQ1ULCz4wed86izjF9GzaWrjQaRLhWZOImC8RyPWh4ZDRC77y
nWnvF8w75CI+zHEShdqyxSJ+YNDWPSZ5cxCoHbaKrOt+WARuNZZ3PZ3iw5zIFltD
5u0ndEI1av+T9I0H9Gb/OgACjMw9TTBpjcZ1C2I3qclqm/IUBUnufr9CRGs9fjk5
jHj6hei7MkZJ/6Pzy44B2/uH+vjKdX7n1w8Vh11JUtHpEH+JZEhnxIcP5BXsw+27
WqvY5vf3BBWqWJbCFUM9ah3oPJUykcXhEnAFgf2OTtsOhO998ZTTjYP48KtXEN7g
f5zFir4pHd+X9xSNdkaM
=vqif
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--

--===============4942373390365467268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4942373390365467268==--
