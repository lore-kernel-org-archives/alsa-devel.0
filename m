From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: [PATCH] ASoC: tlv320aic3x: add AGC, MIC_BIAS
Date: Tue, 26 Jun 2012 15:04:27 +0200
Message-ID: <4FE9B35B.9020002@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id BDA792433C
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 15:04:31 +0200 (CEST)
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

This patch adds settings for TLV320AIC3106 of AGC, MIC_BIAS, De-emphasis.
Also added default settings of output pop-up reduction, short circuit protection and mix both channels to mono_out to 
get maximum level.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>

--- /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.c
+++ /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320aic3x.c.new
@@ -194,6 +194,11 @@
  static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
  static const char *aic3x_adc_hpf[] =
      { "Disabled", "0.0045xFs", "0.0125xFs", "0.025xFs" };
+static const char *aic3x_agc_level[] =
+    { "-5.5dB", "-8dB", "-10dB", "-12dB", "-14dB", "-17dB", "-20dB", "-24dB" };
+static const char *aic3x_agc_attack[] = { "8ms", "11ms", "16ms", "20ms" };
+static const char *aic3x_agc_decay[] = { "100ms", "200ms", "400ms", "500ms" };
+static const char *aic3x_mic_bias[] = { "off", "2V", "2.5V", "AVDD" };

  #define LDAC_ENUM	0
  #define RDAC_ENUM	1
@@ -206,6 +211,13 @@
  #define LINE2L_ENUM	8
  #define LINE2R_ENUM	9
  #define ADC_HPF_ENUM	10
+#define LAGC_LEV_ENUM	11
+#define RAGC_LEV_ENUM	12
+#define LAGC_ATT_ENUM	13
+#define RAGC_ATT_ENUM	14
+#define LAGC_DEC_ENUM	15
+#define RAGC_DEC_ENUM	16
+#define MIC_BIAS_ENUM	17

  static const struct soc_enum aic3x_enum[] = {
  	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3x_left_dac_mux),
@@ -219,6 +231,13 @@
  	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
  	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
  	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 4, 8, aic3x_agc_level),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 4, 8, aic3x_agc_level),
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 2, 4, aic3x_agc_attack),
+	SOC_ENUM_SINGLE(LAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+	SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
+	SOC_ENUM_SINGLE(MICBIAS_CTRL, 6, 4, aic3x_mic_bias),
  };

  /*
@@ -345,6 +364,15 @@
  	 * adjust PGA to max value when ADC is on and will never go back.
  	*/
  	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
+	SOC_ENUM("Left AGC Target level", aic3x_enum[LAGC_LEV_ENUM]),
+	SOC_ENUM("Right AGC Target level", aic3x_enum[RAGC_LEV_ENUM]),
+	SOC_ENUM("Left AGC Attack time", aic3x_enum[LAGC_ATT_ENUM]),
+	SOC_ENUM("Right AGC Attack time", aic3x_enum[RAGC_ATT_ENUM]),
+	SOC_ENUM("Left AGC Decay time", aic3x_enum[LAGC_DEC_ENUM]),
+	SOC_ENUM("Right AGC Decay time", aic3x_enum[RAGC_DEC_ENUM]),
+
+	/* De-emphasis */
+	SOC_DOUBLE("De-emphasis Switch", AIC3X_CODEC_DFILT_CTRL, 2, 0, 0x01, 0),

  	/* Input */
  	SOC_DOUBLE_R_TLV("PGA Capture Volume", LADC_VOL, RADC_VOL,
@@ -352,6 +380,8 @@
  	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),

  	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
+
+	SOC_ENUM("Mic Bias", aic3x_enum[MIC_BIAS_ENUM]),
  };

  /*
@@ -1261,6 +1291,13 @@
  	snd_soc_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
  	snd_soc_write(codec, AIC3X_RESET, SOFT_RESET);

+	/* set to avoid artifacts on the audio output during power-on/off */
+	snd_soc_write(codec, AIC3X_HEADSET_DETECT_CTRL_B, 0x80); /*ac-coupled*/
+	snd_soc_write(codec, HPOUT_POP_REDUCTION, 0x4e); /* 10 + 4 ms, reference*/
+
+	/* short circuit protection */
+	snd_soc_write(codec, HPRCOM_CFG, 0x04);
+
  	/* DAC default volume and mute */
  	snd_soc_write(codec, LDAC_VOL, DEFAULT_VOL | MUTE_ON);
  	snd_soc_write(codec, RDAC_VOL, DEFAULT_VOL | MUTE_ON);
@@ -1274,8 +1311,9 @@
  	snd_soc_write(codec, DACL1_2_LLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
  	snd_soc_write(codec, DACR1_2_RLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
  	/* DAC to Mono Line Out default volume and route to Output mixer */
-	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
-	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, DEFAULT_VOL | ROUTE_ON);
+	/* mix both channels with -6dB level */
+	snd_soc_write(codec, DACL1_2_MONOLOPM_VOL, (DEFAULT_VOL + 12) | ROUTE_ON);
+	snd_soc_write(codec, DACR1_2_MONOLOPM_VOL, (DEFAULT_VOL + 12) | ROUTE_ON);

  	/* unmute all outputs */
  	snd_soc_update_bits(codec, LLOPM_CTRL, UNMUTE, UNMUTE);
@@ -1292,6 +1330,12 @@
  	/* By default route Line1 to ADC PGA mixer */
  	snd_soc_write(codec, LINE1L_2_LADC_CTRL, 0x0);
  	snd_soc_write(codec, LINE1R_2_RADC_CTRL, 0x0);
+
+	/* AGC to -10dB, 20 / 500ms, no clip stepping, noise gate -90dB, hysteresis 3dB*/
+	snd_soc_write(codec, LAGC_CTRL_A, 0x2f);
+	snd_soc_write(codec, RAGC_CTRL_A, 0x2f);
+	snd_soc_write(codec, LAGC_CTRL_C, 0xbe);
+	snd_soc_write(codec, RAGC_CTRL_C, 0xbe);

  	/* PGA to HP Bypass default volume, disconnect from Output Mixer */
  	snd_soc_write(codec, PGAL_2_HPLOUT_VOL, DEFAULT_VOL);
