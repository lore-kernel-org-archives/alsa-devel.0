From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: Convert CS42L73 to devm_kzalloc()
Date: Mon, 28 Nov 2011 15:49:31 -0600
Message-ID: <1322516971-16817-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D31E244B7
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:51:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index d09578f..9fd5de7 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1339,7 +1339,8 @@ static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int devid = 0;
 	unsigned int reg;
 
-	cs42l73 = kzalloc((sizeof *cs42l73), GFP_KERNEL);
+	cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l73_private),
+			       GFP_KERNEL);
 	if (!cs42l73) {
 		dev_err(&i2c_client->dev, "could not allocate codec\n");
 		return -ENOMEM;
@@ -1394,8 +1395,6 @@ err_regmap:
 	regmap_exit(cs42l73->regmap);
 
 err:
-	kfree(cs42l73);
-
 	return ret;
 }
 
@@ -1406,7 +1405,6 @@ static __devexit int cs42l73_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 	regmap_exit(cs42l73->regmap);
 
-	kfree(cs42l73);
 	return 0;
 }
 
-- 
1.7.7.3
