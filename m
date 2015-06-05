From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Init jack_detect_work before
	registering irq
Date: Fri,  5 Jun 2015 18:42:12 +0800
Message-ID: <1433500932-39431-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id D6B29261497
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 12:42:31 +0200 (CEST)
Received: by pdjn11 with SMTP id n11so13201738pdj.0
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2015 03:42:30 -0700 (PDT)
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

Prevents frequent panic on boot, if the irq handler rt5645_irq
gets called before the workqueue rt5645_jack_detect_work is
initialized.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
Applies on top of broonie/sound.git/for-next (dac48b88824392de29a437607b7dbf844bb66f74)

 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e9544c6..d5f0f56 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3416,6 +3416,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
+
 	if (rt5645->i2c->irq) {
 		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
@@ -3434,8 +3436,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			dev_err(&i2c->dev, "Fail gpio_direction hp_det_gpio\n");
 	}
 
-	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
-
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
 				      rt5645_dai, ARRAY_SIZE(rt5645_dai));
 }
-- 
2.2.0.rc0.207.ga3a616c
