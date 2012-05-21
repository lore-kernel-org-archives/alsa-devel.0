From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.5
Date: Mon, 21 May 2012 15:57:41 +0100
Message-ID: <20120521145741.GE4063@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4970057253961425270=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3B15244E8
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 16:57:43 +0200 (CEST)
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


--===============4970057253961425270==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5fb86e5d4a951ddb0474cdfd809380c8e2a8d101:

  ARM: mx31_3ds: Add sound support (2012-05-18 16:42:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.5

for you to fetch changes up to 766812e6d5e2e23be1e212cf84902d5e834dd865:

  ASoC: sh: fsi: enable chip specific data transfer mode (2012-05-19 19:41:45 +0100)

----------------------------------------------------------------
ASoC: Last minute updates

These are all new code, they've been in -next already so should be OK
for merge this time round.  I'd been planning to send a pull request
today after they'd had a bit of exposure there to make sure breakage
didn't propagate into your tree.

----------------------------------------------------------------
Kuninori Morimoto (5):
      ASoC: sh: fsi: use register field macro name on IN/OUT_DMAC
      ASoC: sh: fsi: add fsi_version() and removed meaningless version check
      ASoC: sh: fsi: use same format for IN/OUT
      ASoC: sh: fsi: call fsi_hw_startup/shutdown from fsi_dai_trigger()
      ASoC: sh: fsi: enable chip specific data transfer mode

Ricardo Neri (1):
      ASoC: OMAP: HDMI: Introduce codec

Stephen Warren (1):
      ASoC: tegra: Add machine driver for WM8753 codec

 .../bindings/sound/tegra-audio-wm8753.txt          |   54 +++++
 include/sound/sh_fsi.h                             |    6 +-
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/omap-hdmi.c                       |   69 ++++++
 sound/soc/omap/Kconfig                             |    1 +
 sound/soc/sh/fsi.c                                 |  224 ++++++++++++++------
 sound/soc/tegra/Kconfig                            |   10 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra_wm8753.c                     |  224 ++++++++++++++++++++
 10 files changed, 529 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra-audio-wm8753.txt
 create mode 100644 sound/soc/codecs/omap-hdmi.c
 create mode 100644 sound/soc/tegra/tegra_wm8753.c

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPulffAAoJEBus8iNuMP3deQwQAIoObgF/MR9Cy0Rz4YtHXChv
nka2e/Eo5G5E/oOBapjFyWKWam09gcbbQ4b8tOHs3LzI8/Y27AUKyZAAKaPU9AAz
i7YBLzwvNHBp1DR1NH5myGtjc8Yx6mYCsttOJuHdtYlpj0re8cBg9y5TZKoAFi0p
USUzvRn61cZ27KJa74wsJ7WUKagkWGwi5a+9Q5Rc6pDht37Ntexx0+zZ7Xb7YNcY
fBp34juNmjM+Nyc4OPt/UokD/GHhXwBFcZ2sYAMV4poWlDmPEm7x+AACfT1LTWPD
DMKETnfuREYIHlQpad5qPOULlCLE4xN1Qx4BVnbP4CDLaqHaphuWvNSYeW8T2Z72
5V9SnkVJ8Ib23ood3cZUcvuHOiUC+a8TIVMbe7K9/pIG2mT6UZRcToT342nFlwLo
GtgG1ceLEAmfRGYqlcj+vwGGKWMSHraQD4n4EMmLipwCQEmF+cHqTve2mEybEqq+
Z/dOLbmPLZIFLJnnLvkqJyy39mJOR4J0VnETKPMoSbfuxq8g9Mc8s1F6W06Dfe09
yEUCn3hlDKIOZjDmY0Pa3ZYQKyjgUmZ2nOIThbSIneSj5u1WDlpItiux53Im4hLU
XzWwRcK3R9dOPhbXyfHEH25scAkHEUuSCvds6jl19c/MhdPxUJnKi6vNto5RHN0u
QnTPwTOwG4P5ewBF+exF
=1Vz+
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--

--===============4970057253961425270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4970057253961425270==--
