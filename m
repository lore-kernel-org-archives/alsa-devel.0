From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: davinci-mcasp: Remove long lines
	from suspend/resume callbacks
Date: Mon, 3 Feb 2014 14:51:52 +0200
Message-ID: <1391431912-31653-4-git-send-email-peter.ujfalusi@ti.com>
References: <1391431912-31653-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 51DD4260885
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 13:52:04 +0100 (CET)
In-Reply-To: <1391431912-31653-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Move the context register storage behind of a struct and use a pointer to
it in the suspend/resume callbacks to remove the long lines.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 52 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e5fce2ed4dc6..35b9b5505f07 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -37,6 +37,16 @@
 #include "davinci-pcm.h"
 #include "davinci-mcasp.h"
 
+struct davinci_mcasp_context {
+	u32	txfmtctl;
+	u32	rxfmtctl;
+	u32	txfmt;
+	u32	rxfmt;
+	u32	aclkxctl;
+	u32	aclkrctl;
+	u32	pdir;
+};
+
 struct davinci_mcasp {
 	struct davinci_pcm_dma_params dma_params[2];
 	struct snd_dmaengine_dai_dma_data dma_data[2];
@@ -63,15 +73,7 @@ struct davinci_mcasp {
 	bool	dat_port;
 
 #ifdef CONFIG_PM_SLEEP
-	struct {
-		u32	txfmtctl;
-		u32	rxfmtctl;
-		u32	txfmt;
-		u32	rxfmt;
-		u32	aclkxctl;
-		u32	aclkrctl;
-		u32	pdir;
-	} context;
+	struct davinci_mcasp_context context;
 #endif
 };
 
@@ -741,14 +743,15 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+	struct davinci_mcasp_context *context = &mcasp->context;
 
-	mcasp->context.txfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG);
-	mcasp->context.rxfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG);
-	mcasp->context.txfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMT_REG);
-	mcasp->context.rxfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMT_REG);
-	mcasp->context.aclkxctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG);
-	mcasp->context.aclkrctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG);
-	mcasp->context.pdir = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
+	context->txfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG);
+	context->rxfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG);
+	context->txfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMT_REG);
+	context->rxfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMT_REG);
+	context->aclkxctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG);
+	context->aclkrctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG);
+	context->pdir = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
 
 	return 0;
 }
@@ -756,14 +759,15 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG, mcasp->context.txfmtctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG, mcasp->context.rxfmtctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMT_REG, mcasp->context.txfmt);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMT_REG, mcasp->context.rxfmt);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, mcasp->context.aclkxctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, mcasp->context.aclkrctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PDIR_REG, mcasp->context.pdir);
+	struct davinci_mcasp_context *context = &mcasp->context;
+
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG, context->txfmtctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG, context->rxfmtctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMT_REG, context->txfmt);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMT_REG, context->rxfmt);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, context->aclkxctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, context->aclkrctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PDIR_REG, context->pdir);
 
 	return 0;
 }
-- 
1.8.5.3
