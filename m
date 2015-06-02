From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v8 2/4] ASoC: wm_adsp: Move DVFS control into codec driver
Date: Tue,  2 Jun 2015 11:53:34 +0100
Message-ID: <1433242416-14958-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433242416-14958-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

In theory the ADSP driver should not need to know anything
about the codec it is part of. But the WM5102 needs DVFS
control based on ADSP clocking speed. This was being handled
by bundling part of the knowledge of this into the ADSP driver.

This change moves this handling out of the ADSP driver and
into the WM5102 driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c  |   47 +++++++++++++++++++++++++++-
 sound/soc/codecs/wm5110.c  |    2 +-
 sound/soc/codecs/wm_adsp.c |   73 +-------------------------------------------
 sound/soc/codecs/wm_adsp.h |   15 ++++-----
 4 files changed, 54 insertions(+), 83 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index b73e3a3..11eba0e 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -614,6 +614,49 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return arizona_dvfs_sysclk_ev(w, kcontrol, event);
 }
 
+static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct arizona *arizona = dev_get_drvdata(codec->dev->parent);
+	unsigned int v;
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = regmap_read(arizona->regmap, ARIZONA_SYSTEM_CLOCK_1, &v);
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to read SYSCLK state: %d\n", ret);
+			return -EIO;
+		}
+
+		v = (v & ARIZONA_SYSCLK_FREQ_MASK) >> ARIZONA_SYSCLK_FREQ_SHIFT;
+
+		if (v >= 3) {
+			ret = arizona_dvfs_up(codec, ARIZONA_DVFS_ADSP1_RQ);
+			if (ret) {
+				dev_err(codec->dev,
+					"Failed to raise DVFS: %d\n", ret);
+				return ret;
+			}
+		}
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		ret = arizona_dvfs_down(codec, ARIZONA_DVFS_ADSP1_RQ);
+		if (ret)
+			dev_warn(codec->dev,
+				 "Failed to lower DVFS: %d\n", ret);
+		break;
+
+	default:
+		break;
+	}
+
+	return wm_adsp2_early_event(w, kcontrol, event);
+}
+
 static int wm5102_out_comp_coeff_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -1369,7 +1412,7 @@ ARIZONA_MUX_WIDGETS(ISRC2DEC2, "ISRC2DEC2"),
 ARIZONA_MUX_WIDGETS(ISRC2INT1, "ISRC2INT1"),
 ARIZONA_MUX_WIDGETS(ISRC2INT2, "ISRC2INT2"),
 
-WM_ADSP2("DSP1", 0),
+WM_ADSP2_E("DSP1", 0, wm5102_adsp_power_ev),
 
 SND_SOC_DAPM_OUTPUT("HPOUT1L"),
 SND_SOC_DAPM_OUTPUT("HPOUT1R"),
@@ -1922,7 +1965,7 @@ static int wm5102_probe(struct platform_device *pdev)
 	wm5102->core.adsp[0].mem = wm5102_dsp1_regions;
 	wm5102->core.adsp[0].num_mems = ARRAY_SIZE(wm5102_dsp1_regions);
 
-	ret = wm_adsp2_init(&wm5102->core.adsp[0], true);
+	ret = wm_adsp2_init(&wm5102->core.adsp[0]);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fbaeddb..d65364e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1697,7 +1697,7 @@ static int wm5110_probe(struct platform_device *pdev)
 		wm5110->core.adsp[i].num_mems
 			= ARRAY_SIZE(wm5110_dsp1_regions);
 
-		ret = wm_adsp2_init(&wm5110->core.adsp[i], false);
+		ret = wm_adsp2_init(&wm5110->core.adsp[i]);
 		if (ret != 0)
 			return ret;
 	}
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f6642c1..6e358b5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1787,35 +1787,6 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 		return;
 	}
 
-	if (dsp->dvfs) {
-		ret = regmap_read(dsp->regmap,
-				  dsp->base + ADSP2_CLOCKING, &val);
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to read clocking: %d\n", ret);
-			return;
-		}
-
-		if ((val & ADSP2_CLK_SEL_MASK) >= 3) {
-			ret = regulator_enable(dsp->dvfs);
-			if (ret != 0) {
-				adsp_err(dsp,
-					 "Failed to enable supply: %d\n",
-					 ret);
-				return;
-			}
-
-			ret = regulator_set_voltage(dsp->dvfs,
-						    1800000,
-						    1800000);
-			if (ret != 0) {
-				adsp_err(dsp,
-					 "Failed to raise supply: %d\n",
-					 ret);
-				return;
-			}
-		}
-	}
-
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
 		return;
@@ -1909,21 +1880,6 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		regmap_write(dsp->regmap, dsp->base + ADSP2_WDMA_CONFIG_2, 0);
 		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
 
-		if (dsp->dvfs) {
-			ret = regulator_set_voltage(dsp->dvfs, 1200000,
-						    1800000);
-			if (ret != 0)
-				adsp_warn(dsp,
-					  "Failed to lower supply: %d\n",
-					  ret);
-
-			ret = regulator_disable(dsp->dvfs);
-			if (ret != 0)
-				adsp_err(dsp,
-					 "Failed to enable supply: %d\n",
-					 ret);
-		}
-
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
 
@@ -1950,7 +1906,7 @@ err:
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
-int wm_adsp2_init(struct wm_adsp *dsp, bool dvfs)
+int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
@@ -1969,33 +1925,6 @@ int wm_adsp2_init(struct wm_adsp *dsp, bool dvfs)
 	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
-	if (dvfs) {
-		dsp->dvfs = devm_regulator_get(dsp->dev, "DCVDD");
-		if (IS_ERR(dsp->dvfs)) {
-			ret = PTR_ERR(dsp->dvfs);
-			adsp_err(dsp, "Failed to get DCVDD: %d\n", ret);
-			return ret;
-		}
-
-		ret = regulator_enable(dsp->dvfs);
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to enable DCVDD: %d\n", ret);
-			return ret;
-		}
-
-		ret = regulator_set_voltage(dsp->dvfs, 1200000, 1800000);
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to initialise DVFS: %d\n", ret);
-			return ret;
-		}
-
-		ret = regulator_disable(dsp->dvfs);
-		if (ret != 0) {
-			adsp_err(dsp, "Failed to disable DCVDD: %d\n", ret);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 4fe0667..0e5f07c 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -18,8 +18,6 @@
 
 #include "wmfw.h"
 
-struct regulator;
-
 struct wm_adsp_region {
 	int type;
 	unsigned int base;
@@ -56,8 +54,6 @@ struct wm_adsp {
 	int fw_ver;
 	bool running;
 
-	struct regulator *dvfs;
-
 	struct list_head ctl_list;
 
 	struct work_struct boot_work;
@@ -67,19 +63,22 @@ struct wm_adsp {
 	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, num, 0, NULL, 0, \
 		wm_adsp1_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD)
 
-#define WM_ADSP2(wname, num) \
+#define WM_ADSP2_E(wname, num, event_fn) \
 {	.id = snd_soc_dapm_dai_link, .name = wname " Preloader", \
-	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_early_event, \
-	.event_flags = SND_SOC_DAPM_PRE_PMU }, \
+	.reg = SND_SOC_NOPM, .shift = num, .event = event_fn, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }, \
 {	.id = snd_soc_dapm_out_drv, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
 
+#define WM_ADSP2(wname, num) \
+	WM_ADSP2_E(wname, num, wm_adsp2_early_event)
+
 extern const struct snd_kcontrol_new wm_adsp1_fw_controls[];
 extern const struct snd_kcontrol_new wm_adsp2_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
-int wm_adsp2_init(struct wm_adsp *dsp, bool dvfs);
+int wm_adsp2_init(struct wm_adsp *dsp);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-- 
1.7.2.5
