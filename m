From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Constify struct snd_soc_codec_driver
Date: Fri,  3 Dec 2010 15:26:09 +0000
Message-ID: <1291389969-8392-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A28E244B9
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 16:26:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow the CODEC driver structure to be marked const by making all
the APIs that use it do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    4 ++--
 sound/soc/soc-cache.c |   13 +++++++------
 sound/soc/soc-core.c  |    5 +++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7d53cc4..0eea08e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -265,7 +265,7 @@ int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
 int snd_soc_register_codec(struct device *dev,
-		struct snd_soc_codec_driver *codec_drv,
+		const struct snd_soc_codec_driver *codec_drv,
 		struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_codec(struct device *dev);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
@@ -453,7 +453,7 @@ struct snd_soc_codec {
 	const char *name_prefix;
 	int id;
 	struct device *dev;
-	struct snd_soc_codec_driver *driver;
+	const struct snd_soc_codec_driver *driver;
 
 	struct mutex mutex;
 	struct snd_soc_card *card;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 6c6ced7..c0497e1 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1078,7 +1078,7 @@ static int snd_soc_lzo_decompress_cache_block(struct snd_soc_codec *codec,
 static inline int snd_soc_lzo_get_blkindex(struct snd_soc_codec *codec,
 		unsigned int reg)
 {
-	struct snd_soc_codec_driver *codec_drv;
+	const struct snd_soc_codec_driver *codec_drv;
 	size_t reg_size;
 
 	codec_drv = codec->driver;
@@ -1090,7 +1090,7 @@ static inline int snd_soc_lzo_get_blkindex(struct snd_soc_codec *codec,
 static inline int snd_soc_lzo_get_blkpos(struct snd_soc_codec *codec,
 		unsigned int reg)
 {
-	struct snd_soc_codec_driver *codec_drv;
+	const struct snd_soc_codec_driver *codec_drv;
 	size_t reg_size;
 
 	codec_drv = codec->driver;
@@ -1101,7 +1101,7 @@ static inline int snd_soc_lzo_get_blkpos(struct snd_soc_codec *codec,
 
 static inline int snd_soc_lzo_get_blksize(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec_driver *codec_drv;
+	const struct snd_soc_codec_driver *codec_drv;
 	size_t reg_size;
 
 	codec_drv = codec->driver;
@@ -1301,10 +1301,11 @@ static int snd_soc_lzo_cache_init(struct snd_soc_codec *codec)
 {
 	struct snd_soc_lzo_ctx **lzo_blocks;
 	size_t reg_size, bmp_size;
-	struct snd_soc_codec_driver *codec_drv;
+	const struct snd_soc_codec_driver *codec_drv;
 	int ret, tofree, i, blksize, blkcount;
 	const char *p, *end;
 	unsigned long *sync_bmp;
+	const char *reg_default;
 
 	ret = 0;
 	codec_drv = codec->driver;
@@ -1404,7 +1405,7 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 {
 	int i;
 	int ret;
-	struct snd_soc_codec_driver *codec_drv;
+	const struct snd_soc_codec_driver *codec_drv;
 	unsigned int val;
 
 	codec_drv = codec->driver;
@@ -1504,7 +1505,7 @@ static int snd_soc_flat_cache_exit(struct snd_soc_codec *codec)
 
 static int snd_soc_flat_cache_init(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec_driver *codec_drv;
+	const struct snd_soc_codec_driver *codec_drv;
 	size_t reg_size;
 
 	codec_drv = codec->driver;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 41fe13d..35cdb8f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3487,8 +3487,9 @@ static void fixup_codec_formats(struct snd_soc_pcm_stream *stream)
  * @codec: codec to register
  */
 int snd_soc_register_codec(struct device *dev,
-		struct snd_soc_codec_driver *codec_drv,
-		struct snd_soc_dai_driver *dai_drv, int num_dai)
+			   const struct snd_soc_codec_driver *codec_drv,
+			   struct snd_soc_dai_driver *dai_drv,
+			   int num_dai)
 {
 	size_t reg_size;
 	struct snd_soc_codec *codec;
-- 
1.7.1
