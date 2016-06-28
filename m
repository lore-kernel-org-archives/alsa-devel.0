From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs35l33: Remove unnecessary free_irq call
Date: Tue, 28 Jun 2016 16:40:18 +0800
Message-ID: <1467103218.25747.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
 [209.85.220.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DB222651E3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 10:41:00 +0200 (CEST)
Received: by mail-pa0-f65.google.com with SMTP id us13so1116987pab.1
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 01:41:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Current code uses devm_request_threaded_irq() so it does not need to
explicitly call free_irq() in .probe error path and .remove.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs35l33.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 55c1f75..90dc743 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -1195,7 +1195,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev,
 			"Failed to enable core supplies: %d\n",
 			ret);
-		goto err_irq;
+		return ret;
 	}
 
 	if (cs35l33->reset_gpio)
@@ -1251,7 +1251,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "%s: Register codec failed\n",
 			__func__);
-		goto err_irq;
+		goto err_enable;
 	}
 
 	return 0;
@@ -1259,8 +1259,6 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 err_enable:
 	regulator_bulk_disable(cs35l33->num_core_supplies,
 			       cs35l33->core_supplies);
-err_irq:
-	free_irq(i2c_client->irq, cs35l33);
 
 	return ret;
 }
@@ -1277,7 +1275,6 @@ static int cs35l33_i2c_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	regulator_bulk_disable(cs35l33->num_core_supplies,
 		cs35l33->core_supplies);
-	free_irq(client->irq, cs35l33);
 
 	return 0;
 }
-- 
2.5.0
