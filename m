From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: omap: Use common DAI DMA data
Date: Wed, 3 Apr 2013 18:08:39 +0100
Message-ID: <20130403170839.GG11305@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7508954144885972241=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 875F9265DE3
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 19:08:41 +0200 (CEST)
In-Reply-To: <1364979965-15776-4-git-send-email-lars@metafoo.de>
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


--===============7508954144885972241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:06:05AM +0200, Lars-Peter Clausen wrote:
> Use the common DAI DMA data struct for omap, this allows us to use the common
> helper function to configure the DMA slave config based on the DAI DMA data.

Applied, thanks.

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXGIQAAoJELSic+t+oim9QG8P/2pVrpEFizyTiiEAEJqmG4YD
TkyXKxV9q8CLhw+yXp/t3VBAEGrtxdHfRpKb08H8sdbM2WEBMw2g3+eHVp6AdqzW
HjrabiAXFb4B6xC/mJXG5qeMLlz+X2JysFkz+2Mjtfs4p9EczIRmkizZWP9dAbhO
7CRMURAf4jv5iLN9isT8SQValzEnS9r4avpyD5AourBuNev5eTfBJMHhVuq3w7EL
wbQu+m2bAWJywDtHbD2hJbadtKz0zd5Quoerx/5iVNZT/9t6ONkS1zXXSVimqUMD
NmaI5Y5oZT+Z6tkonjXVtrHE+zYq0QxzXalfcsdzBYto/3eGBEr/5Yu8qSA3/ykz
4BbqIZ/U0Q5h4TY9A/l2TUEtoo48JQsHhn+zbCHEtO5PrEblk4tbB+GdkmljBLfc
oRogqf891tIRdGqXfGAJLbq3C4vfnR1dHSI0o5aN648kpqRIGirsJvsTdh7cUO4y
7IZI9Vk/7QukPraX0hrN/ygAVGqwQDOPMBg3F3jGYMhh0QgcUJaakOm+PGAZCrIJ
ekluEQhaBWHXP2W0dYadLWQnDCqV1j6pQ/TXrmeK6FzacsL3ZNsHnNv3Jf9xwAAM
nLW6yx2yeVvuo0VUAyVvGHUbgaY/Tb3trXkFp51E7VYS79KdP1+OEzFqDMbllbfQ
uBp5G+TBLJ9vvhKgoWqC
=tDGo
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--

--===============7508954144885972241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7508954144885972241==--
