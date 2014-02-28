From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: cache: Do the codec->reg_cache zero pionter check
Date: Fri, 28 Feb 2014 10:48:19 +0800
Message-ID: <1393555699-12752-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.de, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For the snd_soc_cache_init(), the reg_size maybe zero and then the value
of codec->reg_cache, which is alloced via kzalloc, maybe equal to
ZERO_SIZE_PTR. If the reg parameter of snd_soc_cache_write() is large enough,
the cache[idx] = val maybe cause the kernel crash...

So this patch fix this via doing the zero pionter check of it.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-cache.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 375dc6d..bfed3e4 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -96,8 +96,7 @@ int snd_soc_cache_exit(struct snd_soc_codec *codec)
 {
 	dev_dbg(codec->dev, "ASoC: Destroying cache for %s codec\n",
 			codec->name);
-	if (!codec->reg_cache)
-		return 0;
+
 	kfree(codec->reg_cache);
 	codec->reg_cache = NULL;
 	return 0;
@@ -117,8 +116,9 @@ int snd_soc_cache_read(struct snd_soc_codec *codec,
 		return -EINVAL;
 
 	mutex_lock(&codec->cache_rw_mutex);
-	*value = snd_soc_get_cache_val(codec->reg_cache, reg,
-				       codec->driver->reg_word_size);
+	if (!ZERO_OR_NULL_PTR(codec->reg_cache))
+		*value = snd_soc_get_cache_val(codec->reg_cache, reg,
+					       codec->driver->reg_word_size);
 	mutex_unlock(&codec->cache_rw_mutex);
 
 	return 0;
@@ -136,8 +136,9 @@ int snd_soc_cache_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value)
 {
 	mutex_lock(&codec->cache_rw_mutex);
-	snd_soc_set_cache_val(codec->reg_cache, reg, value,
-			      codec->driver->reg_word_size);
+	if (!ZERO_OR_NULL_PTR(codec->reg_cache))
+		snd_soc_set_cache_val(codec->reg_cache, reg, value,
+				      codec->driver->reg_word_size);
 	mutex_unlock(&codec->cache_rw_mutex);
 
 	return 0;
-- 
1.8.4
