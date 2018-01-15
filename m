From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v4 08/17] ASoC: fsl_ssi: Add DAIFMT define for
	AC97
Date: Mon, 15 Jan 2018 15:16:23 -0800
Message-ID: <1516058192-65519-9-git-send-email-nicoleotsuka@gmail.com>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 21E41267630
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 00:17:33 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id g16so1979863pgn.7
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 15:17:33 -0800 (PST)
In-Reply-To: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The _fsl_ssi_set_dai_fmt() bypasses an undefined format for AC97
mode. However, it's not really necessary if AC97 has its complete
format defined.

So this patch adds a DAIFMT macro of complete format including a
clock direction and polarity.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7a6a32b..b76a517 100644
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
2.7.4
