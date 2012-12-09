From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm5110: Enable volume ramp control
Date: Sun,  9 Dec 2012 12:31:10 +0900
Message-ID: <1355023870-32040-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67F1D2616F1
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 04:31:19 +0100 (CET)
In-Reply-To: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/arizona.c |   25 -------------------------
 sound/soc/codecs/wm5110.c  |    6 ++++++
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a377d1f..d5385dc 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -274,31 +274,6 @@ EXPORT_SYMBOL_GPL(arizona_mixer_values);
 const DECLARE_TLV_DB_SCALE(arizona_mixer_tlv, -3200, 100, 0);
 EXPORT_SYMBOL_GPL(arizona_mixer_tlv);
 
-static const char *arizona_vol_ramp_text[] = {
-	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
-	"15ms/6dB", "30ms/6dB",
-};
-
-const struct soc_enum arizona_in_vd_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_INPUT_VOLUME_RAMP,
-			ARIZONA_IN_VD_RAMP_SHIFT, 7, arizona_vol_ramp_text);
-EXPORT_SYMBOL_GPL(arizona_in_vd_ramp);
-
-const struct soc_enum arizona_in_vi_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_INPUT_VOLUME_RAMP,
-			ARIZONA_IN_VI_RAMP_SHIFT, 7, arizona_vol_ramp_text);
-EXPORT_SYMBOL_GPL(arizona_in_vi_ramp);
-
-const struct soc_enum arizona_out_vd_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_VOLUME_RAMP,
-			ARIZONA_OUT_VD_RAMP_SHIFT, 7, arizona_vol_ramp_text);
-EXPORT_SYMBOL_GPL(arizona_out_vd_ramp);
-
-const struct soc_enum arizona_out_vi_ramp =
-	SOC_ENUM_SINGLE(ARIZONA_OUTPUT_VOLUME_RAMP,
-			ARIZONA_OUT_VI_RAMP_SHIFT, 7, arizona_vol_ramp_text);
-EXPORT_SYMBOL_GPL(arizona_out_vi_ramp);
-
 static const char *arizona_lhpf_mode_text[] = {
 	"Low-pass", "High-pass"
 };
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index ed093ee..abdf667 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -87,6 +87,9 @@ SOC_DOUBLE_R_TLV("IN4 Digital Volume", ARIZONA_ADC_DIGITAL_VOLUME_4L,
 		 ARIZONA_ADC_DIGITAL_VOLUME_4R, ARIZONA_IN4L_DIG_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_ENUM("Input Ramp Up", arizona_in_vi_ramp),
+SOC_ENUM("Input Ramp Down", arizona_in_vd_ramp),
+
 ARIZONA_MIXER_CONTROLS("EQ1", ARIZONA_EQ1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ2", ARIZONA_EQ2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("EQ3", ARIZONA_EQ3MIX_INPUT_1_SOURCE),
@@ -260,6 +263,9 @@ SOC_DOUBLE("SPKDAT1 Switch", ARIZONA_PDM_SPK1_CTRL_1, ARIZONA_SPK1L_MUTE_SHIFT,
 SOC_DOUBLE("SPKDAT2 Switch", ARIZONA_PDM_SPK2_CTRL_1, ARIZONA_SPK2L_MUTE_SHIFT,
 	   ARIZONA_SPK2R_MUTE_SHIFT, 1, 1),
 
+SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
+SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
+
 ARIZONA_MIXER_CONTROLS("AIF1TX1", ARIZONA_AIF1TX1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("AIF1TX2", ARIZONA_AIF1TX2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("AIF1TX3", ARIZONA_AIF1TX3MIX_INPUT_1_SOURCE),
-- 
1.7.10.4
