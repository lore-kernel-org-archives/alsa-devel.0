From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: bf5xx-ac97: Fix compile error
Date: Tue, 30 Jul 2013 12:51:36 +0100
Message-ID: <20130730115136.GS9858@sirena.org.uk>
References: <1375184050-21514-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1182503046619405154=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 15CCE260729
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:51:38 +0200 (CEST)
In-Reply-To: <1375184050-21514-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1182503046619405154==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4A+5qYZ+/KToxHVl"
Content-Disposition: inline


--4A+5qYZ+/KToxHVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 01:34:09PM +0200, Lars-Peter Clausen wrote:
> If CONFIG_SND_BF5XX_HAVE_COLD_RESET is enabled building the blackfin ac97 driver
> fails with the following compile error:

Applied, thanks.

--4A+5qYZ+/KToxHVl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96jEAAoJELSic+t+oim98ncP/2Xt+UrIPEZIVk/i1wFOfc0m
t0amBF8ys8HkozTMuGwJWap/70q3xz2mTAntgfInJ70ZUB2PvafZjFaBrH+Hegpt
vUwP0hal69BPguILQFpaYwkH2Ie3EjDwLNtofrhAA7eK9gPwFEeEDFqrMhT/ECsu
L2VPwgDZl1uwkZWyMuKh7C5LJaMLGjmPPIpC4DEDVjttyXwmtqpIibfuRa7+TRB9
6ybQUhNul90sgjcTVj3CpapgfkZvO3D/S/m+du61frq9JKZY97oOim1Hy72nF+I7
hwhrzV6yxJlNneBzEQZiHLMXvGArl7rNszIl4Vu9Bp0WDlbpyg/GtEHQystZ7iml
PnFYqGKSod+/RDGRNNvGdAbcaJoQmNrPx0mDedV3ngxcUk7NJFxYkzorVwMCz3p8
+Zl6W3pq0spQNVE2Q4ISbiXhGO6uaJ9uly42hmt2w+kSLBJ4h7i3bhA/ZX0u86GM
ETCKPqR2uesc7QUr64LDfJ8zpBQfOCEUYnn87WIuvg5tJbkATfF3qHt35MsUBtf9
CoFlF/25+thDIX7eEP7bbo5nbpPk6WJA65kOV/4XUGezim9oE8TT9UtERcTM5Mjv
lMZjfFIneolQ5xHMjqWEfSRD+BFs/EvNnRtRKQwZPOJzlEWO+5PF68MeO9UTQdVY
lf70RWIlM3nMkoMWkWT3
=eUyj
-----END PGP SIGNATURE-----

--4A+5qYZ+/KToxHVl--

--===============1182503046619405154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1182503046619405154==--
