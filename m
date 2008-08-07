From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ALSA: ASoC V2: trim SSI sysfs statistics in
	Freescale MPC8610 sound drivers
Date: Thu,  7 Aug 2008 11:22:33 -0500
Message-ID: <1218126153-26095-3-git-send-email-timur@freescale.com>
References: <1218126153-26095-1-git-send-email-timur@freescale.com>
	<1218126153-26095-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A5C2248FC
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 18:22:41 +0200 (CEST)
In-Reply-To: <1218126153-26095-2-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Optimize the display of SSI statistics in the Freescale MPC8610 sound driver
to display the status count only of the interrupts that were actually enabled.
Previously, it would display the counts of all SISR status bits, even those
that were not enabled.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for ASoC V2.

 sound/soc/fsl/fsl_ssi.c |   78 +++++++++++++++++++++++++++-------------------
 1 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 146587e..d0e200e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -63,6 +63,13 @@
 	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
+/* SIER bitflag of interrupts to enable */
+#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
+		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
+		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
+		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
+		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -87,7 +94,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	   were interrupted for.  We mask it with the Interrupt Enable register
 	   so that we only check for events that we're interested in.
 	 */
-	sisr = in_be32(&ssi->sisr) & in_be32(&ssi->sier);
+	sisr = in_be32(&ssi->sisr) & SIER_FLAGS;
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_info->stats.rfrc++;
@@ -266,12 +273,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 */
 
 		/* 4. Enable the interrupts and DMA requests */
-		out_be32(&ssi->sier,
-			 CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE |
-			 CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN |
-			 CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN |
-			 CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE |
-			 CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN);
+		out_be32(&ssi->sier, SIER_FLAGS);
 
 		/*
 		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
@@ -520,39 +522,51 @@ static int fsl_ssi_set_fmt(struct snd_soc_dai *dai, unsigned int format)
 	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
 }
 
+/* Show the statistics of a flag only if its interrupt is enabled.  The
+ * compiler will optimze this code to a no-op if the interrupt is not
+ * enabled.
+ */
+#define SIER_SHOW(flag, name) \
+	do { \
+		if (SIER_FLAGS & CCSR_SSI_SIER_##flag) \
+			length += sprintf(buf + length, #name "=%u\n", \
+				ssi_info->stats.name); \
+	} while (0)
+
 /**
  * fsl_sysfs_ssi_show: display SSI statistics
  *
- * Display the statistics for the current SSI device.
+ * Display the statistics for the current SSI device.  To avoid confusion,
+ * we only show those counts that are enabled.
  */
 static ssize_t fsl_sysfs_ssi_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct fsl_ssi_info *ssi_info =
-	container_of(attr, struct fsl_ssi_info, dev_attr);
-	ssize_t length;
-
-	length = sprintf(buf, "rfrc=%u", ssi_info->stats.rfrc);
-	length += sprintf(buf + length, "\ttfrc=%u", ssi_info->stats.tfrc);
-	length += sprintf(buf + length, "\tcmdau=%u", ssi_info->stats.cmdau);
-	length += sprintf(buf + length, "\tcmddu=%u", ssi_info->stats.cmddu);
-	length += sprintf(buf + length, "\trxt=%u", ssi_info->stats.rxt);
-	length += sprintf(buf + length, "\trdr1=%u", ssi_info->stats.rdr1);
-	length += sprintf(buf + length, "\trdr0=%u", ssi_info->stats.rdr0);
-	length += sprintf(buf + length, "\ttde1=%u", ssi_info->stats.tde1);
-	length += sprintf(buf + length, "\ttde0=%u", ssi_info->stats.tde0);
-	length += sprintf(buf + length, "\troe1=%u", ssi_info->stats.roe1);
-	length += sprintf(buf + length, "\troe0=%u", ssi_info->stats.roe0);
-	length += sprintf(buf + length, "\ttue1=%u", ssi_info->stats.tue1);
-	length += sprintf(buf + length, "\ttue0=%u", ssi_info->stats.tue0);
-	length += sprintf(buf + length, "\ttfs=%u", ssi_info->stats.tfs);
-	length += sprintf(buf + length, "\trfs=%u", ssi_info->stats.rfs);
-	length += sprintf(buf + length, "\ttls=%u", ssi_info->stats.tls);
-	length += sprintf(buf + length, "\trls=%u", ssi_info->stats.rls);
-	length += sprintf(buf + length, "\trff1=%u", ssi_info->stats.rff1);
-	length += sprintf(buf + length, "\trff0=%u", ssi_info->stats.rff0);
-	length += sprintf(buf + length, "\ttfe1=%u", ssi_info->stats.tfe1);
-	length += sprintf(buf + length, "\ttfe0=%u\n", ssi_info->stats.tfe0);
+		container_of(attr, struct fsl_ssi_info, dev_attr);
+	ssize_t length = 0;
+
+	SIER_SHOW(RFRC_EN, rfrc);
+	SIER_SHOW(TFRC_EN, tfrc);
+	SIER_SHOW(CMDAU_EN, cmdau);
+	SIER_SHOW(CMDDU_EN, cmddu);
+	SIER_SHOW(RXT_EN, rxt);
+	SIER_SHOW(RDR1_EN, rdr1);
+	SIER_SHOW(RDR0_EN, rdr0);
+	SIER_SHOW(TDE1_EN, tde1);
+	SIER_SHOW(TDE0_EN, tde0);
+	SIER_SHOW(ROE1_EN, roe1);
+	SIER_SHOW(ROE0_EN, roe0);
+	SIER_SHOW(TUE1_EN, tue1);
+	SIER_SHOW(TUE0_EN, tue0);
+	SIER_SHOW(TFS_EN, tfs);
+	SIER_SHOW(RFS_EN, rfs);
+	SIER_SHOW(TLS_EN, tls);
+	SIER_SHOW(RLS_EN, rls);
+	SIER_SHOW(RFF1_EN, rff1);
+	SIER_SHOW(RFF0_EN, rff0);
+	SIER_SHOW(TFE1_EN, tfe1);
+	SIER_SHOW(TFE0_EN, tfe0);
 
 	return length;
 }
-- 
1.5.5
