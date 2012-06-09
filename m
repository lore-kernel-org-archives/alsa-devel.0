From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: wm8903: Move interrupt request to
	I2C probe
Date: Sat,  9 Jun 2012 11:09:54 +0800
Message-ID: <1339211396-31711-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B340C103E82
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 05:10:14 +0200 (CEST)
In-Reply-To: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There's no reason to defer requesting of the interrupt until the CODEC
probe and doing so results in more work if we hit an error as we'll have
registered the CODEC with the core. It's neater to acquire as many of the
resources we'll need as we can in the bus probe function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   66 +++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 8fe9b78..21c4dd2 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -122,7 +122,6 @@ struct wm8903_priv {
 
 	int sysclk;
 	int sysclk_src;
-	int irq;
 
 	int fs;
 	int deemph;
@@ -2096,9 +2095,7 @@ static void wm8903_free_gpio(struct wm8903_priv *wm8903)
 static int wm8903_probe(struct snd_soc_codec *codec)
 {
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	struct wm8903_platform_data *pdata = wm8903->pdata;
 	int ret;
-	int trigger, irq_pol;
 	u16 val;
 
 	wm8903->codec = codec;
@@ -2110,32 +2107,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	if (wm8903->irq) {
-		if (pdata->irq_active_low) {
-			trigger = IRQF_TRIGGER_LOW;
-			irq_pol = WM8903_IRQ_POL;
-		} else {
-			trigger = IRQF_TRIGGER_HIGH;
-			irq_pol = 0;
-		}
-
-		snd_soc_update_bits(codec, WM8903_INTERRUPT_CONTROL,
-				    WM8903_IRQ_POL, irq_pol);
-		
-		ret = request_threaded_irq(wm8903->irq, NULL, wm8903_irq,
-					   trigger | IRQF_ONESHOT,
-					   "wm8903", wm8903);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to request IRQ: %d\n",
-				ret);
-			return ret;
-		}
-
-		/* Enable write sequencer interrupts */
-		snd_soc_update_bits(codec, WM8903_INTERRUPT_STATUS_1_MASK,
-				    WM8903_IM_WSEQ_BUSY_EINT, 0);
-	}
-
 	/* power on device */
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -2176,11 +2147,7 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 /* power down chip */
 static int wm8903_remove(struct snd_soc_codec *codec)
 {
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	if (wm8903->irq)
-		free_irq(wm8903->irq, wm8903);
 
 	return 0;
 }
@@ -2290,8 +2257,9 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 {
 	struct wm8903_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8903_priv *wm8903;
+	int trigger;
 	bool mic_gpio = false;
-	unsigned int val;
+	unsigned int val, irq_pol;
 	int ret, i;
 
 	wm8903 = devm_kzalloc(&i2c->dev,  sizeof(struct wm8903_priv),
@@ -2309,7 +2277,6 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	}
 
 	i2c_set_clientdata(i2c, wm8903);
-	wm8903->irq = i2c->irq;
 
 	/* If no platform data was supplied, create storage for defaults */
 	if (pdata) {
@@ -2403,6 +2370,33 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	wm8903->mic_delay = pdata->micdet_delay;
 
+	if (i2c->irq) {
+		if (pdata->irq_active_low) {
+			trigger = IRQF_TRIGGER_LOW;
+			irq_pol = WM8903_IRQ_POL;
+		} else {
+			trigger = IRQF_TRIGGER_HIGH;
+			irq_pol = 0;
+		}
+
+		regmap_update_bits(wm8903->regmap, WM8903_INTERRUPT_CONTROL,
+				   WM8903_IRQ_POL, irq_pol);
+
+		ret = request_threaded_irq(i2c->irq, NULL, wm8903_irq,
+					   trigger | IRQF_ONESHOT,
+					   "wm8903", wm8903);
+		if (ret != 0) {
+			dev_err(wm8903->dev, "Failed to request IRQ: %d\n",
+				ret);
+			return ret;
+		}
+
+		/* Enable write sequencer interrupts */
+		regmap_update_bits(wm8903->regmap,
+				   WM8903_INTERRUPT_STATUS_1_MASK,
+				   WM8903_IM_WSEQ_BUSY_EINT, 0);
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8903, &wm8903_dai, 1);
 	if (ret != 0)
@@ -2418,6 +2412,8 @@ static __devexit int wm8903_i2c_remove(struct i2c_client *client)
 {
 	struct wm8903_priv *wm8903 = i2c_get_clientdata(client);
 
+	if (client->irq)
+		free_irq(client->irq, wm8903);
 	wm8903_free_gpio(wm8903);
 	regmap_exit(wm8903->regmap);
 	snd_soc_unregister_codec(&client->dev);
-- 
1.7.10
