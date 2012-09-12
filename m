From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: wm8580: Convert to devm_kzalloc()
Date: Wed, 12 Sep 2012 09:32:55 +0800
Message-ID: <1347413580-11137-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 45FCB2615E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 03:33:36 +0200 (CEST)
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
 sound/soc/codecs/wm8580.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 7c68226..cc198df 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -899,7 +899,8 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 	struct wm8580_priv *wm8580;
 	int ret;
 
-	wm8580 = kzalloc(sizeof(struct wm8580_priv), GFP_KERNEL);
+	wm8580 = devm_kzalloc(&i2c->dev, sizeof(struct wm8580_priv),
+			      GFP_KERNEL);
 	if (wm8580 == NULL)
 		return -ENOMEM;
 
@@ -908,15 +909,13 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
-	if (ret < 0)
-		kfree(wm8580);
+
 	return ret;
 }
 
 static int wm8580_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.10.4
