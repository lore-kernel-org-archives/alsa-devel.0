From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Date: Tue, 5 Aug 2014 15:32:05 +0800
Message-ID: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

SAI supports these operation modes:
1) asynchronous mode
   Both Tx and Rx are set to be asynchronous.
2) synchronous mode (Rx sync with Tx)
   Tx is set to be asynchronous, Rx is set to be synchronous.
3) synchronous mode (Tx sync with Rx)
   Rx is set to be asynchronous, Tx is set to be synchronous.
4) synchronous mode (Tx/Rx sync with another SAI's Tx)
5) synchronous mode (Tx/Rx sync with another SAI's Rx)

* 4) and 5) are beyond this patch because they are related with another SAI.

As the initial version of this SAI driver, it supported 2) as default while
the others were totally missing.

So this patch just adds supports for 1) and 3).

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/sound/fsl-sai.txt          | 16 ++++++++++++
 sound/soc/fsl/fsl_sai.c                            | 30 +++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h                            |  4 +++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 0f4e238..77864f4 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -24,6 +24,22 @@ Required properties:
 - big-endian-data: If this property is absent, the little endian mode will
   be in use as default, or the big endian mode will be in use for all the
   fifo data.
+- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
+  that SAI will work in the synchronous mode (sync Tx with Rx) which means
+  both the transimitter and receiver will send and receive data by following
+  receiver's bit clocks and frame sync clocks.
+- fsl,sai-asynchronous: This is a boolean property. If present, indicating
+  that SAI will work in the asynchronous mode, which means both transimitter
+  and receiver will send and receive data by following their own bit clocks
+  and frame sync clocks separately.
+
+Note:
+- If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
+  default synchronous mode (sync Rx with Tx) will be used, which means both
+  transimitter and receiver will send and receive data by following clocks
+  of transimitter.
+- fsl,sai-asynchronous will be ignored if fsl,sai-synchronous-rx property is
+  already present.
 
 Example:
 sai2: sai@40031000 {
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9f10575..dc84f98 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -330,12 +330,14 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	u32 xcsr, count = 100;
 
 	/*
-	 * The transmitter bit clock and frame sync are to be
-	 * used by both the transmitter and receiver.
+	 * Asynchronous mode: Clear SYNC for both Tx and Rx.
+	 * Rx sync with Tx clocks: Clear SYNC for Tx, set it for Rx.
+	 * Tx sync with Rx clocks: Clear SYNC for Rx, set it for Tx.
 	 */
-	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
+			   sai->synchronous[TX] ? FSL_SAI_CR2_SYNC : 0);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
-			   FSL_SAI_CR2_SYNC);
+			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
 
 	/*
 	 * It is recommended that the transmitter is the last enabled
@@ -620,6 +622,26 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Sync Tx with Rx as default by following old DT binding */
+	sai->synchronous[RX] = true;
+	sai->synchronous[TX] = false;
+	fsl_sai_dai.symmetric_rates = 1;
+	fsl_sai_dai.symmetric_channels = 1;
+	fsl_sai_dai.symmetric_samplebits = 1;
+
+	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL)) {
+		/* Sync Rx with Tx */
+		sai->synchronous[RX] = false;
+		sai->synchronous[TX] = true;
+	} else if (of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+		/* Discard all settings for asynchronous mode */
+		sai->synchronous[RX] = false;
+		sai->synchronous[TX] = false;
+		fsl_sai_dai.symmetric_rates = 0;
+		fsl_sai_dai.symmetric_channels = 0;
+		fsl_sai_dai.symmetric_samplebits = 0;
+	}
+
 	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR;
 	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR;
 	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0e6c9f5..c24d3fd 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -135,9 +135,13 @@ struct fsl_sai {
 	bool big_endian_data;
 	bool is_dsp_mode;
 	bool sai_on_imx;
+	bool synchronous[2];
 
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
 
+#define TX 1
+#define RX 0
+
 #endif /* __FSL_SAI_H */
-- 
1.8.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
