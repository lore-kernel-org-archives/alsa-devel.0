From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix type for snd_soc_volatile_register()
Date: Mon, 24 Jan 2011 12:39:32 +0000
Message-ID: <1295872772-6308-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2477B24480
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 13:40:24 +0100 (CET)
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

We generally refer to registers as unsigned ints (including in the
underlying CODEC driver operation).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    3 ++-
 sound/soc/soc-core.c |   22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index c184f84..1355ef0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -267,7 +267,8 @@ int snd_soc_register_codec(struct device *dev,
 		const struct snd_soc_codec_driver *codec_drv,
 		struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_codec(struct device *dev);
-int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
+int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
+				    unsigned int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b0e7689..ba81892 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2029,7 +2029,8 @@ static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
  *
  * Boolean function indiciating if a CODEC register is volatile.
  */
-int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg)
+int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
+				    unsigned int reg)
 {
 	if (codec->volatile_register)
 		return codec->volatile_register(codec, reg);
@@ -2039,6 +2040,25 @@ int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg)
 EXPORT_SYMBOL_GPL(snd_soc_codec_volatile_register);
 
 /**
+ * snd_soc_codec_register_name: Return a plain text register name
+ *
+ * @codec: CODEC to query.
+ * @reg: Register to query for.
+ *
+ * Returns a string with a plain text name for the register, or NULL
+ * if none is available.
+ */
+const char *snd_soc_codec_register_name(struct snd_soc_codec *codec,
+					unsigned int reg)
+{
+	if (codec->volatile_register)
+		return codec->register_name(codec, reg);
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_codec_register_name);
+
+/**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
  * @ops: AC97 bus operations
-- 
1.7.2.3
