From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 089/102] ASoC: tlv320aic3x: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:35 +0100
Message-ID: <1392724308-13375-9-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9E3265761
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/tlv320aic3x.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 470fbfb4b386..a874f53da37e 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -238,36 +238,36 @@ static const char *aic3x_adc_hpf[] =
 #define ADC_HPF_ENUM	10
 
 static const struct soc_enum aic3x_enum[] = {
-	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3x_left_dac_mux),
-	SOC_ENUM_SINGLE(DAC_LINE_MUX, 4, 3, aic3x_right_dac_mux),
-	SOC_ENUM_SINGLE(HPLCOM_CFG, 4, 3, aic3x_left_hpcom_mux),
-	SOC_ENUM_SINGLE(HPRCOM_CFG, 3, 5, aic3x_right_hpcom_mux),
-	SOC_ENUM_SINGLE(LINE1L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE1L_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE1R_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE1R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
+	SOC_ENUM_SINGLE_CONST(DAC_LINE_MUX, 6, aic3x_left_dac_mux),
+	SOC_ENUM_SINGLE_CONST(DAC_LINE_MUX, 4, aic3x_right_dac_mux),
+	SOC_ENUM_SINGLE_CONST(HPLCOM_CFG, 4, aic3x_left_hpcom_mux),
+	SOC_ENUM_SINGLE_CONST(HPRCOM_CFG, 3, aic3x_right_hpcom_mux),
+	SOC_ENUM_SINGLE_CONST(LINE1L_2_LADC_CTRL, 7, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE_CONST(LINE1L_2_RADC_CTRL, 7, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE_CONST(LINE1R_2_LADC_CTRL, 7, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE_CONST(LINE1R_2_RADC_CTRL, 7, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE_CONST(LINE2L_2_LADC_CTRL, 7, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE_CONST(LINE2R_2_RADC_CTRL, 7, aic3x_linein_mode_mux),
+	SOC_ENUM_DOUBLE_CONST(AIC3X_CODEC_DFILT_CTRL, 6, 4, aic3x_adc_hpf),
 };
 
 static const char *aic3x_agc_level[] =
 	{ "-5.5dB", "-8dB", "-10dB", "-12dB", "-14dB", "-17dB", "-20dB", "-24dB" };
 static const struct soc_enum aic3x_agc_level_enum[] = {
-	SOC_ENUM_SINGLE(LAGC_CTRL_A, 4, 8, aic3x_agc_level),
-	SOC_ENUM_SINGLE(RAGC_CTRL_A, 4, 8, aic3x_agc_level),
+	SOC_ENUM_SINGLE_CONST(LAGC_CTRL_A, 4, aic3x_agc_level),
+	SOC_ENUM_SINGLE_CONST(RAGC_CTRL_A, 4, aic3x_agc_level),
 };
 
 static const char *aic3x_agc_attack[] = { "8ms", "11ms", "16ms", "20ms" };
 static const struct soc_enum aic3x_agc_attack_enum[] = {
-	SOC_ENUM_SINGLE(LAGC_CTRL_A, 2, 4, aic3x_agc_attack),
-	SOC_ENUM_SINGLE(RAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+	SOC_ENUM_SINGLE_CONST(LAGC_CTRL_A, 2, aic3x_agc_attack),
+	SOC_ENUM_SINGLE_CONST(RAGC_CTRL_A, 2, aic3x_agc_attack),
 };
 
 static const char *aic3x_agc_decay[] = { "100ms", "200ms", "400ms", "500ms" };
 static const struct soc_enum aic3x_agc_decay_enum[] = {
-	SOC_ENUM_SINGLE(LAGC_CTRL_A, 0, 4, aic3x_agc_decay),
-	SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+	SOC_ENUM_SINGLE_CONST(LAGC_CTRL_A, 0, aic3x_agc_decay),
+	SOC_ENUM_SINGLE_CONST(RAGC_CTRL_A, 0, aic3x_agc_decay),
 };
 
 /*
-- 
1.8.5.2
