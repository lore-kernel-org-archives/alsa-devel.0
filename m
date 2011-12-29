From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 14/14] ASoC: Convert tpa6130a2 to devm_kzalloc()
Date: Thu, 29 Dec 2011 12:12:29 +0800
Message-ID: <1325131949.19977.20.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id B9BA12465D
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:12:35 +0100 (CET)
Received: by yhjj56 with SMTP id j56so7876164yhj.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:12:35 -0800 (PST)
In-Reply-To: <1325130983.19977.2.camel@phoenix>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tpa6130a2.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 7eeca79..363b99d 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -376,7 +376,7 @@ static int __devinit tpa6130a2_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(dev, "Can not allocate memory\n");
 		return -ENOMEM;
@@ -450,7 +450,6 @@ err_regulator:
 	if (data->power_gpio >= 0)
 		gpio_free(data->power_gpio);
 err_gpio:
-	kfree(data);
 	tpa6130a2_client = NULL;
 
 	return ret;
@@ -466,8 +465,6 @@ static int __devexit tpa6130a2_remove(struct i2c_client *client)
 		gpio_free(data->power_gpio);
 
 	regulator_put(data->supply);
-
-	kfree(data);
 	tpa6130a2_client = NULL;
 
 	return 0;
-- 
1.7.5.4
