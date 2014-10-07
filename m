From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2] ASoC: rt5645: Add the workqueue of the jack
	detect function for the debouncing
Date: Tue, 7 Oct 2014 10:25:37 +0800
Message-ID: <1412648737-11553-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D5C3260393
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 04:26:01 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the workqueue of the jack detect function for the debouncing.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 15 ++++++++++++++-
 sound/soc/codecs/rt5645.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index cfe1eff..16ee4f3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2166,11 +2166,20 @@ int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(rt5645_set_jack_detect);
 
+static void rt5645_jack_detect_work(struct work_struct *work)
+{
+	struct rt5645_priv *rt5645 =
+		container_of(work, struct rt5645_priv, jack_detect_work.work);
+
+	rt5645_jack_detect(rt5645->codec, rt5645->jack);
+}
+
 static irqreturn_t rt5645_irq(int irq, void *data)
 {
 	struct rt5645_priv *rt5645 = data;
 
-	rt5645_jack_detect(rt5645->codec, rt5645->jack);
+	queue_delayed_work(system_power_efficient_wq,
+			   &rt5645->jack_detect_work, msecs_to_jiffies(250));
 
 	return IRQ_HANDLED;
 }
@@ -2436,6 +2445,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			dev_err(&i2c->dev, "Fail gpio_direction hp_det_gpio\n");
 	}
 
+	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
+
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
 				      rt5645_dai, ARRAY_SIZE(rt5645_dai));
 }
@@ -2447,6 +2458,8 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5645);
 
+	cancel_delayed_work_sync(&rt5645->jack_detect_work);
+
 	if (gpio_is_valid(rt5645->pdata.hp_det_gpio))
 		gpio_free(rt5645->pdata.hp_det_gpio);
 
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 50c62c5..5ec2520 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2168,6 +2168,7 @@ struct rt5645_priv {
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct snd_soc_jack *jack;
+	struct delayed_work jack_detect_work;
 
 	int sysclk;
 	int sysclk_src;
-- 
1.8.1.1.439.g50a6b54
