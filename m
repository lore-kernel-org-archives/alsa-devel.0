From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/13] ASoC: Remove IO register modifier
	callbacks
Date: Tue, 18 Mar 2014 09:02:09 +0100
Message-ID: <1395129736-11938-7-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BAE5261B11
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:47 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There are no ASoC drivers left that use them and new drivers are supposed to use
regmap for this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h   | 14 ---------
 sound/soc/soc-cache.c |  2 --
 sound/soc/soc-core.c  | 80 ++++++---------------------------------------------
 3 files changed, 8 insertions(+), 88 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0233cd3..f6d7ef4f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -393,12 +393,6 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
-int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
-				    unsigned int reg);
-int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
-				    unsigned int reg);
-int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
-				    unsigned int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       struct regmap *regmap);
 int snd_soc_cache_sync(struct snd_soc_codec *codec);
@@ -692,9 +686,6 @@ struct snd_soc_codec {
 	struct list_head list;
 	struct list_head card_list;
 	int num_dai;
-	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
-	int (*readable_register)(struct snd_soc_codec *, unsigned int);
-	int (*writable_register)(struct snd_soc_codec *, unsigned int);
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
@@ -756,11 +747,6 @@ struct snd_soc_codec_driver {
 	/* codec IO */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
-	int (*display_register)(struct snd_soc_codec *, char *,
-				size_t, unsigned int);
-	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
-	int (*readable_register)(struct snd_soc_codec *, unsigned int);
-	int (*writable_register)(struct snd_soc_codec *, unsigned int);
 	unsigned int reg_cache_size;
 	short reg_cache_step;
 	short reg_word_size;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index bfed3e4..3fa77d5 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -162,8 +162,6 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 						  i, codec_drv->reg_word_size) == val)
 				continue;
 
-		WARN_ON(!snd_soc_codec_writable_register(codec, i));
-
 		ret = snd_soc_write(codec, i, val);
 		if (ret)
 			return ret;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b66ccce..4df9859 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -154,22 +154,15 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
 		step = codec->driver->reg_cache_step;
 
 	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
-		if (!snd_soc_codec_readable_register(codec, i))
-			continue;
-		if (codec->driver->display_register) {
-			count += codec->driver->display_register(codec, buf + count,
-							 PAGE_SIZE - count, i);
-		} else {
-			/* only support larger than PAGE_SIZE bytes debugfs
-			 * entries for the default case */
-			if (p >= pos) {
-				if (total + len >= count - 1)
-					break;
-				format_register_str(codec, i, buf + total, len);
-				total += len;
-			}
-			p += len;
+		/* only support larger than PAGE_SIZE bytes debugfs
+		 * entries for the default case */
+		if (p >= pos) {
+			if (total + len >= count - 1)
+				break;
+			format_register_str(codec, i, buf + total, len);
+			total += len;
 		}
+		p += len;
 	}
 
 	total = min(total, count - 1);
@@ -1986,60 +1979,6 @@ static struct platform_driver soc_driver = {
 };
 
 /**
- * snd_soc_codec_volatile_register: Report if a register is volatile.
- *
- * @codec: CODEC to query.
- * @reg: Register to query.
- *
- * Boolean function indiciating if a CODEC register is volatile.
- */
-int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
-				    unsigned int reg)
-{
-	if (codec->volatile_register)
-		return codec->volatile_register(codec, reg);
-	else
-		return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_codec_volatile_register);
-
-/**
- * snd_soc_codec_readable_register: Report if a register is readable.
- *
- * @codec: CODEC to query.
- * @reg: Register to query.
- *
- * Boolean function indicating if a CODEC register is readable.
- */
-int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
-				    unsigned int reg)
-{
-	if (codec->readable_register)
-		return codec->readable_register(codec, reg);
-	else
-		return 1;
-}
-EXPORT_SYMBOL_GPL(snd_soc_codec_readable_register);
-
-/**
- * snd_soc_codec_writable_register: Report if a register is writable.
- *
- * @codec: CODEC to query.
- * @reg: Register to query.
- *
- * Boolean function indicating if a CODEC register is writable.
- */
-int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
-				    unsigned int reg)
-{
-	if (codec->writable_register)
-		return codec->writable_register(codec, reg);
-	else
-		return 1;
-}
-EXPORT_SYMBOL_GPL(snd_soc_codec_writable_register);
-
-/**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
  * @ops: AC97 bus operations
@@ -4142,9 +4081,6 @@ int snd_soc_register_codec(struct device *dev,
 
 	codec->write = codec_drv->write;
 	codec->read = codec_drv->read;
-	codec->volatile_register = codec_drv->volatile_register;
-	codec->readable_register = codec_drv->readable_register;
-	codec->writable_register = codec_drv->writable_register;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
-- 
1.8.0
