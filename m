From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: rt1305: use devm_snd_soc_register_component()
Date: Fri, 22 Jun 2018 02:23:34 +0000
Message-ID: <1529634214-105520-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Using devm_snd_soc_register_component() and drop all of the code
related to .remove hook.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/rt1305.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 421b8fb..c4452ef 100644
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
@@ -1180,7 +1174,6 @@ static void rt1305_i2c_shutdown(struct i2c_client *client)
 #endif
 	},
 	.probe = rt1305_i2c_probe,
-	.remove   = rt1305_i2c_remove,
 	.shutdown = rt1305_i2c_shutdown,
 	.id_table = rt1305_i2c_id,
 };
