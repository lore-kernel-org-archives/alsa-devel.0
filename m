From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: wm8991: Convert to devm_kzalloc()
Date: Wed, 12 Sep 2012 09:33:00 +0800
Message-ID: <1347413580-11137-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD32E2615F0
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
 sound/soc/codecs/wm8991.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index b9dbfeb..fe439f0 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1363,7 +1363,7 @@ static __devinit int wm8991_i2c_probe(struct i2c_client *i2c,
 	struct wm8991_priv *wm8991;
 	int ret;
 
-	wm8991 = kzalloc(sizeof *wm8991, GFP_KERNEL);
+	wm8991 = devm_kzalloc(&i2c->dev, sizeof(*wm8991), GFP_KERNEL);
 	if (!wm8991)
 		return -ENOMEM;
 
@@ -1372,15 +1372,14 @@ static __devinit int wm8991_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8991, &wm8991_dai, 1);
-	if (ret < 0)
-		kfree(wm8991);
+
 	return ret;
 }
 
 static __devexit int wm8991_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+
 	return 0;
 }
 
-- 
1.7.10.4
