From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5102: Remove set of volume update
 bits for output 3R
Date: Mon, 6 Apr 2015 17:12:52 +0100
Message-ID: <20150406161252.GI6023@sirena.org.uk>
References: <1428082112-2390-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3315772576565138856=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11CB1260429
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 18:13:01 +0200 (CEST)
In-Reply-To: <1428082112-2390-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3315772576565138856==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p14GW7TY4DvKqgVo"
Content-Disposition: inline


--p14GW7TY4DvKqgVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 06:28:32PM +0100, Charles Keepax wrote:
> The earpiece on wm5102 is mono, thus there is no output 3R. Don't toggle
> the volume update bits for this output, although worth noting that doing
> so had no negative effects it is just redundant.

Applied, thanks.

--p14GW7TY4DvKqgVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIrCDAAoJECTWi3JdVIfQmbEH/066cC5yIaVxYt+LUzM8ir9/
LWZJ7TULiOPEOh/Lg/BDfksz3kUw0P2RKDHoMZVJzTqkWoArCvzHY9addAiRivYH
oVj7ZDYFM+d+zRfrCV/SyKv3teu/p+/A8GeBnZH58eZQVo3+4qWXH2F1KUdBJX4n
rjYSafoz6FqiMD/3pmZcr8w5rtR2ak5bcTh9dwdORQeRHd1A+11uypDOovCveER7
NRUyVcn/ogshtYFoaK2MylW1ffjBUbe1ALWKTF0BOU2RfYSlBLfIjH04JvO4WLuU
67xa8KQjHMCd3taHtZ5hCSYWMWlyuVxW3mKOu09JqDZcl9ojbmJRwY8gCX1myFY=
=Nhdn
-----END PGP SIGNATURE-----

--p14GW7TY4DvKqgVo--

--===============3315772576565138856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3315772576565138856==--
