From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Fix build warning when
 CONFIG_PM_RUNTIME is not set
Date: Thu, 2 May 2013 10:00:32 +0100
Message-ID: <20130502090032.GC28791@sirena.org.uk>
References: <1367481658.13357.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6459294164804942557=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AE2822651A1
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 11:00:43 +0200 (CEST)
In-Reply-To: <1367481658.13357.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6459294164804942557==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2013 at 04:00:58PM +0800, Axel Lin wrote:
> Fix below build warning when CONFIG_PM_RUNTIME is not set.
>=20
>   CC [M]  sound/soc/codecs/max98090.o
> sound/soc/codecs/max98090.c:2339:12: warning: 'max98090_runtime_resume' d=
efined but not used [-Wunused-function]
> sound/soc/codecs/max98090.c:2350:12: warning: 'max98090_runtime_suspend' =
defined but not used [-Wunused-function]

Applied, thanks.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgistAAoJELSic+t+oim905MP/3AkxTHMG9eM71oxgKm5+CBr
AKeL3R1J/4HwX0kTMLbRLm8anUFaTl1UYkunvBeR9GJMJTbYJl36pBwrYdTlIc5E
5eWUlx6RxPoa+BMxEYla+wJz2Ka33BqsJLHs6Ysakf7vuW0eebR4//J05sF2Sy+5
f8f51U4Ti11d1BQ1CYqqxY31qqZD1khQSEDHKcHnQ/L56jHx1Xwe0G95b8/Ml+7Y
H8CYrnECkzwoBoAGZuORvwdgjEYxUUZf57BLAPbvBh/QX2jddkcx4nmQelwE/a5r
zGDRbXeufsPWgfqctziQ+Gm2qHZqScpaKjE2WM4W3XNIPo0okHgBOhPepWNNUgaR
7LCqsgGHnUwjafgOn87m7Ms/9606nDFAnAufmUGKSYPaGQLSDrKaRFg8rnQ/LP/n
jFnirf2hqfp6HJr46LpVwvZOM47S/NFR5NE3FRMde78uYFDNK0lkbSgQvEpeVAaP
RRhIZKXSWTT0Taeh+3rfM9bFY+n5BFefouFunfrbXvqPaCzm5b9VC+r7IVp2hf/K
NOIqeHJh9W1AzQquqVvh7UOy1hSbeSfQj+2lqLsgygVELTAmY3xJInzovy/Zh6AT
NDCELYiej0374ig4j0Tu4BgN2a74xaVe2fLv5mmcMq3CCRnVupanDWU4rsK3y8DR
vk0koI94yuYMzA8oFbFO
=Q/1V
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============6459294164804942557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6459294164804942557==--
