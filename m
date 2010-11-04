From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: soc.h: Add new caching API
	prototypes and hooks
Date: Thu,  4 Nov 2010 14:22:41 +0000
Message-ID: <1288880564-31957-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F44E103854
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 15:22:52 +0100 (CET)
In-Reply-To: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
 include/sound/soc.h |   26 ++++++++++++++++++++++++++
 sound/soc/Kconfig   |    2 ++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index aaf34d7..90a9b60 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -238,6 +238,7 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+struct snd_soc_cache_ops;
 
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio;
@@ -253,6 +254,10 @@ enum snd_soc_control_type {
 	SND_SOC_SPI,
 };
 
+enum snd_soc_compress_type {
+	SND_SOC_NO_COMPRESSION
+};
+
 int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
@@ -264,6 +269,13 @@ int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
+int snd_soc_cache_sync(struct snd_soc_codec *codec);
+int snd_soc_cache_init(struct snd_soc_codec *codec);
+int snd_soc_cache_exit(struct snd_soc_codec *codec);
+int snd_soc_cache_write(struct snd_soc_codec *codec,
+			unsigned int reg, unsigned int value);
+int snd_soc_cache_read(struct snd_soc_codec *codec,
+		       unsigned int reg, unsigned int *value);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
@@ -420,6 +432,18 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
+/* SoC cache ops */
+struct snd_soc_cache_ops {
+	int id; /* corresponds to snd_soc_compress_type */
+	int (*init)(struct snd_soc_codec *codec);
+	int (*exit)(struct snd_soc_codec *codec);
+	int (*read)(struct snd_soc_codec *codec, unsigned int reg,
+		unsigned int *value);
+	int (*write)(struct snd_soc_codec *codec, unsigned int reg,
+		unsigned int value);
+	int (*sync)(struct snd_soc_codec *codec);
+};
+
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
@@ -450,6 +474,7 @@ struct snd_soc_codec {
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	void *reg_cache;
+	const struct snd_soc_cache_ops *cache_ops;
 
 	/* dapm */
 	u32 pop_time;
@@ -488,6 +513,7 @@ struct snd_soc_codec_driver {
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
+	enum snd_soc_compress_type compress_type;
 
 	/* codec bias level */
 	int (*set_bias_level)(struct snd_soc_codec *,
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3e598e7..4562c89 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -4,6 +4,8 @@
 
 menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
 	select SND_JACK if INPUT=y || INPUT=SND
-- 
1.7.3.2
