From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4 v2] ASoC: simple-card: use
	asoc_simple_xxx prefix
Date: Fri, 29 Aug 2014 12:49:46 +0100
Message-ID: <20140829114946.GR29327@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <8761hdia86.wl%kuninori.morimoto.gx@gmail.com>
 <874mwxia67.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6417070256405285584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EEEC62610AE
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 13:49:56 +0200 (CEST)
In-Reply-To: <874mwxia67.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6417070256405285584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vvRocJ6whMXXNc9q"
Content-Disposition: inline


--vvRocJ6whMXXNc9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 08:07:46PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> simple-card driver is using asoc_simple_xxx() prefix.
> simple_card_dai_link_of() should be
> asoc_simple_card_dai_link_of().

Applied, thanks.

--vvRocJ6whMXXNc9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAGjXAAoJELSic+t+oim9flYP/206DORaIjnncUsF+5EIfF/a
thEhUg0yvZUj+mOg39LZfl1VkHXL3jrzunUQXoqOz8mox+LqAHXGXTPAdmAVPwiP
QEW9VWX6TeWTN92vWRZhEzeSeXfudO9epu70l+UO6E1Lpj/jr+rUIzjDnkKgGtp0
/CnoSzjsQfVvO1lu48CEPHTHpJAVfkSG4nOkz5GqTDQEu2//Lp5L5cVrKfzC4zmz
DaGlq9ZFvOvWM5EsFn17jy8fQX4qthUHM2rLLsR/B8nE6LzvcqlR+9U8uIXykA0a
Z1xdSAtS5EssnL+jLAgErSJXn2Oh6CHKoPGL6/rLgClKXOl520zvbsvhryj3Sjtx
SnV/egcjJ/56iA1hDmhxQ/6S25FLO3iRlkgRg/+SJQ65iL7I5XDfYfahV45DZ0np
cjdFDe/5RJpfOI2OaL7yHQxRtFYT+iingRMcuspE7AK87Bcr0NY8DjfGIRrp9e7k
7EDoqP1ADFDn4tAWwbYylrHPn323pdKaF9cZ/Ot9a4RQINSOh0FTzLSUP6iivxYz
YDDczaHcBGVTjTpCbgQ46Gwvbf8SxGxOk/qAlF+shTqdFfJXuGOGfVJJk19/482K
sduAO6Y9LuZA3O1pRhwDBv8CGdOpjMs9wPCmrOltvfl1lXeQIjcIHff7xCciK0Nt
p9g+2N6RU7qEHHXaK49R
=BF26
-----END PGP SIGNATURE-----

--vvRocJ6whMXXNc9q--

--===============6417070256405285584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6417070256405285584==--
