From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement interrupt based jack detection
Date: Fri,  1 Oct 2010 00:28:17 -0700
Message-ID: <1285918097-20720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 337B51039D5
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 09:28:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow microphone detection on WM8962 to be performed using the interrupt
signal, allowing the detection of both microphone presence and button
presses with a signal singal from the CODEC to CPU.  Currently a 250ms
debounce time is applied to both short circuit and presence detection,
this has not been optimised.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   85 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8962.h |    3 ++
 2 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index eb66c66..3a1db4a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -63,6 +64,9 @@ struct wm8962_priv {
 	int fll_fref;
 	int fll_fout;
 
+	struct delayed_work mic_work;
+	struct snd_soc_jack *jack;
+
 	struct regulator_bulk_data supplies[WM8962_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8962_NUM_SUPPLIES];
 
@@ -1462,9 +1466,40 @@ static struct snd_soc_dai_driver wm8962_dai = {
 	.symmetric_rates = 1,
 };
 
+static void wm8962_mic_work(struct work_struct *work)
+{
+	struct wm8962_priv *wm8962 = container_of(work,
+						  struct wm8962_priv,
+						  mic_work.work);
+	struct snd_soc_codec *codec = wm8962->codec;
+	int status = 0;
+	int irq_pol = 0;
+	int reg;
+
+	reg = snd_soc_read(codec, WM8962_ADDITIONAL_CONTROL_4);
+
+	if (reg & WM8962_MICDET_STS) {
+		status |= SND_JACK_MICROPHONE;
+		irq_pol |= WM8962_MICD_IRQ_POL;
+	}
+
+	if (reg & WM8962_MICSHORT_STS) {
+		status |= SND_JACK_BTN_0;
+		irq_pol |= WM8962_MICSCD_IRQ_POL;
+	}
+
+	snd_soc_jack_report(wm8962->jack, status,
+			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
+
+	snd_soc_update_bits(codec, WM8962_MICINT_SOURCE_POL,
+			    WM8962_MICSCD_IRQ_POL |
+			    WM8962_MICD_IRQ_POL, irq_pol);
+}
+
 static irqreturn_t wm8962_irq(int irq, void *data)
 {
 	struct snd_soc_codec *codec = data;
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int mask;
 	int active;
 
@@ -1479,12 +1514,59 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	if (active & WM8962_TEMP_SHUT_EINT)
 		dev_crit(codec->dev, "Thermal shutdown\n");
 
+	if (active & (WM8962_MICSCD_EINT | WM8962_MICD_EINT)) {
+		dev_dbg(codec->dev, "Microphone event detected\n");
+
+		schedule_delayed_work(&wm8962->mic_work,
+				      msecs_to_jiffies(250));
+	}
+
 	/* Acknowledge the interrupts */
 	snd_soc_write(codec, WM8962_INTERRUPT_STATUS_2, active);
 
 	return IRQ_HANDLED;
 }
 
+/**
+ * wm8962_mic_detect - Enable microphone detection via the WM8962 IRQ
+ *
+ * @codec:  WM8962 codec
+ * @jack:   jack to report detection events on
+ *
+ * Enable microphone detection via IRQ on the WM8962.  If GPIOs are
+ * being used to bring out signals to the processor then only platform
+ * data configuration is needed for WM8962 and processor GPIOs should
+ * be configured using snd_soc_jack_add_gpios() instead.
+ *
+ * If no jack is supplied detection will be disabled.
+ */
+int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
+{
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	int irq_mask, enable;
+
+	wm8962->jack = jack;
+	if (jack) {
+		irq_mask = 0;
+		enable = WM8962_MICDET_ENA;
+	} else {
+		irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
+		enable = 0;
+	}
+
+	snd_soc_update_bits(codec, WM8962_INTERRUPT_STATUS_2_MASK,
+			    WM8962_MICD_EINT | WM8962_MICSCD_EINT, irq_mask);
+	snd_soc_update_bits(codec, WM8962_ADDITIONAL_CONTROL_4,
+			    WM8962_MICDET_ENA, enable);
+
+	/* Send an initial empty report */
+	snd_soc_jack_report(wm8962->jack, 0,
+			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm8962_mic_detect);
+
 #ifdef CONFIG_PM
 static int wm8962_resume(struct snd_soc_codec *codec)
 {
@@ -1773,6 +1855,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	int i, trigger, irq_pol;
 
 	wm8962->codec = codec;
+	INIT_DELAYED_WORK(&wm8962->mic_work, wm8962_mic_work);
 
 	codec->cache_sync = 1;
 	codec->idle_bias_off = 1;
@@ -1946,6 +2029,8 @@ static int wm8962_remove(struct snd_soc_codec *codec)
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
 
+	cancel_delayed_work_sync(&wm8962->mic_work);
+
 	wm8962_free_gpio(codec);
 	wm8962_free_beep(codec);
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
diff --git a/sound/soc/codecs/wm8962.h b/sound/soc/codecs/wm8962.h
index fce1199..2af6c93 100644
--- a/sound/soc/codecs/wm8962.h
+++ b/sound/soc/codecs/wm8962.h
@@ -14,6 +14,7 @@
 #define _WM8962_H
 
 #include <asm/types.h>
+#include <sound/soc.h>
 
 #define WM8962_SYSCLK_MCLK 1
 #define WM8962_SYSCLK_FLL  2
@@ -3785,4 +3786,6 @@ struct wm8962_reg_access {
 extern
 const struct wm8962_reg_access wm8962_reg_access[WM8962_MAX_REGISTER + 1];
 
+int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
+
 #endif
-- 
1.7.1
