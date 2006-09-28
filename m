From: Mike Frysinger <vapier@gentoo.org>
Subject: Re:
 =?iso-8859-1?q?1=2E0=2E13rc3=3A_relocation_error=3A_?=
 =?iso-8859-1?q?mocp=3A_symbol=09snd=5Fpcm=5Fhw=5Fparams=5Fget=5Fchannels?=
 =?iso-8859-1?q?=5Fmin_=2E=2E?=
Date: Thu, 28 Sep 2006 06:34:08 -0400
Message-ID: <200609280634.09622.vapier@gentoo.org>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<20060927194840.GA3542@samweis.home.lxtec.de>
	<s5h1wpwpa49.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0886733899=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wpwpa49.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

--===============0886733899==
Content-Type: multipart/signed; boundary="nextPart2680872.NRSYf2ed2b";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2680872.NRSYf2ed2b
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 28 September 2006 06:18, Takashi Iwai wrote:
> Hm, the versions are not seen here.

here's what i'm getting on my ppc with 1.0.13rc3:
$ tar xf alsa-lib-1.0.13rc3.tar.bz2
$ cd alsa-lib-1.0.13rc3
$ ./configure --enable-static
$ make -j6
$ objdump -T src/.libs/libasound.so | grep snd_pcm_hw_params_get_channels_m=
in
00054fd4 g    DF .text  0000002c  ALSA_0.9   =20
__snd_pcm_hw_params_get_channels_min
00055000 g    DF .text  00000034 (ALSA_0.9)  =20
snd_pcm_hw_params_get_channels_min
00054fd4 g    DF .text  0000002c  ALSA_0.9.0rc4=20
snd_pcm_hw_params_get_channels_min

> Also, what is defined as __SYMBOL_PREFIX in config.h?

$ grep __SYMBOL_PREFIX include/config.h
include/config.h:#define __SYMBOL_PREFIX ""
=2Dmike

--nextPart2680872.NRSYf2ed2b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRulIUFjO5/oN/WBAQKWkQ/7BG2/IX/4danZ7qQbs7Ky1IBNhOF5rD+0
DukYbkU0GcYeqAl+axeyDhmHY3ok9kCS3fVa/HARX707wQ1S9yIKXz4YDn7ny1vC
YpEHXgXLFYJnfJB/96NDhJv+epZEj76a6hzGALho/p4WK7pRTd3vZE75FLVEJcE9
MhRBSYxEHFVaPAC0E862gzlQlb7NvhszlN7YcD9Igg0mAR+v7kdiQavg25rzzCZx
YyU/ymudcC62IhcL5y8l5FkfZkmBHOpdz59uEzcLtaV9YuVuG/PnyI4LEFRbalyk
D00oiKMgQQA5w48cHPDVaSqS0iHZXw2d4lnHhZx2eOZtGtv99Smr4KoaxbVfDwzP
orVB272Q5CwPESolxvOf5nvXyuuIQz/bEUiHNm+S2dibrMknOYV+jRH41mNzU1Lm
u54WNlHJWzmR9mJ3CwBd4CIpDSqJ+XVkdPGKIk0wYQiCkgfnU2AkBlFZ/gDJr1US
4a35nF537bunMzpviMtTeY13mt/6mvWEZ33341eGDq+caYYZY9iEZdPF1CIexUPC
AjJKtINvn68jf4vDHPGK/JrDRIwMWDSJavU5Q+hirsP1BOoiG+bXqOeNd+VxaXeS
U4z1ETHK2BQX8x6vTcUz2H4QWi6g7rCugeHLA6Z9YZDFyNBc0wjB/lZkRWfdqgJf
XZ7HOhGBwDM=
=pSau
-----END PGP SIGNATURE-----

--nextPart2680872.NRSYf2ed2b--


--===============0886733899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0886733899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0886733899==--
