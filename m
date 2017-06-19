From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] ASoC: da7219: Fix HP detection procedure
 for all MCLK frequencies
Date: Mon, 19 Jun 2017 10:56:33 +0100
Message-ID: <509541b8636dccb28fe788fba9f716f4e13141e9.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CADC266851
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 11:56:35 +0200 (CEST)
In-Reply-To: <cover.1497865554.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Cc: Harsha Priya <harshapriya.n@intel.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently when HP detection procedure runs for certain MCLK
frequencies, when PLL is bypassed, the procedure will incorrectly
report Lineout instead of Headphones due to timing incosistencies.
To avoid this problem, the PLL is temporarily enabled (if currently
bypassed and MCLK present) to provide consistent timings for the
procedure, regardless of MCLK frequency.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/codecs/da7219-aad.c | 31 +++++++++++++++++++------
 sound/soc/codecs/da7219.c     | 53 +++++++++++++++++++++++++++++--------------
 sound/soc/codecs/da7219.h     |  5 +++-
 3 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 6274d79..1d1d10d 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -115,19 +115,21 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 
 	u16 tonegen_freq_hptest;
-	u8 pll_srm_sts, gain_ramp_ctrl, accdet_cfg8;
+	u8 pll_srm_sts, pll_ctrl, gain_ramp_ctrl, accdet_cfg8;
 	int report = 0, ret = 0;
 
-	/* Lock DAPM and any Kcontrols that are affected by this test */
+	/* Lock DAPM, Kcontrols affected by this test and the PLL */
 	snd_soc_dapm_mutex_lock(dapm);
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
+	mutex_lock(&da7219->pll_lock);
 
 	/* Ensure MCLK is available for HP test procedure */
 	if (da7219->mclk) {
 		ret = clk_prepare_enable(da7219->mclk);
 		if (ret) {
 			dev_err(codec->dev, "Failed to enable mclk - %d\n", ret);
-			mutex_unlock(&da7219->lock);
+			mutex_unlock(&da7219->pll_lock);
+			mutex_unlock(&da7219->ctrl_lock);
 			snd_soc_dapm_mutex_unlock(dapm);
 			return;
 		}
@@ -136,12 +138,21 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	/*
 	 * If MCLK not present, then we're using the internal oscillator and
 	 * require different frequency settings to achieve the same result.
+	 *
+	 * If MCLK is present, but PLL is not enabled then we enable it here to
+	 * ensure a consistent detection procedure.
 	 */
 	pll_srm_sts = snd_soc_read(codec, DA7219_PLL_SRM_STS);
-	if (pll_srm_sts & DA7219_PLL_SRM_STS_MCLK)
+	if (pll_srm_sts & DA7219_PLL_SRM_STS_MCLK) {
 		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ);
-	else
+
+		pll_ctrl = snd_soc_read(codec, DA7219_PLL_CTRL);
+		if ((pll_ctrl & DA7219_PLL_MODE_MASK) == DA7219_PLL_MODE_BYPASS)
+			da7219_set_pll(codec, DA7219_SYSCLK_PLL,
+				       DA7219_PLL_FREQ_OUT_98304);
+	} else {
 		tonegen_freq_hptest = cpu_to_le16(DA7219_AAD_HPTEST_RAMP_FREQ_INT_OSC);
+	}
 
 	/* Ensure gain ramping at fastest rate */
 	gain_ramp_ctrl = snd_soc_read(codec, DA7219_GAIN_RAMP_CTRL);
@@ -302,11 +313,17 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	snd_soc_update_bits(codec, DA7219_HP_R_CTRL, DA7219_HP_R_AMP_OE_MASK,
 			    DA7219_HP_R_AMP_OE_MASK);
 
+	/* Restore PLL to previous configuration, if re-configured */
+	if ((pll_srm_sts & DA7219_PLL_SRM_STS_MCLK) &&
+	    ((pll_ctrl & DA7219_PLL_MODE_MASK) == DA7219_PLL_MODE_BYPASS))
+		da7219_set_pll(codec, DA7219_SYSCLK_MCLK, 0);
+
 	/* Remove MCLK, if previously enabled */
 	if (da7219->mclk)
 		clk_disable_unprepare(da7219->mclk);
 
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->pll_lock);
+	mutex_unlock(&da7219->ctrl_lock);
 	snd_soc_dapm_mutex_unlock(dapm);
 
 	/*
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 9960162..f71d72c 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -260,9 +260,9 @@ static int da7219_volsw_locked_get(struct snd_kcontrol *kcontrol,
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
 	ret = snd_soc_get_volsw(kcontrol, ucontrol);
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->ctrl_lock);
 
 	return ret;
 }
@@ -274,9 +274,9 @@ static int da7219_volsw_locked_put(struct snd_kcontrol *kcontrol,
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->ctrl_lock);
 
 	return ret;
 }
@@ -288,9 +288,9 @@ static int da7219_enum_locked_get(struct snd_kcontrol *kcontrol,
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
 	ret = snd_soc_get_enum_double(kcontrol, ucontrol);
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->ctrl_lock);
 
 	return ret;
 }
@@ -302,9 +302,9 @@ static int da7219_enum_locked_put(struct snd_kcontrol *kcontrol,
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
 	ret = snd_soc_put_enum_double(kcontrol, ucontrol);
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->ctrl_lock);
 
 	return ret;
 }
@@ -424,9 +424,9 @@ static int da7219_tonegen_freq_get(struct snd_kcontrol *kcontrol,
 	u16 val;
 	int ret;
 
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
 	ret = regmap_raw_read(da7219->regmap, reg, &val, sizeof(val));
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->ctrl_lock);
 
 	if (ret)
 		return ret;
@@ -458,9 +458,9 @@ static int da7219_tonegen_freq_put(struct snd_kcontrol *kcontrol,
 	 */
 	val = cpu_to_le16(ucontrol->value.integer.value[0]);
 
-	mutex_lock(&da7219->lock);
+	mutex_lock(&da7219->ctrl_lock);
 	ret = regmap_raw_write(da7219->regmap, reg, &val, sizeof(val));
-	mutex_unlock(&da7219->lock);
+	mutex_unlock(&da7219->ctrl_lock);
 
 	return ret;
 }
@@ -801,7 +801,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(50);
 			}
-		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
+		} while ((i < DA7219_SRM_CHECK_RETRIES) & (!srm_lock));
 
 		if (!srm_lock)
 			dev_warn(codec->dev, "SRM failed to lock\n");
@@ -1129,6 +1129,8 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
+	mutex_lock(&da7219->pll_lock);
+
 	switch (clk_id) {
 	case DA7219_CLKSRC_MCLK_SQR:
 		snd_soc_update_bits(codec, DA7219_PLL_CTRL,
@@ -1141,6 +1143,7 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		break;
 	default:
 		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
+		mutex_unlock(&da7219->pll_lock);
 		return -EINVAL;
 	}
 
@@ -1152,19 +1155,20 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		if (ret) {
 			dev_err(codec_dai->dev, "Failed to set clock rate %d\n",
 				freq);
+			mutex_unlock(&da7219->pll_lock);
 			return ret;
 		}
 	}
 
 	da7219->mclk_rate = freq;
 
+	mutex_unlock(&da7219->pll_lock);
+
 	return 0;
 }
 
-static int da7219_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
-			      int source, unsigned int fref, unsigned int fout)
+int da7219_set_pll(struct snd_soc_codec *codec, int source, unsigned int fout)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 
 	u8 pll_ctrl, indiv_bits, indiv;
@@ -1237,6 +1241,20 @@ static int da7219_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	return 0;
 }
 
+static int da7219_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+			      int source, unsigned int fref, unsigned int fout)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&da7219->pll_lock);
+	ret = da7219_set_pll(codec, source, fout);
+	mutex_unlock(&da7219->pll_lock);
+
+	return ret;
+}
+
 static int da7219_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1741,7 +1759,8 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	unsigned int rev;
 	int ret;
 
-	mutex_init(&da7219->lock);
+	mutex_init(&da7219->ctrl_lock);
+	mutex_init(&da7219->pll_lock);
 
 	/* Regulator configuration */
 	ret = da7219_handle_supplies(codec);
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 6baba74..8d6c3c8 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -810,7 +810,8 @@ struct da7219_priv {
 	bool wakeup_source;
 	struct regulator_bulk_data supplies[DA7219_NUM_SUPPLIES];
 	struct regmap *regmap;
-	struct mutex lock;
+	struct mutex ctrl_lock;
+	struct mutex pll_lock;
 
 	struct clk *mclk;
 	unsigned int mclk_rate;
@@ -821,4 +822,6 @@ struct da7219_priv {
 	u8 gain_ramp_ctrl;
 };
 
+int da7219_set_pll(struct snd_soc_codec *codec, int source, unsigned int fout);
+
 #endif /* __DA7219_H */
-- 
1.9.1
