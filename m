From: Timur Tabi <timur@freescale.com>
Subject: [PATCH][ASoC v2] Replace snd_soc_free_codec with
	snd_soc_unregister_codec
Date: Thu, 24 Apr 2008 11:20:01 -0500
Message-ID: <1209054001-1155-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 5774D24593
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 18:20:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lg@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

The functions snd_soc_register_codec() and snd_soc_free_codec() are companion
functions, but snd_soc_free_codec() releases resources (via kfree) that were
not allocated by snd_soc_register_codec().  This means that the caller of
snd_soc_register_codec() has to use a specific method to allocate these
resources.

So we replace snd_soc_free_codec() with snd_soc_unregister_codec().  This new
function only unregisters the codec but does not free the memory resources.
The caller can now allocate and free the memory resources as it sees fit.

Also updated all callers of snd_soc_free_codec() to call
snd_soc_unregister_codec() instead and free the resources themselves.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 include/sound/soc-codec.h |    2 +-
 sound/soc/codecs/wm8350.c |    8 ++++++--
 sound/soc/codecs/wm8731.c |    8 ++++++--
 sound/soc/codecs/wm8750.c |    8 ++++++--
 sound/soc/codecs/wm8753.c |    8 ++++++--
 sound/soc/codecs/wm9712.c |    8 ++++++--
 sound/soc/codecs/wm9713.c |    8 ++++++--
 sound/soc/soc-core.c      |   11 ++++-------
 8 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc-codec.h b/include/sound/soc-codec.h
index 3cf4819..6f132ba 100644
--- a/include/sound/soc-codec.h
+++ b/include/sound/soc-codec.h
@@ -160,7 +160,7 @@ struct snd_soc_codec *snd_soc_new_codec(
 
 int snd_soc_register_codec(struct snd_soc_codec *codec, struct device *dev);
 
-void snd_soc_free_codec(struct snd_soc_codec *codec);
+void snd_soc_deregister_codec(struct snd_soc_codec *codec);
 
 int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, struct snd_card *card,
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 3195d13..4ea8ced 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1436,7 +1436,9 @@ static int wm8350_codec_probe(struct platform_device *pdev)
 codec_err:
 	kfree(wm8350);
 prv_err:
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return ret;
 }
 
@@ -1446,7 +1448,9 @@ static int wm8350_codec_remove(struct platform_device *pdev)
 	struct wm8350_data *wm8350 = codec->private_data;
 	
 	snd_soc_unregister_codec_dai(wm8350->dai);
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	kfree(wm8350);
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 0fe8766..2195c77 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -595,7 +595,9 @@ static int wm8731_codec_probe(struct platform_device *pdev)
 codec_err:
 	kfree(wm8731);
 wm8731_err:
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return ret;
 }
 
@@ -606,7 +608,9 @@ static int wm8731_codec_remove(struct platform_device *pdev)
 	
 	snd_soc_unregister_codec_dai(wm8731->dai);
 	kfree(wm8731);
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 1b0296f..23e9126 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -898,7 +898,9 @@ static int wm8750_codec_probe(struct platform_device *pdev)
 codec_err:
 	kfree(wm8750);
 wm8750_err:
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return ret;
 }
 
@@ -909,7 +911,9 @@ static int wm8750_codec_remove(struct platform_device *pdev)
 	
 	snd_soc_unregister_codec_dai(wm8750->dai);
 	kfree(wm8750);
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return 0;
 }
 static struct platform_driver wm8750_codec_driver = {
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 0d795f4..1cb2d64 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1584,7 +1584,9 @@ voice_err:
 codec_err:
 	kfree(codec->private_data);
 err:
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return ret;
 }
 
@@ -1603,7 +1605,9 @@ static int wm8753_codec_remove(struct platform_device *pdev)
 
 	/* free codec */
 	kfree(codec->private_data);
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 16b6a18..7014190 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -715,7 +715,9 @@ aux_dai_err:
 codec_err:
 	kfree(wm9712);
 priv_err:
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return ret;
 }
 
@@ -728,7 +730,9 @@ static int wm9712_codec_remove(struct platform_device *pdev)
 	snd_soc_unregister_codec_dai(wm9712->aux_dai);
 
 	kfree(codec->private_data);
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 5e99bbe..d9ded51 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1154,7 +1154,9 @@ aux_dai_err:
 codec_err:
 	kfree(wm9713);
 priv_err:
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return ret;
 }
 
@@ -1168,7 +1170,9 @@ static int wm9713_codec_remove(struct platform_device *pdev)
 	snd_soc_unregister_codec_dai(wm9713->voice_dai);
 	
 	kfree(codec->private_data);
-	snd_soc_free_codec(codec);
+	snd_soc_unregister_codec(codec);
+	kfree(codec->reg_cache);
+	kfree(codec);
 	return 0;
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 939b543..7dc6d68 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1856,21 +1856,18 @@ int snd_soc_register_codec(struct snd_soc_codec *codec, struct device *dev)
 EXPORT_SYMBOL_GPL(snd_soc_register_codec);
 
 /**
- * snd_soc_free_codec - unregister and free codec.
+ * snd_soc_unregister_codec - unregister a codec.
  * @codec: codec driver
  *
- * Unregisters a codec driver with the core and frees all its resources.
+ * Unregisters a codec driver with the core.
  */
-void snd_soc_free_codec(struct snd_soc_codec *codec)
+void snd_soc_unregister_codec(struct snd_soc_codec *codec)
 {
 	mutex_lock(&client_mutex);
 	list_del(&codec->list);
 	mutex_unlock(&client_mutex);
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
-	kfree(codec);
 }
-EXPORT_SYMBOL_GPL(snd_soc_free_codec);
+EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
 
 /**
  * snd_soc_register_platform_dai - registers a  platform DAI.
-- 
1.5.5.1
