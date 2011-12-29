From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: Convert wm8978 to devm_kzalloc()
Date: Thu, 29 Dec 2011 11:49:12 +0000
Message-ID: <1325159355-31686-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D3FA24705
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 12:49:25 +0100 (CET)
In-Reply-To: <1325159355-31686-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 36468f8..051f5d0 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -997,7 +997,8 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 	struct wm8978_priv *wm8978;
 	int ret;
 
-	wm8978 = kzalloc(sizeof(struct wm8978_priv), GFP_KERNEL);
+	wm8978 = devm_kzalloc(&i2c->dev, sizeof(struct wm8978_priv),
+			      GFP_KERNEL);
 	if (wm8978 == NULL)
 		return -ENOMEM;
 
@@ -1005,15 +1006,14 @@ static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8978, &wm8978_dai, 1);
-	if (ret < 0)
-		kfree(wm8978);
+
 	return ret;
 }
 
 static __devexit int wm8978_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+
 	return 0;
 }
 
-- 
1.7.7.3
