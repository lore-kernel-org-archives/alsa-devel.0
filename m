From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 06/12] ASoC: wm_adsp: Move wm_adsp2_set_dspclk
	to CODEC drivers
Date: Tue, 19 Mar 2019 11:52:09 +0000
Message-ID: <20190319115215.22960-7-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CAAAF896F5
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:18 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

The original wm_adsp2_early_event took an additional frequency
argument for clocking control so could not be used directly as a
DAPM callback. But this setup could equally be done by the codec
driver function wrapping wm_adsp2_early event. In preparation
for adding support for new core types wm_adsp2_set_dspclk has
been exported, and the freq argument removed so that it can
be used directly as a DAPM callback.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l24.c |  4 +++-
 sound/soc/codecs/wm5102.c  |  4 +++-
 sound/soc/codecs/wm5110.c  |  4 +++-
 sound/soc/codecs/wm_adsp.c | 32 +++++++++++++-------------------
 sound/soc/codecs/wm_adsp.h |  6 ++++--
 5 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index b16832a6a9af8..e056d871fafb8 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -75,7 +75,9 @@ static int cs47l24_adsp_power_ev(struct snd_soc_dapm_widget *w,
 
 	v = (v & ARIZONA_SYSCLK_FREQ_MASK) >> ARIZONA_SYSCLK_FREQ_SHIFT;
 
-	return wm_adsp2_early_event(w, kcontrol, event, v);
+	wm_adsp2_set_dspclk(w, v);
+
+	return wm_adsp2_early_event(w, kcontrol, event);
 }
 
 static DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 4466e195b66df..c972591f1cc4f 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -646,6 +646,8 @@ static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
 				return ret;
 			}
 		}
+
+		wm_adsp2_set_dspclk(w, v);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
@@ -659,7 +661,7 @@ static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return wm_adsp2_early_event(w, kcontrol, event, v);
+	return wm_adsp2_early_event(w, kcontrol, event);
 }
 
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b25877fa529dd..c543b73e2f205 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -211,7 +211,9 @@ static int wm5110_adsp_power_ev(struct snd_soc_dapm_widget *w,
 
 	v = (v & ARIZONA_SYSCLK_FREQ_MASK) >> ARIZONA_SYSCLK_FREQ_SHIFT;
 
-	return wm_adsp2_early_event(w, kcontrol, event, v);
+	wm_adsp2_set_dspclk(w, v);
+
+	return wm_adsp2_early_event(w, kcontrol, event);
 }
 
 static const struct reg_sequence wm5110_no_dre_left_enable[] = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a9542a56b19e4..8800ffcc4f8c0 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2715,26 +2715,22 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	mutex_unlock(&dsp->pwr_lock);
 }
 
-static void wm_adsp2_set_dspclk(struct wm_adsp *dsp, unsigned int freq)
+int wm_adsp2_set_dspclk(struct snd_soc_dapm_widget *w, unsigned int freq)
 {
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsp = &dsps[w->shift];
 	int ret;
 
-	switch (dsp->rev) {
-	case 0:
-		ret = regmap_update_bits_async(dsp->regmap,
-					       dsp->base + ADSP2_CLOCKING,
-					       ADSP2_CLK_SEL_MASK,
-					       freq << ADSP2_CLK_SEL_SHIFT);
-		if (ret) {
-			adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
-			return;
-		}
-		break;
-	default:
-		/* clock is handled by parent codec driver */
-		break;
-	}
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CLOCKING,
+				 ADSP2_CLK_SEL_MASK,
+				 freq << ADSP2_CLK_SEL_SHIFT);
+	if (ret)
+		adsp_err(dsp, "Failed to set clock rate: %d\n", ret);
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(wm_adsp2_set_dspclk);
 
 int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
@@ -2792,8 +2788,7 @@ static void wm_adsp_stop_watchdog(struct wm_adsp *dsp)
 }
 
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event,
-			 unsigned int freq)
+			 struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
@@ -2802,7 +2797,6 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		wm_adsp2_set_dspclk(dsp, freq);
 		queue_work(system_unbound_wq, &dsp->boot_work);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 65ccf120dd5bc..ac1bec3b2248c 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -137,15 +137,17 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 int wm_adsp2_component_remove(struct wm_adsp *dsp, struct snd_soc_component *component);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
+
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event,
-			 unsigned int freq);
+			 struct snd_kcontrol *kcontrol, int event);
 
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
 
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
+int wm_adsp2_set_dspclk(struct snd_soc_dapm_widget *w, unsigned int freq);
+
 int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol);
 int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
-- 
2.11.0
