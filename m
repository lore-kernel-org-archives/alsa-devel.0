From: Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH 2/2] ASoC: mediatek: Reduce repititive code on mtk_regmap_update_bits.
Date: Wed,  6 Mar 2019 17:09:03 +0800
Message-ID: <20190306090922.117634-3-pihsun@chromium.org>
References: <20190306090922.117634-1-pihsun@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306090922.117634-1-pihsun@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pi-Hsun Shih <pihsun@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Garlic Tseng <garlic.tseng@mediatek.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-mediatek@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Change the signature of mtk_regmap_update_bits to also take a shift, and
warn when reg >= 0 but shift < 0. This reduce the code repetition
on the calling side, and prevent future UBSAN warning when some of the
xxx_shift and xxx_reg are both set to -1.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 46 +++++++++-------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3830e582e188..fded11d14cde 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -18,11 +18,11 @@
 
 static int mtk_regmap_update_bits(struct regmap *map, int reg,
 			   unsigned int mask,
-			   unsigned int val)
+			   unsigned int val, int shift)
 {
-	if (reg < 0)
+	if (reg < 0 || WARN_ON_ONCE(shift < 0))
 		return 0;
-	return regmap_update_bits(map, reg, mask, val);
+	return regmap_update_bits(map, reg, mask << shift, val << shift);
 }
 
 static int mtk_regmap_write(struct regmap *map, int reg, unsigned int val)
@@ -49,8 +49,7 @@ int mtk_afe_fe_startup(struct snd_pcm_substream *substream,
 				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 16);
 	/* enable agent */
 	mtk_regmap_update_bits(afe->regmap, memif->data->agent_disable_reg,
-			       1 << memif->data->agent_disable_shift,
-			       0 << memif->data->agent_disable_shift);
+			       1, 0, memif->data->agent_disable_shift);
 
 	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
 
@@ -105,8 +104,7 @@ void mtk_afe_fe_shutdown(struct snd_pcm_substream *substream,
 	irq_id = memif->irq_usage;
 
 	mtk_regmap_update_bits(afe->regmap, memif->data->agent_disable_reg,
-			       1 << memif->data->agent_disable_shift,
-			       1 << memif->data->agent_disable_shift);
+			       1, 1, memif->data->agent_disable_shift);
 
 	if (!memif->const_irq) {
 		mtk_dynamic_irq_release(afe, irq_id);
@@ -144,16 +142,14 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 
 	/* set MSB to 33-bit */
 	mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
-			       1 << memif->data->msb_shift,
-			       msb_at_bit33 << memif->data->msb_shift);
+			       1, msb_at_bit33, memif->data->msb_shift);
 
 	/* set channel */
 	if (memif->data->mono_shift >= 0) {
 		unsigned int mono = (params_channels(params) == 1) ? 1 : 0;
 
 		mtk_regmap_update_bits(afe->regmap, memif->data->mono_reg,
-				       1 << memif->data->mono_shift,
-				       mono << memif->data->mono_shift);
+				       1, mono, memif->data->mono_shift);
 	}
 
 	/* set rate */
@@ -166,8 +162,8 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	mtk_regmap_update_bits(afe->regmap, memif->data->fs_reg,
-			       memif->data->fs_maskbit << memif->data->fs_shift,
-			       fs << memif->data->fs_shift);
+			       memif->data->fs_maskbit, fs,
+			       memif->data->fs_shift);
 
 	return 0;
 }
@@ -199,14 +195,12 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 		mtk_regmap_update_bits(afe->regmap,
 				       memif->data->enable_reg,
-				       1 << memif->data->enable_shift,
-				       1 << memif->data->enable_shift);
+				       1, 1, memif->data->enable_shift);
 
 		/* set irq counter */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
-				       irq_data->irq_cnt_maskbit
-				       << irq_data->irq_cnt_shift,
-				       counter << irq_data->irq_cnt_shift);
+				       irq_data->irq_cnt_maskbit, counter,
+				       irq_data->irq_cnt_shift);
 
 		/* set irq fs */
 		fs = afe->irq_fs(substream, runtime->rate);
@@ -215,24 +209,21 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 			return -EINVAL;
 
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
-				       irq_data->irq_fs_maskbit
-				       << irq_data->irq_fs_shift,
-				       fs << irq_data->irq_fs_shift);
+				       irq_data->irq_fs_maskbit, fs,
+				       irq_data->irq_fs_shift);
 
 		/* enable interrupt */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_en_reg,
-				       1 << irq_data->irq_en_shift,
-				       1 << irq_data->irq_en_shift);
+				       1, 1, irq_data->irq_en_shift);
 
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		mtk_regmap_update_bits(afe->regmap, memif->data->enable_reg,
-				       1 << memif->data->enable_shift, 0);
+				       1, 0, memif->data->enable_shift);
 		/* disable interrupt */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_en_reg,
-				       1 << irq_data->irq_en_shift,
-				       0 << irq_data->irq_en_shift);
+				       1, 0, irq_data->irq_en_shift);
 		/* and clear pending IRQ */
 		mtk_regmap_write(afe->regmap, irq_data->irq_clr_reg,
 				 1 << irq_data->irq_clr_shift);
@@ -269,8 +260,7 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 	}
 
 	mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
-			       1 << memif->data->hd_shift,
-			       hd_audio << memif->data->hd_shift);
+			       1, hd_audio, memif->data->hd_shift);
 
 	return 0;
 }
-- 
2.21.0.352.gf09ad66450-goog
