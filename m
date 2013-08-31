From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: Remove 'reg_size' field from
	snd_soc_codec struct
Date: Sat, 31 Aug 2013 20:31:14 +0200
Message-ID: <1377973875-2209-4-git-send-email-lars@metafoo.de>
References: <1377973875-2209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 813C62655A5
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 20:29:50 +0200 (CEST)
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

The reg_size field is calculated in snd_soc_register_codec() and then used
exactly once in snd_soc_flat_cache_init(). Since it is calculated based on other
fields from the codec struct just move the calculation to
snd_soc_flat_cache_init() and remove the 'reg_size' field from the codec struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h   | 1 -
 sound/soc/soc-cache.c | 7 +++++--
 sound/soc/soc-core.c  | 7 -------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 696de9a..cd26858 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -662,7 +662,6 @@ struct snd_soc_codec {
 	struct list_head card_list;
 	int num_dai;
 	enum snd_soc_compress_type compress_type;
-	size_t reg_size;	/* reg_cache_size * reg_word_size */
 	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
 	int (*readable_register)(struct snd_soc_codec *, unsigned int);
 	int (*writable_register)(struct snd_soc_codec *, unsigned int);
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index a7f83c0..9542c83 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -122,12 +122,15 @@ static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
 static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 {
 	const struct snd_soc_codec_driver *codec_drv = codec->driver;
+	size_t reg_size;
+
+	reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
 
 	if (codec_drv->reg_cache_default)
 		codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
-					   codec->reg_size, GFP_KERNEL);
+					   reg_size, GFP_KERNEL);
 	else
-		codec->reg_cache = kzalloc(codec->reg_size, GFP_KERNEL);
+		codec->reg_cache = kzalloc(reg_size, GFP_KERNEL);
 	if (!codec->reg_cache)
 		return -ENOMEM;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fbfd6a7..14cc60c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4157,7 +4157,6 @@ int snd_soc_register_codec(struct device *dev,
 			   struct snd_soc_dai_driver *dai_drv,
 			   int num_dai)
 {
-	size_t reg_size;
 	struct snd_soc_codec *codec;
 	int ret, i;
 
@@ -4195,12 +4194,6 @@ int snd_soc_register_codec(struct device *dev,
 	codec->num_dai = num_dai;
 	mutex_init(&codec->mutex);
 
-	/* allocate CODEC register cache */
-	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
-		reg_size = codec_drv->reg_cache_size * codec_drv->reg_word_size;
-		codec->reg_size = reg_size;
-	}
-
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
-- 
1.8.0
