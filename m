From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Initial WM8962 IRQ support
Date: Tue, 28 Sep 2010 20:53:26 -0700
Message-ID: <1285732406-30090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24862103897
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 05:53:16 +0200 (CEST)
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

Provide an initial hookup for interrupts on the WM8962. Currently we simply
report error status via log messages if an IRQ is provided for the device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm8962.h    |    2 +
 sound/soc/codecs/wm8962.c |   60 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/include/sound/wm8962.h b/include/sound/wm8962.h
index f70258e..cc32aff 100644
--- a/include/sound/wm8962.h
+++ b/include/sound/wm8962.h
@@ -17,6 +17,8 @@
 struct wm8962_pdata {
 	u32 gpio_init[WM8962_MAX_GPIO];
 
+	bool irq_active_low;
+
 	bool spk_mono;   /* Speaker outputs tied together as mono */
 };
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 12286d6..009321b 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1461,6 +1461,29 @@ static struct snd_soc_dai_driver wm8962_dai = {
 	.symmetric_rates = 1,
 };
 
+static irqreturn_t wm8962_irq(int irq, void *data)
+{
+	struct snd_soc_codec *codec = data;
+	int mask;
+	int active;
+
+	mask = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2);
+
+	active = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2);
+	active &= ~mask;
+
+	if (active & WM8962_FIFOS_ERR_EINT)
+		dev_err(codec->dev, "FIFO error\n");
+
+	if (active & WM8962_TEMP_SHUT_EINT)
+		dev_crit(codec->dev, "Thermal shutdown\n");
+
+	/* Acknowledge the interrupts */
+	snd_soc_write(codec, WM8962_INTERRUPT_STATUS_2, active);
+
+	return IRQ_HANDLED;
+}
+
 #ifdef CONFIG_PM
 static int wm8962_resume(struct snd_soc_codec *codec)
 {
@@ -1632,7 +1655,9 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
-	int i;
+	struct i2c_client *i2c = container_of(codec->dev, struct i2c_client,
+					      dev);
+	int i, trigger, irq_pol;
 
 	wm8962->codec = codec;
 
@@ -1748,6 +1773,34 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 
 	wm8962_init_beep(codec);
 
+	if (i2c->irq) {
+		if (pdata && pdata->irq_active_low) {
+			trigger = IRQF_TRIGGER_LOW;
+			irq_pol = WM8962_IRQ_POL;
+		} else {
+			trigger = IRQF_TRIGGER_HIGH;
+			irq_pol = 0;
+		}
+
+		snd_soc_update_bits(codec, WM8962_INTERRUPT_CONTROL,
+				    WM8962_IRQ_POL, irq_pol);
+
+		ret = request_threaded_irq(i2c->irq, NULL, wm8962_irq,
+					   trigger | IRQF_ONESHOT,
+					   "wm8962", codec);
+		if (ret != 0) {
+			dev_err(codec->dev, "Failed to request IRQ %d: %d\n",
+				i2c->irq, ret);
+			/* Non-fatal */
+		} else {
+			/* Enable error reporting IRQs by default */
+			snd_soc_update_bits(codec,
+					    WM8962_INTERRUPT_STATUS_2_MASK,
+					    WM8962_TEMP_SHUT_EINT |
+					    WM8962_FIFOS_ERR_EINT, 0);
+		}
+	}
+
 	return 0;
 
 err_enable:
@@ -1762,8 +1815,13 @@ err:
 static int wm8962_remove(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *i2c = container_of(codec->dev, struct i2c_client,
+					      dev);
 	int i;
 
+	if (i2c->irq)
+		free_irq(i2c->irq, codec);
+
 	wm8962_free_beep(codec);
 	for (i = 0; i < ARRAY_SIZE(wm8962->supplies); i++)
 		regulator_unregister_notifier(wm8962->supplies[i].consumer,
-- 
1.7.1
