From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC:isabelle:Remove regmap_exit()
Date: Mon, 4 Jun 2012 17:44:54 +0530
Message-ID: <1338812094-10426-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E82524942
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 14:09:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
Cc: vishwas.a.deshpande@ti.com, M@alsa-project.org, MR Swami Reddy <MR.Swami.Reddy@ti.com>, Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

From: MR Swami Reddy <MR.Swami.Reddy@ti.com>

ASoC:isabelle:With devm_ APIs regmap_exit() not needed, so remove regmap_exit().

Signed-off-by: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
Signed-off-by: M R Swami Reddy <mr.swami.reddy@ti.com>
---
 sound/soc/codecs/isabelle.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 69228ec..bcc77ef 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1141,7 +1141,6 @@ static int __devinit isabelle_i2c_probe(struct i2c_client *i2c,
 				ARRAY_SIZE(isabelle_dai));
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
-		regmap_exit(dev_get_regmap(&i2c->dev, NULL));
 		return ret;
 	}
 
@@ -1151,7 +1150,6 @@ static int __devinit isabelle_i2c_probe(struct i2c_client *i2c,
 static int __devexit isabelle_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
-	regmap_exit(dev_get_regmap(&client->dev, NULL));
 	return 0;
 }
 
