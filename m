From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for v3.7
Date: Sat, 27 Oct 2012 23:13:14 +0100
Message-ID: <20121027221311.GM4564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3022209018470925311=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57CE426522E
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2012 00:13:18 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3022209018470925311==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwtQuX191/I956S7"
Content-Disposition: inline


--wwtQuX191/I956S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

for you to fetch changes up to 19118eb8dc3cd6bb1b1fdf0e4ad62070c6683158:

  ASoC: omap-dmic: Correct functional clock name (2012-10-27 23:00:18 +0100)

----------------------------------------------------------------
ASoC: Fixes for v3.7

Clean up some fallout from the OMAP header reorganisation and a minor
fix for DMIC which has no practical effect but is neater.

----------------------------------------------------------------
Peter Ujfalusi (1):
      ASoC: omap-dmic: Correct functional clock name

Tony Lindgren (1):
      ASoC: zoom2: Fix compile error by including correct header files

 sound/soc/omap/omap-dmic.c |    4 ++--
 sound/soc/omap/zoom2.c     |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

--wwtQuX191/I956S7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjFxeAAoJELSic+t+oim9tPEP/2dmS5pyBOn7MezKBtJ/wUQw
hoTwJjuhBKFoOXw8zcuGKR7roccKFwM8bjimfX5BIB3XbLFn46pBDTpE6YUjpJy/
vwSeIG8wiBFM2dRdhTf4fpIsjenXCrQAsyGZZzYZ12bFBPRN8+HOLU1YrVkYpeiO
AAKhmj3s5iAZ8jgeuqDp2LJQs3oYLIDrIBHzT2mhyKVDyyMxlVElMjIxGADWpE2V
h3Fg8HQiqvE0wxZp1griMXEDXwf+wg6eviaVnBQ3NfGDVBA0pcQGM17PL5zMF7gX
rBJ3KJUCWVUcGCOHD+81WiAkL3N8y+zLOly9RDeKARSDC1GUWJAzGctKIrKpur43
/G5hUNI58t2hvNMDutKTl/f30FeqfBupv0u46HDHBGXNnulXYcfP4LsmECFoMp9v
03utZeuB+Sp17R4VbmNe7uJmJw2XkkubhNP4ULGaMh2CTRRkZfNZ/tn9QgrkvOCL
nwFyvNhAav8jt2Rp3p0u8PcJvn3iSnunIhBQSzNY7HdnuooYL0rGVgPXvNWuGHQB
lGJGNZHGDsQ5Pixv/pe0xG+8H6uFxMNnQbqbi+mICrLR0fAUlUZrAnBTgfYEK0zX
TZdzF36S6nGlHA0VD1V+Wj/j3WrjHG4rn1KFNYG1BDnJeqZC83+/jX+nqfoA3JDw
dHFnbuMhlAHLUb2AgOpq
=pQSw
-----END PGP SIGNATURE-----

--wwtQuX191/I956S7--

--===============3022209018470925311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3022209018470925311==--
