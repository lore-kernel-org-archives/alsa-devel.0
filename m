From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.4
Date: Tue, 6 Mar 2012 13:02:16 +0000
Message-ID: <20120306130216.GS19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7439002138863870392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 446191044E3
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 14:02:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7439002138863870392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4PJudQiuYY5+cwwi"
Content-Disposition: inline


--4PJudQiuYY5+cwwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit ad20ff920c1fd217578e2c637dd50c1878a21c06:

  ASoC: wm8753: fix initialization (2012-03-04 14:34:44 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-3.4

for you to fetch changes up to 9d5ef2663fe220a88412a7190942b7d933da0333:

  ASoC: fsl: add dt support for imx-audmux (2012-03-06 12:44:21 +0000)

----------------------------------------------------------------
A few more ASoC updates, the main one is the move of the audmux driver
=66rom arch/arm into sound/soc.  There's also some general driver specific
tweaks and fixes.
----------------------------------------------------------------

Axel Lin (1):
      ASoC: Add missing regmap_init_i2c in wm8804_i2c_probe

Mark Brown (4):
      ASoC: dapm: Show if widgets are forced in debugfs
      ASoC: wm8994: Use audio mode for jack detection when system is active
      ASoC: wm8962: Remove unneeded pm_runtime_set_active()
      ASoC: wm8962: Remove defaults for volatile registers

Richard Zhao (2):
      ARM: imx: convert audmux to a platform driver
      ASoC: fsl: add dt support for imx-audmux

Shawn Guo (7):
      ASoC: imx: move eukrea audmux call into ASoC machine driver
      ASoC: imx: move phycore audmux call into ASoC machine driver
      ARM: imx: merge audmux-v1 and audmux-v2
      ASoC: imx: move audmux driver into sound/soc/imx
      ASoC: imx: rename audmux prefix mxc to imx
      ASoC: imx: separate imx-pcm bits from imx-ssi driver
      ASoC: imx: add an explicit Kconfig option for imx-ssi driver

 .../devicetree/bindings/sound/imx-audmux.txt       |   13 ++
 arch/arm/mach-imx/Kconfig                          |    6 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |   20 --
 arch/arm/mach-imx/eukrea_mbimxsd-baseboard.c       |    1 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |   17 --
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |   17 --
 arch/arm/mach-imx/mach-pca100.c                    |   13 --
 arch/arm/mach-imx/mach-pcm043.c                    |   13 --
 arch/arm/mach-imx/mm-imx21.c                       |    6 +
 arch/arm/mach-imx/mm-imx25.c                       |    7 +
 arch/arm/mach-imx/mm-imx27.c                       |    7 +
 arch/arm/mach-imx/mm-imx3.c                        |   13 ++
 arch/arm/mach-imx/mm-imx5.c                        |   22 +++
 arch/arm/plat-mxc/Kconfig                          |    6 -
 arch/arm/plat-mxc/Makefile                         |    2 -
 arch/arm/plat-mxc/audmux-v1.c                      |   64 -------
 arch/arm/plat-mxc/include/mach/audmux.h            |   60 -------
 sound/soc/codecs/wm8804.c                          |    6 +
 sound/soc/codecs/wm8962.c                          |   18 +--
 sound/soc/codecs/wm8994.c                          |   77 +++++---
 sound/soc/codecs/wm8994.h                          |    1 +
 sound/soc/imx/Kconfig                              |   21 ++-
 sound/soc/imx/Makefile                             |   15 +-
 sound/soc/imx/eukrea-tlv320.c                      |   40 ++++-
 .../audmux-v2.c =3D> sound/soc/imx/imx-audmux.c      |  185 ++++++++++++++=
+-----
 sound/soc/imx/imx-audmux.h                         |   60 +++++++
 sound/soc/imx/imx-pcm-dma-mx2.c                    |    2 +-
 sound/soc/imx/imx-pcm.c                            |  105 +++++++++++
 sound/soc/imx/imx-pcm.h                            |   32 ++++
 sound/soc/imx/imx-ssi.c                            |   88 ---------
 sound/soc/imx/imx-ssi.h                            |   16 +--
 sound/soc/imx/mx27vis-aic32x4.c                    |   20 +-
 sound/soc/imx/phycore-ac97.c                       |   27 +++-
 sound/soc/imx/wm1133-ev1.c                         |   25 ++--
 sound/soc/soc-dapm.c                               |    5 +-
 35 files changed, 581 insertions(+), 449 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.txt
 delete mode 100644 arch/arm/plat-mxc/audmux-v1.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/audmux.h
 rename arch/arm/plat-mxc/audmux-v2.c =3D> sound/soc/imx/imx-audmux.c (52%)
 create mode 100644 sound/soc/imx/imx-audmux.h
 create mode 100644 sound/soc/imx/imx-pcm.c
 create mode 100644 sound/soc/imx/imx-pcm.h

--4PJudQiuYY5+cwwi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVgrCAAoJEBus8iNuMP3dOJkP/1XNO8CaUuRCo42ZRsc8tXQr
jqh5ewDkN1U8wq/AlpuI4hocPsuIyP5KcQc88qpZEfQSypV8d0W6dODhuahq+Fd5
+yF+UghD9oqBLFE3w41EqHD07GOFJIu270drj5rQoC9lzkpxb2fc0ITJzdxI4+q5
w3a8rnOxo0xCQsR8jALuEugre0WDwYcdx14Lcs9FODOTLu0THAXCEYyldur1RiRA
WGSOhT13CzDrI06FlZxvha1aSHtw/6KyuR5rUx0m4ykpkCbwUMeb/WQROpP+9onX
ZKD5bj+WGItYffYJTDKAB5xR49OFgPbs/LQYJC6aGPPSYnfcCiIlttg01UZSVPUD
27gxaNt5Mir/ejYI7RFFFyXxZnicgboA8CJ6fhy//6NYnZ6NTOjKLyfJ+83hqDDU
Ai778k8IoA69T2caCLTnaZWqZhvIH7dkZsZTRo6JFmALGdF7Sxpzo27OW3HZTqkU
Db4NaswAyRHb5xoacLb9xhSx5O+PJizASxhi99r7tWVwfFS/rVmCKgGakI0xBJ0n
3K2Ue5pUTuhi7RLkocGNfefftKXTq1slcgnjRh6JZgtdW3VbOlDFWN1YO5kgNO1+
ALRMYG6GKbV2q0/HIOUX+CVr6uGP3gUEI1kRbci6MuzmuPBor7lQ5AUVmzXjTtUm
E7ENU0nFz99ACjugEfH0
=8Soz
-----END PGP SIGNATURE-----

--4PJudQiuYY5+cwwi--

--===============7439002138863870392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7439002138863870392==--
