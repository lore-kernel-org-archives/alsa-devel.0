From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: request IRQ in soc level
Date: Mon, 28 Jul 2014 16:08:43 +0800
Message-ID: <1406534923-27415-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EAB87265465
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 10:09:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

We assign rt286->codec in rt286_probe. To prevent rt286->codec = NULL
when rt286_irq is executed, it is better to request IRQ in rt286_probe
instead of rt286_i2c_probe.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 218f86e..76b55cd 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -963,10 +963,28 @@ static irqreturn_t rt286_irq(int irq, void *data)
 static int rt286_probe(struct snd_soc_codec *codec)
 {
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	rt286->codec = codec;
 
+	if (rt286->i2c->irq) {
+		regmap_update_bits(rt286->regmap,
+					RT286_IRQ_CTRL, 0x2, 0x2);
+
+		INIT_DELAYED_WORK(&rt286->jack_detect_work,
+					rt286_jack_detect_work);
+		schedule_delayed_work(&rt286->jack_detect_work,
+					msecs_to_jiffies(1250));
+
+		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
+			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to reguest IRQ: %d\n", ret);
+			return ret;
+		}
+	}
 	return 0;
 }
 
@@ -976,6 +994,9 @@ static int rt286_remove(struct snd_soc_codec *codec)
 
 	cancel_delayed_work_sync(&rt286->jack_detect_work);
 
+	if (rt286->i2c->irq)
+		free_irq(rt286->i2c->irq, rt286);
+
 	return 0;
 }
 
@@ -1170,24 +1191,6 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL3, 0xf777, 0x4737);
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
 
-	if (rt286->i2c->irq) {
-		regmap_update_bits(rt286->regmap,
-					RT286_IRQ_CTRL, 0x2, 0x2);
-
-		INIT_DELAYED_WORK(&rt286->jack_detect_work,
-					rt286_jack_detect_work);
-		schedule_delayed_work(&rt286->jack_detect_work,
-					msecs_to_jiffies(1250));
-
-		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);
-		if (ret != 0) {
-			dev_err(&i2c->dev,
-				"Failed to reguest IRQ: %d\n", ret);
-			return ret;
-		}
-	}
-
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
 				     rt286_dai, ARRAY_SIZE(rt286_dai));
 
@@ -1196,12 +1199,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 
 static int rt286_i2c_remove(struct i2c_client *i2c)
 {
-	struct rt286_priv *rt286 = i2c_get_clientdata(i2c);
-
-	if (i2c->irq)
-		free_irq(i2c->irq, rt286);
 	snd_soc_unregister_codec(&i2c->dev);
-
 	return 0;
 }
 
-- 
1.8.1.1.439.g50a6b54
