From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: rt5659: Fix irq leak
Date: Tue, 12 Jan 2016 15:55:17 +0800
Message-ID: <1452585317.5282.2.camel@ingics.com>
References: <1452585226.5282.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
 [209.85.220.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4093D265312
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 08:55:21 +0100 (CET)
Received: by mail-pa0-f68.google.com with SMTP id yy13so25499622pab.1
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 23:55:21 -0800 (PST)
In-Reply-To: <1452585226.5282.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use devm_request_threaded_irq to ensure the irq is freed when unload the
module. The rt5659->i2c is no longer used after this conversion, thus
remove it as well.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5659.c | 16 ++++------------
 sound/soc/codecs/rt5659.h |  1 -
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 47c717f4..1701c29 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3985,7 +3985,6 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 	if (rt5659 == NULL)
 		return -ENOMEM;
 
-	rt5659->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5659);
 
 	if (pdata)
@@ -4157,24 +4156,17 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 
 	INIT_DELAYED_WORK(&rt5659->jack_detect_work, rt5659_jack_detect_work);
 
-	if (rt5659->i2c->irq) {
-		ret = request_threaded_irq(rt5659->i2c->irq, NULL, rt5659_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+	if (i2c->irq) {
+		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+			rt5659_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5659", rt5659);
 		if (ret)
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5659,
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5659,
 			rt5659_dai, ARRAY_SIZE(rt5659_dai));
-
-	if (ret) {
-		if (rt5659->i2c->irq)
-			free_irq(rt5659->i2c->irq, rt5659);
-	}
-
-	return 0;
 }
 
 static int rt5659_i2c_remove(struct i2c_client *i2c)
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index 8f07ee9..d31c9e5 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1792,7 +1792,6 @@ struct rt5659_priv {
 	struct snd_soc_codec *codec;
 	struct rt5659_platform_data pdata;
 	struct regmap *regmap;
-	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_ldo1_en;
 	struct gpio_desc *gpiod_reset;
 	struct snd_soc_jack *hs_jack;
-- 
2.1.4
