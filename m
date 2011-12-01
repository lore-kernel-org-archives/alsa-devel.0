From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: Implement support for WM1811A jack
	detection
Date: Thu,  1 Dec 2011 14:16:43 +0000
Message-ID: <1322749006-371-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 791A7103C01
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 15:17:09 +0100 (CET)
In-Reply-To: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM1811A features an advanced low power accessory detection subsystem
which allows the device to be maintained in a very low power state while
the system is idle without sacrificing any accessory detection features.

Implement software support for this, automatically managing the power
configuration of the device depending on the detected accessory.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |   16 ++
 sound/soc/codecs/wm8994.c            |  264 +++++++++++++++++++++++++++++++---
 sound/soc/codecs/wm8994.h            |    3 +
 3 files changed, 264 insertions(+), 19 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 8317b19..86e6a03 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -250,6 +250,7 @@
 #define WM8994_GPIO_4                           0x703
 #define WM8994_GPIO_5                           0x704
 #define WM8994_GPIO_6                           0x705
+#define WM1811_JACKDET_CTRL			0x705
 #define WM8994_GPIO_7                           0x706
 #define WM8994_GPIO_8                           0x707
 #define WM8994_GPIO_9                           0x708
@@ -1904,6 +1905,9 @@
 /*
  * R57 (0x39) - AntiPOP (2)
  */
+#define WM1811_JACKDET_MODE_MASK                0x0180  /* JACKDET_MODE - [8:7] */
+#define WM1811_JACKDET_MODE_SHIFT                    7  /* JACKDET_MODE - [8:7] */
+#define WM1811_JACKDET_MODE_WIDTH                    2  /* JACKDET_MODE - [8:7] */
 #define WM8994_MICB2_DISCH                      0x0100  /* MICB2_DISCH */
 #define WM8994_MICB2_DISCH_MASK                 0x0100  /* MICB2_DISCH */
 #define WM8994_MICB2_DISCH_SHIFT                     8  /* MICB2_DISCH */
@@ -4283,6 +4287,18 @@
 #define WM8994_STL_SEL_WIDTH                         1  /* STL_SEL */
 
 /*
+ * R1797 (0x705) - JACKDET Ctrl
+ */
+#define WM1811_JACKDET_DB                       0x0100  /* JACKDET_DB */
+#define WM1811_JACKDET_DB_MASK                  0x0100  /* JACKDET_DB */
+#define WM1811_JACKDET_DB_SHIFT                      8  /* JACKDET_DB */
+#define WM1811_JACKDET_DB_WIDTH                      1  /* JACKDET_DB */
+#define WM1811_JACKDET_LVL                      0x0040  /* JACKDET_LVL */
+#define WM1811_JACKDET_LVL_MASK                 0x0040  /* JACKDET_LVL */
+#define WM1811_JACKDET_LVL_SHIFT                     6  /* JACKDET_LVL */
+#define WM1811_JACKDET_LVL_WIDTH                     1  /* JACKDET_LVL */
+
+/*
  * R1824 (0x720) - Pull Control (1)
  */
 #define WM8994_DMICDAT2_PU                      0x0800  /* DMICDAT2_PU */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c138937..5c042de 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -38,6 +38,11 @@
 #include "wm8994.h"
 #include "wm_hubs.h"
 
+#define WM1811_JACKDET_MODE_NONE  0x0000
+#define WM1811_JACKDET_MODE_JACK  0x0100
+#define WM1811_JACKDET_MODE_MIC   0x0080
+#define WM1811_JACKDET_MODE_AUDIO 0x0180
+
 #define WM8994_NUM_DRC 3
 #define WM8994_NUM_EQ  3
 
@@ -55,23 +60,34 @@ static int wm8994_retune_mobile_base[] = {
 
 static void wm8958_default_micdet(u16 status, void *data);
 
-static const struct {
+struct wm8958_micd_rate {
 	int sysclk;
 	bool idle;
 	int start;
 	int rate;
-} wm8958_micd_rates[] = {
+};
+
+static const struct wm8958_micd_rate micdet_rates[] = {
 	{ 32768,       true,  1, 4 },
 	{ 32768,       false, 1, 1 },
 	{ 44100 * 256, true,  7, 10 },
 	{ 44100 * 256, false, 7, 10 },
 };
 
+static const struct wm8958_micd_rate jackdet_rates[] = {
+	{ 32768,       true,  0, 1 },
+	{ 32768,       false, 0, 1 },
+	{ 44100 * 256, true,  7, 10 },
+	{ 44100 * 256, false, 7, 10 },
+};
+
 static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int best, i, sysclk, val;
 	bool idle;
+	const struct wm8958_micd_rate *rates;
+	int num_rates;
 
 	if (wm8994->jack_cb != wm8958_default_micdet)
 		return;
@@ -84,19 +100,27 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 	else
 		sysclk = wm8994->aifclk[0];
 
+	if (wm8994->jackdet) {
+		rates = jackdet_rates;
+		num_rates = ARRAY_SIZE(jackdet_rates);
+	} else {
+		rates = micdet_rates;
+		num_rates = ARRAY_SIZE(micdet_rates);
+	}
+
 	best = 0;
-	for (i = 0; i < ARRAY_SIZE(wm8958_micd_rates); i++) {
-		if (wm8958_micd_rates[i].idle != idle)
+	for (i = 0; i < num_rates; i++) {
+		if (rates[i].idle != idle)
 			continue;
-		if (abs(wm8958_micd_rates[i].sysclk - sysclk) <
-		    abs(wm8958_micd_rates[best].sysclk - sysclk))
+		if (abs(rates[i].sysclk - sysclk) <
+		    abs(rates[best].sysclk - sysclk))
 			best = i;
-		else if (wm8958_micd_rates[best].idle != idle)
+		else if (rates[best].idle != idle)
 			best = i;
 	}
 
-	val = wm8958_micd_rates[best].start << WM8958_MICD_BIAS_STARTTIME_SHIFT
-		| wm8958_micd_rates[best].rate << WM8958_MICD_RATE_SHIFT;
+	val = rates[best].start << WM8958_MICD_BIAS_STARTTIME_SHIFT
+		| rates[best].rate << WM8958_MICD_RATE_SHIFT;
 
 	snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 			    WM8958_MICD_BIAS_STARTTIME_MASK |
@@ -663,6 +687,74 @@ SOC_SINGLE_TLV("MIXINL IN1RP Boost Volume", WM8994_INPUT_MIXER_1, 8, 1, 0,
 	       mixin_boost_tlv),
 };
 
+/* We run all mode setting through a function to enforce audio mode */
+static void wm1811_jackdet_set_mode(struct snd_soc_codec *codec, u16 mode)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	if (wm8994->active_refcount)
+		mode = WM1811_JACKDET_MODE_AUDIO;
+
+	snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+			    WM1811_JACKDET_MODE_MASK, mode);
+
+	if (mode == WM1811_JACKDET_MODE_MIC)
+		msleep(2);
+}
+
+static void active_reference(struct snd_soc_codec *codec)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	mutex_lock(&wm8994->accdet_lock);
+
+	wm8994->active_refcount++;
+
+	dev_dbg(codec->dev, "Active refcount incremented, now %d\n",
+		wm8994->active_refcount);
+
+	if (wm8994->active_refcount == 1) {
+		/* If we're using jack detection go into audio mode */
+		if (wm8994->jackdet && wm8994->jack_cb) {
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM1811_JACKDET_MODE_MASK,
+					    WM1811_JACKDET_MODE_AUDIO);
+			msleep(2);
+		}
+	}
+
+	mutex_unlock(&wm8994->accdet_lock);
+}
+
+static void active_dereference(struct snd_soc_codec *codec)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	u16 mode;
+
+	mutex_lock(&wm8994->accdet_lock);
+
+	wm8994->active_refcount--;
+
+	dev_dbg(codec->dev, "Active refcount decremented, now %d\n",
+		wm8994->active_refcount);
+
+	if (wm8994->active_refcount == 0) {
+		/* Go into appropriate detection only mode */
+		if (wm8994->jackdet && wm8994->jack_cb) {
+			if (wm8994->jack_mic || wm8994->mic_detecting)
+				mode = WM1811_JACKDET_MODE_MIC;
+			else
+				mode = WM1811_JACKDET_MODE_JACK;
+
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM1811_JACKDET_MODE_MASK,
+					    mode);
+		}
+	}
+
+	mutex_unlock(&wm8994->accdet_lock);
+}
+
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
@@ -1820,6 +1912,8 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	if (freq_out) {
 		/* Enable VMID if we need it */
 		if (!was_enabled) {
+			active_reference(codec);
+
 			switch (control->type) {
 			case WM8994:
 				vmid_reference(codec);
@@ -1863,6 +1957,8 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			default:
 				break;
 			}
+
+			active_dereference(codec);
 		}
 	}
 
@@ -1992,6 +2088,9 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		default:
 			break;
 		}
+
+		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+			active_reference(codec);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -2044,6 +2143,9 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 					    WM8994_LINEOUT2_DISCH);
 		}
 
+		if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE)
+			active_dereference(codec);
+
 		/* MICBIAS into bypass mode on newer devices */
 		switch (control->type) {
 		case WM8958:
@@ -2069,6 +2171,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 	codec->dapm.bias_level = level;
+
 	return 0;
 }
 
@@ -2616,6 +2719,9 @@ static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
 		snd_soc_update_bits(codec, WM8994_MICBIAS, WM8994_MICD_ENA, 0);
 		break;
 	case WM1811:
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM1811_JACKDET_MODE_MASK, 0);
+		/* Fall through */
 	case WM8958:
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, 0);
@@ -2685,6 +2791,13 @@ static int wm8994_resume(struct snd_soc_codec *codec)
 					    WM8994_MICD_ENA, WM8994_MICD_ENA);
 		break;
 	case WM1811:
+		if (wm8994->jackdet && wm8994->jack_cb) {
+			/* Restart from idle */
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM1811_JACKDET_MODE_MASK,
+					    WM1811_JACKDET_MODE_JACK);
+			break;
+		}
 	case WM8958:
 		if (wm8994->jack_cb)
 			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
@@ -2948,17 +3061,20 @@ static void wm8958_default_micdet(u16 status, void *data)
 
 	dev_dbg(codec->dev, "MICDET %x\n", status);
 
-	/* If nothing present then clear our statuses */
+	/* Either nothing present or just starting detection */
 	if (!(status & WM8958_MICD_STS)) {
-		dev_dbg(codec->dev, "Detected open circuit\n");
-		wm8994->jack_mic = false;
-		wm8994->mic_detecting = true;
+		if (!wm8994->jackdet) {
+			/* If nothing present then clear our statuses */
+			dev_dbg(codec->dev, "Detected open circuit\n");
+			wm8994->jack_mic = false;
+			wm8994->mic_detecting = true;
 
-		wm8958_micd_set_rate(codec);
-
-		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
-				    wm8994->btn_mask | SND_JACK_HEADSET);
+			wm8958_micd_set_rate(codec);
 
+			snd_soc_jack_report(wm8994->micdet[0].jack, 0,
+					    wm8994->btn_mask |
+					     SND_JACK_HEADSET);
+		}
 		return;
 	}
 
@@ -2986,6 +3102,15 @@ static void wm8958_default_micdet(u16 status, void *data)
 
 		snd_soc_jack_report(wm8994->micdet[0].jack, SND_JACK_HEADPHONE,
 				    SND_JACK_HEADSET);
+
+		/* If we have jackdet that will detect removal */
+		if (wm8994->jackdet) {
+			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+					    WM8958_MICD_ENA, 0);
+
+			wm1811_jackdet_set_mode(codec,
+						WM1811_JACKDET_MODE_JACK);
+		}
 	}
 
 	/* Report short circuit as a button */
@@ -3014,6 +3139,56 @@ static void wm8958_default_micdet(u16 status, void *data)
 	}
 }
 
+static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
+{
+	struct wm8994_priv *wm8994 = data;
+	struct snd_soc_codec *codec = wm8994->codec;
+	int reg;
+
+	mutex_lock(&wm8994->accdet_lock);
+
+	reg = snd_soc_read(codec, WM1811_JACKDET_CTRL);
+	if (reg < 0) {
+		dev_err(codec->dev, "Failed to read jack status: %d\n", reg);
+		mutex_unlock(&wm8994->accdet_lock);
+		return IRQ_NONE;
+	}
+
+	dev_dbg(codec->dev, "JACKDET %x\n", reg);
+
+	if (reg & WM1811_JACKDET_LVL) {
+		dev_dbg(codec->dev, "Jack detected\n");
+
+		snd_soc_jack_report(wm8994->micdet[0].jack,
+				    SND_JACK_MECHANICAL, SND_JACK_MECHANICAL);
+
+		/*
+		 * Start off measument of microphone impedence to find
+		 * out what's actually there.
+		 */
+		wm8994->mic_detecting = true;
+		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_MIC);
+		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+				    WM8958_MICD_ENA, WM8958_MICD_ENA);
+	} else {
+		dev_dbg(codec->dev, "Jack not detected\n");
+
+		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
+				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
+				    wm8994->btn_mask);
+
+		wm8994->mic_detecting = false;
+		wm8994->jack_mic = false;
+		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+				    WM8958_MICD_ENA, 0);
+		wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_JACK);
+	}
+
+	mutex_unlock(&wm8994->accdet_lock);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * wm8958_mic_detect - Enable microphone detection via the WM8958 IRQ
  *
@@ -3076,8 +3251,22 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_2,
 				    WM8958_MICD_LVL_SEL_MASK, micd_lvl_sel);
 
-		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
-				    WM8958_MICD_ENA, WM8958_MICD_ENA);
+		WARN_ON(codec->dapm.bias_level > SND_SOC_BIAS_STANDBY);
+
+		/*
+		 * If we can use jack detection start off with that,
+		 * otherwise jump straight to microphone detection.
+		 */
+		if (wm8994->jackdet) {
+			snd_soc_update_bits(codec, WM8994_LDO_1,
+					    WM8994_LDO1_DISCH, 0);
+			wm1811_jackdet_set_mode(codec,
+						WM1811_JACKDET_MODE_JACK);
+		} else {
+			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+					    WM8958_MICD_ENA, WM8958_MICD_ENA);
+		}
+
 	} else {
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, 0);
@@ -3094,6 +3283,18 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	struct snd_soc_codec *codec = wm8994->codec;
 	int reg, count;
 
+	mutex_lock(&wm8994->accdet_lock);
+
+	/*
+	 * Jack detection may have detected a removal simulataneously
+	 * with an update of the MICDET status; if so it will have
+	 * stopped detection and we can ignore this interrupt.
+	 */
+	if (!(snd_soc_read(codec, WM8958_MIC_DETECT_1) & WM8958_MICD_ENA)) {
+		mutex_unlock(&wm8994->accdet_lock);
+		return IRQ_HANDLED;
+	}
+
 	/* We may occasionally read a detection without an impedence
 	 * range being provided - if that happens loop again.
 	 */
@@ -3101,6 +3302,7 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	do {
 		reg = snd_soc_read(codec, WM8958_MIC_DETECT_3);
 		if (reg < 0) {
+			mutex_unlock(&wm8994->accdet_lock);
 			dev_err(codec->dev,
 				"Failed to read mic detect status: %d\n",
 				reg);
@@ -3131,6 +3333,8 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 		dev_warn(codec->dev, "Accessory detection with no callback\n");
 
 out:
+	mutex_unlock(&wm8994->accdet_lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -3182,6 +3386,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994->pdata = dev_get_platdata(codec->dev->parent);
 	wm8994->codec = codec;
 
+	mutex_init(&wm8994->accdet_lock);
+
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		init_completion(&wm8994->fll_locked[i]);
 
@@ -3311,6 +3517,21 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		}
 	}
 
+	switch (control->type) {
+	case WM1811:
+		if (wm8994->revision > 1) {
+			ret = wm8994_request_irq(wm8994->wm8994,
+						 WM8994_IRQ_GPIO(6),
+						 wm1811_jackdet_irq, "JACKDET",
+						 wm8994);
+			if (ret == 0)
+				wm8994->jackdet = true;
+		}
+		break;
+	default:
+		break;
+	}
+
 	wm8994->fll_locked_irq = true;
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++) {
 		ret = wm8994_request_irq(wm8994->wm8994,
@@ -3533,6 +3754,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err_irq:
+	if (wm8994->jackdet)
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_GPIO(6), wm8994);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC2_SHRT, wm8994);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC2_DET, wm8994);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC1_SHRT, wm8994);
@@ -3571,6 +3794,9 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, codec);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, codec);
 
+	if (wm8994->jackdet)
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_GPIO(6), wm8994);
+
 	switch (control->type) {
 	case WM8994:
 		if (wm8994->micdet_irq)
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 0678f4d..c3a4247 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -75,6 +75,7 @@ struct wm8994_priv {
 	bool fll_locked_irq;
 
 	int vmid_refcount;
+	int active_refcount;
 
 	int dac_rates[2];
 	int lrclk_shared[2];
@@ -116,10 +117,12 @@ struct wm8994_priv {
 	const char **enh_eq_texts;
 	struct soc_enum enh_eq_enum;
 
+	struct mutex accdet_lock;
 	struct wm8994_micdet micdet[2];
 	bool mic_detecting;
 	bool jack_mic;
 	int btn_mask;
+	bool jackdet;
 
 	wm8958_micdet_cb jack_cb;
 	void *jack_cb_data;
-- 
1.7.7.3
