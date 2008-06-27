From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [alsa-kernel][PATCH] ASoC: TLV320AIC3X: Add mixer
	control for ADC highpass filter
Date: Fri, 27 Jun 2008 14:07:57 +0300
Message-ID: <1214564877-5607-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 00DBE24415
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jun 2008 13:08:18 +0200 (CEST)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5RB6xbc029424
	for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2008 06:08:11 -0500
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |    6 ++++++
 sound/soc/codecs/tlv320aic3x.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 4f0bf26..d138306 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -223,6 +223,8 @@ static const char *aic3x_right_hpcom_mux[] =
     { "differential of HPROUT", "constant VCM", "single-ended",
       "differential of HPLCOM", "external feedback" };
 static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
+static const char *aic3x_adc_hpf[] =
+    { "Disabled", "0.0045xFs", "0.0125xFs", "0.025xFs" };
 
 #define LDAC_ENUM	0
 #define RDAC_ENUM	1
@@ -232,6 +234,7 @@ static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
 #define LINE1R_ENUM	5
 #define LINE2L_ENUM	6
 #define LINE2R_ENUM	7
+#define ADC_HPF_ENUM	8
 
 static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3x_left_dac_mux),
@@ -242,6 +245,7 @@ static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_SINGLE(LINE1R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
+	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
 };
 
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
@@ -292,6 +296,8 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Input */
 	SOC_DOUBLE_R("PGA Capture Volume", LADC_VOL, RADC_VOL, 0, 0x7f, 0),
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
+
+	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
 };
 
 /* add non dapm controls */
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index c1dd1ac..e600946 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -37,6 +37,8 @@
 #define AIC3X_ASD_INTF_CTRLB		9
 /* Audio overflow status and PLL R value programming register */
 #define AIC3X_OVRF_STATUS_AND_PLLR_REG	11
+/* Audio codec digital filter control register */
+#define AIC3X_CODEC_DFILT_CTRL		12
 
 /* ADC PGA Gain control registers */
 #define LADC_VOL			15
-- 
1.5.5.4
