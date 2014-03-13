From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 08/12] ASoC: snappercl15: Convert to
 table based DAPM setup
Date: Thu, 13 Mar 2014 09:38:47 +0000
Message-ID: <20140313093847.GE366@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1409356125845757039=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6D32652AC
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 10:39:18 +0100 (CET)
In-Reply-To: <1394634460-15889-9-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1409356125845757039==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:36PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes.  This on one hand
> makes the code a bit shorter and cleaner and on the other hand the board level
> DAPM elements get registered in the card's DAPM context rather than in the
> CODEC's DAPM context.

Applied, thanks.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIXykAAoJELSic+t+oim9jgIP/jdL2L50LJzIMqJc8iuqMu65
LuiumFO5AzqyjW4V+I6CC3z9QPYSSZbeQmIGKmg+l01J32wWnv1EaAnq+u+VwDf5
Gd5BjPK99Vjm7oX/VuJQgJ2Cu9pzSAeAg9TJQgYdv14bUcDa89s+ZfhbZ0rQylKL
lEPzmvJiHWbpChTSQQzz1J2gx82XdtpY1QK8jbbuBTlDsvaqyPsjmx6UV0ncs/XW
6/AGaLZ2zn6m/nTkq6ksujaMRvl+bH0Hw+sLAwggprt8LYeSWMbN6QCPE5hz3gFP
L7ZuUone2+Cb/6W5uL71xW6p+VlJv6qGjg5+2DQdbt6p5ep/gRpHX10vZOP1k9Ki
1jG2q8aBl6ie0Agl/s0+L8NL7Dl34qWkF+ySe8O09aPMF3vS2aCCUMcIno3AkUv/
x7j39tkTFQiZf3jty/lv3MCrw+suQCLc8NApGyseiGwQnt3xEpxDj67xcMbuZJp2
Q6R1If6iSCw1iT2In1AqUuh4SaI8i0i8vknKhovEMsELjaHhDzOLh3dE/QRw93YM
207Vp8rXb2+cUO9MXnLjMrMDWrcYyZIAFxMjwNmEI9QSLwBcLenJUb2lJlMBi1WC
AToZe8gZhSYHfg8ugLEw7ZxKgAUTw4R1RGTflFBhDZ3aZ8RKTZRdYMeepMD38aZo
Y59R1Mmn2Vs5WAilpDOQ
=Ljgb
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

--===============1409356125845757039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1409356125845757039==--
