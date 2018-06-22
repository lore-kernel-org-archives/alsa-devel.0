From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: rt5682: use devm_snd_soc_register_component()
Date: Fri, 22 Jun 2018 02:23:24 +0000
Message-ID: <1529634204-105428-1-git-send-email-weiyongjun1@huawei.com>
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
 sound/soc/codecs/rt5682.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 61a9730..baad177 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2630,17 +2630,11 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 
 	}
 
-	return snd_soc_register_component(&i2c->dev, &soc_component_dev_rt5682,
+	return devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_rt5682,
 			rt5682_dai, ARRAY_SIZE(rt5682_dai));
 }
 
-static int rt5682_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_component(&i2c->dev);
-
-	return 0;
-}
-
 static void rt5682_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5682_priv *rt5682 = i2c_get_clientdata(client);
@@ -2671,7 +2665,6 @@ static void rt5682_i2c_shutdown(struct i2c_client *client)
 		.acpi_match_table = ACPI_PTR(rt5682_acpi_match),
 	},
 	.probe = rt5682_i2c_probe,
-	.remove = rt5682_i2c_remove,
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
