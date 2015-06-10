From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 2/3] ASoC: wm_adsp: create ALSA controls from wm_adsp driver
Date: Wed, 10 Jun 2015 16:12:47 +0100
Message-ID: <1433949168-25615-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Now that we have a codec_probe stage initialization in the wm_adsp
driver, we can make the wm_adsp driver create its own ALSA controls
instead of having that responsibility pushed to every codec driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c  |    4 ----
 sound/soc/codecs/wm5110.c  |    4 ----
 sound/soc/codecs/wm_adsp.c |   41 ++++++++++++++++++++++++-----------------
 sound/soc/codecs/wm_adsp.h |    1 -
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 341d96e..872c2ad 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1879,10 +1879,6 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 2);
-	if (ret != 0)
-		return ret;
-
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 6e15d9c..ce7de94 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1613,10 +1613,6 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 			return ret;
 	}
 
-	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 8);
-	if (ret != 0)
-		return ret;
-
 	snd_soc_dapm_disable_pin(&codec->dapm, "HAPTICS");
 
 	priv->core.arizona->dapm = &codec->dapm;
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 490edb3..1694636 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -293,7 +293,6 @@ const struct snd_kcontrol_new wm_adsp1_fw_controls[] = {
 };
 EXPORT_SYMBOL_GPL(wm_adsp1_fw_controls);
 
-#if IS_ENABLED(CONFIG_SND_SOC_ARIZONA)
 static const struct soc_enum wm_adsp2_rate_enum[] = {
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP1_CONTROL_1,
 			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
@@ -313,22 +312,28 @@ static const struct soc_enum wm_adsp2_rate_enum[] = {
 			      arizona_rate_text, arizona_rate_val),
 };
 
-const struct snd_kcontrol_new wm_adsp2_fw_controls[] = {
-	SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP1 Rate", wm_adsp2_rate_enum[0]),
-	SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP2 Rate", wm_adsp2_rate_enum[1]),
-	SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP3 Rate", wm_adsp2_rate_enum[2]),
-	SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP4 Rate", wm_adsp2_rate_enum[3]),
+static const struct snd_kcontrol_new wm_adsp2_fw_controls[4][2] = {
+	{
+		SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
+			     wm_adsp_fw_get, wm_adsp_fw_put),
+		SOC_ENUM("DSP1 Rate", wm_adsp2_rate_enum[0]),
+	},
+	{
+		SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
+			     wm_adsp_fw_get, wm_adsp_fw_put),
+		SOC_ENUM("DSP2 Rate", wm_adsp2_rate_enum[1]),
+	},
+	{
+		SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
+			     wm_adsp_fw_get, wm_adsp_fw_put),
+		SOC_ENUM("DSP3 Rate", wm_adsp2_rate_enum[2]),
+	},
+	{
+		SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
+			     wm_adsp_fw_get, wm_adsp_fw_put),
+		SOC_ENUM("DSP4 Rate", wm_adsp2_rate_enum[3]),
+	},
 };
-EXPORT_SYMBOL_GPL(wm_adsp2_fw_controls);
-#endif
 
 static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 							int type)
@@ -1908,7 +1913,9 @@ EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
 int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 {
-	return 0;
+	return snd_soc_add_codec_controls(codec,
+					  wm_adsp2_fw_controls[dsp->num - 1],
+					  ARRAY_SIZE(wm_adsp2_fw_controls[0]));
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_codec_probe);
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 5584e34..9059632 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -75,7 +75,6 @@ struct wm_adsp {
 	WM_ADSP2_E(wname, num, wm_adsp2_early_event)
 
 extern const struct snd_kcontrol_new wm_adsp1_fw_controls[];
-extern const struct snd_kcontrol_new wm_adsp2_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
 int wm_adsp2_init(struct wm_adsp *dsp);
-- 
1.7.2.5
