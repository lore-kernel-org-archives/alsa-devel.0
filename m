From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Move irq request to rt5645_probe
Date: Tue, 30 Jun 2015 15:30:41 +0800
Message-ID: <1435649441-1941-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B5C260412
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 09:31:01 +0200 (CEST)
Received: by pdjd13 with SMTP id d13so1373502pdj.0
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 00:30:58 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

rt5645_jack_detect_work (the workqueue called by rt5645_irq),
needs to access rt5645->codec. However, this field is only
initialized in rt5645_probe. This can obviously lead to kernel
panics.

Fix that by moving the irq request from rt5645_i2c_probe to
rt5645_probe. Also, fail if the IRQ cannot be requested, and move
irq_free from rt5645_i2c_remove to rt5645_remove.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e..7f84f21 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3044,6 +3044,7 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 static int rt5645_probe(struct snd_soc_codec *codec)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	rt5645->codec = codec;
 
@@ -3072,12 +3073,32 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_sync(&codec->dapm);
 	}
 
+	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
+
+	if (rt5645->i2c->irq) {
+		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+				| IRQF_ONESHOT, "rt5645", rt5645);
+		if (ret) {
+			dev_err(codec->dev, "Failed to request IRQ: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static int rt5645_remove(struct snd_soc_codec *codec)
 {
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+
+	if (rt5645->i2c->irq)
+		free_irq(rt5645->i2c->irq, rt5645);
+
+	cancel_delayed_work_sync(&rt5645->jack_detect_work);
+
 	rt5645_reset(codec);
+
 	return 0;
 }
 
@@ -3428,29 +3449,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
-	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
-
-	if (rt5645->i2c->irq) {
-		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-			| IRQF_ONESHOT, "rt5645", rt5645);
-		if (ret)
-			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
-	}
-
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
 				      rt5645_dai, ARRAY_SIZE(rt5645_dai));
 }
 
 static int rt5645_i2c_remove(struct i2c_client *i2c)
 {
-	struct rt5645_priv *rt5645 = i2c_get_clientdata(i2c);
-
-	if (i2c->irq)
-		free_irq(i2c->irq, rt5645);
-
-	cancel_delayed_work_sync(&rt5645->jack_detect_work);
-
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
-- 
2.4.3.573.g4eafbef
