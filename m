From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Split ADSP1 and ADSP2 firmware
	controls
Date: Fri, 29 Mar 2013 18:01:27 +0000
Message-ID: <1364580087-5210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6EB7260309
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 19:08:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that we have regular register mapped controls we should be splitting
the control sets for ADSP1 and ADSP2 as the register maps are not
identical. Do that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2200.c  |    2 +-
 sound/soc/codecs/wm5102.c  |    2 +-
 sound/soc/codecs/wm_adsp.c |   26 +++++++++++++++++++-------
 sound/soc/codecs/wm_adsp.h |    3 ++-
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index ddc98f0..57ba315 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1565,7 +1565,7 @@ static int wm2200_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	ret = snd_soc_add_codec_controls(codec, wm_adsp_fw_controls, 2);
+	ret = snd_soc_add_codec_controls(codec, wm_adsp1_fw_controls, 2);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index d1b43eb..cb03cc4 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1572,7 +1572,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		return ret;
 
-	ret = snd_soc_add_codec_controls(codec, wm_adsp_fw_controls, 2);
+	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 2);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3a481fd..bc03bae 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -247,7 +247,18 @@ static const struct soc_enum wm_adsp_fw_enum[] = {
 	SOC_ENUM_SINGLE(0, 3, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 };
 
-static const struct soc_enum wm_adsp_rate_enum[] = {
+const struct snd_kcontrol_new wm_adsp1_fw_controls[] = {
+	SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
+	SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
+	SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
+		     wm_adsp_fw_get, wm_adsp_fw_put),
+};
+EXPORT_SYMBOL_GPL(wm_adsp1_fw_controls);
+
+#if IS_ENABLED(CONFIG_SND_SOC_ARIZONA)
+static const struct soc_enum wm_adsp2_rate_enum[] = {
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_DSP1_CONTROL_1,
 			      ARIZONA_DSP1_RATE_SHIFT, 0xf,
 			      ARIZONA_RATE_ENUM_SIZE,
@@ -266,21 +277,22 @@ static const struct soc_enum wm_adsp_rate_enum[] = {
 			      arizona_rate_text, arizona_rate_val),
 };
 
-const struct snd_kcontrol_new wm_adsp_fw_controls[] = {
+const struct snd_kcontrol_new wm_adsp2_fw_controls[] = {
 	SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP1 Rate", wm_adsp_rate_enum[0]),
+	SOC_ENUM("DSP1 Rate", wm_adsp2_rate_enum[0]),
 	SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP2 Rate", wm_adsp_rate_enum[1]),
+	SOC_ENUM("DSP2 Rate", wm_adsp2_rate_enum[1]),
 	SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP3 Rate", wm_adsp_rate_enum[2]),
+	SOC_ENUM("DSP3 Rate", wm_adsp2_rate_enum[2]),
 	SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
 		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM("DSP4 Rate", wm_adsp_rate_enum[3]),
+	SOC_ENUM("DSP4 Rate", wm_adsp2_rate_enum[3]),
 };
-EXPORT_SYMBOL_GPL(wm_adsp_fw_controls);
+EXPORT_SYMBOL_GPL(wm_adsp2_fw_controls);
+#endif
 
 static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 							int type)
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index cb8871a..9f90c9f 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -65,7 +65,8 @@ struct wm_adsp {
 	.shift = num, .event = wm_adsp2_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
 
-extern const struct snd_kcontrol_new wm_adsp_fw_controls[];
+extern const struct snd_kcontrol_new wm_adsp1_fw_controls[];
+extern const struct snd_kcontrol_new wm_adsp2_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *adsp);
 int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs);
-- 
1.7.10.4
