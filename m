From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] ASoC: tegra: Use common DAI DMA data
	struct
Date: Wed, 3 Apr 2013 18:14:13 +0100
Message-ID: <20130403171413.GH11305@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-1-git-send-email-lars@metafoo.de>
 <1364979965-15776-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4707645885373679311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7DCA265DE2
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 19:14:16 +0200 (CEST)
In-Reply-To: <1364979965-15776-2-git-send-email-lars@metafoo.de>
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


--===============4707645885373679311==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:06:03AM +0200, Lars-Peter Clausen wrote:
> Use the common DAI DMA data struct for tegra, this allows us to use the common
> helper function to configure the DMA slave config based on the DAI DMA data.

Applied, thanks.

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXGNXAAoJELSic+t+oim9WTQP/RBmCzbrl3kyGMu2xRi2iPk9
JxfpWb/IhN3mRz9ZNWmFQw6h0YAEx4Id1VFjKeK5cHdWlKBzreNsIEzXDAI6lTbF
KnaIEO9Je/Vx7PRbSZumPEa8BBTRpISZtKbO8fmnQi9bI/vFl2QjsAjYWkIPX2f4
KVaISEc0+ZrdnF/z+HkKzKon4xv8hgspQackSCpGhcyX9CgnSCEFBNjcCzMUXu0H
px5o9+EfiThAIZyb5NRGqc+OPHbUSMjfjjCWJmwnmuD8SjtLDbhXLVgGKPsovFgT
lbp3SD/LIwmJ6PCqCZXtBI8NxGdnOYxNHsHipIg7kR2RC8Av0nU/B0T2WKe+gpkL
nYikyVHL35V9yl1OdxfL93cRjTsIcujjpAJx4QsG2venDLD2LtPLPWxN4CqdQaQQ
51HCk4Ncccn63EIOh3qEfCIuRhekTmZIltOGo2K+O8QHZqguRDsbmtJwXMhsR5cW
XXFiJ7Gs6bmH2Z1cyZJ5M1WwZl/QiZpbZ5H0DiKl0+TI/HA+3S2CfVYM1EsBHNv6
eaixGHl3RHGlxTH4O8fqBQrdIlokJ1qgGqF2KVtyKuOp2Oa0LZFvOsNBlsWtyfx3
+xxS93K/03NgW7cBG51npZjyejGtGEUaSStJjXG4zSW4jncRsDCKRFl90MBsyLRh
DIs/vy0XB9x4psVbxO0/
=qTE1
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--

--===============4707645885373679311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4707645885373679311==--
