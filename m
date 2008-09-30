From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Fix cs4270 error path
Date: Tue, 30 Sep 2008 11:40:37 +0200
Message-ID: <20080930114037.670c2f8e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E62B82442C
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 11:40:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

The error path in cs4270_probe/cs4270_remove is pretty broken:
* If cs4270_probe fails, codec is leaked.
* If snd_soc_register_card fails, cs4270_i2c_driver stays registered.
* If I2C support is enabled but no I2C device is found, i2c_del_driver
  is never called (neither in cs4270_probe nor in cs4270_remove.

Fix all 3 problems by implementing a clean error path in cs4270_probe
and jumping to its labels as needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- linux-2.6.27-rc8.orig/sound/soc/codecs/cs4270.c	2008-09-30 11:11:22.000000000 +0200
+++ linux-2.6.27-rc8/sound/soc/codecs/cs4270.c	2008-09-30 11:33:03.000000000 +0200
@@ -681,7 +681,7 @@ static int cs4270_probe(struct platform_
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: failed to create PCMs\n");
-		return ret;
+		goto error_free_codec;
 	}
 
 #ifdef USE_I2C
@@ -690,8 +690,7 @@ static int cs4270_probe(struct platform_
 	ret = i2c_add_driver(&cs4270_i2c_driver);
 	if (ret) {
 		printk(KERN_ERR "cs4270: failed to attach driver");
-		snd_soc_free_pcms(socdev);
-		return ret;
+		goto error_free_pcms;
 	}
 
 	/* Did we find a CS4270 on the I2C bus? */
@@ -713,10 +712,23 @@ static int cs4270_probe(struct platform_
 	ret = snd_soc_register_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: failed to register card\n");
-		snd_soc_free_pcms(socdev);
-		return ret;
+		goto error_del_driver;
 	}
 
+	return 0;
+
+error_del_driver:
+#ifdef USE_I2C
+	i2c_del_driver(&cs4270_i2c_driver);
+
+error_free_pcms:
+#endif
+	snd_soc_free_pcms(socdev);
+
+error_free_codec:
+	kfree(socdev->codec);
+	socdev->codec = NULL;
+
 	return ret;
 }
 
@@ -727,8 +739,7 @@ static int cs4270_remove(struct platform
 	snd_soc_free_pcms(socdev);
 
 #ifdef USE_I2C
-	if (socdev->codec->control_data)
-		i2c_del_driver(&cs4270_i2c_driver);
+	i2c_del_driver(&cs4270_i2c_driver);
 #endif
 
 	kfree(socdev->codec);


-- 
Jean Delvare
