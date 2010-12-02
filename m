From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: soc-core: Allow machine drivers to
	override compress_type
Date: Thu,  2 Dec 2010 16:11:06 +0000
Message-ID: <1291306266-4907-3-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AE29244B9
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 17:11:15 +0100 (CET)
In-Reply-To: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch allows machine drivers to override the compression type
provided by the codec driver.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   74 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4cdba68..e5b9bd7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -472,6 +472,7 @@ struct snd_soc_codec {
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
+	unsigned int cache_init:1; /* codec cache has been initialized */
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9d9364a..a9827f1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1726,9 +1726,36 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 	}
 }
 
+static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
+				    enum snd_soc_compress_type compress_type)
+{
+	int ret;
+
+	if (codec->cache_init)
+		return 0;
+
+	/* override the compress_type if necessary */
+	if (compress_type && codec->compress_type != compress_type)
+		codec->compress_type = compress_type;
+	dev_dbg(codec->dev, "Cache compress_type for %s is %d\n",
+		codec->name, codec->compress_type);
+	ret = snd_soc_cache_init(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache compression type: %d\n",
+			ret);
+		return ret;
+	}
+	codec->cache_init = 1;
+	return 0;
+}
+
+
 static void snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct platform_device *pdev = to_platform_device(card->dev);
+	struct snd_soc_codec *codec;
+	struct snd_soc_codec_conf *codec_conf;
+	enum snd_soc_compress_type compress_type;
 	int ret, i;
 
 	mutex_lock(&card->mutex);
@@ -1748,6 +1775,39 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		return;
 	}
 
+	/* initialize the register cache for each available codec */
+	list_for_each_entry(codec, &codec_list, list) {
+		if (codec->cache_init)
+			continue;
+		/* check to see if we need to override the compress_type */
+		for (i = 0; i < card->num_configs; ++i) {
+			codec_conf = &card->codec_conf[i];
+			if (!strcmp(codec->name, codec_conf->dev_name)) {
+				compress_type = codec_conf->compress_type;
+				if (compress_type && compress_type
+				    != codec->compress_type)
+					break;
+			}
+		}
+		if (i == card->num_configs) {
+			/* no need to override the compress_type so
+			 * go ahead and do the standard thing */
+			ret = snd_soc_init_codec_cache(codec, 0);
+			if (ret < 0) {
+				mutex_unlock(&card->mutex);
+				return;
+			}
+			continue;
+		}
+		/* override the compress_type with the one supplied in
+		 * the machine driver */
+		ret = snd_soc_init_codec_cache(codec, compress_type);
+		if (ret < 0) {
+			mutex_unlock(&card->mutex);
+			return;
+		}
+	}
+
 	/* card bind complete so register a sound card */
 	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			card->owner, 0, &card->snd_card);
@@ -3475,13 +3535,7 @@ int snd_soc_register_codec(struct device *dev,
 					      reg_size, GFP_KERNEL);
 		if (!codec->reg_def_copy) {
 			ret = -ENOMEM;
-			goto error_cache;
-		}
-		ret = snd_soc_cache_init(codec);
-		if (ret < 0) {
-			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
-				ret);
-			goto error_cache;
+			goto fail;
 		}
 	}
 
@@ -3494,7 +3548,7 @@ int snd_soc_register_codec(struct device *dev,
 	if (num_dai) {
 		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
 		if (ret < 0)
-			goto error_dais;
+			goto fail;
 	}
 
 	mutex_lock(&client_mutex);
@@ -3505,9 +3559,7 @@ int snd_soc_register_codec(struct device *dev,
 	pr_debug("Registered codec '%s'\n", codec->name);
 	return 0;
 
-error_dais:
-	snd_soc_cache_exit(codec);
-error_cache:
+fail:
 	kfree(codec->reg_def_copy);
 	codec->reg_def_copy = NULL;
 	kfree(codec->name);
-- 
1.7.3.2
