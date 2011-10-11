From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement WM5100 accessory detection
	support
Date: Tue, 11 Oct 2011 18:55:40 +0100
Message-ID: <1318355741-23167-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2BC8103839
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 19:55:43 +0200 (CEST)
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

The WM5100 includes an advanced, low power, accessory detect subsystem
capable of detecting both accessory presence and button presses while
the device is in an ultra low power mode. Implement initial support for
this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |  162 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm5100.h |    2 +
 2 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 80f3fee..9ce3e57 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -26,6 +26,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/wm5100.h>
@@ -68,6 +69,11 @@ struct wm5100_priv {
 
 	bool out_ena[2];
 
+	struct snd_soc_jack *jack;
+	bool jack_detecting;
+	bool jack_mic;
+	int jack_mode;
+
 	struct wm5100_fll fll[2];
 
 	struct wm5100_pdata pdata;
@@ -2114,6 +2120,159 @@ static int wm5100_dig_vu[] = {
 	WM5100_DAC_DIGITAL_VOLUME_6R,
 };
 
+static void wm5100_set_detect_mode(struct snd_soc_codec *codec, int the_mode)
+{
+	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	struct wm5100_jack_mode *mode = &wm5100->pdata.jack_modes[the_mode];
+
+	BUG_ON(the_mode >= ARRAY_SIZE(wm5100->pdata.jack_modes));
+
+	gpio_set_value_cansleep(wm5100->pdata.hp_pol, mode->hp_pol);
+	snd_soc_update_bits(codec, WM5100_ACCESSORY_DETECT_MODE_1,
+			    WM5100_ACCDET_BIAS_SRC_MASK |
+			    WM5100_ACCDET_SRC,
+			    (mode->bias << WM5100_ACCDET_BIAS_SRC_SHIFT) |
+			    mode->micd_src << WM5100_ACCDET_SRC_SHIFT);
+
+	wm5100->jack_mode = the_mode;
+
+	dev_dbg(codec->dev, "Set microphone polarity to %d\n",
+		wm5100->jack_mode);
+}
+
+static void wm5100_micd_irq(struct snd_soc_codec *codec)
+{
+	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	int val;
+
+	val = snd_soc_read(codec, WM5100_MIC_DETECT_3);
+
+	dev_dbg(codec->dev, "Microphone event: %x\n", val);
+
+	if (!(val & WM5100_ACCDET_VALID)) {
+		dev_warn(codec->dev, "Microphone detection state invalid\n");
+		return;
+	}
+
+	/* No accessory, reset everything and report removal */
+	if (!(val & WM5100_ACCDET_STS)) {
+		dev_dbg(codec->dev, "Jack removal detected\n");
+		wm5100->jack_mic = false;
+		wm5100->jack_detecting = true;
+		snd_soc_jack_report(wm5100->jack, 0,
+				    SND_JACK_LINEOUT | SND_JACK_HEADSET |
+				    SND_JACK_BTN_0);
+
+		snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
+				    WM5100_ACCDET_RATE_MASK,
+				    WM5100_ACCDET_RATE_MASK);
+		return;
+	}
+
+	/* If the measurement is very high we've got a microphone,
+	 * either we just detected one or if we already reported then
+	 * we've got a button release event.
+	 */
+	if (val & 0x400) {
+		if (wm5100->jack_detecting) {
+			dev_dbg(codec->dev, "Microphone detected\n");
+			wm5100->jack_mic = true;
+			snd_soc_jack_report(wm5100->jack,
+					    SND_JACK_HEADSET,
+					    SND_JACK_HEADSET | SND_JACK_BTN_0);
+
+			/* Increase poll rate to give better responsiveness
+			 * for buttons */
+			snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
+					    WM5100_ACCDET_RATE_MASK,
+					    5 << WM5100_ACCDET_RATE_SHIFT);
+		} else {
+			dev_dbg(codec->dev, "Mic button up\n");
+			snd_soc_jack_report(wm5100->jack, 0, SND_JACK_BTN_0);
+		}
+
+		return;
+	}
+
+	/* If we detected a lower impedence during initial startup
+	 * then we probably have the wrong polarity, flip it.  Don't
+	 * do this for the lowest impedences to speed up detection of
+	 * plain headphones.
+	 */
+	if (wm5100->jack_detecting && (val & 0x3f8)) {
+		wm5100_set_detect_mode(codec, !wm5100->jack_mode);
+
+		return;
+	}
+
+	/* Don't distinguish between buttons, just report any low
+	 * impedence as BTN_0.
+	 */
+	if (val & 0x3fc) {
+		if (wm5100->jack_mic) {
+			dev_dbg(codec->dev, "Mic button detected\n");
+			snd_soc_jack_report(wm5100->jack, SND_JACK_BTN_0,
+					    SND_JACK_BTN_0);
+		} else if (wm5100->jack_detecting) {
+			dev_dbg(codec->dev, "Headphone detected\n");
+			snd_soc_jack_report(wm5100->jack, SND_JACK_HEADPHONE,
+					    SND_JACK_HEADPHONE);
+
+			/* Increase the detection rate a bit for
+			 * responsiveness.
+			 */
+			snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
+					    WM5100_ACCDET_RATE_MASK,
+					    7 << WM5100_ACCDET_RATE_SHIFT);
+		}
+	}
+}
+
+int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
+{
+	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+
+	if (jack) {
+		wm5100->jack = jack;
+		wm5100->jack_detecting = true;
+
+		wm5100_set_detect_mode(codec, 0);
+
+		/* Slowest detection rate, gives debounce for initial
+		 * detection */
+		snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
+				    WM5100_ACCDET_BIAS_STARTTIME_MASK |
+				    WM5100_ACCDET_RATE_MASK,
+				    (7 << WM5100_ACCDET_BIAS_STARTTIME_SHIFT) |
+				    WM5100_ACCDET_RATE_MASK);
+
+		/* We need the charge pump to power MICBIAS */
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "CP2");
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
+		snd_soc_dapm_sync(&codec->dapm);
+
+		/* We start off just enabling microphone detection - even a
+		 * plain headphone will trigger detection.
+		 */
+		snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
+				    WM5100_ACCDET_ENA, WM5100_ACCDET_ENA);
+
+		snd_soc_update_bits(codec, WM5100_INTERRUPT_STATUS_3_MASK,
+				    WM5100_IM_ACCDET_EINT, 0);
+	} else {
+		snd_soc_update_bits(codec, WM5100_INTERRUPT_STATUS_3_MASK,
+				    WM5100_IM_HPDET_EINT |
+				    WM5100_IM_ACCDET_EINT,
+				    WM5100_IM_HPDET_EINT |
+				    WM5100_IM_ACCDET_EINT);
+		snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
+				    WM5100_ACCDET_ENA, 0);
+		wm5100->jack = NULL;
+	}
+
+	return 0;
+}
+
 static irqreturn_t wm5100_irq(int irq, void *data)
 {
 	struct snd_soc_codec *codec = data;
@@ -2145,6 +2304,9 @@ static irqreturn_t wm5100_irq(int irq, void *data)
 		complete(&wm5100->fll[1].lock);
 	}
 
+	if (irq_val & WM5100_ACCDET_EINT)
+		wm5100_micd_irq(codec);
+
 	irq_val = snd_soc_read(codec, WM5100_INTERRUPT_STATUS_4);
 	if (irq_val < 0) {
 		dev_err(codec->dev, "Failed to read IRQ status 4: %d\n",
diff --git a/sound/soc/codecs/wm5100.h b/sound/soc/codecs/wm5100.h
index 345b3cf..fa32b12 100644
--- a/sound/soc/codecs/wm5100.h
+++ b/sound/soc/codecs/wm5100.h
@@ -16,6 +16,8 @@
 
 #include <sound/soc.h>
 
+int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
+
 #define WM5100_CLK_AIF1     1
 #define WM5100_CLK_AIF2     2
 #define WM5100_CLK_AIF3     3
-- 
1.7.6.3
