From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/6] ASoC: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:06 +0530
Message-ID: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const. Done using Coccinelle

Bhumika Goyal (6):
  ASoC: fsl: make snd_pcm_hardware const
  ASoC: Intel: Atom: make snd_pcm_hardware const
  ASoC: Intel: Skylake: make snd_pcm_hardware const
  ASoC: kirkwood: make snd_pcm_hardware const
  ASoC: sh: make snd_pcm_hardware const
  ASoC: qcom: make snd_pcm_hardware const

 sound/soc/fsl/fsl_asrc_dma.c                 | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c                  | 2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 sound/soc/intel/skylake/skl-pcm.c            | 2 +-
 sound/soc/kirkwood/kirkwood-dma.c            | 2 +-
 sound/soc/qcom/lpass-platform.c              | 2 +-
 sound/soc/sh/dma-sh7760.c                    | 2 +-
 sound/soc/sh/fsi.c                           | 2 +-
 sound/soc/sh/rcar/core.c                     | 2 +-
 sound/soc/sh/siu_dai.c                       | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1
