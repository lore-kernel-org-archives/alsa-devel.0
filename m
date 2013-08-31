From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: Remove reg_def_copy
Date: Sat, 31 Aug 2013 20:31:13 +0200
Message-ID: <1377973875-2209-3-git-send-email-lars@metafoo.de>
References: <1377973875-2209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 402F42654B2
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 20:29:49 +0200 (CEST)
In-Reply-To: <1377973875-2209-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

reg_def_copy was introduced in commit 3335ddca ("ASoC: soc-cache: Use
reg_def_copy instead of reg_cache_default") to keep a copy of the register
defaults around in case the register defaults where placed in the __devinitdata
section. With the __devinitdata section gone we effectivly keep the same data
around twice. This patch removes reg_def_copy and uses reg_cache_default
directly instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h   |  1 -
 sound/soc/soc-cache.c | 10 ++++++----
 sound/soc/soc-core.c  | 15 ---------------
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c72b7b3..696de9a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -687,7 +687,6 @@ struct snd_soc_codec {
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	void *reg_cache;
-	const void *reg_def_copy;
 	const struct snd_soc_cache_ops *cache_ops;
 	struct mutex cache_rw_mutex;
 	int val_bytes;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index eaa898f..a7f83c0 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -78,8 +78,8 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 		ret = snd_soc_cache_read(codec, i, &val);
 		if (ret)
 			return ret;
-		if (codec->reg_def_copy)
-			if (snd_soc_get_cache_val(codec->reg_def_copy,
+		if (codec_drv->reg_cache_default)
+			if (snd_soc_get_cache_val(codec_drv->reg_cache_default,
 						  i, codec_drv->reg_word_size) == val)
 				continue;
 
@@ -121,8 +121,10 @@ static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
 
 static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 {
-	if (codec->reg_def_copy)
-		codec->reg_cache = kmemdup(codec->reg_def_copy,
+	const struct snd_soc_codec_driver *codec_drv = codec->driver;
+
+	if (codec_drv->reg_cache_default)
+		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
 					   codec->reg_size, GFP_KERNEL);
 	else
 		codec->reg_cache = kzalloc(codec->reg_size, GFP_KERNEL);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d25feed..fbfd6a7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4199,20 +4199,6 @@ int snd_soc_register_codec(struct device *dev,
 	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
 		reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 		codec->reg_size = reg_size;
-		/* it is necessary to make a copy of the default register cache
-		 * because in the case of using a compression type that requires
-		 * the default register cache to be marked as the
-		 * kernel might have freed the array by the time we initialize
-		 * the cache.
-		 */
-		if (codec_drv->reg_cache_default) {
-			codec->reg_def_copy = kmemdup(codec_drv->reg_cache_default,
-						      reg_size, GFP_KERNEL);
-			if (!codec->reg_def_copy) {
-				ret = -ENOMEM;
-				goto fail_codec_name;
-			}
-		}
 	}
 
 	for (i = 0; i < num_dai; i++) {
@@ -4271,7 +4257,6 @@ found:
 	dev_dbg(codec->dev, "ASoC: Unregistered codec '%s'\n", codec->name);
 
 	snd_soc_cache_exit(codec);
-	kfree(codec->reg_def_copy);
 	kfree(codec->name);
 	kfree(codec);
 }
-- 
1.8.0
