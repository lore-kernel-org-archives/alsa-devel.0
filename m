From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Move DSP Rate controls into the
	codec
Date: Thu, 18 Jun 2015 13:43:19 +0100
Message-ID: <1434631399-30102-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E7E626059C
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2015 14:41:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The rate controls are codec-specific, it's not possible to
generically say what the range or the meaning of each control
is (or even if they exist at all) - that depends on the
particular codec.

This is currently being handled for Arizona codecs by putting
an Arizona-specific table of controls inside the wm_adsp driver.
This creates a dependency between wm_adsp and arizona.c, and is an
awkward solution if the ADSP is used in another family of codecs

Fix this by moving the Arizona-specific rate controls into the
Arizona codec drivers.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   27 ++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    2 +
 sound/soc/codecs/wm2200.c  |    2 +-
 sound/soc/codecs/wm5102.c  |    5 ++++
 sound/soc/codecs/wm5110.c  |    6 +++++
 sound/soc/codecs/wm_adsp.c |   52 +++++--------------------------------------
 sound/soc/codecs/wm_adsp.h |    2 +-
 7 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 88f6df2..802e05e 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2286,6 +2286,33 @@ int arizona_set_output_mode(struct snd_soc_codec *codec, int output, bool diff)
 }
 EXPORT_SYMBOL_GPL(arizona_set_output_mode);
 
+static const struct soc_enum arizona_adsp2_rate_enum[] = {
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP1_CONTROL_1,
+			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP2_CONTROL_1,
+			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP3_CONTROL_1,
+			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP4_CONTROL_1,
+			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
+			      ARIZONA_RATE_ENUM_SIZE,
+			      arizona_rate_text, arizona_rate_val),
+};
+
+const struct snd_kcontrol_new arizona_adsp2_rate_controls[] = {
+	SOC_ENUM("DSP1 Rate", arizona_adsp2_rate_enum[0]),
+	SOC_ENUM("DSP2 Rate", arizona_adsp2_rate_enum[1]),
+	SOC_ENUM("DSP3 Rate", arizona_adsp2_rate_enum[2]),
+	SOC_ENUM("DSP4 Rate", arizona_adsp2_rate_enum[3]),
+};
+EXPORT_SYMBOL_GPL(arizona_adsp2_rate_controls);
+
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 8824f5b..9881b6f 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -217,6 +217,8 @@ extern const struct soc_enum arizona_ng_hold;
 extern const struct soc_enum arizona_in_hpf_cut_enum;
 extern const struct soc_enum arizona_in_dmic_osr[];
 
+extern const struct snd_kcontrol_new arizona_adsp2_rate_controls[];
+
 extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event);
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 5a9da28..c830832 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1555,7 +1555,7 @@ static int wm2200_probe(struct snd_soc_codec *codec)
 
 	wm2200->codec = codec;
 
-	ret = snd_soc_add_codec_controls(codec, wm_adsp1_fw_controls, 2);
+	ret = snd_soc_add_codec_controls(codec, wm_adsp_fw_controls, 2);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index c5ec519..d097f09e5 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1880,6 +1880,11 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
+	ret = snd_soc_add_codec_controls(codec,
+					 arizona_adsp2_rate_controls, 1);
+	if (ret)
+		return ret;
+
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 5f032a3..709fcc6 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1614,6 +1614,12 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 			return ret;
 	}
 
+	ret = snd_soc_add_codec_controls(codec,
+					 arizona_adsp2_rate_controls,
+					 WM5110_NUM_ADSP);
+	if (ret)
+		return ret;
+
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
 	return 0;
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f9f90b0..0bb415a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -458,57 +458,17 @@ static const struct soc_enum wm_adsp_fw_enum[] = {
 	SOC_ENUM_SINGLE(0, 3, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 };
 
-const struct snd_kcontrol_new wm_adsp1_fw_controls[] = {
+const struct snd_kcontrol_new wm_adsp_fw_controls[] = {
 	SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
 	SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
 	SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
+	SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
 };
-EXPORT_SYMBOL_GPL(wm_adsp1_fw_controls);
-
-static const struct soc_enum wm_adsp2_rate_enum[] = {
-	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP1_CONTROL_1,
-			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
-			      ARIZONA_RATE_ENUM_SIZE,
-			      arizona_rate_text, arizona_rate_val),
-	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP2_CONTROL_1,
-			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
-			      ARIZONA_RATE_ENUM_SIZE,
-			      arizona_rate_text, arizona_rate_val),
-	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP3_CONTROL_1,
-			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
-			      ARIZONA_RATE_ENUM_SIZE,
-			      arizona_rate_text, arizona_rate_val),
-	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP4_CONTROL_1,
-			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
-			      ARIZONA_RATE_ENUM_SIZE,
-			      arizona_rate_text, arizona_rate_val),
-};
-
-static const struct snd_kcontrol_new wm_adsp2_fw_controls[4][2] = {
-	{
-		SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
-			     wm_adsp_fw_get, wm_adsp_fw_put),
-		SOC_ENUM("DSP1 Rate", wm_adsp2_rate_enum[0]),
-	},
-	{
-		SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
-			     wm_adsp_fw_get, wm_adsp_fw_put),
-		SOC_ENUM("DSP2 Rate", wm_adsp2_rate_enum[1]),
-	},
-	{
-		SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
-			     wm_adsp_fw_get, wm_adsp_fw_put),
-		SOC_ENUM("DSP3 Rate", wm_adsp2_rate_enum[2]),
-	},
-	{
-		SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
-			     wm_adsp_fw_get, wm_adsp_fw_put),
-		SOC_ENUM("DSP4 Rate", wm_adsp2_rate_enum[3]),
-	},
-};
+EXPORT_SYMBOL_GPL(wm_adsp_fw_controls);
 
 static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 							int type)
@@ -2125,8 +2085,8 @@ int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 	wm_adsp2_init_debugfs(dsp, codec);
 
 	return snd_soc_add_codec_controls(codec,
-					  wm_adsp2_fw_controls[dsp->num - 1],
-					  ARRAY_SIZE(wm_adsp2_fw_controls[0]));
+					  &wm_adsp_fw_controls[dsp->num - 1],
+					  1);
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_codec_probe);
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 5042cbd..579a635 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -83,7 +83,7 @@ struct wm_adsp {
 #define WM_ADSP2(wname, num) \
 	WM_ADSP2_E(wname, num, wm_adsp2_early_event)
 
-extern const struct snd_kcontrol_new wm_adsp1_fw_controls[];
+extern const struct snd_kcontrol_new wm_adsp_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
 int wm_adsp2_init(struct wm_adsp *dsp);
-- 
1.7.2.5
