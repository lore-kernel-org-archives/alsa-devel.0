From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: arizona: Add volume ramp controls
Date: Sun,  9 Dec 2012 12:31:07 +0900
Message-ID: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65DB12616DA
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 04:31:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   25 +++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d5385dc..a377d1f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -274,6 +274,31 @@ EXPORT_SYMBOL_GPL(arizona_mixer_values);
 const DECLARE_TLV_DB_SCALE(arizona_mixer_tlv, -3200, 100, 0);
 EXPORT_SYMBOL_GPL(arizona_mixer_tlv);
 
+static const char *arizona_vol_ramp_text[] = {
+	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
+	"15ms/6dB", "30ms/6dB",
+};
+
+const struct soc_enum arizona_in_vd_ramp =
+	SOC_ENUM_SINGLE(ARIZONA_INPUT_VOLUME_RAMP,
+			ARIZONA_IN_VD_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+EXPORT_SYMBOL_GPL(arizona_in_vd_ramp);
+
+const struct soc_enum arizona_in_vi_ramp =
+	SOC_ENUM_SINGLE(ARIZONA_INPUT_VOLUME_RAMP,
+			ARIZONA_IN_VI_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+EXPORT_SYMBOL_GPL(arizona_in_vi_ramp);
+
+const struct soc_enum arizona_out_vd_ramp =
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_VOLUME_RAMP,
+			ARIZONA_OUT_VD_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+EXPORT_SYMBOL_GPL(arizona_out_vd_ramp);
+
+const struct soc_enum arizona_out_vi_ramp =
+	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_VOLUME_RAMP,
+			ARIZONA_OUT_VI_RAMP_SHIFT, 7, arizona_vol_ramp_text);
+EXPORT_SYMBOL_GPL(arizona_out_vi_ramp);
+
 static const char *arizona_lhpf_mode_text[] = {
 	"Low-pass", "High-pass"
 };
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 24b9692..4f09bb5 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -165,6 +165,12 @@ extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MIXER_ROUTES(name, name "L"), \
 	ARIZONA_MIXER_ROUTES(name, name "R")
 
+extern const struct soc_enum arizona_in_vi_ramp;
+extern const struct soc_enum arizona_in_vd_ramp;
+
+extern const struct soc_enum arizona_out_vi_ramp;
+extern const struct soc_enum arizona_out_vd_ramp;
+
 extern const struct soc_enum arizona_lhpf1_mode;
 extern const struct soc_enum arizona_lhpf2_mode;
 extern const struct soc_enum arizona_lhpf3_mode;
-- 
1.7.10.4
