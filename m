From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Wed, 24 Jul 2013 01:10:27 +0100
Message-ID: <20130724001027.GV9858@sirena.org.uk>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
 <1374583782.2475.26.camel@loki>
 <20130723173646.GL9858@sirena.org.uk> <51EEC3FB.9050701@metafoo.de>
 <20130723193204.GQ9858@sirena.org.uk> <51EEDDEE.9030701@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0178527723484142498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DBB82651E5
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 02:10:37 +0200 (CEST)
In-Reply-To: <51EEDDEE.9030701@metafoo.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0178527723484142498==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kgRJX/VMeJk3ygiz"
Content-Disposition: inline


--kgRJX/VMeJk3ygiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 09:47:58PM +0200, Lars-Peter Clausen wrote:
> On 07/23/2013 09:32 PM, Mark Brown wrote:

> >Right, though my thought looking at the code was that the intention was
> >to also do a transition so that dapm->card isn't there any more.

> In a sense the dapm context is like a common base class to both
> platforms and codecs. So it's probably better to remove 'card' from

Yeah, I don't immediately see a way to go with the cleanup - that was
just my reading of why you might want to push things in that direction.

--kgRJX/VMeJk3ygiz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7xtwAAoJELSic+t+oim9mAUP/R9/8P6/MM3fvh0CtDIVOO87
fUCCiE9wfPtBX+TRQZqRnNDNfwUMpAlwjwN7v6BYiYcC5AKcLwovKuo1HSg54NZ9
eRjVqpksKDkMSdZuNx/uRyXltavm666jDMGgVrboToQ8RDqb/dDMBN7BOha7FT69
v5zuHYDpE49u7lloZZWRUuyOa4kf4mugsiCrGjZZeYTwh0OWh/UmfmPySFbinTQN
QWrbpXTo9r9b0+R7nyIH1KkOclCuowPlV13Y3/UMKqWHmmPf4NbLwSTolm/zdsSq
JEWR5mL6bAuV6AW5pSl4iFk6vYYOQ50AuL+DlapTAZk4fFQiirmFtbkvOmIh8Ibs
XNxp5JAOFUj0W4jV02YVnFJQuaQoAs1tLVG1ptXgrp4o4jlXPvl13epkxmovCPK7
x0IYh6iOTdAFmFn6l96fvwYhCqt+j0tLPTwsi2mjx3yn8XyiP2xSMvJUhUr4lj8/
ZZvSyIyXH5wDSW/hWCswfEmYVqjmRoQzV6J6CVGSmhsR8sN0BhD9DbR0OkiNd/Ur
phjLFoFnukF5APouQhco5+mf+9nrLeyxQ3hvqGBCWIc82Hfh3klyJcp0sy9gP41j
Bv3kLBebsD+c/oz9V8TNxECwjc3KrfHGBMfAQopGq3muvWQZ7Xh6QopCdr3jiOOx
bUChzzvpWhSJC/Qz7W7Q
=yRG4
-----END PGP SIGNATURE-----

--kgRJX/VMeJk3ygiz--

--===============0178527723484142498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0178527723484142498==--
