From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 2/2] Revert "ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support."
Date: Wed, 6 Aug 2014 18:23:04 +0800
Message-ID: <c4337ee35f7e513b8eb50910cbe2ccd6d39bc9d8.1407320232.git.shengjiu.wang@freescale.com>
References: <cover.1407320232.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1407320232.git.shengjiu.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, arnd@arndb.de
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This reverts commit a603c8ee526f5ea9ad9b40710308766299ad8a69.

fsl_asoc_xlate_tdm_slot_mask() will invert the mask, which isn't fit for
esai. The default function snd_soc_xlate_tdm_slot_mask() is ok for esai.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/Kconfig    |    1 -
 sound/soc/fsl/fsl_esai.c |    2 --
 2 files changed, 3 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index f54a8fc..f3012b6 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -49,7 +49,6 @@ config SND_SOC_FSL_ESAI
 	tristate "Enhanced Serial Audio Interface (ESAI) module support"
 	select REGMAP_MMIO
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
-	select SND_SOC_FSL_UTILS
 	help
 	  Say Y if you want to add Enhanced Synchronous Audio Interface
 	  (ESAI) support for the Freescale CPUs.
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 89aa531..d05b920 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -18,7 +18,6 @@
 
 #include "fsl_esai.h"
 #include "imx-pcm.h"
-#include "fsl_utils.h"
 
 #define FSL_ESAI_RATES		SNDRV_PCM_RATE_8000_192000
 #define FSL_ESAI_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
@@ -611,7 +610,6 @@ static struct snd_soc_dai_ops fsl_esai_dai_ops = {
 	.hw_params = fsl_esai_hw_params,
 	.set_sysclk = fsl_esai_set_dai_sysclk,
 	.set_fmt = fsl_esai_set_dai_fmt,
-	.xlate_tdm_slot_mask = fsl_asoc_xlate_tdm_slot_mask,
 	.set_tdm_slot = fsl_esai_set_dai_tdm_slot,
 };
 
-- 
1.7.9.5
