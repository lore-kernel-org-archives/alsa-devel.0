From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 00/20] Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:50 +0300
Message-ID: <20190405115010.28838-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch set switches to SPDX identifier inside the fsl directory.

Andra Danciu (20):
  ASoC: imx-pcm: Switch to SPDX identifier
  ASoC: efika-audio-fabric.c: Switch to SPDX identifier
  ASoC: eukrea-tlv320: Switch to SPDX identifier
  ASoC: fsl-dma: Switch to SPDX identifier
  ASoC: imx-audmux: Switch to SPDX identifier
  ASoC: imx-es8328: Switch to SPDX identifier
  ASoC: imx-mc13783: Switch to SPDX identifier
  ASoC: imx-pcm-fiq: Switch to SPDX identifier
  ASoC: imx-spdif: Switch to SPDX identifier
  ASoC: imx-ssi: Switch to SPDX identifier
  ASoC: mpc5200_dma: Switch to SPDX identifier
  ASoC: mpc5200_psc_ac97: Switch to SPDX identifier
  ASoC: mpc5200_psc_i2s: Switch to SPDX identifier
  ASoC: mpc8610_hpcd: Switch to SPDX identifier
  ASoC: mx27vis-aic32x4: Switch to SPDX identifier
  ASoC: p1022_ds: Switch to SPDX identifier
  ASoC: p1022_rdk: Switch to SPDX identifier
  ASoC: pcm030-audio-fabric: Switch to SPDX identifier
  ASoC: phycore-ac97: Switch to SPDX identifier
  ASoC: wm1133-ev1: Switch to SPDX identifier

 sound/soc/fsl/efika-audio-fabric.c  | 17 ++++-------
 sound/soc/fsl/eukrea-tlv320.c       | 26 +++++++----------
 sound/soc/fsl/fsl_dma.c             | 26 +++++++----------
 sound/soc/fsl/fsl_dma.h             |  5 +---
 sound/soc/fsl/imx-audmux.c          | 26 ++++++-----------
 sound/soc/fsl/imx-es8328.c          | 15 +++-------
 sound/soc/fsl/imx-mc13783.c         | 22 ++++++--------
 sound/soc/fsl/imx-pcm-fiq.c         | 21 ++++++--------
 sound/soc/fsl/imx-pcm.h             |  6 +---
 sound/soc/fsl/imx-spdif.c           | 13 ++-------
 sound/soc/fsl/imx-ssi.c             | 57 ++++++++++++++++---------------------
 sound/soc/fsl/imx-ssi.h             |  6 +---
 sound/soc/fsl/mpc5200_dma.c         | 14 ++++-----
 sound/soc/fsl/mpc5200_psc_ac97.c    | 16 ++++-------
 sound/soc/fsl/mpc5200_psc_i2s.c     | 14 ++++-----
 sound/soc/fsl/mpc8610_hpcd.c        | 18 +++++-------
 sound/soc/fsl/mx27vis-aic32x4.c     | 29 +++++--------------
 sound/soc/fsl/p1022_ds.c            | 18 +++++-------
 sound/soc/fsl/p1022_rdk.c           | 32 +++++++++------------
 sound/soc/fsl/pcm030-audio-fabric.c | 18 +++++-------
 sound/soc/fsl/phycore-ac97.c        | 16 ++++-------
 sound/soc/fsl/wm1133-ev1.c          | 21 ++++++--------
 22 files changed, 161 insertions(+), 275 deletions(-)

-- 
2.11.0
