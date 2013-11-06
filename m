From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 30/31] ASoC: Replace BUG() with snd_BUG()
Date: Wed, 6 Nov 2013 09:39:47 +0000
Message-ID: <20131106093947.GD11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-31-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3887797654787888875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B27A2610A1
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 10:39:52 +0100 (CET)
In-Reply-To: <1383673218-18405-31-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3887797654787888875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:17PM +0100, Takashi Iwai wrote:
> BUG() used in the driver is just to spit the stack trace on buggy
> points, not really needed to stop the whole operation.  For that
> purpose, it'd be more convenient to use snd_BUG() instead.

snd_BUG() doesn't look like it's quite doing what was desired here -
it's conditional on SND_DEBUG but these are all for really bad problems
which should never happen and will generally cause serious problems if
they don't happen.  It seems better to replace them (or at least most of
them) with the direct WARN() instead.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeg5gAAoJELSic+t+oim9aG8P/AgPafInVkqkRrlMeEyyLI99
jwOuzHMfzxQK50pKwXiNMxpK7Po11smiXO0fdxRu+8xe1XFJ+21TQQlhANv3EbZ3
m4SPtXiMg2TyegGWVekBwcRRTz+rsRp0YtnZzRbSyqLEmBUzDdZdzbYa1T9KDzsZ
ftZmDIXO/4DJ8KrZTY/mVCIwvOOCtkY3W+hexpR+iNSGzwhe0ZgkilStNBa94mvJ
WexSM7MYtvcQLsjWfn24AOOaznqGChdqnCPlKymvybpOkS9cKuuI8088KyVom3xw
X1QSn3MYx5EYsnrXkhsFOVkOHqfyUUNlAh7YSVZxARSrZOptsi7kIMr5tWTBY3KE
Gq0vC5wZfuBWMHMPNi82D+Ur8jzQV/UKEsUApDdr5LUOdtOgwiu7+KZddgKKlj18
gLnujF5RU7XHxQ+NQ8zsNTIJcgzve+OsQBteXcPawtUoFr2tr5vvdvHNlCxv5yga
GXwaxmCV523GT6HkBhMacM472xgUhDhxDpdLtdzGVhebwoLtjf86Anm9tg5Qy5lN
PiB8RgAAUoxdaRO+yfcO7M/vjqHaVR/07vosiGiLC6YdqAz9g1V3fjX2pVxPK4Hy
+LsKPuuHNn8xrJKS88g3aR6STVaYxCHuH4J40+e1i/W9wwzq5yIeh7T3cOoamLYR
o46E4mgjCMMAL5/c2wSX
=p6t6
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--

--===============3887797654787888875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3887797654787888875==--
