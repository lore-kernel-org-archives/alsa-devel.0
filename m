From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: soc.h: Add new caching API
	prototypes and hooks
Date: Fri, 22 Oct 2010 15:28:19 +0100
Message-ID: <1287757702-9573-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A12A5103810
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 16:28:25 +0200 (CEST)
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
 include/sound/soc.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5c3bce8..29b4aef 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -238,6 +238,7 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+struct snd_soc_cache_ops;
 
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio;
@@ -253,6 +254,11 @@ enum snd_soc_control_type {
 	SND_SOC_SPI,
 };
 
+enum snd_soc_compress_type {
+	SND_SOC_NO_COMPRESSION,
+	SND_SOC_LZO_COMPRESSION
+};
+
 int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
@@ -264,6 +270,13 @@ int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
+int snd_soc_cache_sync(struct snd_soc_codec *codec);
+int snd_soc_cache_init(struct snd_soc_codec *codec);
+int snd_soc_cache_deinit(struct snd_soc_codec *codec);
+int snd_soc_cache_write(struct snd_soc_codec *codec,
+			unsigned int reg, unsigned int value);
+int snd_soc_cache_read(struct snd_soc_codec *codec,
+		       unsigned int reg, unsigned int *value);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
@@ -420,6 +433,18 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
+/* SoC cache ops */
+struct snd_soc_cache_ops {
+	int id; /* corresponds to snd_soc_compress_type */
+	int (*init)(struct snd_soc_codec *codec);
+	int (*deinit)(struct snd_soc_codec *codec);
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
@@ -450,6 +475,7 @@ struct snd_soc_codec {
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	void *reg_cache;
+	const struct snd_soc_cache_ops *cache_ops;
 
 	/* dapm */
 	u32 pop_time;
@@ -488,6 +514,7 @@ struct snd_soc_codec_driver {
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
+	enum snd_soc_compress_type compress_type;
 
 	/* codec bias level */
 	int (*set_bias_level)(struct snd_soc_codec *,
-- 
1.7.3.1
