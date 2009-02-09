From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic-asoc 2.6.30][PATCH 2/2] ASoC: TLV320AIC3X: Add
	TLV information for volume controls
Date: Mon,  9 Feb 2009 14:27:07 +0200
Message-ID: <1234182427-16613-2-git-send-email-jarkko.nikula@nokia.com>
References: <1234182427-16613-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 310BC103800
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 13:27:04 +0100 (CET)
In-Reply-To: <1234182427-16613-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

TLV320AIC3X volume controls are logarithmic. Export their dB ranges.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |  114 +++++++++++++++++++++++++--------------
 1 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index cdb6dec..d638e3f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -45,6 +45,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 
 #include "tlv320aic3x.h"
 
@@ -250,56 +251,86 @@ static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
 };
 
+/*
+ * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(dac_tlv, -6350, 50, 0);
+/* ADC PGA gain volumes. From 0 to 59.5 dB in 0.5 dB steps */
+static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
+/*
+ * Output stage volumes. From -78.3 to 0 dB. Muted below -78.3 dB.
+ * Step size is approximately 0.5 dB over most of the scale but increasing
+ * near the very low levels.
+ * Define dB scale so that it is mostly correct for range about -55 to 0 dB
+ * but having increasing dB difference below that (and where it doesn't count
+ * so much). This setting shows -50 dB (actual is -50.3 dB) for register
+ * value 100 and -58.5 dB (actual is -78.3 dB) for register value 117.
+ */
+static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
-	SOC_DOUBLE_R("PCM Playback Volume", LDAC_VOL, RDAC_VOL, 0, 0x7f, 1),
+	SOC_DOUBLE_R_TLV("PCM Playback Volume",
+			 LDAC_VOL, RDAC_VOL, 0, 0x7f, 1, dac_tlv),
 
-	SOC_DOUBLE_R("Line DAC Playback Volume", DACL1_2_LLOPM_VOL,
-		     DACR1_2_RLOPM_VOL, 0, 118, 1),
+	SOC_DOUBLE_R_TLV("Line DAC Playback Volume",
+			 DACL1_2_LLOPM_VOL, DACR1_2_RLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE("LineL Playback Switch", LLOPM_CTRL, 3, 0x01, 0),
 	SOC_SINGLE("LineR Playback Switch", RLOPM_CTRL, 3, 0x01, 0),
-	SOC_DOUBLE_R("LineL DAC Playback Volume", DACL1_2_LLOPM_VOL,
-		     DACR1_2_LLOPM_VOL, 0, 118, 1),
-	SOC_SINGLE("LineL Left PGA Bypass Playback Volume", PGAL_2_LLOPM_VOL,
-		     0, 118, 1),
-	SOC_SINGLE("LineR Right PGA Bypass Playback Volume", PGAR_2_RLOPM_VOL,
-		     0, 118, 1),
-	SOC_DOUBLE_R("LineL Line2 Bypass Playback Volume", LINE2L_2_LLOPM_VOL,
-		     LINE2R_2_LLOPM_VOL, 0, 118, 1),
-	SOC_DOUBLE_R("LineR Line2 Bypass Playback Volume", LINE2L_2_RLOPM_VOL,
-		     LINE2R_2_RLOPM_VOL, 0, 118, 1),
-
-	SOC_DOUBLE_R("Mono DAC Playback Volume", DACL1_2_MONOLOPM_VOL,
-		     DACR1_2_MONOLOPM_VOL, 0, 118, 1),
+	SOC_DOUBLE_R_TLV("LineL DAC Playback Volume",
+			 DACL1_2_LLOPM_VOL, DACR1_2_LLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("LineL Left PGA Bypass Playback Volume",
+		       PGAL_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("LineR Right PGA Bypass Playback Volume",
+		       PGAR_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("LineL Line2 Bypass Playback Volume",
+			 LINE2L_2_LLOPM_VOL, LINE2R_2_LLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("LineR Line2 Bypass Playback Volume",
+			 LINE2L_2_RLOPM_VOL, LINE2R_2_RLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+
+	SOC_DOUBLE_R_TLV("Mono DAC Playback Volume",
+			 DACL1_2_MONOLOPM_VOL, DACR1_2_MONOLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
 	SOC_SINGLE("Mono DAC Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
-	SOC_DOUBLE_R("Mono PGA Bypass Playback Volume", PGAL_2_MONOLOPM_VOL,
-		     PGAR_2_MONOLOPM_VOL, 0, 118, 1),
-	SOC_DOUBLE_R("Mono Line2 Bypass Playback Volume", LINE2L_2_MONOLOPM_VOL,
-		     LINE2R_2_MONOLOPM_VOL, 0, 118, 1),
-
-	SOC_DOUBLE_R("HP DAC Playback Volume", DACL1_2_HPLOUT_VOL,
-		     DACR1_2_HPROUT_VOL, 0, 118, 1),
+	SOC_DOUBLE_R_TLV("Mono PGA Bypass Playback Volume",
+			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Playback Volume",
+			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+
+	SOC_DOUBLE_R_TLV("HP DAC Playback Volume",
+			 DACL1_2_HPLOUT_VOL, DACR1_2_HPROUT_VOL,
+			 0, 118, 1, output_stage_tlv),
 	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
-	SOC_DOUBLE_R("HP Right PGA Bypass Playback Volume", PGAR_2_HPLOUT_VOL,
-		     PGAR_2_HPROUT_VOL, 0, 118, 1),
-	SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
-		     0, 118, 1),
-	SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
-		     0, 118, 1),
-	SOC_DOUBLE_R("HP Line2 Bypass Playback Volume", LINE2L_2_HPLOUT_VOL,
-		     LINE2R_2_HPROUT_VOL, 0, 118, 1),
-
-	SOC_DOUBLE_R("HPCOM DAC Playback Volume", DACL1_2_HPLCOM_VOL,
-		     DACR1_2_HPRCOM_VOL, 0, 118, 1),
+	SOC_DOUBLE_R_TLV("HP Right PGA Bypass Playback Volume",
+			 PGAR_2_HPLOUT_VOL, PGAR_2_HPROUT_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("HPL PGA Bypass Playback Volume",
+		       PGAL_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("HPR PGA Bypass Playback Volume",
+		       PGAL_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("HP Line2 Bypass Playback Volume",
+			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
+			 0, 118, 1, output_stage_tlv),
+
+	SOC_DOUBLE_R_TLV("HPCOM DAC Playback Volume",
+			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
+			 0, 118, 1, output_stage_tlv),
 	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
-	SOC_SINGLE("HPLCOM PGA Bypass Playback Volume", PGAL_2_HPLCOM_VOL,
-		     0, 118, 1),
-	SOC_SINGLE("HPRCOM PGA Bypass Playback Volume", PGAL_2_HPRCOM_VOL,
-		     0, 118, 1),
-	SOC_DOUBLE_R("HPCOM Line2 Bypass Playback Volume", LINE2L_2_HPLCOM_VOL,
-		     LINE2R_2_HPRCOM_VOL, 0, 118, 1),
+	SOC_SINGLE_TLV("HPLCOM PGA Bypass Playback Volume",
+		       PGAL_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("HPRCOM PGA Bypass Playback Volume",
+		       PGAL_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("HPCOM Line2 Bypass Playback Volume",
+			 LINE2L_2_HPLCOM_VOL, LINE2R_2_HPRCOM_VOL,
+			 0, 118, 1, output_stage_tlv),
 
 	/*
 	 * Note: enable Automatic input Gain Controller with care. It can
@@ -308,7 +339,8 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
 
 	/* Input */
-	SOC_DOUBLE_R("PGA Capture Volume", LADC_VOL, RADC_VOL, 0, 119, 0),
+	SOC_DOUBLE_R_TLV("PGA Capture Volume", LADC_VOL, RADC_VOL,
+			 0, 119, 0, adc_tlv),
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
-- 
1.5.6.5
