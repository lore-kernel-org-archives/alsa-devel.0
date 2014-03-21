From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 3/4] ASoC: fsl-esai: Add .xlate_tdm_slot_mask()
	support.
Date: Fri, 21 Mar 2014 14:17:14 +0800
Message-ID: <1395382635-16349-4-git-send-email-Li.Xiubo@freescale.com>
References: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id D3FCA2610AA
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:01:14 +0100 (CET)
In-Reply-To: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch add .xlate_tdm_slot_mask support for ESAI, and this will
generate the TDM slot TX and RX masks.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/Kconfig    | 1 +
 sound/soc/fsl/fsl_esai.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 597962e..789bc4d 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -13,6 +13,7 @@ config SND_SOC_FSL_SPDIF
 config SND_SOC_FSL_ESAI
 	tristate
 	select REGMAP_MMIO
+	select SND_SOC_FSL_UTILS
 
 config SND_SOC_FSL_UTILS
 	tristate
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 0ba3700..c8e5db1 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -18,6 +18,7 @@
 
 #include "fsl_esai.h"
 #include "imx-pcm.h"
+#include "fsl_utils.h"
 
 #define FSL_ESAI_RATES		SNDRV_PCM_RATE_8000_192000
 #define FSL_ESAI_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
@@ -581,6 +582,7 @@ static struct snd_soc_dai_ops fsl_esai_dai_ops = {
 	.hw_params = fsl_esai_hw_params,
 	.set_sysclk = fsl_esai_set_dai_sysclk,
 	.set_fmt = fsl_esai_set_dai_fmt,
+	.xlate_tdm_slot_mask = fsl_asoc_xlate_tdm_slot_mask,
 	.set_tdm_slot = fsl_esai_set_dai_tdm_slot,
 };
 
-- 
1.8.4
