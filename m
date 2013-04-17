From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
 driver
Date: Wed, 17 Apr 2013 14:21:17 +0100
Message-ID: <20130417132117.GF13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8777140180944718494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B791D261681
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:21:19 +0200 (CEST)
In-Reply-To: <1366046404-8759-4-git-send-email-lars@metafoo.de>
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


--===============8777140180944718494==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:19:50PM +0200, Lars-Peter Clausen wrote:
> This patch adds a generic dmaengine PCM driver. It builds on top of the
> dmaengine PCM library and adds the missing pieces like DMA channel management,
> buffer management and channel configuration. It will be able to replace the
> majority of the existing platform specific dmaengine based PCM drivers.
> Devicetree is used to map the DMA channels to the PCM device.

Applied, thanks - seems like it'll need some more work but let's make
the merge window...

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqHGAAoJELSic+t+oim9+HcP/RdPyyU8/vRtSJWXz8p4DrUN
cXr+VjJ5naHmzrk3sRxhwTL0bGdMSDQ5teLxITTB1ZZ1yRF8iir9Kep38W1Z+RCE
LAhLAgN9kd7w/zMpi+11H9PgQxsh4Un/F5qOx1zIDJCq0iDBpAZWrEpLLtgrIIDk
jg3qzF2lo8ExqJZNzXLtxx8gT3Se+hIlGkGGBteaxtSWd4TBAcJoQkAGzA+KX55W
d7/aTOW0CCOGkeCeEfJvklOgtsAzV1gfSnsF7SnVztqyP1nFlBkmnjad3PAJprhs
iozqbLRIG/s32ZGRAjNPDv8n8+hSdyeGmOVwj13e4N9bYb8DoqNDfrIfRU5tKa9S
tWXqBXp2a37C3DF9+GVmQmxaF4JvBoiO2JEc7csUHu5ee/s1J487TNKYpYWGCdTP
XVZ2WCsccL9Im/QezzBnykKzUayWNqS2Oa3iAD7cQ0TyIH8p/8fyAEKJJCH3i1ZN
d8EKHRWwA40nZHJp0a+RNZZPkPKLuA1Hs4tDFA17YmXvMF231WWa87mTc+FDvzeI
DyAbNSGJgykCBFM5HHQnEzEsSwwjikqsPQ0eivIOf+X5tEbwZJDnCWo4SWgXzMI9
sqzUFxHk7wuEiuCa9mhY3CSpmrl38gyAFwE0eFsu20SwnjAix5JcdB9APXCp+hAk
NmIme5osPPFtWmz3FYUo
=2Cie
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--

--===============8777140180944718494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8777140180944718494==--
