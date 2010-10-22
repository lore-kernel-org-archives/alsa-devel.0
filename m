From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: soc-core: Adapt soc-core to fit the
	new caching API
Date: Fri, 22 Oct 2010 15:28:21 +0100
Message-ID: <1287757702-9573-4-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAEB9103863
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 16:28:28 +0200 (CEST)
In-Reply-To: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 70d9a73..c77f2b5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3213,23 +3213,6 @@ int snd_soc_register_codec(struct device *dev,
 		return -ENOMEM;
 	}
 
-	/* allocate CODEC register cache */
-	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
-
-		if (codec_drv->reg_cache_default)
-			codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
-				codec_drv->reg_cache_size * codec_drv->reg_word_size, GFP_KERNEL);
-		else
-			codec->reg_cache = kzalloc(codec_drv->reg_cache_size *
-				codec_drv->reg_word_size, GFP_KERNEL);
-
-		if (codec->reg_cache == NULL) {
-			kfree(codec->name);
-			kfree(codec);
-			return -ENOMEM;
-		}
-	}
-
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->bias_level = SND_SOC_BIAS_OFF;
@@ -3238,6 +3221,16 @@ int snd_soc_register_codec(struct device *dev,
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
+	/* allocate CODEC register cache */
+	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
+		ret = snd_soc_cache_init(codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to set cache compression type: %d\n",
+				ret);
+			goto error_cache;
+		}
+	}
+
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
@@ -3247,7 +3240,7 @@ int snd_soc_register_codec(struct device *dev,
 	if (num_dai) {
 		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
 		if (ret < 0)
-			goto error;
+			goto error_dais;
 	}
 
 	mutex_lock(&client_mutex);
@@ -3258,12 +3251,12 @@ int snd_soc_register_codec(struct device *dev,
 	pr_debug("Registered codec '%s'\n", codec->name);
 	return 0;
 
-error:
+error_dais:
 	for (i--; i >= 0; i--)
 		snd_soc_unregister_dai(dev);
 
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
+	snd_soc_cache_deinit(codec);
+error_cache:
 	kfree(codec->name);
 	kfree(codec);
 	return ret;
@@ -3297,8 +3290,7 @@ found:
 
 	pr_debug("Unregistered codec '%s'\n", codec->name);
 
-	if (codec->reg_cache)
-		kfree(codec->reg_cache);
+	snd_soc_cache_deinit(codec);
 	kfree(codec->name);
 	kfree(codec);
 }
-- 
1.7.3.1
