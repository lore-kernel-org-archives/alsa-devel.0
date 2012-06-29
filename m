From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: [PATCH] ASoC: tlv320aic3x: add AGC settings
Date: Fri, 29 Jun 2012 10:52:20 +0200
Message-ID: <4FED6CC4.4070807@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C20A11CF54
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 10:52:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vbarinov@embeddedalley.com, mr.swami.reddy@ti.com, peter.ujfalusi@ti.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, sudhakar.raj@ti.com, nsekhar@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

This patch adds AGC target level and times settings for TLV320AIC3106.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
  sound/soc/codecs/tlv320aic3x.c |   25 +++++++++++++++++++++++++
  1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 50a7112..5335ebc 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -204,6 +204,10 @@ static const char *aic3x_right_hpcom_mux[] =
  static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
  static const char *aic3x_adc_hpf[] =
      { "Disabled", "0.0045xFs", "0.0125xFs", "0.025xFs" };
+static const char *aic3x_agc_level[] =
+    { "-5.5dB", "-8dB", "-10dB", "-12dB", "-14dB", "-17dB", "-20dB", "-24dB" };
+static const char *aic3x_agc_attack[] = { "8ms", "11ms", "16ms", "20ms" };
+static const char *aic3x_agc_decay[] = { "100ms", "200ms", "400ms", "500ms" };

  #define LDAC_ENUM	0
  #define RDAC_ENUM	1
@@ -231,6 +235,21 @@ static const struct soc_enum aic3x_enum[] = {
  	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
  };

+#define LAGC_LEV_ENUM	0
+#define RAGC_LEV_ENUM	1
+#define LAGC_ATT_ENUM	2
+#define RAGC_ATT_ENUM	3
+#define LAGC_DEC_ENUM	4
+#define RAGC_DEC_ENUM	5
+static const struct soc_enum aic3x_agc_enum[] = {
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 4, 8, aic3x_agc_level),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 4, 8, aic3x_agc_level),
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+};
+
  /*
   * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
   */
@@ -355,6 +374,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
  	 * adjust PGA to max value when ADC is on and will never go back.
  	*/
  	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
+	SOC_ENUM("Left AGC Target level", aic3x_agc_enum[LAGC_LEV_ENUM]),
+	SOC_ENUM("Right AGC Target level", aic3x_agc_enum[RAGC_LEV_ENUM]),
+	SOC_ENUM("Left AGC Attack time", aic3x_agc_enum[LAGC_ATT_ENUM]),
+	SOC_ENUM("Right AGC Attack time", aic3x_agc_enum[RAGC_ATT_ENUM]),
+	SOC_ENUM("Left AGC Decay time", aic3x_agc_enum[LAGC_DEC_ENUM]),
+	SOC_ENUM("Right AGC Decay time", aic3x_agc_enum[RAGC_DEC_ENUM]),

  	/* Input */
  	SOC_DOUBLE_R_TLV("PGA Capture Volume", LADC_VOL, RADC_VOL,
-- 
1.7.7
