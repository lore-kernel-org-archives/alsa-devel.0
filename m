From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: wm8903: Convert to
	devm_regmap_init_i2c()
Date: Sat,  9 Jun 2012 11:09:56 +0800
Message-ID: <1339211396-31711-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72A4917C9F9
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 05:10:18 +0200 (CEST)
In-Reply-To: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 9410d54..676432d 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2236,7 +2236,7 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	wm8903->dev = &i2c->dev;
 
-	wm8903->regmap = regmap_init_i2c(i2c, &wm8903_regmap);
+	wm8903->regmap = devm_regmap_init_i2c(i2c, &wm8903_regmap);
 	if (IS_ERR(wm8903->regmap)) {
 		ret = PTR_ERR(wm8903->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
@@ -2403,7 +2403,6 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	return 0;
 err:
-	regmap_exit(wm8903->regmap);
 	return ret;
 }
 
@@ -2414,7 +2413,6 @@ static __devexit int wm8903_i2c_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, wm8903);
 	wm8903_free_gpio(wm8903);
-	regmap_exit(wm8903->regmap);
 	snd_soc_unregister_codec(&client->dev);
 
 	return 0;
-- 
1.7.10
