From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 4/4] ASoC: imx-ssi: Add .xlate_tdm_slot_mask()
	support.
Date: Fri, 21 Mar 2014 14:17:15 +0800
Message-ID: <1395382635-16349-5-git-send-email-Li.Xiubo@freescale.com>
References: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 61C0726536F
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:01:29 +0100 (CET)
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

This patch add .xlate_tdm_slot_mask support for IMX SSI, and this
will generate the TDM slot TX and RX masks.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/Kconfig   | 1 +
 sound/soc/fsl/imx-ssi.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 789bc4d..338a916 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -121,6 +121,7 @@ if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
 	tristate
+	select SND_SOC_FSL_UTILS
 
 config SND_SOC_IMX_PCM_FIQ
 	tristate
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index df552fa..ab2fdd7 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -50,6 +50,7 @@
 #include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "imx-ssi.h"
+#include "fsl_utils.h"
 
 #define SSI_SACNT_DEFAULT (SSI_SACNT_AC97EN | SSI_SACNT_FV)
 
@@ -339,6 +340,7 @@ static const struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
 	.set_fmt	= imx_ssi_set_dai_fmt,
 	.set_clkdiv	= imx_ssi_set_dai_clkdiv,
 	.set_sysclk	= imx_ssi_set_dai_sysclk,
+	.xlate_tdm_slot_mask = fsl_asoc_xlate_tdm_slot_mask,
 	.set_tdm_slot	= imx_ssi_set_dai_tdm_slot,
 	.trigger	= imx_ssi_trigger,
 };
-- 
1.8.4
