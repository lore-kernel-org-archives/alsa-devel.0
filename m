From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/21] ASoC: Convert WM9090 to devm_kzalloc()
Date: Sat,  3 Dec 2011 21:33:17 +0000
Message-ID: <1322948009-27658-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B983A243DD
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:39 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm9090.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 4d90c54..69c89c4 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -647,7 +647,7 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 	struct wm9090_priv *wm9090;
 	int ret;
 
-	wm9090 = kzalloc(sizeof(*wm9090), GFP_KERNEL);
+	wm9090 = devm_kzalloc(&i2c->dev, sizeof(*wm9090), GFP_KERNEL);
 	if (wm9090 == NULL) {
 		dev_err(&i2c->dev, "Can not allocate memory\n");
 		return -ENOMEM;
@@ -661,8 +661,6 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm9090,  NULL, 0);
-	if (ret < 0)
-		kfree(wm9090);
 	return ret;
 }
 
@@ -671,7 +669,6 @@ static int __devexit wm9090_i2c_remove(struct i2c_client *i2c)
 	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
 
 	snd_soc_unregister_codec(&i2c->dev);
-	kfree(wm9090);
 
 	return 0;
 }
-- 
1.7.7.3
