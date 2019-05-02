From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/5] ASoC: mediatek: make agent_disable, msb & hd fields optional
Date: Thu,  2 May 2019 14:10:37 +0200
Message-ID: <20190502121041.8045-2-fparent@baylibre.com>
References: <20190502121041.8045-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502121041.8045-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Not every SoC have the following registers: agent_disable_reg,
msg_reg, and hd_reg. Make them optional in order to allow more
SoC to use the common DAI FE code.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index cf4978be062f..f39f5d8c4244 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -47,10 +47,13 @@ int mtk_afe_fe_startup(struct snd_pcm_substream *substream,
 
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 16);
+
 	/* enable agent */
-	mtk_regmap_update_bits(afe->regmap, memif->data->agent_disable_reg,
-			       1 << memif->data->agent_disable_shift,
-			       0 << memif->data->agent_disable_shift);
+	if (memif->data->agent_disable_shift >= 0)
+		mtk_regmap_update_bits(afe->regmap,
+				       memif->data->agent_disable_reg,
+				       1 << memif->data->agent_disable_shift,
+				       0 << memif->data->agent_disable_shift);
 
 	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
 
@@ -143,9 +146,10 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 			 memif->phys_buf_addr + memif->buffer_size - 1);
 
 	/* set MSB to 33-bit */
-	mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
-			       1 << memif->data->msb_shift,
-			       msb_at_bit33 << memif->data->msb_shift);
+	if (memif->data->msb_shift >= 0)
+		mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
+				       1 << memif->data->msb_shift,
+				       msb_at_bit33 << memif->data->msb_shift);
 
 	/* set channel */
 	if (memif->data->mono_shift >= 0) {
@@ -269,9 +273,10 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
-			       1 << memif->data->hd_shift,
-			       hd_audio << memif->data->hd_shift);
+	if (memif->data->hd_shift >= 0)
+		mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
+				       1 << memif->data->hd_shift,
+				       hd_audio << memif->data->hd_shift);
 
 	return 0;
 }
-- 
2.20.1
