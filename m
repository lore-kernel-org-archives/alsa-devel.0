From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH v2 1/2] ASoC: rt5645: Fix missing free_irq
Date: Fri, 17 Jul 2015 11:33:11 +0800
Message-ID: <1437103992-61518-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com
Cc: srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bardliao@realtek.com, oder_chiou@realtek.com, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The driver does not free irq when snd_soc_register_codec returns error.
It does not return error when request irq failed, either.

Add return when request irq failed, and free_irq if
snd_soc_register_codec failed.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
Change since v1:
 - use free_irq instead of devm_request_threaded_irq
---
 sound/soc/codecs/rt5645.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2cedf0d..56e8c31 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3401,12 +3401,23 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
 			| IRQF_ONESHOT, "rt5645", rt5645);
-		if (ret)
+		if (ret) {
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			return ret;
+		}
 	}
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
-				      rt5645_dai, ARRAY_SIZE(rt5645_dai));
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
+				     rt5645_dai, ARRAY_SIZE(rt5645_dai));
+	if (ret)
+		goto err_irq;
+
+	return 0;
+
+err_irq:
+	if (rt5645->i2c->irq)
+		free_irq(rt5645->i2c->irq, rt5645);
+	return ret;
 }
 
 static int rt5645_i2c_remove(struct i2c_client *i2c)
-- 
1.8.1.1.dirty
