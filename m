From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/4] ASoC: fsl-utils: Add
	fsl_asoc_xlate_tdm_slot_mask() support.
Date: Fri, 21 Mar 2014 14:17:13 +0800
Message-ID: <1395382635-16349-3-git-send-email-Li.Xiubo@freescale.com>
References: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8E3265313
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:01:11 +0100 (CET)
In-Reply-To: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch add fsl_asoc_xlate_tdm_slot_mask() support for utils.
For the some spcified DAI driver, this will be used to generate the
TDM slot TX/RX mask. And the TX/RX mask will use a 0 bit for an active
slot as default, and the default active bits are at the LSB of
the masks.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_utils.c | 27 +++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h |  4 +++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index b9e42b5..2ac7755 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -86,6 +86,33 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 }
 EXPORT_SYMBOL(fsl_asoc_get_dma_channel);
 
+/**
+ * fsl_asoc_xlate_tdm_slot_mask - generate TDM slot TX/RX mask.
+ *
+ * @slots: Number of slots in use.
+ * @tx_mask: bitmask representing active TX slots.
+ * @rx_mask: bitmask representing active RX slots.
+ *
+ * This function used to generate the TDM slot TX/RX mask. And the TX/RX
+ * mask will use a 0 bit for an active slot as default, and the default
+ * active bits are at the LSB of the mask value.
+ */
+int fsl_asoc_xlate_tdm_slot_mask(unsigned int slots,
+				    unsigned int *tx_mask,
+				    unsigned int *rx_mask)
+{
+	if (!slots)
+		return -EINVAL;
+
+	if (tx_mask)
+		*tx_mask = ~((1 << slots) - 1);
+	if (rx_mask)
+		*rx_mask = ~((1 << slots) - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_xlate_tdm_slot_mask);
+
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale ASoC utility code");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
index b295112..df535db 100644
--- a/sound/soc/fsl/fsl_utils.h
+++ b/sound/soc/fsl/fsl_utils.h
@@ -22,5 +22,7 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np, const char *name,
 			     struct snd_soc_dai_link *dai,
 			     unsigned int *dma_channel_id,
 			     unsigned int *dma_id);
-
+int fsl_asoc_xlate_tdm_slot_mask(unsigned int slots,
+				    unsigned int *tx_mask,
+				    unsigned int *rx_mask);
 #endif /* _FSL_UTILS_H */
-- 
1.8.4
