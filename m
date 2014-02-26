From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 05/10] ASoC: imx-ssi: Add
	.of_xlate_tdm_slot_mask() support.
Date: Wed, 26 Feb 2014 11:59:30 +0800
Message-ID: <1393387175-15539-6-git-send-email-Li.Xiubo@freescale.com>
References: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A8D526515F
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:08:33 +0100 (CET)
In-Reply-To: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
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
Cc: fabio.estevam@freescale.com, moinejf@free.fr, alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, s.hauer@pengutronix.de, timur@tabi.org, linux-kernel@vger.kernel.org, denis@eukrea.com, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, mpa@pengutronix.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch add .of_xlate_tdm_slot_mask support for IMX SSI, and this
will generate the TDM slot TX and RX masks.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/Kconfig   | 1 +
 sound/soc/fsl/imx-ssi.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7472308..67833dd 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -122,6 +122,7 @@ if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
 	tristate
+	select SND_SOC_FSL_UTILS
 
 config SND_SOC_IMX_PCM_FIQ
 	tristate
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index df552fa..52d4b7a 100644
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
+	.of_xlate_tdm_slot_mask = fsl_asoc_of_xlate_tdm_slot_mask,
 	.set_tdm_slot	= imx_ssi_set_dai_tdm_slot,
 	.trigger	= imx_ssi_trigger,
 };
-- 
1.8.4
