From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 4/4] ASoC: tlv320aic3x: Sanitize output controls
Date: Fri, 27 Aug 2010 16:56:50 +0300
Message-ID: <1282917410-12000-5-git-send-email-jhnikula@gmail.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DA08B10388B
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:56:28 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 9so2009580eyd.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 06:56:28 -0700 (PDT)
In-Reply-To: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Currently output controls are not uniform. Some routes are adjusted by
mono controls that don't match to associated mixer switch, many routes are
not covered at all and stereo controls have following variants:

- L-to-L & R-to-R
- R-to-L & R-to-R
- L-to-L & R-to-L

This patch attempts to fix these issues. First, for the convenience, only
direct L-to-L, R-to-R and [L | R]-to-Mono routes are controlled by the
stereo controls. This logic is also used with the output pin mute controls
so all of them except mono output are controlled by stereo switches.

Then rest of the swapped L-to-R and R-to-L routes are controlled by the
mono controls that map to mixer switches with a same name. Mixers can then
associate these switches and volumes together.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |  114 ++++++++++++++++++++++++++-------------
 1 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 0a3b98c..8577c50 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -292,64 +292,102 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
 			 LDAC_VOL, RDAC_VOL, 0, 0x7f, 1, dac_tlv),
 
+	/*
+	 * Output controls that map to output mixer switches. Note these are
+	 * only for swapped L-to-R and R-to-L routes. See below stereo controls
+	 * for direct L-to-L and R-to-R routes.
+	 */
+	SOC_SINGLE_TLV("Left Line Mixer Line2R Bypass Volume",
+		       LINE2R_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Left Line Mixer PGAR Bypass Volume",
+		       PGAR_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Left Line Mixer DACR1 Playback Volume",
+		       DACR1_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Right Line Mixer Line2L Bypass Volume",
+		       LINE2L_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Right Line Mixer PGAL Bypass Volume",
+		       PGAL_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Right Line Mixer DACL1 Playback Volume",
+		       DACL1_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Left HP Mixer Line2R Bypass Volume",
+		       LINE2R_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Left HP Mixer PGAR Bypass Volume",
+		       PGAR_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Left HP Mixer DACR1 Playback Volume",
+		       DACR1_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Right HP Mixer Line2L Bypass Volume",
+		       LINE2L_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Right HP Mixer PGAL Bypass Volume",
+		       PGAL_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Right HP Mixer DACL1 Playback Volume",
+		       DACL1_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Left HPCOM Mixer Line2R Bypass Volume",
+		       LINE2R_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Left HPCOM Mixer PGAR Bypass Volume",
+		       PGAR_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Left HPCOM Mixer DACR1 Playback Volume",
+		       DACR1_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
+
+	SOC_SINGLE_TLV("Right HPCOM Mixer Line2L Bypass Volume",
+		       LINE2L_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Right HPCOM Mixer PGAL Bypass Volume",
+		       PGAL_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
+	SOC_SINGLE_TLV("Right HPCOM Mixer DACL1 Playback Volume",
+		       DACL1_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
+
+	/* Stereo output controls for direct L-to-L and R-to-R routes */
+	SOC_DOUBLE_R_TLV("Line Line2 Bypass Volume",
+			 LINE2L_2_LLOPM_VOL, LINE2R_2_RLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
+	SOC_DOUBLE_R_TLV("Line PGA Bypass Volume",
+			 PGAL_2_LLOPM_VOL, PGAR_2_RLOPM_VOL,
+			 0, 118, 1, output_stage_tlv),
 	SOC_DOUBLE_R_TLV("Line DAC Playback Volume",
 			 DACL1_2_LLOPM_VOL, DACR1_2_RLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE("LineL Playback Switch", LLOPM_CTRL, 3, 0x01, 0),
-	SOC_SINGLE("LineR Playback Switch", RLOPM_CTRL, 3, 0x01, 0),
-	SOC_DOUBLE_R_TLV("LineL DAC Playback Volume",
-			 DACL1_2_LLOPM_VOL, DACR1_2_LLOPM_VOL,
-			 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE_TLV("LineL Left PGA Bypass Playback Volume",
-		       PGAL_2_LLOPM_VOL, 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE_TLV("LineR Right PGA Bypass Playback Volume",
-		       PGAR_2_RLOPM_VOL, 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("LineL Line2 Bypass Playback Volume",
-			 LINE2L_2_LLOPM_VOL, LINE2R_2_LLOPM_VOL,
+
+	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Volume",
+			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("LineR Line2 Bypass Playback Volume",
-			 LINE2L_2_RLOPM_VOL, LINE2R_2_RLOPM_VOL,
+	SOC_DOUBLE_R_TLV("Mono PGA Bypass Volume",
+			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
-
 	SOC_DOUBLE_R_TLV("Mono DAC Playback Volume",
 			 DACL1_2_MONOLOPM_VOL, DACR1_2_MONOLOPM_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
-	SOC_DOUBLE_R_TLV("Mono PGA Bypass Playback Volume",
-			 PGAL_2_MONOLOPM_VOL, PGAR_2_MONOLOPM_VOL,
+
+	SOC_DOUBLE_R_TLV("HP Line2 Bypass Volume",
+			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("Mono Line2 Bypass Playback Volume",
-			 LINE2L_2_MONOLOPM_VOL, LINE2R_2_MONOLOPM_VOL,
+	SOC_DOUBLE_R_TLV("HP PGA Bypass Volume",
+			 PGAL_2_HPLOUT_VOL, PGAR_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
-
 	SOC_DOUBLE_R_TLV("HP DAC Playback Volume",
 			 DACL1_2_HPLOUT_VOL, DACR1_2_HPROUT_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
-		     0x01, 0),
-	SOC_DOUBLE_R_TLV("HP Right PGA Bypass Playback Volume",
-			 PGAR_2_HPLOUT_VOL, PGAR_2_HPROUT_VOL,
+
+	SOC_DOUBLE_R_TLV("HPCOM Line2 Bypass Volume",
+			 LINE2L_2_HPLCOM_VOL, LINE2R_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE_TLV("HPL PGA Bypass Playback Volume",
-		       PGAL_2_HPLOUT_VOL, 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE_TLV("HPR PGA Bypass Playback Volume",
-		       PGAL_2_HPROUT_VOL, 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("HP Line2 Bypass Playback Volume",
-			 LINE2L_2_HPLOUT_VOL, LINE2R_2_HPROUT_VOL,
+	SOC_DOUBLE_R_TLV("HPCOM PGA Bypass Volume",
+			 PGAL_2_HPLCOM_VOL, PGAR_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
-
 	SOC_DOUBLE_R_TLV("HPCOM DAC Playback Volume",
 			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
+
+	/* Output pin mute controls */
+	SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
+		     0x01, 0),
+	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
+		     0x01, 0),
 	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
-	SOC_SINGLE_TLV("HPLCOM PGA Bypass Playback Volume",
-		       PGAL_2_HPLCOM_VOL, 0, 118, 1, output_stage_tlv),
-	SOC_SINGLE_TLV("HPRCOM PGA Bypass Playback Volume",
-		       PGAL_2_HPRCOM_VOL, 0, 118, 1, output_stage_tlv),
-	SOC_DOUBLE_R_TLV("HPCOM Line2 Bypass Playback Volume",
-			 LINE2L_2_HPLCOM_VOL, LINE2R_2_HPRCOM_VOL,
-			 0, 118, 1, output_stage_tlv),
 
 	/*
 	 * Note: enable Automatic input Gain Controller with care. It can
-- 
1.7.1
