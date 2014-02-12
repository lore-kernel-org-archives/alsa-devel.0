From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: Fix machine driver Kconfig
	dependencies
Date: Wed, 12 Feb 2014 16:18:12 +0000
Message-ID: <20140212161812.GD28112@sirena.org.uk>
References: <1392221482-16559-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7209449788460804627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ECFE265063
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 17:18:20 +0100 (CET)
In-Reply-To: <1392221482-16559-1-git-send-email-lars@metafoo.de>
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


--===============7209449788460804627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qN286NIOm1dtEdh0"
Content-Disposition: inline


--qN286NIOm1dtEdh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 05:11:22PM +0100, Lars-Peter Clausen wrote:
> Since the machine driver selects the CODEC driver we need to make sure that the
> machine driver is only selectable if the CODEC driver can be build. This avoids
> build errors under some configurations (which typically only result from
> randconfig).

Applied, thanks.

--qN286NIOm1dtEdh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+57AAAoJELSic+t+oim98S0P/1jujWZ/4DjxrxvIZvlhm7kW
0Kx7yIgqiE4YFFoLR+9zoXhpxUgczc2YU5I1h/2kJF51+eLxxAzf6g1gyspsl13k
bB13XihLJmT6RZCwQSgWlXe3XeLRz6RIs/l//+CqC0JRnEPYWhRVqwMTTEB3cXli
1tqStEJqSVqrxdUb7gtHBfUhs299EbZoZ+YDE6sJU6vbOjZ2VnKNR/3To1YV1jg5
2TrjNzn/34LL6su8CZeJdxmLcPaN4aatUgI0EsKws1HHeFDjf5T5DQeiaia8B8Sk
ow8GejPKGkKwv1A3w/SOAign7C3UlmcTq9voxVPBgBZqsCIhteDvYDzWER3f80om
+nIKFZM0idznuNOovAOhUluPcdubMn3C2aZ/T10DXBZ0FjD3aPQHPgRuwPFIWHTa
iN7YLei6FPyBq7V+b5n1gF3CcQJqQTZFax7NINT0IhzTt4HpKj/Au1ozZYkCZnqm
Gt5sdNUSuzrwSiSetVf1h19Bsmsuffi37WKjLp5UyWXu4Tz5pxijXWn3QocitRKN
AvrpURFzcEluHIOgyWm30CM3PwUndyIM27e3QPhkdzNtdYPq+uPexL2wh0WEMvGa
vodME8WqxBoPjQVfDPuL5D/H75f+OUY+iwzPf/MO50rqurwoBx4D7TLU3eLQXYvv
1ppjUoHJk4EemG+7Rgnx
=vBSN
-----END PGP SIGNATURE-----

--qN286NIOm1dtEdh0--

--===============7209449788460804627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7209449788460804627==--
