From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: davinvi-mcasp: Proper suspend/resume
	support while audio is active
Date: Wed, 1 Oct 2014 16:02:12 +0300
Message-ID: <1412168532-31091-3-git-send-email-peter.ujfalusi@ti.com>
References: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id C61EA260487
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 15:02:22 +0200 (CEST)
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

If the board is sent to suspend (deep sleep) the McASP context will be lost.
In case when suspend happens during active audio we need to save and restore
more registers, which was configured during hw_param times as well.
We need to add more config registers, AFIFO control registers and we also
need to save and restore the serializer configuration as well.
Since the number of serializers depends on the SoC we need to allocate the
memory for it based on the num_serializer for the given McASP instance.

With this patch the ongoing stream will resume after resuming from deep
sleep.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ccf2f3920a20..0eed9b1b24e1 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -49,11 +49,19 @@ static u32 context_regs[] = {
 	DAVINCI_MCASP_RXFMT_REG,
 	DAVINCI_MCASP_ACLKXCTL_REG,
 	DAVINCI_MCASP_ACLKRCTL_REG,
+	DAVINCI_MCASP_AHCLKXCTL_REG,
+	DAVINCI_MCASP_AHCLKRCTL_REG,
 	DAVINCI_MCASP_PDIR_REG,
+	DAVINCI_MCASP_RXMASK_REG,
+	DAVINCI_MCASP_TXMASK_REG,
+	DAVINCI_MCASP_RXTDM_REG,
+	DAVINCI_MCASP_TXTDM_REG,
 };
 
 struct davinci_mcasp_context {
 	u32	config_regs[ARRAY_SIZE(context_regs)];
+	u32	afifo_regs[2]; /* for read/write fifo control registers */
+	u32	*xrsr_regs; /* for serializer configuration */
 };
 
 struct davinci_mcasp {
@@ -878,11 +886,25 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
 		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
 
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
+						DAVINCI_MCASP_XRSRCTL_REG(i));
+
 	return 0;
 }
 
@@ -890,11 +912,25 @@ static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
 		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
 
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+			      context->xrsr_regs[i]);
+
 	return 0;
 }
 #else
@@ -1212,6 +1248,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->op_mode = pdata->op_mode;
 	mcasp->tdm_slots = pdata->tdm_slots;
 	mcasp->num_serializer = pdata->num_serializer;
+#ifdef CONFIG_PM_SLEEP
+	mcasp->context.xrsr_regs = devm_kzalloc(&pdev->dev,
+					sizeof(u32) * mcasp->num_serializer,
+					GFP_KERNEL);
+#endif
 	mcasp->serial_dir = pdata->serial_dir;
 	mcasp->version = pdata->version;
 	mcasp->txnumevt = pdata->txnumevt;
-- 
2.1.0
