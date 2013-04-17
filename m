From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/17] ASoC: Add snd_soc_{add,
 remove}_platform
Date: Wed, 17 Apr 2013 14:20:40 +0100
Message-ID: <20130417132040.GE13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5083829905987469320=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F2CF26164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:20:42 +0200 (CEST)
In-Reply-To: <1366046404-8759-3-git-send-email-lars@metafoo.de>
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


--===============5083829905987469320==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:19:49PM +0200, Lars-Peter Clausen wrote:
> snd_soc_{add,remove}_platform are similar to snd_soc_register_platform and
> snd_soc_unregister_platform with the difference that they won't allocate and
> free the snd_soc_platform structure.

Applied, thanks.  Seems like we're going to get a bit of refactoring
still but I'd rather get this in for the merge window.

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqGhAAoJELSic+t+oim9t7MP/2Lq4liZnW9idB8LsBtCMN//
iz6GjN8HzsXxkSJR4OahiHTVQi8kHPGr/0ftbxJl3x53H+ai35Y49WKW/a7BW7QD
7E84X4l/e3bpbracWU1Nc25laMoIqSb6xKR4tRcHZzBcnVkx1e4DmajSYLqWlr+j
Lr/i3ozycjoBtbZCBYsf/VzUVaNe0ElaHM6oQ3+WyC+Ium8SiBWiLZ2h5iyHzYar
XNfMRy0D0GcECjksISnfNhcLAgbZAvZloqhS9QmkWwZG7VlMyFxkcFJgubdkN4fv
wNcC2JPNiE5FUD/YaBcOeI1wK8Luj2hylwZL1MU544vBMMOn7naoV62ipmPr33Xy
oyb+1UvCoFYLeHDOQCSrp8LFhwFxS5dpUMZqdYXv65L6Omn9TeJ/9vnoANiysF5b
Zm8yRQr0FSe98cKOR0ESqNn/wqOeIKUxbvetiuQZ6Tq4xVGOD55Y4CmyB3XjuLlY
Y97ap1Id29n7izbw9NkqbDt7ruF6qIVXNu7t3D0mZlPzwObL5E+7w4cbCW/sAxvh
Fr2A4u5jWChstWQV6sein3Ph3q5WfzCmrDlfv9TDKlyUZIZk42qqyZp29epDga84
GOs8TUFgldn9DOLwzkLxldlO+x4JDZQHZiQCPiYsKfpQZzBgt/Yc+ypk5y8+G/M2
RGArv/9mOd3emTHMdYFJ
=QnzJ
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--

--===============5083829905987469320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5083829905987469320==--
