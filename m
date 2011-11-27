From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Convert wm9081 driver to use
	devm_kzalloc()
Date: Sun, 27 Nov 2011 16:03:11 +0000
Message-ID: <1322409792-5132-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322409792-5132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 101212446B
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 17:03:17 +0100 (CET)
In-Reply-To: <1322409792-5132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index ba12690..8a4b970 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1361,7 +1361,8 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 	unsigned int reg;
 	int ret;
 
-	wm9081 = kzalloc(sizeof(struct wm9081_priv), GFP_KERNEL);
+	wm9081 = devm_kzalloc(&i2c->dev, sizeof(struct wm9081_priv),
+			      GFP_KERNEL);
 	if (wm9081 == NULL)
 		return -ENOMEM;
 
@@ -1405,7 +1406,6 @@ static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 err_regmap:
 	regmap_exit(wm9081->regmap);
 err:
-	kfree(wm9081);
 
 	return ret;
 }
@@ -1416,7 +1416,6 @@ static __devexit int wm9081_i2c_remove(struct i2c_client *client)
 
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(wm9081->regmap);
-	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-- 
1.7.7.3
