From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: fsl: Remove
	fsl_asoc_xlate_tdm_slot_mask()
Date: Sat, 10 Jan 2015 11:52:36 +0100
Message-ID: <1420887157-18593-4-git-send-email-lars@metafoo.de>
References: <1420887157-18593-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-105.synserver.de (smtp-out-105.synserver.de
 [212.40.185.105])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D742606AC
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 11:52:43 +0100 (CET)
In-Reply-To: <1420887157-18593-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Now that the fsl DAI drivers uses the same semantics as the rest of a ASoC
the custom fsl_asoc_xlate_tdm_slot_mask() callback can be removed as it is
identical to the generic one.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/fsl_utils.c | 27 ---------------------------
 sound/soc/fsl/fsl_utils.h |  3 ---
 sound/soc/fsl/imx-ssi.c   |  1 -
 3 files changed, 31 deletions(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 5fd4463..b9e42b5 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -86,33 +86,6 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 }
 EXPORT_SYMBOL(fsl_asoc_get_dma_channel);
 
-/**
- * fsl_asoc_xlate_tdm_slot_mask - generate TDM slot TX/RX mask.
- *
- * @slots: Number of slots in use.
- * @tx_mask: bitmask representing active TX slots.
- * @rx_mask: bitmask representing active RX slots.
- *
- * This function used to generate the TDM slot TX/RX mask. And the TX/RX
- * mask will use a 1 bit for an active slot as default, and the default
- * active bits are at the LSB of the mask value.
- */
-int fsl_asoc_xlate_tdm_slot_mask(unsigned int slots,
-				    unsigned int *tx_mask,
-				    unsigned int *rx_mask)
-{
-	if (!slots)
-		return -EINVAL;
-
-	if (tx_mask)
-		*tx_mask = ((1 << slots) - 1);
-	if (rx_mask)
-		*rx_mask = ((1 << slots) - 1);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(fsl_asoc_xlate_tdm_slot_mask);
-
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
 MODULE_DESCRIPTION("Freescale ASoC utility code");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
index df535db..1687b66 100644
--- a/sound/soc/fsl/fsl_utils.h
+++ b/sound/soc/fsl/fsl_utils.h
@@ -22,7 +22,4 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np, const char *name,
 			     struct snd_soc_dai_link *dai,
 			     unsigned int *dma_channel_id,
 			     unsigned int *dma_id);
-int fsl_asoc_xlate_tdm_slot_mask(unsigned int slots,
-				    unsigned int *tx_mask,
-				    unsigned int *rx_mask);
 #endif /* _FSL_UTILS_H */
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 6aeaac3..461ce27 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -340,7 +340,6 @@ static const struct snd_soc_dai_ops imx_ssi_pcm_dai_ops = {
 	.set_fmt	= imx_ssi_set_dai_fmt,
 	.set_clkdiv	= imx_ssi_set_dai_clkdiv,
 	.set_sysclk	= imx_ssi_set_dai_sysclk,
-	.xlate_tdm_slot_mask = fsl_asoc_xlate_tdm_slot_mask,
 	.set_tdm_slot	= imx_ssi_set_dai_tdm_slot,
 	.trigger	= imx_ssi_trigger,
 };
-- 
1.8.0
