From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1305: use devm_snd_soc_register_component()" to the asoc tree
Date: Fri, 22 Jun 2018 15:50:34 +0100
Message-ID: <E1fWNOU-0002gy-Cc@debutante>
References: <1529634214-105520-1-git-send-email-weiyongjun1@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529634214-105520-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1305: use devm_snd_soc_register_component()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2854a214f398f2c3315204a05efff11739fec062 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 22 Jun 2018 02:23:34 +0000
Subject: [PATCH] ASoC: rt1305: use devm_snd_soc_register_component()

Using devm_snd_soc_register_component() and drop all of the code
related to .remove hook.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1305.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 421b8fb2fa04..c4452efc7970 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -1150,17 +1150,11 @@ static int rt1305_i2c_probe(struct i2c_client *i2c,
 	rt1305_reset(rt1305->regmap);
 	rt1305_calibrate(rt1305);
 
-	return snd_soc_register_component(&i2c->dev, &soc_component_dev_rt1305,
+	return devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_rt1305,
 			rt1305_dai, ARRAY_SIZE(rt1305_dai));
 }
 
-static int rt1305_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_component(&i2c->dev);
-
-	return 0;
-}
-
 static void rt1305_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt1305_priv *rt1305 = i2c_get_clientdata(client);
@@ -1180,7 +1174,6 @@ static struct i2c_driver rt1305_i2c_driver = {
 #endif
 	},
 	.probe = rt1305_i2c_probe,
-	.remove   = rt1305_i2c_remove,
 	.shutdown = rt1305_i2c_shutdown,
 	.id_table = rt1305_i2c_id,
 };
-- 
2.18.0.rc2
