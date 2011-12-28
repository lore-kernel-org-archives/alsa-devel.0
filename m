From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: Convert sgtl5000 to use devm_kzalloc()
Date: Wed, 28 Dec 2011 11:30:11 -0200
Message-ID: <1325079011-9128-1-git-send-email-festevam@gmail.com>
References: <1325078785-9063-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 191C5103996
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 14:30:26 +0100 (CET)
Received: by yhjj56 with SMTP id j56so7619842yhj.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 05:30:26 -0800 (PST)
In-Reply-To: <1325078785-9063-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Convert sgtl5000 codec driver to use devm_kzalloc().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fixed typo in codec name
 sound/soc/codecs/sgtl5000.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c189663..32f491d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1402,7 +1402,8 @@ static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
 	struct sgtl5000_priv *sgtl5000;
 	int ret;
 
-	sgtl5000 = kzalloc(sizeof(struct sgtl5000_priv), GFP_KERNEL);
+	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
+								GFP_KERNEL);
 	if (!sgtl5000)
 		return -ENOMEM;
 
@@ -1410,22 +1411,13 @@ static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
 
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
-	if (ret) {
-		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
-		kfree(sgtl5000);
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 static __devexit int sgtl5000_i2c_remove(struct i2c_client *client)
 {
-	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
-
 	snd_soc_unregister_codec(&client->dev);
 
-	kfree(sgtl5000);
 	return 0;
 }
 
-- 
1.7.1
