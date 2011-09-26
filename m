From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend 3/4] ASoC: omap-mcpdm: API to configure
	offset cancellation
Date: Mon, 26 Sep 2011 16:05:58 +0300
Message-ID: <1317042359-27127-4-git-send-email-peter.ujfalusi@ti.com>
References: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 202D624394
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:06:24 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id zu17so5510787bkb.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:06:23 -0700 (PDT)
In-Reply-To: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The offset cancellation values can be different from board to board, even
on the same HW platform.
Provide a way for the machine drivers to configure the McPDM offset
cancellation.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |   25 +++++++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.h |   12 ++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 2c9fa51..41d1706 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -59,6 +59,9 @@ struct omap_mcpdm {
 	/* McPDM FIFO thresholds */
 	u32 dn_threshold;
 	u32 up_threshold;
+
+	/* McPDM dn offsets for rx1, and 2 channels */
+	u32 dn_rx_offset;
 };
 
 /*
@@ -183,6 +186,15 @@ static void omap_mcpdm_open_streams(struct omap_mcpdm *mcpdm)
 			MCPDM_DN_IRQ_EMPTY | MCPDM_DN_IRQ_FULL |
 			MCPDM_UP_IRQ_EMPTY | MCPDM_UP_IRQ_FULL);
 
+	/* Enable DN RX1/2 offset cancellation feature, if configured */
+	if (mcpdm->dn_rx_offset) {
+		u32 dn_offset = mcpdm->dn_rx_offset;
+
+		omap_mcpdm_write(mcpdm, MCPDM_REG_DN_OFFSET, dn_offset);
+		dn_offset |= (MCPDM_DN_OFST_RX1_EN | MCPDM_DN_OFST_RX2_EN);
+		omap_mcpdm_write(mcpdm, MCPDM_REG_DN_OFFSET, dn_offset);
+	}
+
 	omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_DN, mcpdm->dn_threshold);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_FIFO_CTRL_UP, mcpdm->up_threshold);
 
@@ -209,6 +221,10 @@ static void omap_mcpdm_close_streams(struct omap_mcpdm *mcpdm)
 
 	/* Disable DMA request generation for uplink */
 	omap_mcpdm_write(mcpdm, MCPDM_REG_DMAENABLE_CLR, MCPDM_DMA_UP_ENABLE);
+
+	/* Disable RX1/2 offset cancellation */
+	if (mcpdm->dn_rx_offset)
+		omap_mcpdm_write(mcpdm, MCPDM_REG_DN_OFFSET, 0);
 }
 
 static irqreturn_t omap_mcpdm_irq_handler(int irq, void *dev_id)
@@ -418,6 +434,15 @@ static struct snd_soc_dai_driver omap_mcpdm_dai = {
 	.ops = &omap_mcpdm_dai_ops,
 };
 
+void omap_mcpdm_configure_dn_offsets(struct snd_soc_pcm_runtime *rtd,
+				    u8 rx1, u8 rx2)
+{
+	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	mcpdm->dn_rx_offset = MCPDM_DNOFST_RX1(rx1) | MCPDM_DNOFST_RX2(rx2);
+}
+EXPORT_SYMBOL_GPL(omap_mcpdm_configure_dn_offsets);
+
 static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm;
diff --git a/sound/soc/omap/omap-mcpdm.h b/sound/soc/omap/omap-mcpdm.h
index d23122a..de8cf26 100644
--- a/sound/soc/omap/omap-mcpdm.h
+++ b/sound/soc/omap/omap-mcpdm.h
@@ -92,4 +92,16 @@
 #define MCPDM_UP_THRES_MAX		0xF
 #define MCPDM_DN_THRES_MAX		0xF
 
+/*
+ * MCPDM_DN_OFFSET bit fields
+ */
+
+#define MCPDM_DN_OFST_RX1_EN		(1 << 0)
+#define MCPDM_DNOFST_RX1(x)		((x & 0x1f) << 1)
+#define MCPDM_DN_OFST_RX2_EN		(1 << 8)
+#define MCPDM_DNOFST_RX2(x)		((x & 0x1f) << 9)
+
+void omap_mcpdm_configure_dn_offsets(struct snd_soc_pcm_runtime *rtd,
+				    u8 rx1, u8 rx2);
+
 #endif	/* End of __OMAP_MCPDM_H__ */
-- 
1.7.6.1
