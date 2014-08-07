From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: enable SRC setting via DT
Date: Thu, 7 Aug 2014 16:05:14 +0100
Message-ID: <20140807150514.GK17528@sirena.org.uk>
References: <87oawzum8z.wl%kuninori.morimoto.gx@gmail.com>
 <20140711123026.GK30458@sirena.org.uk>
 <87oaws1rhm.wl%kuninori.morimoto.gx@renesas.com>
 <877g32gpgu.wl%kuninori.morimoto.gx@gmail.com>
 <20140729182816.GC17528@sirena.org.uk>
 <87oavz1gb3.wl%kuninori.morimoto.gx@gmail.com>
 <20140806202432.GP17528@sirena.org.uk>
 <874mxpkq2y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0979991031772705033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D8C52650E4
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 17:05:21 +0200 (CEST)
In-Reply-To: <874mxpkq2y.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0979991031772705033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZutuIa7cvbRnFdec"
Content-Disposition: inline


--ZutuIa7cvbRnFdec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 07:10:00PM -0700, Kuninori Morimoto wrote:

> Fortunately (?) these blocks are controlled
> in rsnd driver as 1 CPU today.
> So, I can say we can use it as

>     FE : CPU(*) <-> dummy
>     BE : dummy  <-> codec

>    (*) CPU includes SSI/SRC/CMD/DVC in rsnd driver

> This is simple enough and good 1st step for DPCM support.
> I think our IP block needed these step

>    1. simple DPCM support on DT
>    2. sampling rate convert support on DPCM
>    3. multi FE/BE support on DT
>    4. rsnd multi block IP use multi DPCM

> or (1 + 3) -> 2 -> 4 order
> How about this plan ?

That sounds like it's moving in the right direction - it's always going
to be possible to go round again and expand the code in the future if it
turns out that more is needed.

--ZutuIa7cvbRnFdec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT45WnAAoJELSic+t+oim9WiMP/j7fsMx9dkCX+J7L4yWY+7Iw
TpeXwV4RhoYs4VAgwcKcEFh7S142N6No0XpWoY9fA+qJa4Pq+tM03XjA+vFApOC+
29fncq2nqsBIBEyH5fNxEirZwT2ycuWMJw4bxlXwOb921iYpzXHASxwiVnCENjBv
BMio+rr/IGMGhjcKTtnhZEuca//UEqNFK5xExZEYmW0gUCsWRcGFvFtacgwryxPw
HgL8GzBJjlOtOaD/mA8PtizCYEpVDegQ0OaUKBAlMA5qFuwU1UhDikc8nqdNhIpX
eYSSZ6e8j2sMwS9/sBd42lJtX/YcUuElJiFbRRsRjNaZPFCQhPPlX6mbEZbNSFGc
JaWfF1DqhmpuLIq5mbWGuymzdxzY0K9Bpb9MbyryuZlUmCNU0vDPR/Nf642oecr5
odLSgDpoHOPaVa+jpcuCsuO7wRtqluSAPLYD83/pN6vjlinKLh6UUEEY8jWxM6Ol
QDmDdmanMIM39PH7rRR38nxeF2CJKv6/Q5giUdhfgwxTAMfdxgCthVYyElOBSBCY
WPf+A1R6WK8jYPZ/USXPkGpyfeGUF6MKLI7f1rY+0wI48srSQaD97NY/QpOgTtCT
Qowi4O0Doz30zPDiA/ooMw2lX29BYY9pg71AtItNJwvo0hrKFcY1vXcumD5OCJ/Z
ScBqsoNZue0sSrxxNj3j
=V72P
-----END PGP SIGNATURE-----

--ZutuIa7cvbRnFdec--

--===============0979991031772705033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0979991031772705033==--
