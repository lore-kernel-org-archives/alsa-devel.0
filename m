From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm8904: Convert to
	devm_regmap_init_i2c()
Date: Sat,  9 Jun 2012 12:20:09 +0800
Message-ID: <1339215609-14435-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339215609-14435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 78666103F39
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 06:20:22 +0200 (CEST)
In-Reply-To: <1339215609-14435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm8904.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 02bc2ca..560a9a47 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2263,7 +2263,7 @@ static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
 	if (wm8904 == NULL)
 		return -ENOMEM;
 
-	wm8904->regmap = regmap_init_i2c(i2c, &wm8904_regmap);
+	wm8904->regmap = devm_regmap_init_i2c(i2c, &wm8904_regmap);
 	if (IS_ERR(wm8904->regmap)) {
 		ret = PTR_ERR(wm8904->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -2283,15 +2283,12 @@ static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
 	return 0;
 
 err:
-	regmap_exit(wm8904->regmap);
 	return ret;
 }
 
 static __devexit int wm8904_i2c_remove(struct i2c_client *client)
 {
-	struct wm8904_priv *wm8904 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(wm8904->regmap);
 	return 0;
 }
 
-- 
1.7.10
