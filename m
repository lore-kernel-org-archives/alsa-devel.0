From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: wm8990: Convert to devm_kzalloc()
Date: Wed, 12 Sep 2012 09:32:59 +0800
Message-ID: <1347413580-11137-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 487452615E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 03:33:37 +0200 (CEST)
In-Reply-To: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8990.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index db63c97..c28c83e 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1388,7 +1388,8 @@ static __devinit int wm8990_i2c_probe(struct i2c_client *i2c,
 	struct wm8990_priv *wm8990;
 	int ret;
 
-	wm8990 = kzalloc(sizeof(struct wm8990_priv), GFP_KERNEL);
+	wm8990 = devm_kzalloc(&i2c->dev, sizeof(struct wm8990_priv),
+			      GFP_KERNEL);
 	if (wm8990 == NULL)
 		return -ENOMEM;
 
@@ -1396,15 +1397,14 @@ static __devinit int wm8990_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8990, &wm8990_dai, 1);
-	if (ret < 0)
-		kfree(wm8990);
+
 	return ret;
 }
 
 static __devexit int wm8990_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+
 	return 0;
 }
 
-- 
1.7.10.4
