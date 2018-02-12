From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 08/17] ASoC: fsl_ssi: Add DAIFMT define for
	AC97
Date: Mon, 12 Feb 2018 14:03:16 -0800
Message-ID: <1518473005-14090-9-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
 [209.85.160.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F21E26761B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 23:02:49 +0100 (CET)
Received: by mail-pl0-f65.google.com with SMTP id 31so116667ple.9
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 14:02:49 -0800 (PST)
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, timur@tabi.org
Cc: mail@maciej.szmigiero.name, kernel@pengutronix.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The _fsl_ssi_set_dai_fmt() bypasses an undefined format for AC97
mode. However, it's not really necessary if AC97 has its complete
format defined.

So this patch adds a DAIFMT macro of complete format including a
clock direction and polarity.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9f024a9..fc5768d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -90,6 +90,16 @@
 	 SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
+/*
+ * In AC97 mode, TXDIR bit is forced to 0 and TFDIR bit is forced to 1:
+ *  - SSI inputs external bit clock and outputs frame sync clock -- CBM_CFS
+ *  - Also have NB_NF to mark these two clocks will not be inverted
+ */
+#define FSLSSI_AC97_DAIFMT \
+	(SND_SOC_DAIFMT_AC97 | \
+	 SND_SOC_DAIFMT_CBM_CFS | \
+	 SND_SOC_DAIFMT_NB_NF)
+
 #define FSLSSI_SIER_DBG_RX_FLAGS \
 	(SSI_SIER_RFF0_EN | \
 	 SSI_SIER_RLS_EN | \
@@ -964,8 +974,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		if (!fsl_ssi_is_ac97(ssi))
-			return -EINVAL;
+		return -EINVAL;
 	}
 
 	stcr |= strcr;
@@ -1372,7 +1381,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
 		if (!strcmp(sprop, "ac97-slave"))
-			ssi->dai_fmt = SND_SOC_DAIFMT_AC97;
+			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
 	}
 
 	/* Select DMA or FIQ */
-- 
2.1.4
