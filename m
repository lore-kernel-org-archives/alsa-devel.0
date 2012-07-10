From: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: [PATCH] ASoC: tlv320aic3x: add AGC settings
Date: Tue, 10 Jul 2012 14:35:11 +0200
Message-ID: <1341923712-8361-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id CB0FE24AB7
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 14:35:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
List-Id: alsa-devel@alsa-project.org

This patch adds AGC target level and times settings for TLV320AIC3x.
Enums uses small arrays of two channels left and right since it uses different registers.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 sound/soc/codecs/tlv320aic3x.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 0b17e66..11e195f 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -256,6 +256,25 @@ static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
 };
 
+static const char *aic3x_agc_level[] =
+	{ "-5.5dB", "-8dB", "-10dB", "-12dB", "-14dB", "-17dB", "-20dB", "-24dB" };
+static const struct soc_enum aic3x_agc_level_enum[] = {
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 4, 8, aic3x_agc_level),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 4, 8, aic3x_agc_level),
+};
+
+static const char *aic3x_agc_attack[] = { "8ms", "11ms", "16ms", "20ms" };
+static const struct soc_enum aic3x_agc_attack_enum[] = {
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+};
+
+static const char *aic3x_agc_decay[] = { "100ms", "200ms", "400ms", "500ms" };
+static const struct soc_enum aic3x_agc_decay_enum[] = {
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+};
+
 /*
  * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
  */
@@ -380,6 +399,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	 * adjust PGA to max value when ADC is on and will never go back.
 	*/
 	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
+	SOC_ENUM("Left AGC Target level", aic3x_agc_level_enum[0]),
+	SOC_ENUM("Right AGC Target level", aic3x_agc_level_enum[1]),
+	SOC_ENUM("Left AGC Attack time", aic3x_agc_attack_enum[0]),
+	SOC_ENUM("Right AGC Attack time", aic3x_agc_attack_enum[1]),
+	SOC_ENUM("Left AGC Decay time", aic3x_agc_decay_enum[0]),
+	SOC_ENUM("Right AGC Decay time", aic3x_agc_decay_enum[1]),
 
 	/* De-emphasis */
 	SOC_DOUBLE("De-emphasis Switch", AIC3X_CODEC_DFILT_CTRL, 2, 0, 0x01, 0),
-- 
1.7.7
