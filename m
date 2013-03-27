From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Implement OSR support
Date: Wed, 27 Mar 2013 12:52:42 +0000
Message-ID: <1364388762-8477-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C90226517B
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 13:58:31 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index b7a3fdc..99972a5 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -612,6 +612,26 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char *wm5102_osr_text[] = {
+	"Low power", "Normal", "High performance",
+};
+
+static const unsigned int wm5102_osr_val[] = {
+	0x0, 0x3, 0x5,
+};
+
+static const struct soc_enum wm5102_hpout_osr[] = {
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_1L,
+			      ARIZONA_OUT1_OSR_SHIFT, 0xe00, 3,
+			      wm5102_osr_text, wm5102_osr_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_2L,
+			      ARIZONA_OUT2_OSR_SHIFT, 0xe00, 3,
+			      wm5102_osr_text, wm5102_osr_val),
+	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_3L,
+			      ARIZONA_OUT3_OSR_SHIFT, 0xe00, 3,
+			      wm5102_osr_text, wm5102_osr_val),
+};
+
 #define WM5102_NG_SRC(name, base) \
 	SOC_SINGLE(name " NG HPOUT1L Switch",  base, 0, 1, 0), \
 	SOC_SINGLE(name " NG HPOUT1R Switch",  base, 1, 1, 0), \
@@ -761,6 +781,8 @@ ARIZONA_MIXER_CONTROLS("SPKOUTR", ARIZONA_OUT4RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT1L", ARIZONA_OUT5LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT1R", ARIZONA_OUT5RMIX_INPUT_1_SOURCE),
 
+SOC_SINGLE("Speaker High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_4L,
+	   ARIZONA_OUT4_OSR_SHIFT, 1, 0),
 SOC_SINGLE("SPKDAT1 High Performance Switch", ARIZONA_OUTPUT_PATH_CONFIG_5L,
 	   ARIZONA_OUT5_OSR_SHIFT, 1, 0),
 
@@ -790,6 +812,10 @@ SOC_DOUBLE_R_TLV("SPKDAT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_5L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_5R, ARIZONA_OUT5L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 
+SOC_VAL_ENUM("HPOUT1 OSR", wm5102_hpout_osr[0]),
+SOC_VAL_ENUM("HPOUT2 OSR", wm5102_hpout_osr[1]),
+SOC_VAL_ENUM("HPOUT3 OSR", wm5102_hpout_osr[2]),
+
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
 
-- 
1.7.10.4
