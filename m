From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] ASoC: dmaengine-pcm: Add a common DAI
	DMA data struct
Date: Wed, 3 Apr 2013 18:08:18 +0100
Message-ID: <20130403170818.GF11305@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7747452250319580947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA8A7265D08
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 19:08:19 +0200 (CEST)
In-Reply-To: <1364979965-15776-1-git-send-email-lars@metafoo.de>
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


--===============7747452250319580947==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:06:02AM +0200, Lars-Peter Clausen wrote:
> This patch adds a common DMA data struct which can be used by DAI drivers to
> communicate their DMA configuration requirements to the DMA pcm driver.  Having
> a common data structure for this allows us to implement common functions on top
> of them, which can be used by multiple platforms.

Applied, thanks.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXGH1AAoJELSic+t+oim99mYP/jjCyBbtByzZpAtVXccYSfZu
Fz7MJ7tNiiQiutyhdedDVejRchEO6T7/uzdC9P+6k+gLfYMUvGUtHNDtnPLYiJZt
mPcRhB1vKKwR0P8Hxu8aOq74nhLfFKmiRo2i7BobiYQhyUZ1M7T+OKpeZGdH4IxX
Sg8vd9gh7qCCD+ruMItAJPGNB9Px0TJ2yTEzL7m2kgydylbdBq0nl8FiN8Pwztv5
d2e6wtCvbXcR7Z0Ipotz7JwRpPrVmIOHsdoek+SU0txMPkz+SkedCy7YlhadH1fB
JaeIADM615ohOHPO/IbkAcLIMVSjiVhKMGGnlaVdp/CALpcJ6Sp3Se1xz26pAb+/
A9RcZ5Ow70SfR0pYLpISa6RCBhK14iY04pavhKVFpDcuoC+j4YSbq/xkX0PRwdKG
kOjE4nerlEj7YHnTvQDJq+TRnyjK+5iEBzvNVIIreat5YCsI091MuCKQH4cs39wc
sYU/E6kKEU+F0nTiqrDXI8esNa+6tpUAHFfhSqR4WZ1xIm7dbW7e6ModIHEvBE2j
xzDMVMhUFC3YcviYiILixUvo43Jd1JW72k3gdgWVwyfDoL1dhN6nsGxgntrW1f/P
T/zhR0YZTmHqtwXT3waXkIP6iDqF73mk+1iRVIC5VNwEd6bdIPmuLo6SGAz/Gdhx
hITZpEFnbyN7m093js3C
=aKz5
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--

--===============7747452250319580947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7747452250319580947==--
