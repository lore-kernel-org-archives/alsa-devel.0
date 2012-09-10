From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: wm8523: Convert to devm_kzalloc()
Date: Mon, 10 Sep 2012 17:07:59 +0800
Message-ID: <1347268082-14993-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6437026501D
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 11:27:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8523.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 1c3ffb2..af2289e 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -516,7 +516,8 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 	struct wm8523_priv *wm8523;
 	int ret;
 
-	wm8523 = kzalloc(sizeof(struct wm8523_priv), GFP_KERNEL);
+	wm8523 = devm_kzalloc(&i2c->dev, sizeof(struct wm8523_priv),
+			      GFP_KERNEL);
 	if (wm8523 == NULL)
 		return -ENOMEM;
 
@@ -525,8 +526,7 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8523, &wm8523_dai, 1);
-	if (ret < 0)
-		kfree(wm8523);
+
 	return ret;
 
 }
@@ -534,7 +534,6 @@ static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
 static __devexit int wm8523_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.10.4
