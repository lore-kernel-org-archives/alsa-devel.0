From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: Fix irq leak" to the asoc tree
Date: Fri, 15 Jan 2016 18:18:56 +0000
Message-ID: <E1aK8xc-0005RK-9v@debutante>
References: <1452585317.5282.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40A60260484
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 19:19:03 +0100 (CET)
In-Reply-To: <1452585317.5282.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: Fix irq leak

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1ca2cf8c4167c2016d9716998b4f89c4e79d1f89 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 12 Jan 2016 15:55:17 +0800
Subject: [PATCH] ASoC: rt5659: Fix irq leak

Use devm_request_threaded_irq to ensure the irq is freed when unload the
module. The rt5659->i2c is no longer used after this conversion, thus
remove it as well.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 16 ++++------------
 sound/soc/codecs/rt5659.h |  1 -
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 820d8fa62b5e..c166d9394c69 100644
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
index 8f07ee903eaa..d31c9e5bcec8 100644
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
2.7.0.rc3
