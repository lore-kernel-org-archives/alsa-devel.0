From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda1380: Request GPIOs at bus probe
	time" to the asoc tree
Date: Wed, 23 Nov 2016 12:38:14 +0000
Message-ID: <E1c9WoY-0007Br-AY@debutante>
References: <1479893411-32011-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 600D6266649
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 13:38:28 +0100 (CET)
In-Reply-To: <1479893411-32011-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda1380: Request GPIOs at bus probe time

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

>From 222e728ca29b5976accd1fc520a716d168ee2ca5 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 23 Nov 2016 10:30:11 +0100
Subject: [PATCH] ASoC: uda1380: Request GPIOs at bus probe time

Resources should be requested when the device is probed on the control bus
rather then when the CODEC is bound to the sound card. This allows things
like probe deferring and device managed allocations to work.

So move the GPIO request calls from the CODEC probe to the bus probe and
also make them managed along the way.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda1380.c | 55 +++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 8e52439a58fd..2918fdb95e58 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -698,25 +698,10 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	codec->hw_write = (hw_write_t)i2c_master_send;
 	codec->control_data = uda1380->control_data;
 
-	if (!pdata)
-		return -EINVAL;
-
-	if (gpio_is_valid(pdata->gpio_reset)) {
-		ret = gpio_request_one(pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
-				       "uda1380 reset");
-		if (ret)
-			goto err_out;
-	}
-
-	if (gpio_is_valid(pdata->gpio_power)) {
-		ret = gpio_request_one(pdata->gpio_power, GPIOF_OUT_INIT_LOW,
-				   "uda1380 power");
-		if (ret)
-			goto err_free_gpio;
-	} else {
+	if (!gpio_is_valid(pdata->gpio_power)) {
 		ret = uda1380_reset(codec);
 		if (ret)
-			goto err_free_gpio;
+			return ret;
 	}
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
@@ -733,28 +718,10 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 	}
 
 	return 0;
-
-err_free_gpio:
-	if (gpio_is_valid(pdata->gpio_reset))
-		gpio_free(pdata->gpio_reset);
-err_out:
-	return ret;
-}
-
-/* power down chip */
-static int uda1380_remove(struct snd_soc_codec *codec)
-{
-	struct uda1380_platform_data *pdata =codec->dev->platform_data;
-
-	gpio_free(pdata->gpio_reset);
-	gpio_free(pdata->gpio_power);
-
-	return 0;
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.probe =	uda1380_probe,
-	.remove =	uda1380_remove,
 	.read =		uda1380_read_reg_cache,
 	.write =	uda1380_write,
 	.set_bias_level = uda1380_set_bias_level,
@@ -778,14 +745,32 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 static int uda1380_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
+	struct uda1380_platform_data *pdata = i2c->dev.platform_data;
 	struct uda1380_priv *uda1380;
 	int ret;
 
+	if (!pdata)
+		return -EINVAL;
+
 	uda1380 = devm_kzalloc(&i2c->dev, sizeof(struct uda1380_priv),
 			       GFP_KERNEL);
 	if (uda1380 == NULL)
 		return -ENOMEM;
 
+	if (gpio_is_valid(pdata->gpio_reset)) {
+		ret = devm_gpio_request_one(&i2c->dev, pdata->gpio_reset,
+			GPIOF_OUT_INIT_LOW, "uda1380 reset");
+		if (ret)
+			return ret;
+	}
+
+	if (gpio_is_valid(pdata->gpio_power)) {
+		ret = devm_gpio_request_one(&i2c->dev, pdata->gpio_power,
+			GPIOF_OUT_INIT_LOW, "uda1380 power");
+		if (ret)
+			return ret;
+	}
+
 	i2c_set_clientdata(i2c, uda1380);
 	uda1380->control_data = i2c;
 
-- 
2.10.2
