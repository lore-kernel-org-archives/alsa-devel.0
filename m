From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: arizona: Use async writes
Date: Thu, 12 Dec 2013 11:07:38 +0000
Message-ID: <1386846461-32325-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F8A12608D6
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 12:07:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Where possible write to the device asynchronously, allowing better
performance when used with a bus like SPI which supports this by
minimising the need to context switch back to the driver to get the
next bit of data.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/arizona.c | 163 +++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 74 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index eb9f5d4d8928..6bfd8031c0c9 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -93,7 +93,7 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		if (!priv->spk_ena && manual_ena) {
-			snd_soc_write(codec, 0x4f5, 0x25a);
+			regmap_write_async(arizona->regmap, 0x4f5, 0x25a);
 			priv->spk_ena_pending = true;
 		}
 		break;
@@ -105,12 +105,13 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 			return -EBUSY;
 		}
 
-		snd_soc_update_bits(codec, ARIZONA_OUTPUT_ENABLES_1,
-				    1 << w->shift, 1 << w->shift);
+		regmap_update_bits_async(arizona->regmap,
+					 ARIZONA_OUTPUT_ENABLES_1,
+					 1 << w->shift, 1 << w->shift);
 
 		if (priv->spk_ena_pending) {
 			msleep(75);
-			snd_soc_write(codec, 0x4f5, 0xda);
+			regmap_write_async(arizona->regmap, 0x4f5, 0xda);
 			priv->spk_ena_pending = false;
 			priv->spk_ena++;
 		}
@@ -119,16 +120,19 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 		if (manual_ena) {
 			priv->spk_ena--;
 			if (!priv->spk_ena)
-				snd_soc_write(codec, 0x4f5, 0x25a);
+				regmap_write_async(arizona->regmap,
+						   0x4f5, 0x25a);
 		}
 
-		snd_soc_update_bits(codec, ARIZONA_OUTPUT_ENABLES_1,
-				    1 << w->shift, 0);
+		regmap_update_bits_async(arizona->regmap,
+					 ARIZONA_OUTPUT_ENABLES_1,
+					 1 << w->shift, 0);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		if (manual_ena) {
 			if (!priv->spk_ena)
-				snd_soc_write(codec, 0x4f5, 0x0da);
+				regmap_write_async(arizona->regmap,
+						   0x4f5, 0x0da);
 		}
 		break;
 	}
@@ -687,6 +691,7 @@ int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 		   int event)
 {
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(w->codec);
+	struct arizona *arizona = priv->arizona;
 	unsigned int mask = 1 << w->shift;
 	unsigned int val;
 
@@ -709,7 +714,8 @@ int arizona_hp_ev(struct snd_soc_dapm_widget *w,
 	if (priv->arizona->hpdet_magic)
 		val = 0;
 
-	snd_soc_update_bits(w->codec, ARIZONA_OUTPUT_ENABLES_1, mask, val);
+	regmap_update_bits_async(arizona->regmap, ARIZONA_OUTPUT_ENABLES_1,
+				 mask, val);
 
 	return arizona_out_ev(w, kcontrol, event);
 }
@@ -864,6 +870,8 @@ EXPORT_SYMBOL_GPL(arizona_set_sysclk);
 static int arizona_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->arizona;
 	int lrclk, bclk, mode, base;
 
 	base = dai->driver->base;
@@ -920,17 +928,19 @@ static int arizona_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_BCLK_CTRL,
-			    ARIZONA_AIF1_BCLK_INV | ARIZONA_AIF1_BCLK_MSTR,
-			    bclk);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_PIN_CTRL,
-			    ARIZONA_AIF1TX_LRCLK_INV |
-			    ARIZONA_AIF1TX_LRCLK_MSTR, lrclk);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_RX_PIN_CTRL,
-			    ARIZONA_AIF1RX_LRCLK_INV |
-			    ARIZONA_AIF1RX_LRCLK_MSTR, lrclk);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_FORMAT,
-			    ARIZONA_AIF1_FMT_MASK, mode);
+	regmap_update_bits_async(arizona->regmap, base + ARIZONA_AIF_BCLK_CTRL,
+				 ARIZONA_AIF1_BCLK_INV |
+				 ARIZONA_AIF1_BCLK_MSTR,
+				 bclk);
+	regmap_update_bits_async(arizona->regmap, base + ARIZONA_AIF_TX_PIN_CTRL,
+				 ARIZONA_AIF1TX_LRCLK_INV |
+				 ARIZONA_AIF1TX_LRCLK_MSTR, lrclk);
+	regmap_update_bits_async(arizona->regmap,
+				 base + ARIZONA_AIF_RX_PIN_CTRL,
+				 ARIZONA_AIF1RX_LRCLK_INV |
+				 ARIZONA_AIF1RX_LRCLK_MSTR, lrclk);
+	regmap_update_bits(arizona->regmap, base + ARIZONA_AIF_FORMAT,
+			   ARIZONA_AIF1_FMT_MASK, mode);
 
 	return 0;
 }
@@ -1182,18 +1192,22 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	if (ret != 0)
 		return ret;
 
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_BCLK_CTRL,
-			    ARIZONA_AIF1_BCLK_FREQ_MASK, bclk);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_BCLK_RATE,
-			    ARIZONA_AIF1TX_BCPF_MASK, lrclk);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_RX_BCLK_RATE,
-			    ARIZONA_AIF1RX_BCPF_MASK, lrclk);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_FRAME_CTRL_1,
-			    ARIZONA_AIF1TX_WL_MASK |
-			    ARIZONA_AIF1TX_SLOT_LEN_MASK, frame);
-	snd_soc_update_bits(codec, base + ARIZONA_AIF_FRAME_CTRL_2,
-			    ARIZONA_AIF1RX_WL_MASK |
-			    ARIZONA_AIF1RX_SLOT_LEN_MASK, frame);
+	regmap_update_bits_async(arizona->regmap,
+				 base + ARIZONA_AIF_BCLK_CTRL,
+				 ARIZONA_AIF1_BCLK_FREQ_MASK, bclk);
+	regmap_update_bits_async(arizona->regmap,
+				 base + ARIZONA_AIF_TX_BCLK_RATE,
+				 ARIZONA_AIF1TX_BCPF_MASK, lrclk);
+	regmap_update_bits_async(arizona->regmap,
+				 base + ARIZONA_AIF_RX_BCLK_RATE,
+				 ARIZONA_AIF1RX_BCPF_MASK, lrclk);
+	regmap_update_bits_async(arizona->regmap,
+				 base + ARIZONA_AIF_FRAME_CTRL_1,
+				 ARIZONA_AIF1TX_WL_MASK |
+				 ARIZONA_AIF1TX_SLOT_LEN_MASK, frame);
+	regmap_update_bits(arizona->regmap, base + ARIZONA_AIF_FRAME_CTRL_2,
+			   ARIZONA_AIF1RX_WL_MASK |
+			   ARIZONA_AIF1RX_SLOT_LEN_MASK, frame);
 
 	return 0;
 }
@@ -1446,31 +1460,31 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 			      struct arizona_fll_cfg *cfg, int source,
 			      bool sync)
 {
-	regmap_update_bits(arizona->regmap, base + 3,
-			   ARIZONA_FLL1_THETA_MASK, cfg->theta);
-	regmap_update_bits(arizona->regmap, base + 4,
-			   ARIZONA_FLL1_LAMBDA_MASK, cfg->lambda);
-	regmap_update_bits(arizona->regmap, base + 5,
-			   ARIZONA_FLL1_FRATIO_MASK,
-			   cfg->fratio << ARIZONA_FLL1_FRATIO_SHIFT);
-	regmap_update_bits(arizona->regmap, base + 6,
-			   ARIZONA_FLL1_CLK_REF_DIV_MASK |
-			   ARIZONA_FLL1_CLK_REF_SRC_MASK,
-			   cfg->refdiv << ARIZONA_FLL1_CLK_REF_DIV_SHIFT |
-			   source << ARIZONA_FLL1_CLK_REF_SRC_SHIFT);
+	regmap_update_bits_async(arizona->regmap, base + 3,
+				 ARIZONA_FLL1_THETA_MASK, cfg->theta);
+	regmap_update_bits_async(arizona->regmap, base + 4,
+				 ARIZONA_FLL1_LAMBDA_MASK, cfg->lambda);
+	regmap_update_bits_async(arizona->regmap, base + 5,
+				 ARIZONA_FLL1_FRATIO_MASK,
+				 cfg->fratio << ARIZONA_FLL1_FRATIO_SHIFT);
+	regmap_update_bits_async(arizona->regmap, base + 6,
+				 ARIZONA_FLL1_CLK_REF_DIV_MASK |
+				 ARIZONA_FLL1_CLK_REF_SRC_MASK,
+				 cfg->refdiv << ARIZONA_FLL1_CLK_REF_DIV_SHIFT |
+				 source << ARIZONA_FLL1_CLK_REF_SRC_SHIFT);
 
 	if (sync)
-		regmap_update_bits(arizona->regmap, base + 0x7,
-				   ARIZONA_FLL1_GAIN_MASK,
-				   cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+		regmap_update_bits_async(arizona->regmap, base + 0x7,
+					 ARIZONA_FLL1_GAIN_MASK,
+					 cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
 	else
-		regmap_update_bits(arizona->regmap, base + 0x9,
-				   ARIZONA_FLL1_GAIN_MASK,
-				   cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+		regmap_update_bits_async(arizona->regmap, base + 0x9,
+					 ARIZONA_FLL1_GAIN_MASK,
+					 cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
 
-	regmap_update_bits(arizona->regmap, base + 2,
-			   ARIZONA_FLL1_CTRL_UPD | ARIZONA_FLL1_N_MASK,
-			   ARIZONA_FLL1_CTRL_UPD | cfg->n);
+	regmap_update_bits_async(arizona->regmap, base + 2,
+				 ARIZONA_FLL1_CTRL_UPD | ARIZONA_FLL1_N_MASK,
+				 ARIZONA_FLL1_CTRL_UPD | cfg->n);
 }
 
 static bool arizona_is_enabled_fll(struct arizona_fll *fll)
@@ -1503,9 +1517,9 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	 */
 	if (fll->ref_src >= 0 && fll->ref_freq &&
 	    fll->ref_src != fll->sync_src) {
-		regmap_update_bits(arizona->regmap, fll->base + 5,
-				   ARIZONA_FLL1_OUTDIV_MASK,
-				   ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+		regmap_update_bits_async(arizona->regmap, fll->base + 5,
+					 ARIZONA_FLL1_OUTDIV_MASK,
+					 ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
 
 		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src,
 				  false);
@@ -1515,15 +1529,15 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 			use_sync = true;
 		}
 	} else if (fll->sync_src >= 0) {
-		regmap_update_bits(arizona->regmap, fll->base + 5,
-				   ARIZONA_FLL1_OUTDIV_MASK,
-				   sync->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+		regmap_update_bits_async(arizona->regmap, fll->base + 5,
+					 ARIZONA_FLL1_OUTDIV_MASK,
+					 sync->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
 
 		arizona_apply_fll(arizona, fll->base, sync,
 				  fll->sync_src, false);
 
-		regmap_update_bits(arizona->regmap, fll->base + 0x11,
-				   ARIZONA_FLL1_SYNC_ENA, 0);
+		regmap_update_bits_async(arizona->regmap, fll->base + 0x11,
+					 ARIZONA_FLL1_SYNC_ENA, 0);
 	} else {
 		arizona_fll_err(fll, "No clocks provided\n");
 		return;
@@ -1534,11 +1548,12 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	 * sync source.
 	 */
 	if (use_sync && fll->sync_freq > 100000)
-		regmap_update_bits(arizona->regmap, fll->base + 0x17,
-				   ARIZONA_FLL1_SYNC_BW, 0);
+		regmap_update_bits_async(arizona->regmap, fll->base + 0x17,
+					 ARIZONA_FLL1_SYNC_BW, 0);
 	else
-		regmap_update_bits(arizona->regmap, fll->base + 0x17,
-				   ARIZONA_FLL1_SYNC_BW, ARIZONA_FLL1_SYNC_BW);
+		regmap_update_bits_async(arizona->regmap, fll->base + 0x17,
+					 ARIZONA_FLL1_SYNC_BW,
+					 ARIZONA_FLL1_SYNC_BW);
 
 	if (!arizona_is_enabled_fll(fll))
 		pm_runtime_get(arizona->dev);
@@ -1546,14 +1561,14 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	/* Clear any pending completions */
 	try_wait_for_completion(&fll->ok);
 
-	regmap_update_bits(arizona->regmap, fll->base + 1,
-			   ARIZONA_FLL1_FREERUN, 0);
-	regmap_update_bits(arizona->regmap, fll->base + 1,
-			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
+	regmap_update_bits_async(arizona->regmap, fll->base + 1,
+				 ARIZONA_FLL1_FREERUN, 0);
+	regmap_update_bits_async(arizona->regmap, fll->base + 1,
+				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
 	if (use_sync)
-		regmap_update_bits(arizona->regmap, fll->base + 0x11,
-				   ARIZONA_FLL1_SYNC_ENA,
-				   ARIZONA_FLL1_SYNC_ENA);
+		regmap_update_bits_async(arizona->regmap, fll->base + 0x11,
+					 ARIZONA_FLL1_SYNC_ENA,
+					 ARIZONA_FLL1_SYNC_ENA);
 
 	ret = wait_for_completion_timeout(&fll->ok,
 					  msecs_to_jiffies(250));
@@ -1566,8 +1581,8 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 	struct arizona *arizona = fll->arizona;
 	bool change;
 
-	regmap_update_bits(arizona->regmap, fll->base + 1,
-			   ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
+	regmap_update_bits_async(arizona->regmap, fll->base + 1,
+				 ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
 	regmap_update_bits_check(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_ENA, 0, &change);
 	regmap_update_bits(arizona->regmap, fll->base + 0x11,
-- 
1.8.5.1
