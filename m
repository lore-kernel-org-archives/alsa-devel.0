From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 11/15] ASoC: fsl-ssi: Fix register values when disabling
Date: Wed, 26 Feb 2014 17:02:14 +0100
Message-ID: <1393430538-32333-12-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The bits we have to clear when disabling are different when the other
stream is still active.

This patch fixes the calculation of new register values after disabling
one stream. It also adds a more detailed description of the new register
value calculation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f5e43bb..9a1980d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -324,6 +324,26 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
 }
 
 /*
+ * Calculate the bits that have to be disabled for the current stream that is
+ * getting disabled. This keeps the bits enabled that are necessary for the
+ * second stream to work if 'stream_active' is true.
+ *
+ * Detailed calculation:
+ * These are the values that need to be active after disabling. For non-active
+ * second stream, this is 0:
+ *	vals_stream * !!stream_active
+ *
+ * The following computes the overall differences between the setup for the
+ * to-disable stream and the active stream, a simple XOR:
+ *	vals_disable ^ (vals_stream * !!(stream_active))
+ *
+ * The full expression adds a mask on all values we care about
+ */
+#define fsl_ssi_disable_val(vals_disable, vals_stream, stream_active) \
+	((vals_disable) & \
+	 ((vals_disable) ^ ((vals_stream) * (u32)!!(stream_active))))
+
+/*
  * Enable/Disable a ssi configuration. You have to pass either
  * ssi_private->rxtx_reg_val.rx or tx as vals parameter.
  */
@@ -334,10 +354,15 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	struct fsl_ssi_reg_val *avals;
 	u32 scr_val;
 	int nr_active_streams;
+	int keep_active;
 
 	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
 	nr_active_streams = !!(scr_val & CCSR_SSI_SCR_TE) +
 			!!(scr_val & CCSR_SSI_SCR_RE);
+	if (nr_active_streams - 1 > 0)
+		keep_active = 1;
+	else
+		keep_active = 0;
 
 	/* Find the other direction values rx or tx which we do not want to
 	 * modify */
@@ -348,7 +373,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 
 	/* If vals should be disabled, start with disabling the unit */
 	if (!enable) {
-		u32 scr = vals->scr & (vals->scr ^ avals->scr);
+		u32 scr = fsl_ssi_disable_val(vals->scr, avals->scr,
+				keep_active);
 		regmap_update_bits(regs, CCSR_SSI_SCR, scr, 0);
 	}
 
@@ -359,7 +385,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 */
 	if (fsl_ssi_offline_config(ssi_private)) {
 		if ((enable && !nr_active_streams) ||
-				(!enable && nr_active_streams == 1))
+				(!enable && !keep_active))
 			fsl_ssi_rxtx_config(ssi_private, enable);
 
 		goto config_done;
@@ -388,9 +414,12 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 		 */
 
 		/* These assignments are simply vals without bits set in avals*/
-		sier = vals->sier & (vals->sier ^ avals->sier);
-		srcr = vals->srcr & (vals->srcr ^ avals->srcr);
-		stcr = vals->stcr & (vals->stcr ^ avals->stcr);
+		sier = fsl_ssi_disable_val(vals->sier, avals->sier,
+				keep_active);
+		srcr = fsl_ssi_disable_val(vals->srcr, avals->srcr,
+				keep_active);
+		stcr = fsl_ssi_disable_val(vals->stcr, avals->stcr,
+				keep_active);
 
 		regmap_update_bits(regs, CCSR_SSI_SRCR, srcr, 0);
 		regmap_update_bits(regs, CCSR_SSI_STCR, stcr, 0);
-- 
1.8.5.3
