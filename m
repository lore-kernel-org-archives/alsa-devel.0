From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 1/5] ASoC: multi-component - Core
	Multi-component API
Date: Tue, 10 Aug 2010 18:02:21 +0100
Message-ID: <1281459745-28846-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 77CA924554
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 19:02:36 +0200 (CEST)
Received: by wyb42 with SMTP id 42so11149509wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 10:02:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch extends the ASoC API to allow sound cards to have more than one
CODEC and more than one platform DMA controller. This is achieved by dividing
some current ASoC structures that contain both driver data and device data into
structures that only either contain device data or driver data. i.e.

 struct snd_soc_codec    --->  struct snd_soc_codec (device data)
                          +->  struct snd_soc_codec_driver (driver data)

 struct snd_soc_platform --->  struct snd_soc_platform (device data)
                          +->  struct snd_soc_platform_driver (driver data)

 struct snd_soc_dai      --->  struct snd_soc_dai (device data)
                          +->  struct snd_soc_dai_driver (driver data)

 struct snd_soc_device   --->  deleted

This now allows ASoC to be more tightly aligned with the Linux driver model and
also means that every ASoC codec, platform and (platform) DAI is a kernel
device. ASoC component private data is now stored as device private data.

The ASoC sound card struct snd_soc_card has also been updated to store lists
of it's components rather than a pointer to a codec and platform. The PCM
runtime struct soc_pcm_runtime now has pointers to all its components.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/soc-dai.h |   98 +++++++++++++-------
 include/sound/soc.h     |  238 ++++++++++++++++++++++++++++------------------
 2 files changed, 208 insertions(+), 128 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 377693a..e7b6802 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -91,15 +91,17 @@ struct snd_pcm_substream;
                                SNDRV_PCM_FMTBIT_S32_LE |\
                                SNDRV_PCM_FMTBIT_S32_BE)
 
-struct snd_soc_dai_ops;
+struct snd_soc_dai_driver;
 struct snd_soc_dai;
 struct snd_ac97_bus_ops;
 
 /* Digital Audio Interface registration */
-int snd_soc_register_dai(struct snd_soc_dai *dai);
-void snd_soc_unregister_dai(struct snd_soc_dai *dai);
-int snd_soc_register_dais(struct snd_soc_dai *dai, size_t count);
-void snd_soc_unregister_dais(struct snd_soc_dai *dai, size_t count);
+int snd_soc_register_dai(struct device *dev,
+		struct snd_soc_dai_driver *dai_drv);
+void snd_soc_unregister_dai(struct device *dev);
+int snd_soc_register_dais(struct device *dev,
+		struct snd_soc_dai_driver *dai_drv, size_t count);
+void snd_soc_unregister_dais(struct device *dev, size_t count);
 
 /* Digital Audio Interface clocking API.*/
 int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
@@ -126,16 +128,6 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 /* Digital Audio Interface mute */
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute);
 
-/*
- * Digital Audio Interface.
- *
- * Describes the Digital Audio Interface in terms of its ALSA, DAI and AC97
- * operations and capabilities. Codec and platform drivers will register this
- * structure for every DAI they have.
- *
- * This structure covers the clocking, formating and ALSA operations for each
- * interface.
- */
 struct snd_soc_dai_ops {
 	/*
 	 * DAI clocking configuration, all optional.
@@ -191,24 +183,24 @@ struct snd_soc_dai_ops {
 };
 
 /*
- * Digital Audio Interface runtime data.
+ * Digital Audio Interface Driver.
  *
- * Holds runtime data for a DAI.
+ * Describes the Digital Audio Interface in terms of its ALSA, DAI and AC97
+ * operations and capabilities. Codec and platform drivers will register this
+ * structure for every DAI they have.
+ *
+ * This structure covers the clocking, formating and ALSA operations for each
+ * interface.
  */
-struct snd_soc_dai {
+struct snd_soc_dai_driver {
 	/* DAI description */
-	char *name;
+	const char *name;
 	unsigned int id;
 	int ac97_control;
 
-	struct device *dev;
-	void *ac97_pdata;	/* platform_data for the ac97 codec */
-
-	/* DAI callbacks */
-	int (*probe)(struct platform_device *pdev,
-		     struct snd_soc_dai *dai);
-	void (*remove)(struct platform_device *pdev,
-		       struct snd_soc_dai *dai);
+	/* DAI driver callbacks */
+	int (*probe)(struct snd_soc_dai *dai);
+	int (*remove)(struct snd_soc_dai *dai);
 	int (*suspend)(struct snd_soc_dai *dai);
 	int (*resume)(struct snd_soc_dai *dai);
 
@@ -219,26 +211,51 @@ struct snd_soc_dai {
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
 	unsigned int symmetric_rates:1;
+};
+
+/*
+ * Digital Audio Interface runtime data.
+ *
+ * Holds runtime data for a DAI.
+ */
+struct snd_soc_dai {
+	const char *name;
+	int id;
+	struct device *dev;
+	void *ac97_pdata;	/* platform_data for the ac97 codec */
+
+	/* driver ops */
+	struct snd_soc_dai_driver *driver;
 
 	/* DAI runtime info */
-	struct snd_soc_codec *codec;
+	unsigned int capture_active:1;		/* stream is in use */
+	unsigned int playback_active:1;		/* stream is in use */
+	unsigned int symmetric_rates:1;
+	struct snd_pcm_runtime *runtime;
 	unsigned int active;
 	unsigned char pop_wait:1;
+	unsigned char probed:1;
 
-	/* DAI private data */
-	void *private_data;
+	/* DAI DMA data */
+	void *playback_dma_data;
+	void *capture_dma_data;
 
-	/* parent platform */
-	struct snd_soc_platform *platform;
+	/* parent platform/codec */
+	union {
+		struct snd_soc_platform *platform;
+		struct snd_soc_codec *codec;
+	};
+	struct snd_soc_card *card;
 
 	struct list_head list;
+	struct list_head card_list;
 };
 
 static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
 					     const struct snd_pcm_substream *ss)
 {
 	return (ss->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
-		dai->playback.dma_data : dai->capture.dma_data;
+		dai->playback_dma_data : dai->capture_dma_data;
 }
 
 static inline void snd_soc_dai_set_dma_data(struct snd_soc_dai *dai,
@@ -246,9 +263,20 @@ static inline void snd_soc_dai_set_dma_data(struct snd_soc_dai *dai,
 					    void *data)
 {
 	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dai->playback.dma_data = data;
+		dai->playback_dma_data = data;
 	else
-		dai->capture.dma_data = data;
+		dai->capture_dma_data = data;
+}
+
+static inline void snd_soc_dai_set_drvdata(struct snd_soc_dai *dai,
+		void *data)
+{
+	dev_set_drvdata(dai->dev, data);
+}
+
+static inline void *snd_soc_dai_get_drvdata(struct snd_soc_dai *dai)
+{
+	return dev_get_drvdata(dai->dev);
 }
 
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 65e9d03..6982b15 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -228,13 +228,17 @@ struct snd_soc_ops;
 struct snd_soc_dai_mode;
 struct snd_soc_pcm_runtime;
 struct snd_soc_dai;
+struct snd_soc_dai_driver;
 struct snd_soc_platform;
 struct snd_soc_dai_link;
+struct snd_soc_platform_driver;
 struct snd_soc_codec;
+struct snd_soc_codec_driver;
 struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio;
 #endif
@@ -249,19 +253,18 @@ enum snd_soc_control_type {
 	SND_SOC_SPI,
 };
 
-int snd_soc_register_platform(struct snd_soc_platform *platform);
-void snd_soc_unregister_platform(struct snd_soc_platform *platform);
-int snd_soc_register_codec(struct snd_soc_codec *codec);
-void snd_soc_unregister_codec(struct snd_soc_codec *codec);
+int snd_soc_register_platform(struct device *dev,
+		struct snd_soc_platform_driver *platform_drv);
+void snd_soc_unregister_platform(struct device *dev);
+int snd_soc_register_codec(struct device *dev,
+		struct snd_soc_codec_driver *codec_drv,
+		struct snd_soc_dai_driver *dai_drv, int num_dai);
+void snd_soc_unregister_codec(struct device *dev);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 			       int addr_bits, int data_bits,
 			       enum snd_soc_control_type control);
 
-/* pcm <-> DAI connect */
-void snd_soc_free_pcms(struct snd_soc_device *socdev);
-int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid);
-
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
@@ -273,7 +276,7 @@ int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);
 
 /* Jack reporting */
-int snd_soc_jack_new(struct snd_soc_card *card, const char *id, int type,
+int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 		     struct snd_soc_jack *jack);
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask);
 int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
@@ -390,7 +393,7 @@ struct snd_soc_jack_gpio {
 
 struct snd_soc_jack {
 	struct snd_jack *jack;
-	struct snd_soc_card *card;
+	struct snd_soc_codec *codec;
 	struct list_head pins;
 	int status;
 	struct blocking_notifier_head notifier;
@@ -398,15 +401,13 @@ struct snd_soc_jack {
 
 /* SoC PCM stream information */
 struct snd_soc_pcm_stream {
-	char *stream_name;
+	const char *stream_name;
 	u64 formats;			/* SNDRV_PCM_FMTBIT_* */
 	unsigned int rates;		/* SNDRV_PCM_RATE_* */
 	unsigned int rate_min;		/* min rate */
 	unsigned int rate_max;		/* max rate */
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
-	unsigned int active;		/* stream is in use */
-	void *dma_data;			/* used by platform code */
 };
 
 /* SoC audio ops */
@@ -419,44 +420,36 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
-/* SoC Audio Codec */
+/* SoC Audio Codec device */
 struct snd_soc_codec {
-	char *name;
-	struct module *owner;
-	struct mutex mutex;
+	const char *name;
+	int id;
 	struct device *dev;
-	struct snd_soc_device *socdev;
+	struct snd_soc_codec_driver *driver;
 
+	struct mutex mutex;
+	struct snd_card *snd_card;
+	struct snd_soc_card *card;
 	struct list_head list;
-
-	/* callbacks */
-	int (*set_bias_level)(struct snd_soc_codec *,
-			      enum snd_soc_bias_level level);
+	struct list_head card_list;
+	int num_dai;
 
 	/* runtime */
-	struct snd_card *card;
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int active;
-	unsigned int pcm_devs;
-	void *drvdata;
+	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
+	unsigned int cache_only:1;  /* Suppress writes to hardware */
+	unsigned int cache_sync:1; /* Cache needs to be synced to hardware */
+	unsigned int suspended:1; /* Codec is in suspend PM state */
+	unsigned int probed:1; /* Codec has been probed */
+	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
+	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
 
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
-	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
-	int (*display_register)(struct snd_soc_codec *, char *,
-				size_t, unsigned int);
-	int (*volatile_register)(unsigned int);
-	int (*readable_register)(unsigned int);
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	void *reg_cache;
-	short reg_cache_size;
-	short reg_cache_step;
-
-	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
-	unsigned int cache_only:1;  /* Suppress writes to hardware */
-	unsigned int cache_sync:1; /* Cache needs to be synced to hardware */
 
 	/* dapm */
 	u32 pop_time;
@@ -466,10 +459,6 @@ struct snd_soc_codec {
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
 
-	/* codec DAI's */
-	struct snd_soc_dai *dai;
-	unsigned int num_dai;
-
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_codec_root;
 	struct dentry *debugfs_reg;
@@ -478,23 +467,40 @@ struct snd_soc_codec {
 #endif
 };
 
-/* codec device */
-struct snd_soc_codec_device {
-	int (*probe)(struct platform_device *pdev);
-	int (*remove)(struct platform_device *pdev);
-	int (*suspend)(struct platform_device *pdev, pm_message_t state);
-	int (*resume)(struct platform_device *pdev);
+/* codec driver */
+struct snd_soc_codec_driver {
+
+	/* driver ops */
+	int (*probe)(struct snd_soc_codec *);
+	int (*remove)(struct snd_soc_codec *);
+	int (*suspend)(struct snd_soc_codec *,
+			pm_message_t state);
+	int (*resume)(struct snd_soc_codec *);
+
+	/* codec IO */
+	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
+	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	int (*display_register)(struct snd_soc_codec *, char *,
+				size_t, unsigned int);
+	int (*volatile_register)(unsigned int);
+	int (*readable_register)(unsigned int);
+	short reg_cache_size;
+	short reg_cache_step;
+	short reg_word_size;
+	const void *reg_cache_default;
+
+	/* codec bias level */
+	int (*set_bias_level)(struct snd_soc_codec *,
+			      enum snd_soc_bias_level level);
 };
 
 /* SoC platform interface */
-struct snd_soc_platform {
-	char *name;
-	struct list_head list;
+struct snd_soc_platform_driver {
 
-	int (*probe)(struct platform_device *pdev);
-	int (*remove)(struct platform_device *pdev);
-	int (*suspend)(struct snd_soc_dai_link *dai_link);
-	int (*resume)(struct snd_soc_dai_link *dai_link);
+	int (*probe)(struct snd_soc_platform *);
+	int (*remove)(struct snd_soc_platform *);
+	int (*suspend)(struct snd_soc_dai *dai);
+	int (*resume)(struct snd_soc_dai *dai);
 
 	/* pcm creation and destruction */
 	int (*pcm_new)(struct snd_card *, struct snd_soc_dai *,
@@ -509,23 +515,32 @@ struct snd_soc_platform {
 		struct snd_soc_dai *);
 
 	/* platform stream ops */
-	struct snd_pcm_ops *pcm_ops;
+	struct snd_pcm_ops *ops;
 };
 
-/* SoC machine DAI configuration, glues a codec and cpu DAI together */
-struct snd_soc_dai_link  {
-	char *name;			/* Codec name */
-	char *stream_name;		/* Stream name */
+struct snd_soc_platform {
+	const char *name;
+	int id;
+	struct device *dev;
+	struct snd_soc_platform_driver *driver;
 
-	/* DAI */
-	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai;
+	unsigned int suspended:1; /* platform is suspended */
+	unsigned int probed:1;
 
-	/* machine stream operations */
-	struct snd_soc_ops *ops;
+	struct snd_card *snd_card;
+	struct snd_soc_card *card;
+	struct list_head list;
+	struct list_head card_list;
+};
 
-	/* codec/machine specific init - e.g. add machine controls */
-	int (*init)(struct snd_soc_codec *codec);
+struct snd_soc_dai_link {
+	/* config - must be set by machine driver */
+	const char *name;			/* Codec name */
+	const char *stream_name;		/* Stream name */
+	const char *codec_name;		/* for multi-codec */
+	const char *platform_name;	/* for multi-platform */
+	const char *cpu_dai_name;
+	const char *codec_dai_name;
 
 	/* Keep DAI active over suspend */
 	unsigned int ignore_suspend:1;
@@ -533,21 +548,24 @@ struct snd_soc_dai_link  {
 	/* Symmetry requirements */
 	unsigned int symmetric_rates:1;
 
-	/* Symmetry data - only valid if symmetry is being enforced */
-	unsigned int rate;
+	/* codec/machine specific init - e.g. add machine controls */
+	int (*init)(struct snd_soc_pcm_runtime *rtd);
 
-	/* DAI pcm */
-	struct snd_pcm *pcm;
+	/* machine stream operations */
+	struct snd_soc_ops *ops;
 };
 
 /* SoC card */
 struct snd_soc_card {
-	char *name;
+	const char *name;
 	struct device *dev;
+	struct snd_card *snd_card;
+	struct module *owner;
 
 	struct list_head list;
+	struct mutex mutex;
 
-	int instantiated;
+	bool instantiated;
 
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
@@ -568,28 +586,38 @@ struct snd_soc_card {
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
+	struct snd_soc_pcm_runtime *rtd;
+	int num_rtd;
 
-	struct snd_soc_device *socdev;
-
-	struct snd_soc_codec *codec;
-
-	struct snd_soc_platform *platform;
-	struct delayed_work delayed_work;
 	struct work_struct deferred_resume_work;
+
+	/* lists of probed devices belonging to this card */
+	struct list_head codec_dev_list;
+	struct list_head platform_dev_list;
+	struct list_head dai_dev_list;
 };
 
-/* SoC Device - the audio subsystem */
-struct snd_soc_device {
-	struct device *dev;
+/* SoC machine DAI configuration, glues a codec and cpu DAI together */
+struct snd_soc_pcm_runtime  {
+	struct device dev;
 	struct snd_soc_card *card;
-	struct snd_soc_codec_device *codec_dev;
-	void *codec_data;
-};
+	struct snd_soc_dai_link *dai_link;
+
+	unsigned int complete:1;
+	unsigned int dev_registered:1;
 
-/* runtime channel data */
-struct snd_soc_pcm_runtime {
-	struct snd_soc_dai_link *dai;
-	struct snd_soc_device *socdev;
+	/* Symmetry data - only valid if symmetry is being enforced */
+	unsigned int rate;
+	long pmdown_time;
+
+	/* runtime devices */
+	struct snd_pcm *pcm;
+	struct snd_soc_codec *codec;
+	struct snd_soc_platform *platform;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
+
+	struct delayed_work delayed_work;
 };
 
 /* mixer control */
@@ -615,24 +643,48 @@ struct soc_enum {
 static inline unsigned int snd_soc_read(struct snd_soc_codec *codec,
 					unsigned int reg)
 {
-	return codec->read(codec, reg);
+	return codec->driver->read(codec, reg);
 }
 
 static inline unsigned int snd_soc_write(struct snd_soc_codec *codec,
 					 unsigned int reg, unsigned int val)
 {
-	return codec->write(codec, reg, val);
+	return codec->driver->write(codec, reg, val);
 }
 
+/* device driver data */
+
 static inline void snd_soc_codec_set_drvdata(struct snd_soc_codec *codec,
-					     void *data)
+		void *data)
 {
-	codec->drvdata = data;
+	dev_set_drvdata(codec->dev, data);
 }
 
 static inline void *snd_soc_codec_get_drvdata(struct snd_soc_codec *codec)
 {
-	return codec->drvdata;
+	return dev_get_drvdata(codec->dev);
+}
+
+static inline void snd_soc_platform_set_drvdata(struct snd_soc_platform *platform,
+		void *data)
+{
+	dev_set_drvdata(platform->dev, data);
+}
+
+static inline void *snd_soc_platform_get_drvdata(struct snd_soc_platform *platform)
+{
+	return dev_get_drvdata(platform->dev);
+}
+
+static inline void snd_soc_pcm_set_drvdata(struct snd_soc_pcm_runtime *rtd,
+		void *data)
+{
+	dev_set_drvdata(&rtd->dev, data);
+}
+
+static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
+{
+	return dev_get_drvdata(&rtd->dev);
 }
 
 #include <sound/soc-dai.h>
-- 
1.7.0.4
