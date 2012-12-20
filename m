From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: arizona: Do proper shift for
	setting aif1 rate
Date: Thu, 20 Dec 2012 15:57:56 +0000
Message-ID: <20121220155756.GD4985@opensource.wolfsonmicro.com>
References: <1356017382.12143.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1102345710843599594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 248AA26077D
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 17:07:38 +0100 (CET)
In-Reply-To: <1356017382.12143.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1102345710843599594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TuBLotoxjxNtqonL"
Content-Disposition: inline


--TuBLotoxjxNtqonL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20, 2012 at 11:29:42PM +0800, Axel Lin wrote:
> ARIZONA_AIF1_RATE_MASK is 0x7800 /* AIF1_RATE - [14:11] */
> Thus we need left shift ARIZONA_AIF1_RATE_SHIFT when setting aif1 rate.

Applied, thanks.

--TuBLotoxjxNtqonL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0zVvAAoJELSic+t+oim9fhUP/3NkoVA8JgPeeCXb76fKpCVW
yGioErg3bHZB8F1tsAc69TyTEb2z/9+PsioWtzbYeHjmgFombsz0rUlUIwPEFAr9
xc3zfCP0pIGvVx9zua1cQtE1guDRqMJpIJcIDGwxt1Hli3JoFIi8xoWT+tX9KPPe
FRnqHT1gpkYkYvfzI745XBkWDPm/Ov6JM+JFNJYgXebLPZoQDtkg/6yh/4bNilk3
enEyZHtm/w37c/I51VvdlvzJfp8N/Rf5Yq8xhIf+sj3FFzg7tgtdFASsnVQjPt8Y
HvmNhfCqn+XGUdcOZgVsm/hdLN43tpB8VknzbkJGxLhT5x6jKL8ii9+vnueikzZj
Jzj6+xDdkrVXc/xeV/TmPPEWetZ+6+hMTt6gPOfTgeYYiPYGglivhPQG5FR1JLsP
SfpBO4ujiNWwFm+IZDuxR2+4Z2htCqniK03VefMMkDqXyqD5/5YvulTgguAun1IJ
0itMgTpmUB400EOFUl0ddXDjUcEgDrM7P1+A4EfPnji6Fzh9j6sZrRvfJgqs6Gqs
BIAwFclSyj3bhd6f84JXFKz0yDUmi2EB8LXET/nERDX8xcLsU0lmADYJQRY2QKRJ
GSzHGJiZMvalsuBuxVzkjpivpoC+8Ccdo09vvE4pSoh8RuXU0kNCenIhG/HIuuSY
yQSPTdoHu2bW72kzqKz+
=mPWQ
-----END PGP SIGNATURE-----

--TuBLotoxjxNtqonL--

--===============1102345710843599594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1102345710843599594==--
