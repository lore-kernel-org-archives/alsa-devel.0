From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: Factor out I2C usage in WM8962 driver
Date: Wed,  8 Jun 2011 14:50:51 +0100
Message-ID: <1307541055-10150-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E15A103888
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 15:51:03 +0200 (CEST)
In-Reply-To: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The chip can actually support SPI so we shouldn't assume we've got an I2C
device even though that's the most common configuration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 5e05eed..a159453 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -78,6 +78,8 @@ struct wm8962_priv {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
 #endif
+
+	int irq;
 };
 
 /* We can't use the same notifier block for more than one supply and
@@ -3731,8 +3733,6 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
-	struct i2c_client *i2c = container_of(codec->dev, struct i2c_client,
-					      dev);
 	u16 *reg_cache = codec->reg_cache;
 	int i, trigger, irq_pol;
 	bool dmicclk, dmicdat;
@@ -3899,7 +3899,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	wm8962_init_beep(codec);
 	wm8962_init_gpio(codec);
 
-	if (i2c->irq) {
+	if (wm8962->irq) {
 		if (pdata && pdata->irq_active_low) {
 			trigger = IRQF_TRIGGER_LOW;
 			irq_pol = WM8962_IRQ_POL;
@@ -3911,12 +3911,13 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 		snd_soc_update_bits(codec, WM8962_INTERRUPT_CONTROL,
 				    WM8962_IRQ_POL, irq_pol);
 
-		ret = request_threaded_irq(i2c->irq, NULL, wm8962_irq,
+		ret = request_threaded_irq(wm8962->irq, NULL, wm8962_irq,
 					   trigger | IRQF_ONESHOT,
 					   "wm8962", codec);
 		if (ret != 0) {
 			dev_err(codec->dev, "Failed to request IRQ %d: %d\n",
-				i2c->irq, ret);
+				wm8962->irq, ret);
+			wm8962->irq = 0;
 			/* Non-fatal */
 		} else {
 			/* Enable some IRQs by default */
@@ -3941,12 +3942,10 @@ err:
 static int wm8962_remove(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = container_of(codec->dev, struct i2c_client,
-					      dev);
 	int i;
 
-	if (i2c->irq)
-		free_irq(i2c->irq, codec);
+	if (wm8962->irq)
+		free_irq(wm8962->irq, codec);
 
 	cancel_delayed_work_sync(&wm8962->mic_work);
 
@@ -3986,6 +3985,8 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8962);
 
+	wm8962->irq = i2c->irq;
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8962, &wm8962_dai, 1);
 	if (ret < 0)
-- 
1.7.5.3
