From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: wm8996: Move regulator notifier
	callbacks into I2C level
Date: Mon, 11 Jun 2012 19:55:38 +0800
Message-ID: <1339415740-2376-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B19D243A0
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:56:31 +0200 (CEST)
In-Reply-To: <1339415740-2376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Now that we're using regmap the cache is available here.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 49e0e8d..e0cf5b0 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2644,21 +2644,6 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		goto err;
 	}
 
-	wm8996->disable_nb[0].notifier_call = wm8996_regulator_event_0;
-	wm8996->disable_nb[1].notifier_call = wm8996_regulator_event_1;
-	wm8996->disable_nb[2].notifier_call = wm8996_regulator_event_2;
-
-	/* This should really be moved into the regulator core */
-	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++) {
-		ret = regulator_register_notifier(wm8996->supplies[i].consumer,
-						  &wm8996->disable_nb[i]);
-		if (ret != 0) {
-			dev_err(codec->dev,
-				"Failed to register regulator notifier: %d\n",
-				ret);
-		}
-	}
-
 	/* Apply platform data settings */
 	snd_soc_update_bits(codec, WM8996_LINE_INPUT_CONTROL,
 			    WM8996_INL_MODE_MASK | WM8996_INR_MODE_MASK,
@@ -2858,9 +2843,7 @@ err:
 
 static int wm8996_remove(struct snd_soc_codec *codec)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
-	int i;
 
 	snd_soc_update_bits(codec, WM8996_INTERRUPT_CONTROL,
 			    WM8996_IM_IRQ, WM8996_IM_IRQ);
@@ -2868,10 +2851,6 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 	if (i2c->irq)
 		free_irq(i2c->irq, codec);
 
-	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
-		regulator_unregister_notifier(wm8996->supplies[i].consumer,
-					      &wm8996->disable_nb[i]);
-
 	return 0;
 }
 
@@ -2985,6 +2964,21 @@ static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
 		goto err_gpio;
 	}
 
+	wm8996->disable_nb[0].notifier_call = wm8996_regulator_event_0;
+	wm8996->disable_nb[1].notifier_call = wm8996_regulator_event_1;
+	wm8996->disable_nb[2].notifier_call = wm8996_regulator_event_2;
+
+	/* This should really be moved into the regulator core */
+	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++) {
+		ret = regulator_register_notifier(wm8996->supplies[i].consumer,
+						  &wm8996->disable_nb[i]);
+		if (ret != 0) {
+			dev_err(&i2c->dev,
+				"Failed to register regulator notifier: %d\n",
+				ret);
+		}
+	}
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8996->supplies),
 				    wm8996->supplies);
 	if (ret != 0) {
@@ -3062,6 +3056,7 @@ err:
 static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 {
 	struct wm8996_priv *wm8996 = i2c_get_clientdata(client);
+	int i;
 
 	snd_soc_unregister_codec(&client->dev);
 	wm8996_free_gpio(wm8996);
@@ -3069,6 +3064,10 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
 		gpio_free(wm8996->pdata.ldo_ena);
 	}
+	for (i = 0; i < ARRAY_SIZE(wm8996->supplies); i++)
+		regulator_unregister_notifier(wm8996->supplies[i].consumer,
+					      &wm8996->disable_nb[i]);
+
 	return 0;
 }
 
-- 
1.7.10
