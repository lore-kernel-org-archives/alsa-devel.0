From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Split firmware load into
	smaller chunks
Date: Wed, 12 Mar 2014 00:29:06 +0000
Message-ID: <20140312002906.GA4063@sirena.org.uk>
References: <1394029696-25975-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8670744779327763892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB6B1261ADB
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 01:29:15 +0100 (CET)
In-Reply-To: <1394029696-25975-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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


--===============8670744779327763892==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 02:28:16PM +0000, Charles Keepax wrote:
> The firmware files can be quite large and allocating the whole firmware
> a single DMA safe buffer can be problematic if the system is under a
> high memory load. Ease the requirements slightly by writing the firmware
> out in page sized chunks.

While looking at some other related stuff it occurred to me that while
this is probably what you want for your backported code for upstream you
probably want to just convert to vmalloc() - SPI will do DMA mappings in
page sized chunks in order to support this so you get a similar effect
but without needing to split into multiple physical writes so it can all
be pushed down into hardware for best performance.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH6pPAAoJELSic+t+oim9c2UP/3TdaQl5j8+lVI9b71A1ODNZ
5/jKJFlNipofxhPoh0oTR82FegDC6LSTFjdAsTgpMk3Gph95A33B2Gf6r1jPWmVT
KIB26VZrraBnckkYDRUNvPntTgjxtUwqLIk5wm0Kvwj+/ioDKTltLkKck64GkbzF
rVwaDaK1WV6dBt3kTrYillnecv1CNUu9wVVf46hsyKNQFJZVMGz4cWxtSeIV/tOO
UEsJeSjKaGwgYZ7c1twdtc08lUmPsiOttOMOblV8WE0QfRnkUoMKfwBsc1zHsQJj
8X3sfebKpSR1LYY3jtU+vX8IShKHBLnszX/4tRF72pGlgaTFyqVlntNvvR//hQuW
UKM6rJFsRpsokmeU1V3yvUgx111lvqsjt4P24GOcSA6H2bQ+shqyB+mP1wmqIE8l
0sQj27hZwzjQ6UyOXAxNjWwZsQhdw/ljEL9UjavB3SWJUsI6sgokaZnd6gwNEhrH
PpKjbOhbvA1FG4qXbykRng7KQISh0R2H2o454aI0XvX8ljSed0Xtt7M4XSpIEqy2
VW1ifmQP0Z0jtd4EShk0Ffhmmgr8qRhNMHKLlNJlAgVKJqy276Eo4S7MP1dqc9IU
Ky8cJM7s0WMrd19T2Lm3VdfabQrKzWlWFnxN0NbSm2+foryHvCdOMIN3b7ca43TJ
Mr6VRvwtxCmWkrpoMcR1
=U1Hg
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--===============8670744779327763892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8670744779327763892==--
