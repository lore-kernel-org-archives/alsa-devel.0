From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/10] constify ASoC snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:23 +0530
Message-ID: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Arvind Yadav (10):
  [PATCH 01/10] ASoC: au1x: constify snd_pcm_ops structures
  [PATCH 02/10] ASoC: blackfin: constify snd_pcm_ops structures
  [PATCH 03/10] ASoC: fsl: constify snd_pcm_ops structures
  [PATCH 04/10] ASoC: intel: constify snd_pcm_ops structures
  [PATCH 05/10] ASoC: nuc900: constify snd_pcm_ops structures
  [PATCH 06/10] ASoC: omap: constify snd_pcm_ops structures
  [PATCH 07/10] ASoC: pxa: constify snd_pcm_ops structures
  [PATCH 08/10] ASoC: samsung: constify snd_pcm_ops structures
  [PATCH 09/10] ASoC: sh: constify snd_pcm_ops structures
  [PATCH 10/10] ASoC: txx9: constify snd_pcm_ops structures

 sound/soc/au1x/dbdma2.c                     | 2 +-
 sound/soc/au1x/dma.c                        | 2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c         | 2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c          | 2 +-
 sound/soc/fsl/fsl_dma.c                     | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c                 | 2 +-
 sound/soc/fsl/mpc5200_dma.c                 | 2 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 2 +-
 sound/soc/nuc900/nuc900-pcm.c               | 2 +-
 sound/soc/omap/omap-pcm.c                   | 2 +-
 sound/soc/pxa/mmp-pcm.c                     | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c                  | 2 +-
 sound/soc/samsung/idma.c                    | 2 +-
 sound/soc/sh/dma-sh7760.c                   | 2 +-
 sound/soc/sh/fsi.c                          | 2 +-
 sound/soc/sh/rcar/core.c                    | 2 +-
 sound/soc/sh/siu_pcm.c                      | 2 +-
 sound/soc/txx9/txx9aclc.c                   | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

-- 
1.9.1
