From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Convert the context
	save/restore to use array
Date: Wed, 1 Oct 2014 16:02:11 +0300
Message-ID: <1412168532-31091-2-git-send-email-peter.ujfalusi@ti.com>
References: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id BAB2A260486
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 15:02:20 +0200 (CEST)
In-Reply-To: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Instead of individual values use an array to store the registers need to be
saved on suspend and restored on resume.
It is going to be easier to add more registers to save and restore.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 68347b55f6e1..ccf2f3920a20 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -42,14 +42,18 @@
 
 #define MCASP_MAX_AFIFO_DEPTH	64
 
+static u32 context_regs[] = {
+	DAVINCI_MCASP_TXFMCTL_REG,
+	DAVINCI_MCASP_RXFMCTL_REG,
+	DAVINCI_MCASP_TXFMT_REG,
+	DAVINCI_MCASP_RXFMT_REG,
+	DAVINCI_MCASP_ACLKXCTL_REG,
+	DAVINCI_MCASP_ACLKRCTL_REG,
+	DAVINCI_MCASP_PDIR_REG,
+};
+
 struct davinci_mcasp_context {
-	u32	txfmtctl;
-	u32	rxfmtctl;
-	u32	txfmt;
-	u32	rxfmt;
-	u32	aclkxctl;
-	u32	aclkrctl;
-	u32	pdir;
+	u32	config_regs[ARRAY_SIZE(context_regs)];
 };
 
 struct davinci_mcasp {
@@ -874,14 +878,10 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 	struct davinci_mcasp_context *context = &mcasp->context;
+	int i;
 
-	context->txfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG);
-	context->rxfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG);
-	context->txfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMT_REG);
-	context->rxfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMT_REG);
-	context->aclkxctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG);
-	context->aclkrctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG);
-	context->pdir = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
 
 	return 0;
 }
@@ -890,14 +890,10 @@ static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 	struct davinci_mcasp_context *context = &mcasp->context;
+	int i;
 
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG, context->txfmtctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG, context->rxfmtctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMT_REG, context->txfmt);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMT_REG, context->rxfmt);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, context->aclkxctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, context->aclkrctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PDIR_REG, context->pdir);
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
 
 	return 0;
 }
-- 
2.1.0
