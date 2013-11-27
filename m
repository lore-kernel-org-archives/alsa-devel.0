From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: soc_pcm_init_runtime_hw: Fix
 rate_max calculation
Date: Wed, 27 Nov 2013 16:42:21 +0000
Message-ID: <20131127164221.GI14725@sirena.org.uk>
References: <1385542698-13362-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7742097703049211366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B2DF2264F23
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 17:42:25 +0100 (CET)
In-Reply-To: <1385542698-13362-1-git-send-email-lars@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7742097703049211366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l7s6Pb57gD/AGupR"
Content-Disposition: inline


--l7s6Pb57gD/AGupR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 09:58:17AM +0100, Lars-Peter Clausen wrote:
> In order to make sure that the sample rate is in the supported range of both
> components the maximum rate of the card should be the minimum of the maximum
> rate of each components. There is one special case to consider though, if
> max_rate is set to 0 this means there is no maximum specified, so use
> min_not_zero() macro which will give use the desired result.

Applied, thanks.

--l7s6Pb57gD/AGupR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSliDqAAoJELSic+t+oim913kP/2CK10/XoQjnS/oaRtW258tL
2JjK+iP0pZf8dcUxrZeyf0Wcfu59weVeKuXveVqmY7xGkHBTpGtLLAwKT/VNZWwh
SbOG3GzI7l0irJM/Dkq1l9Upb9BX/dvDdjzMuWTysIuQt6aHfxxl62TwZ/Vw6YWU
BcumrcprxqiFjVJ15rTPmrd86MZgM4Z27F7vv1I+CHWi2yfJTiCe9XAjXiaxnT2u
4z7BSw5MfwNF4gkTpjYKbwYAW06HiM1gTw2NXagjqQbU3JYA8eY+SlRW2yH2BuJW
C/p3nSTio7RvwjTrz2yVuWiOtyBzObzlWow3Q+Vy/3TKNald+V9AAVitLyTmAtKH
Q/GelZE5Av0s5kLFGRjAp7qi8Pw4epMS6lZXY+IbEhzaIswskAyCIE4YGMLE+Et9
MzTW4W9aux2KSo8zCHKi+1k+MVzAvlLd15LBP9AetO4wUY3c3anrtqWpHKhFlYIF
VxJ5wck0pPJC6eFm3jAn5WIzNTsScloC6Mc+Te0Nuw6JczNYyZfUUf+1/uA/Viju
+i1aBVRrQUyI1PrPQCC7W+x6rpb6CAUhn1c+6yS1u3iVCgpJctEkWrYsy9RyhXi+
E6LhfWsHU21vZh/2TJn3Qr3YhTNjydKK57prVd1A0GxhDxyzge239MZuUr1aQvO9
9f+tEaSsjoJwYOgvvPsV
=1MbN
-----END PGP SIGNATURE-----

--l7s6Pb57gD/AGupR--

--===============7742097703049211366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7742097703049211366==--
