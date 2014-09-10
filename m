From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: fix regression in clock
	rate lookup
Date: Wed, 10 Sep 2014 11:56:53 +0100
Message-ID: <20140910105653.GB7960@sirena.org.uk>
References: <42811667.3TM1iBfezH@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9189994361304948827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 120792619E3
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 12:57:15 +0200 (CEST)
In-Reply-To: <42811667.3TM1iBfezH@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============9189994361304948827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2014 at 01:14:05PM +0200, Arnd Bergmann wrote:
> Commit 7c7b9cf53d284f ("ASoC: simple-card: fixup cpu_dai_name
> clear case") changed the way that "sound-dai" properties are handled,
> which leads to the clock frequency not being picked up from the
> node that the phandle points to, as correctly identified by gcc
> with this warning:

Applied, thanks.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEC51AAoJECTWi3JdVIfQ3IAH/RQiHYbu53xmOtyMaWaRyy8J
V4s9T5P72gHz82IW8/8dx0EatrwpuMvR/nkxed5P9boUyGNA5PRSFxAAdpdl/Ksz
IjPm8kdXtzOrdH672KO9a64rsvzshUezpEDILOLK4azgNp3rrsjnyeFi9OJdubxz
YHZowOvnDhENhlSOuNvpik7lY6bBWmZjVZl6KEOcd9cAUEaYd3j0NwPeWrz2RnWZ
0cXiJuZKfiE4wZlyhJUe5idxEt+7GayNLAGEhpxQ5qZIg2ynBsR2Fx3FkQbC2bsr
qAA7RABdaxHET1nY4z/4dhqp+Af0YFBfM4pLXJojjwRMu2t5qPeCHKETaR9F3Sc=
=p88X
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

--===============9189994361304948827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9189994361304948827==--
