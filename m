From: Caleb Crome <caleb@crome.org>
Subject: [PATCH] FSL_SSI: fix fsl_ssi interrupt reporting so
	that interrupts are only reported when they have been enabled.
Date: Wed, 28 Oct 2015 12:53:12 -0700
Message-ID: <1446061992-88379-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 89687262607
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 20:53:58 +0100 (CET)
Received: by padhk11 with SMTP id hk11so15954914pad.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 12:53:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mpa@pengutronix.de, timur@freescale.com, alsa-devel@alsa-project.org
Cc: Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

The current implementation reports all interrupt stats
in /sys/kernel/debug/*.ssi/stats, even if the interrupt
was not enabled.  This is not the intention as per
the comments.  This fix keeps track of ever bit in the
SIER register that has ever been enabled, which allows
fsl_ssi_stats_show to actually only report those
interrupt counts for interrupts that are enabled.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c     | 15 +++++++++++++++
 sound/soc/fsl/fsl_ssi.h     |  1 +
 sound/soc/fsl/fsl_ssi_dbg.c |  8 +++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 73778c2..14d5ade 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -299,6 +299,18 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+// call fsl_ssi_dbg_update_sier_enbled every time sier is
+// updated.  it tracks which interrupts have ever been enabled.
+// so that the print function can keep track.
+void fsl_ssi_update_sier_enabled(
+	struct fsl_ssi_private *ssi_private)
+{
+	int sier;
+	struct regmap *regs = ssi_private->regs;
+	regmap_read(regs, CCSR_SSI_SIER, &sier);
+	ssi_private->dbg_stats.sier_ever_enabled |= sier;
+}
+
 /*
  * Enable/Disable all rx/tx config flags at once.
  */
@@ -312,6 +324,7 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 		regmap_update_bits(regs, CCSR_SSI_SIER,
 				vals->rx.sier | vals->tx.sier,
 				vals->rx.sier | vals->tx.sier);
+		fsl_ssi_update_sier_enabled(ssi_private);
 		regmap_update_bits(regs, CCSR_SSI_SRCR,
 				vals->rx.srcr | vals->tx.srcr,
 				vals->rx.srcr | vals->tx.srcr);
@@ -404,6 +417,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 */
 	if (enable) {
 		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
+		fsl_ssi_update_sier_enabled(ssi_private);
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
 	} else {
@@ -431,6 +445,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 		regmap_update_bits(regs, CCSR_SSI_SRCR, srcr, 0);
 		regmap_update_bits(regs, CCSR_SSI_STCR, stcr, 0);
 		regmap_update_bits(regs, CCSR_SSI_SIER, sier, 0);
+		fsl_ssi_update_sier_enabled(ssi_private);
 	}
 
 config_done:
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 5065105..a078c69 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -237,6 +237,7 @@ struct fsl_ssi_dbg {
 		unsigned int tfe1;
 		unsigned int tfe0;
 	} stats;
+	unsigned int sier_ever_enabled;
 };
 
 void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *ssi_dbg, u32 sisr);
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 5469ffb..1066620 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -82,13 +82,10 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 		dbg->stats.tfe0++;
 }
 
-/* Show the statistics of a flag only if its interrupt is enabled.  The
- * compiler will optimze this code to a no-op if the interrupt is not
- * enabled.
- */
+/* Show the statistics of a flag only if its interrupt is enabled. */
 #define SIER_SHOW(flag, name) \
 	do { \
-		if (CCSR_SSI_SIER_##flag) \
+		if (CCSR_SSI_SIER_##flag & sier) \
 			seq_printf(s, #name "=%u\n", ssi_dbg->stats.name); \
 	} while (0)
 
@@ -102,6 +99,7 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 {
 	struct fsl_ssi_dbg *ssi_dbg = s->private;
+	unsigned int sier = ssi_dbg->sier_ever_enabled;
 
 	SIER_SHOW(RFRC_EN, rfrc);
 	SIER_SHOW(TFRC_EN, tfrc);
-- 
2.1.4
