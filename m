From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Convert wm8961 to devm_kzalloc()
Date: Sat, 17 Dec 2011 09:39:15 +0000
Message-ID: <1324114756-24254-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1324114756-24254-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A0C4244BB
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2011 10:39:20 +0100 (CET)
In-Reply-To: <1324114756-24254-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8961.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 13a0850..8bcc17a 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1087,7 +1087,8 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 	struct wm8961_priv *wm8961;
 	int ret;
 
-	wm8961 = kzalloc(sizeof(struct wm8961_priv), GFP_KERNEL);
+	wm8961 = devm_kzalloc(&i2c->dev, sizeof(struct wm8961_priv),
+			      GFP_KERNEL);
 	if (wm8961 == NULL)
 		return -ENOMEM;
 
@@ -1095,15 +1096,14 @@ static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8961, &wm8961_dai, 1);
-	if (ret < 0)
-		kfree(wm8961);
+
 	return ret;
 }
 
 static __devexit int wm8961_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	kfree(i2c_get_clientdata(client));
+
 	return 0;
 }
 
-- 
1.7.7.3
