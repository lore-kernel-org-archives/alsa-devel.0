From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH]  sound: Clean up docbook warnings
Date: Tue, 25 Aug 2015 01:14:48 -0600
Message-ID: <20150825011448.20a74301@xps>
References: <20150823035036.1c5614db@xps.lwn.net>
	<s5hzj1is09b.wl-tiwai@suse.de>
	<20150825062541.GC27431@sirena.org.uk>
	<s5hegir51do.wl-tiwai@suse.de>
	<20150825064739.GF27431@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150825064739.GF27431@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 25 Aug 2015 07:47:39 +0100
Mark Brown <broonie@kernel.org> wrote:

> Sure, but as a result of being at Plumbers last week I currently have
> about 100 patches actually in my inbox that need review and I don't need
> to go trawling for...

Sorry, should have cc'd you on it from the beginning.  Here's a copy...

Thanks,

jon

>From c1efe503d05c1a9a1cb5e0c9c3e39b4e74f2ead2 Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Sun, 16 Aug 2015 16:56:21 -0600
Subject: [PATCH] sound: Clean up docbook warnings

A number of functions and structures in the sound subsystem had incomplete
and/or obsolete DocBook comments, leading to warnings when the docs were
built.  Correct those comments so that we can enjoy our audio in the
absence of warning noise.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/DocBook/alsa-driver-api.tmpl |  2 +-
 include/sound/soc.h                        | 11 +++++++----
 sound/soc/soc-core.c                       | 17 +++++++++++------
 sound/soc/soc-dapm.c                       |  2 +-
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index 71f9246127ec..e94a10bb4a9e 100644
--- a/Documentation/DocBook/alsa-driver-api.tmpl
+++ b/Documentation/DocBook/alsa-driver-api.tmpl
@@ -108,7 +108,7 @@
      <sect1><title>ASoC Core API</title>
 !Iinclude/sound/soc.h
 !Esound/soc/soc-core.c
-!Esound/soc/soc-cache.c
+<!-- !Esound/soc/soc-cache.c no docbook comments here -->
 !Esound/soc/soc-devres.c
 !Esound/soc/soc-io.c
 !Esound/soc/soc-pcm.c
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93df8bf9d54a..4537e81eeeda 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -619,6 +619,7 @@ int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
  * @pin:    name of the pin to update
  * @mask:   bits to check for in reported jack status
  * @invert: if non-zero then pin is enabled when status is not reported
+ * @list:   internal list entry
  */
 struct snd_soc_jack_pin {
 	struct list_head list;
@@ -635,7 +636,7 @@ struct snd_soc_jack_pin {
  * @jack_type: type of jack that is expected for this voltage
  * @debounce_time: debounce_time for jack, codec driver should wait for this
  *		duration before reading the adc for voltages
- * @:list: list container
+ * @list:   internal list entry
  */
 struct snd_soc_jack_zone {
 	unsigned int min_mv;
@@ -651,12 +652,12 @@ struct snd_soc_jack_zone {
  * @gpio:         legacy gpio number
  * @idx:          gpio descriptor index within the function of the GPIO
  *                consumer device
- * @gpiod_dev     GPIO consumer device
+ * @gpiod_dev:    GPIO consumer device
  * @name:         gpio name. Also as connection ID for the GPIO consumer
  *                device function name lookup
  * @report:       value to report when jack detected
  * @invert:       report presence in low state
- * @debouce_time: debouce time in ms
+ * @debounce_time: debounce time in ms
  * @wake:	  enable as wake source
  * @jack_status_check: callback function which overrides the detection
  *		       to provide more complex checks (eg, reading an
@@ -672,11 +673,13 @@ struct snd_soc_jack_gpio {
 	int debounce_time;
 	bool wake;
 
+	/* private: */
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
 	struct gpio_desc *desc;
 
 	void *data;
+	/* public: */
 	int (*jack_status_check)(void *data);
 };
 
@@ -1319,7 +1322,7 @@ static inline struct snd_soc_dapm_context *snd_soc_codec_get_dapm(
 
 /**
  * snd_soc_dapm_init_bias_level() - Initialize CODEC DAPM bias level
- * @dapm: The CODEC for which to initialize the DAPM bias level
+ * @codec: The CODEC for which to initialize the DAPM bias level
  * @level: The DAPM level to initialize to
  *
  * Initializes the CODEC DAPM bias level. See snd_soc_dapm_init_bias_level().
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a4a5c0e3f97..32242512d828 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2127,7 +2127,7 @@ EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
 /**
  * snd_soc_dai_set_bclk_ratio - configure BCLK to sample rate ratio.
  * @dai: DAI
- * @ratio Ratio of BCLK to Sample rate.
+ * @ratio: Ratio of BCLK to Sample rate.
  *
  * Configures the DAI for a preset BCLK to sample rate ratio.
  */
@@ -2798,6 +2798,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_component);
 /**
  * snd_soc_unregister_component - Unregister a component from the ASoC core
  *
+ * @dev: The device to unregister
  */
 void snd_soc_unregister_component(struct device *dev)
 {
@@ -2838,7 +2839,7 @@ static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
  * @platform: The platform to add
- * @platform_driver: The driver for the platform
+ * @platform_drv: The driver for the platform
  */
 int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		const struct snd_soc_platform_driver *platform_drv)
@@ -2877,7 +2878,8 @@ EXPORT_SYMBOL_GPL(snd_soc_add_platform);
 /**
  * snd_soc_register_platform - Register a platform with the ASoC core
  *
- * @platform: platform to register
+ * @dev: The device for the platform
+ * @platform_drv: The driver for the platform
  */
 int snd_soc_register_platform(struct device *dev,
 		const struct snd_soc_platform_driver *platform_drv)
@@ -2938,7 +2940,7 @@ EXPORT_SYMBOL_GPL(snd_soc_lookup_platform);
 /**
  * snd_soc_unregister_platform - Unregister a platform from the ASoC core
  *
- * @platform: platform to unregister
+ * @dev: platform to unregister
  */
 void snd_soc_unregister_platform(struct device *dev)
 {
@@ -3029,7 +3031,10 @@ static int snd_soc_codec_set_bias_level(struct snd_soc_dapm_context *dapm,
 /**
  * snd_soc_register_codec - Register a codec with the ASoC core
  *
- * @codec: codec to register
+ * @dev: The parent device for this codec
+ * @codec_drv: Codec driver
+ * @dai_drv: The associated DAI driver
+ * @num_dai: Number of DAIs
  */
 int snd_soc_register_codec(struct device *dev,
 			   const struct snd_soc_codec_driver *codec_drv,
@@ -3128,7 +3133,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_codec);
 /**
  * snd_soc_unregister_codec - Unregister a codec from the ASoC core
  *
- * @codec: codec to unregister
+ * @dev: codec to unregister
  */
 void snd_soc_unregister_codec(struct device *dev)
 {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index aa327c92480c..c4e3720bea41 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2911,7 +2911,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_weak_routes);
 
 /**
  * snd_soc_dapm_new_widgets - add new dapm widgets
- * @dapm: DAPM context
+ * @card: card to be checked for new dapm widgets
  *
  * Checks the codec for any new dapm widgets and creates them if found.
  *
-- 
2.4.3

