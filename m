From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic-asoc 2.6.30][PATCH 1/2] ASoC: TLV320AIC3X: Fix
	volume ranges
Date: Mon,  9 Feb 2009 14:27:06 +0200
Message-ID: <1234182427-16613-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B092103811
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 13:27:13 +0100 (CET)
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

This is a minor fix but helps to define dB ranges for volume controls.

Only DAC digital volume has full register value range from 0 to 127 but
ADC PGA gain and output stage volume controls don't.

For ADC PGA, maximum value is 119 and then it saturates to the same
gain value of 59.5 dB. For output stages, value 117 corresponds to -78.3 dB
and is muted for values 118 and above.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index ac73e69..cdb6dec 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -255,51 +255,51 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("PCM Playback Volume", LDAC_VOL, RDAC_VOL, 0, 0x7f, 1),
 
 	SOC_DOUBLE_R("Line DAC Playback Volume", DACL1_2_LLOPM_VOL,
-		     DACR1_2_RLOPM_VOL, 0, 0x7f, 1),
+		     DACR1_2_RLOPM_VOL, 0, 118, 1),
 	SOC_SINGLE("LineL Playback Switch", LLOPM_CTRL, 3, 0x01, 0),
 	SOC_SINGLE("LineR Playback Switch", RLOPM_CTRL, 3, 0x01, 0),
 	SOC_DOUBLE_R("LineL DAC Playback Volume", DACL1_2_LLOPM_VOL,
-		     DACR1_2_LLOPM_VOL, 0, 0x7f, 1),
+		     DACR1_2_LLOPM_VOL, 0, 118, 1),
 	SOC_SINGLE("LineL Left PGA Bypass Playback Volume", PGAL_2_LLOPM_VOL,
-		     0, 0x7f, 1),
+		     0, 118, 1),
 	SOC_SINGLE("LineR Right PGA Bypass Playback Volume", PGAR_2_RLOPM_VOL,
-		     0, 0x7f, 1),
+		     0, 118, 1),
 	SOC_DOUBLE_R("LineL Line2 Bypass Playback Volume", LINE2L_2_LLOPM_VOL,
-		     LINE2R_2_LLOPM_VOL, 0, 0x7f, 1),
+		     LINE2R_2_LLOPM_VOL, 0, 118, 1),
 	SOC_DOUBLE_R("LineR Line2 Bypass Playback Volume", LINE2L_2_RLOPM_VOL,
-		     LINE2R_2_RLOPM_VOL, 0, 0x7f, 1),
+		     LINE2R_2_RLOPM_VOL, 0, 118, 1),
 
 	SOC_DOUBLE_R("Mono DAC Playback Volume", DACL1_2_MONOLOPM_VOL,
-		     DACR1_2_MONOLOPM_VOL, 0, 0x7f, 1),
+		     DACR1_2_MONOLOPM_VOL, 0, 118, 1),
 	SOC_SINGLE("Mono DAC Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
 	SOC_DOUBLE_R("Mono PGA Bypass Playback Volume", PGAL_2_MONOLOPM_VOL,
-		     PGAR_2_MONOLOPM_VOL, 0, 0x7f, 1),
+		     PGAR_2_MONOLOPM_VOL, 0, 118, 1),
 	SOC_DOUBLE_R("Mono Line2 Bypass Playback Volume", LINE2L_2_MONOLOPM_VOL,
-		     LINE2R_2_MONOLOPM_VOL, 0, 0x7f, 1),
+		     LINE2R_2_MONOLOPM_VOL, 0, 118, 1),
 
 	SOC_DOUBLE_R("HP DAC Playback Volume", DACL1_2_HPLOUT_VOL,
-		     DACR1_2_HPROUT_VOL, 0, 0x7f, 1),
+		     DACR1_2_HPROUT_VOL, 0, 118, 1),
 	SOC_DOUBLE_R("HP DAC Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
 	SOC_DOUBLE_R("HP Right PGA Bypass Playback Volume", PGAR_2_HPLOUT_VOL,
-		     PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
+		     PGAR_2_HPROUT_VOL, 0, 118, 1),
 	SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
-		     0, 0x7f, 1),
+		     0, 118, 1),
 	SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
-		     0, 0x7f, 1),
+		     0, 118, 1),
 	SOC_DOUBLE_R("HP Line2 Bypass Playback Volume", LINE2L_2_HPLOUT_VOL,
-		     LINE2R_2_HPROUT_VOL, 0, 0x7f, 1),
+		     LINE2R_2_HPROUT_VOL, 0, 118, 1),
 
 	SOC_DOUBLE_R("HPCOM DAC Playback Volume", DACL1_2_HPLCOM_VOL,
-		     DACR1_2_HPRCOM_VOL, 0, 0x7f, 1),
+		     DACR1_2_HPRCOM_VOL, 0, 118, 1),
 	SOC_DOUBLE_R("HPCOM DAC Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 	SOC_SINGLE("HPLCOM PGA Bypass Playback Volume", PGAL_2_HPLCOM_VOL,
-		     0, 0x7f, 1),
+		     0, 118, 1),
 	SOC_SINGLE("HPRCOM PGA Bypass Playback Volume", PGAL_2_HPRCOM_VOL,
-		     0, 0x7f, 1),
+		     0, 118, 1),
 	SOC_DOUBLE_R("HPCOM Line2 Bypass Playback Volume", LINE2L_2_HPLCOM_VOL,
-		     LINE2R_2_HPRCOM_VOL, 0, 0x7f, 1),
+		     LINE2R_2_HPRCOM_VOL, 0, 118, 1),
 
 	/*
 	 * Note: enable Automatic input Gain Controller with care. It can
@@ -308,7 +308,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
 
 	/* Input */
-	SOC_DOUBLE_R("PGA Capture Volume", LADC_VOL, RADC_VOL, 0, 0x7f, 0),
+	SOC_DOUBLE_R("PGA Capture Volume", LADC_VOL, RADC_VOL, 0, 119, 0),
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
-- 
1.5.6.5
