From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Add default
	snd_soc_default_writable_register() callback
Date: Thu, 24 Mar 2011 13:45:17 +0000
Message-ID: <1300974319-14423-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1033D103816
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 14:45:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

By using struct snd_soc_reg_access for the read/write/vol attributes
of the registers, we provide callbacks that automatically determine whether
a given register is readable/writable or volatile.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    4 ++++
 sound/soc/soc-cache.c |   14 ++++++++++++++
 sound/soc/soc-core.c  |    3 +++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bfa4836..982e63e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -292,6 +292,8 @@ int snd_soc_default_volatile_register(struct snd_soc_codec *codec,
 				      unsigned int reg);
 int snd_soc_default_readable_register(struct snd_soc_codec *codec,
 				      unsigned int reg);
+int snd_soc_default_writable_register(struct snd_soc_codec *codec,
+				      unsigned int reg);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
@@ -523,6 +525,7 @@ struct snd_soc_codec {
 	size_t reg_size;	/* reg_cache_size * reg_word_size */
 	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
 	int (*readable_register)(struct snd_soc_codec *, unsigned int);
+	int (*writable_register)(struct snd_soc_codec *, unsigned int);
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
@@ -587,6 +590,7 @@ struct snd_soc_codec_driver {
 				size_t, unsigned int);
 	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
 	int (*readable_register)(struct snd_soc_codec *, unsigned int);
+	int (*writable_register)(struct snd_soc_codec *, unsigned int);
 	short reg_cache_size;
 	short reg_cache_step;
 	short reg_word_size;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 5d76da4..657889d 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1677,3 +1677,17 @@ int snd_soc_default_readable_register(struct snd_soc_codec *codec,
 	return codec->driver->reg_access_default[index].read;
 }
 EXPORT_SYMBOL_GPL(snd_soc_default_readable_register);
+
+int snd_soc_default_writable_register(struct snd_soc_codec *codec,
+				      unsigned int reg)
+{
+	int index;
+
+	if (reg >= codec->driver->reg_cache_size)
+		return 1;
+	index = snd_soc_get_reg_access_index(codec, reg);
+	if (index < 0)
+		return 0;
+	return codec->driver->reg_access_default[index].write;
+}
+EXPORT_SYMBOL_GPL(snd_soc_default_writable_register);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4dda589..1cb1446 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3666,6 +3666,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->read = codec_drv->read;
 	codec->volatile_register = codec_drv->volatile_register;
 	codec->readable_register = codec_drv->readable_register;
+	codec->writable_register = codec_drv->writable_register;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
@@ -3700,6 +3701,8 @@ int snd_soc_register_codec(struct device *dev,
 			codec->volatile_register = snd_soc_default_volatile_register;
 		if (!codec->readable_register)
 			codec->readable_register = snd_soc_default_readable_register;
+		if (!codec->writable_register)
+			codec->writable_register = snd_soc_default_writable_register;
 	}
 
 	for (i = 0; i < num_dai; i++) {
-- 
1.7.4.1
