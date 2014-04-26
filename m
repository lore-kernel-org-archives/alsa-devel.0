From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove name_prefix unset during DAI
 link init hack again
Date: Sat, 26 Apr 2014 17:55:48 +0100
Message-ID: <20140426165548.GU12304@sirena.org.uk>
References: <1398510149-24032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7238314516837730513=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B4E26162E
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 18:56:08 +0200 (CEST)
In-Reply-To: <1398510149-24032-1-git-send-email-lars@metafoo.de>
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
Cc: Fabien Parent <fparent@baylibre.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7238314516837730513==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z3jfSNvuACVJDaDR"
Content-Disposition: inline


--Z3jfSNvuACVJDaDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 26, 2014 at 01:02:29PM +0200, Lars-Peter Clausen wrote:
> This was initially removed in commit 6479f15ad ("ASoC: Remove name_prefix unset
> during DAI link init hack"), but was brought back in commit 503ae5e0 ("ASoC:
> core: Add helpers for dai link and aux dev init") by accident. This patch
> removes it again.

Applied, thanks.

--Z3jfSNvuACVJDaDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTW+URAAoJELSic+t+oim9ol4P/0gccTBRBxe86TqHfEF29LaY
4V7D0A4cWHqHfOndb+OlyTNOEePEJon0wZVNcAThDTnh9hxL5aX+s4WEa56p8QU3
XxN9kd4dfa3JOVHyw7bHZXxQ9Sn35ts6f0Z+h5HmSEBJin27MOaWz7ekyDCb2PAF
vgZhYjFNM8pQ6tzk536qO88F4vW2F60g6uLWV2pqzOO1SlsUlRX4YyYyBs3GmoUS
BiLDRFyB/4Be05kvt4J0oWBxskfhecQeS8/Fe43afVUsy7s+JaxUa4Qb6/oQi8Td
yMR+ukbHQJGAuQmUaef4/fBET3AMjhPtfYLBOKAAUGF9jiuISm0ppQULMsNW+JRY
7EUAA5TbigWizwy2i56IG1J5ZpqCFuGFhAYKXA7UB13EUM2Vv0Ds+IEWSbYdPJJ7
zcz9gz+hvSLv7/7VT651wO8Rytjko5jWNPhrcGszuUr+cZxE1eJOKhNVxDcRUYQ7
ZEkIY2tapL1OS3WSaTK+KgM2DPeG3ZtfyWb7Jy6vQZkN+1dubLysybKcNJEXtg6S
LA+WSwTDPjmK71kpHEeBafaT0A2dS9dnByP86VnJ/tekX9o/YpuNwyRu2Iz2TuzW
eDIes9fXWKO+psy6nuO14ohG0QDakOQJesE+RtdlukEACeKN32llgieV08ehnDkG
sC6r8O5v6D8XQzo3Chz5
=Ir06
-----END PGP SIGNATURE-----

--Z3jfSNvuACVJDaDR--

--===============7238314516837730513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7238314516837730513==--
