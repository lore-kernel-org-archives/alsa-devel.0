From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Avoid direct register cache access when
	setting defaults
Date: Thu, 30 Dec 2010 12:57:39 +0000
Message-ID: <1293713859-4480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5AD801038F4
	for <alsa-devel@alsa-project.org>; Thu, 30 Dec 2010 13:57:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimglogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Directly accessing the register cache means that we can't use anything
except a flat register cache so use snd_soc_update_bits().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8523.c |    6 +++---
 sound/soc/codecs/wm8741.c |   13 ++++++++-----
 sound/soc/codecs/wm8904.c |   41 ++++++++++++++++++++++++++---------------
 sound/soc/codecs/wm8955.c |   27 +++++++++++++++++++--------
 sound/soc/codecs/wm8962.c |   30 ++++++++++++++++++++----------
 sound/soc/codecs/wm8978.c |    2 +-
 sound/soc/codecs/wm9090.c |   41 ++++++++++++++++++++++++-----------------
 7 files changed, 101 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 5eb2f50..9b8603f 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -414,7 +414,6 @@ static int wm8523_resume(struct snd_soc_codec *codec)
 static int wm8523_probe(struct snd_soc_codec *codec)
 {
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
-	u16 *reg_cache = codec->reg_cache;
 	int ret, i;
 
 	codec->hw_write = (hw_write_t)i2c_master_send;
@@ -471,8 +470,9 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Change some default settings - latch VU and enable ZC */
-	reg_cache[WM8523_DAC_GAINR] |= WM8523_DACR_VU;
-	reg_cache[WM8523_DAC_CTRL3] |= WM8523_ZC;
+	snd_soc_update_bits(codec, WM8523_DAC_GAINR,
+			    WM8523_DACR_VU, WM8523_DACR_VU);
+	snd_soc_update_bits(codec, WM8523_DAC_CTRL3, WM8523_ZC, WM8523_ZC);
 
 	wm8523_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 494f2d3..25af901 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -421,7 +421,6 @@ static int wm8741_resume(struct snd_soc_codec *codec)
 static int wm8741_probe(struct snd_soc_codec *codec)
 {
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
-	u16 *reg_cache = codec->reg_cache;
 	int ret = 0;
 
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8741->control_type);
@@ -437,10 +436,14 @@ static int wm8741_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Change some default settings - latch VU */
-	reg_cache[WM8741_DACLLSB_ATTENUATION] |= WM8741_UPDATELL;
-	reg_cache[WM8741_DACLMSB_ATTENUATION] |= WM8741_UPDATELM;
-	reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERL;
-	reg_cache[WM8741_DACRLSB_ATTENUATION] |= WM8741_UPDATERM;
+	snd_soc_update_bits(codec, WM8741_DACLLSB_ATTENUATION,
+			    WM8741_UPDATELL, WM8741_UPDATELL);
+	snd_soc_update_bits(codec, WM8741_DACLMSB_ATTENUATION,
+			    WM8741_UPDATELM, WM8741_UPDATELM);
+	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
+			    WM8741_UPDATERL, WM8741_UPDATERL);
+	snd_soc_update_bits(codec, WM8741_DACRLSB_ATTENUATION,
+			    WM8741_UPDATERM, WM8741_UPDATERM);
 
 	snd_soc_add_controls(codec, wm8741_snd_controls,
 			     ARRAY_SIZE(wm8741_snd_controls));
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 9de44a4..86c1cb8 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2436,19 +2436,28 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Change some default settings - latch VU and enable ZC */
-	reg_cache[WM8904_ADC_DIGITAL_VOLUME_LEFT] |= WM8904_ADC_VU;
-	reg_cache[WM8904_ADC_DIGITAL_VOLUME_RIGHT] |= WM8904_ADC_VU;
-	reg_cache[WM8904_DAC_DIGITAL_VOLUME_LEFT] |= WM8904_DAC_VU;
-	reg_cache[WM8904_DAC_DIGITAL_VOLUME_RIGHT] |= WM8904_DAC_VU;
-	reg_cache[WM8904_ANALOGUE_OUT1_LEFT] |= WM8904_HPOUT_VU |
-		WM8904_HPOUTLZC;
-	reg_cache[WM8904_ANALOGUE_OUT1_RIGHT] |= WM8904_HPOUT_VU |
-		WM8904_HPOUTRZC;
-	reg_cache[WM8904_ANALOGUE_OUT2_LEFT] |= WM8904_LINEOUT_VU |
-		WM8904_LINEOUTLZC;
-	reg_cache[WM8904_ANALOGUE_OUT2_RIGHT] |= WM8904_LINEOUT_VU |
-		WM8904_LINEOUTRZC;
-	reg_cache[WM8904_CLOCK_RATES_0] &= ~WM8904_SR_MODE;
+	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_LEFT,
+			    WM8904_ADC_VU, WM8904_ADC_VU);
+	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_RIGHT,
+			    WM8904_ADC_VU, WM8904_ADC_VU);
+	snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_VOLUME_LEFT,
+			    WM8904_DAC_VU, WM8904_DAC_VU);
+	snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_VOLUME_RIGHT,
+			    WM8904_DAC_VU, WM8904_DAC_VU);
+	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT1_LEFT,
+			    WM8904_HPOUT_VU | WM8904_HPOUTLZC,
+			    WM8904_HPOUT_VU | WM8904_HPOUTLZC);
+	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT1_RIGHT,
+			    WM8904_HPOUT_VU | WM8904_HPOUTRZC,
+			    WM8904_HPOUT_VU | WM8904_HPOUTRZC);
+	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT2_LEFT,
+			    WM8904_LINEOUT_VU | WM8904_LINEOUTLZC,
+			    WM8904_LINEOUT_VU | WM8904_LINEOUTLZC);
+	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT2_RIGHT,
+			    WM8904_LINEOUT_VU | WM8904_LINEOUTRZC,
+			    WM8904_LINEOUT_VU | WM8904_LINEOUTRZC);
+	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_0,
+			    WM8904_SR_MODE, 0);
 
 	/* Apply configuration from the platform data. */
 	if (wm8904->pdata) {
@@ -2469,10 +2478,12 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 	/* Set Class W by default - this will be managed by the Class
 	 * G widget at runtime where bypass paths are available.
 	 */
-	reg_cache[WM8904_CLASS_W_0] |= WM8904_CP_DYN_PWR;
+	snd_soc_update_bits(codec, WM8904_CLASS_W_0,
+			    WM8904_CP_DYN_PWR, WM8904_CP_DYN_PWR);
 
 	/* Use normal bias source */
-	reg_cache[WM8904_BIAS_CONTROL_0] &= ~WM8904_POBCTRL;
+	snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
+			    WM8904_POBCTRL, 0);
 
 	wm8904_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 7167dfc..5e0214d 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -934,16 +934,27 @@ static int wm8955_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Change some default settings - latch VU and enable ZC */
-	reg_cache[WM8955_LEFT_DAC_VOLUME] |= WM8955_LDVU;
-	reg_cache[WM8955_RIGHT_DAC_VOLUME] |= WM8955_RDVU;
-	reg_cache[WM8955_LOUT1_VOLUME] |= WM8955_LO1VU | WM8955_LO1ZC;
-	reg_cache[WM8955_ROUT1_VOLUME] |= WM8955_RO1VU | WM8955_RO1ZC;
-	reg_cache[WM8955_LOUT2_VOLUME] |= WM8955_LO2VU | WM8955_LO2ZC;
-	reg_cache[WM8955_ROUT2_VOLUME] |= WM8955_RO2VU | WM8955_RO2ZC;
-	reg_cache[WM8955_MONOOUT_VOLUME] |= WM8955_MOZC;
+	snd_soc_update_bits(codec, WM8955_LEFT_DAC_VOLUME,
+			    WM8955_LDVU, WM8955_LDVU);
+	snd_soc_update_bits(codec, WM8955_RIGHT_DAC_VOLUME,
+			    WM8955_RDVU, WM8955_RDVU);
+	snd_soc_update_bits(codec, WM8955_LOUT1_VOLUME,
+			    WM8955_LO1VU | WM8955_LO1ZC,
+			    WM8955_LO1VU | WM8955_LO1ZC);
+	snd_soc_update_bits(codec, WM8955_ROUT1_VOLUME,
+			    WM8955_RO1VU | WM8955_RO1ZC,
+			    WM8955_RO1VU | WM8955_RO1ZC);
+	snd_soc_update_bits(codec, WM8955_LOUT2_VOLUME,
+			    WM8955_LO2VU | WM8955_LO2ZC,
+			    WM8955_LO2VU | WM8955_LO2ZC);
+	snd_soc_update_bits(codec, WM8955_ROUT2_VOLUME,
+			    WM8955_RO2VU | WM8955_RO2ZC,
+			    WM8955_RO2VU | WM8955_RO2ZC);
+	snd_soc_update_bits(codec, WM8955_MONOOUT_VOLUME,
+			    WM8955_MOZC, WM8955_MOZC);
 
 	/* Also enable adaptive bass boost by default */
-	reg_cache[WM8955_BASS_CONTROL] |= WM8955_BB;
+	snd_soc_update_bits(codec, WM8955_BASS_CONTROL, WM8955_BB, WM8955_BB);
 
 	/* Set platform data values */
 	if (pdata) {
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b9cb1fc..c827057 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3822,16 +3822,26 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	}
 
 	/* Latch volume update bits */
-	reg_cache[WM8962_LEFT_INPUT_VOLUME] |= WM8962_IN_VU;
-	reg_cache[WM8962_RIGHT_INPUT_VOLUME] |= WM8962_IN_VU;
-	reg_cache[WM8962_LEFT_ADC_VOLUME] |= WM8962_ADC_VU;
-	reg_cache[WM8962_RIGHT_ADC_VOLUME] |= WM8962_ADC_VU;
-	reg_cache[WM8962_LEFT_DAC_VOLUME] |= WM8962_DAC_VU;
-	reg_cache[WM8962_RIGHT_DAC_VOLUME] |= WM8962_DAC_VU;
-	reg_cache[WM8962_SPKOUTL_VOLUME] |= WM8962_SPKOUT_VU;
-	reg_cache[WM8962_SPKOUTR_VOLUME] |= WM8962_SPKOUT_VU;
-	reg_cache[WM8962_HPOUTL_VOLUME] |= WM8962_HPOUT_VU;
-	reg_cache[WM8962_HPOUTR_VOLUME] |= WM8962_HPOUT_VU;
+	snd_soc_update_bits(codec, WM8962_LEFT_INPUT_VOLUME,
+			    WM8962_IN_VU, WM8962_IN_VU);
+	snd_soc_update_bits(codec, WM8962_RIGHT_INPUT_VOLUME,
+			    WM8962_IN_VU, WM8962_IN_VU);
+	snd_soc_update_bits(codec, WM8962_LEFT_ADC_VOLUME,
+			    WM8962_ADC_VU, WM8962_ADC_VU);
+	snd_soc_update_bits(codec, WM8962_RIGHT_ADC_VOLUME,
+			    WM8962_ADC_VU, WM8962_ADC_VU);
+	snd_soc_update_bits(codec, WM8962_LEFT_DAC_VOLUME,
+			    WM8962_DAC_VU, WM8962_DAC_VU);
+	snd_soc_update_bits(codec, WM8962_RIGHT_DAC_VOLUME,
+			    WM8962_DAC_VU, WM8962_DAC_VU);
+	snd_soc_update_bits(codec, WM8962_SPKOUTL_VOLUME,
+			    WM8962_SPKOUT_VU, WM8962_SPKOUT_VU);
+	snd_soc_update_bits(codec, WM8962_SPKOUTR_VOLUME,
+			    WM8962_SPKOUT_VU, WM8962_SPKOUT_VU);
+	snd_soc_update_bits(codec, WM8962_HPOUTL_VOLUME,
+			    WM8962_HPOUT_VU, WM8962_HPOUT_VU);
+	snd_soc_update_bits(codec, WM8962_HPOUTR_VOLUME,
+			    WM8962_HPOUT_VU, WM8962_HPOUT_VU);
 
 	wm8962_add_widgets(codec);
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 4bbc344..30fb48e 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -965,7 +965,7 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 	 * written.
 	 */
 	for (i = 0; i < ARRAY_SIZE(update_reg); i++)
-		((u16 *)codec->reg_cache)[update_reg[i]] |= 0x100;
+		snd_soc_update_bits(codec, update_reg[i], 0x100, 0x100);
 
 	/* Reset the codec */
 	ret = snd_soc_write(codec, WM8978_RESET, 0);
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index a788c42..3c5d325 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -551,7 +551,6 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 static int wm9090_probe(struct snd_soc_codec *codec)
 {
 	struct wm9090_priv *wm9090 = snd_soc_codec_get_drvdata(codec);
-	u16 *reg_cache = codec->reg_cache;
 	int ret;
 
 	codec->control_data = wm9090->control_data;
@@ -576,22 +575,30 @@ static int wm9090_probe(struct snd_soc_codec *codec)
 	/* Configure some defaults; they will be written out when we
 	 * bring the bias up.
 	 */
-	reg_cache[WM9090_IN1_LINE_INPUT_A_VOLUME] |= WM9090_IN1_VU
-		| WM9090_IN1A_ZC;
-	reg_cache[WM9090_IN1_LINE_INPUT_B_VOLUME] |= WM9090_IN1_VU
-		| WM9090_IN1B_ZC;
-	reg_cache[WM9090_IN2_LINE_INPUT_A_VOLUME] |= WM9090_IN2_VU
-		| WM9090_IN2A_ZC;
-	reg_cache[WM9090_IN2_LINE_INPUT_B_VOLUME] |= WM9090_IN2_VU
-		| WM9090_IN2B_ZC;
-	reg_cache[WM9090_SPEAKER_VOLUME_LEFT] |=
-		WM9090_SPKOUT_VU | WM9090_SPKOUTL_ZC;
-	reg_cache[WM9090_LEFT_OUTPUT_VOLUME] |=
-		WM9090_HPOUT1_VU | WM9090_HPOUT1L_ZC;
-	reg_cache[WM9090_RIGHT_OUTPUT_VOLUME] |=
-		WM9090_HPOUT1_VU | WM9090_HPOUT1R_ZC;
-
-	reg_cache[WM9090_CLOCKING_1] |= WM9090_TOCLK_ENA;
+	snd_soc_update_bits(codec, WM9090_IN1_LINE_INPUT_A_VOLUME,
+			    WM9090_IN1_VU | WM9090_IN1A_ZC,
+			    WM9090_IN1_VU | WM9090_IN1A_ZC);
+	snd_soc_update_bits(codec, WM9090_IN1_LINE_INPUT_B_VOLUME,
+			    WM9090_IN1_VU | WM9090_IN1B_ZC,
+			    WM9090_IN1_VU | WM9090_IN1B_ZC);
+	snd_soc_update_bits(codec, WM9090_IN2_LINE_INPUT_A_VOLUME,
+			    WM9090_IN2_VU | WM9090_IN2A_ZC,
+			    WM9090_IN2_VU | WM9090_IN2A_ZC);
+	snd_soc_update_bits(codec, WM9090_IN2_LINE_INPUT_B_VOLUME,
+			    WM9090_IN2_VU | WM9090_IN2B_ZC,
+			    WM9090_IN2_VU | WM9090_IN2B_ZC);
+	snd_soc_update_bits(codec, WM9090_SPEAKER_VOLUME_LEFT,
+			    WM9090_SPKOUT_VU | WM9090_SPKOUTL_ZC,
+			    WM9090_SPKOUT_VU | WM9090_SPKOUTL_ZC);
+	snd_soc_update_bits(codec, WM9090_LEFT_OUTPUT_VOLUME,
+			    WM9090_HPOUT1_VU | WM9090_HPOUT1L_ZC,
+			    WM9090_HPOUT1_VU | WM9090_HPOUT1L_ZC);
+	snd_soc_update_bits(codec, WM9090_RIGHT_OUTPUT_VOLUME,
+			    WM9090_HPOUT1_VU | WM9090_HPOUT1R_ZC,
+			    WM9090_HPOUT1_VU | WM9090_HPOUT1R_ZC);
+
+	snd_soc_update_bits(codec, WM9090_CLOCKING_1,
+			    WM9090_TOCLK_ENA, WM9090_TOCLK_ENA);
 
 	wm9090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.7.2.3
