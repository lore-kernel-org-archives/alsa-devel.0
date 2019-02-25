From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when
	stream starts
Date: Mon, 25 Feb 2019 02:48:18 +0000
Message-ID: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150040.outbound.protection.outlook.com [40.107.15.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C39EEF808F7
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 03:48:20 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

There is very low possibility ( < 0.1% ) that channel swap happened
in beginning when multi output/input pin is enabled. The issue is
that hardware can't send data to correct pin in the beginning with
the normal enable flow.

This is hardware issue, but there is no errata, the workaround flow
is that: Each time playback/recording, firstly clear the xSMA/xSMB,
then enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
before xSMA). Which is to use the xSMA as the trigger start register,
previously the xCR_TE or xCR_RE is the bit for starting.

Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v2
- update commit comments.

 sound/soc/fsl/fsl_esai.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index afe67c865330..23bd0ad4ac31 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -54,6 +54,8 @@ struct fsl_esai {
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
+	u32 tx_mask;
+	u32 rx_mask;
 	u32 hck_rate[2];
 	u32 sck_rate[2];
 	bool hck_dir[2];
@@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
 
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
-			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
-			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
-
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
 
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
-			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
-			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
-
 	esai_priv->slot_width = slot_width;
 	esai_priv->slots = slots;
+	esai_priv->tx_mask    = tx_mask;
+	esai_priv->rx_mask    = rx_mask;
 
 	return 0;
 }
@@ -596,6 +590,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u8 i, channels = substream->runtime->channels;
 	u32 pins = DIV_ROUND_UP(channels, esai_priv->slots);
+	u32 mask;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
 				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
+		mask = tx ? esai_priv->tx_mask : esai_priv->rx_mask;
+
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
+				   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(mask));
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
+				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
+
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
+				   ESAI_xSMA_xS_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
+				   ESAI_xSMB_xS_MASK, 0);
 
 		/* Disable and reset FIFO */
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
@@ -906,6 +912,12 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Clear the TSMA, TSMB, RSMA, RSMB */
+	regmap_write(esai_priv->regmap, REG_ESAI_TSMA, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_TSMB, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_RSMA, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_esai_component,
 					      &fsl_esai_dai, 1);
 	if (ret) {
-- 
1.9.1
