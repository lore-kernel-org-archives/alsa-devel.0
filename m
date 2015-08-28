From: Mark Brown <broonie@kernel.org>
Subject: Applied "sound: Clean up docbook warnings" to the asoc
	tree
Date: Fri, 28 Aug 2015 18:44:10 +0100
Message-ID: <E1ZVNhC-00076Q-3H@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAF302605C6
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:44:23 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   sound: Clean up docbook warnings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 55b1faa33d485ace99a5a9e58bb1007782ae8ec9 Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 25 Aug 2015 01:14:48 -0600
Subject: [PATCH] sound: Clean up docbook warnings

A number of functions and structures in the sound subsystem had incomplete
and/or obsolete DocBook comments, leading to warnings when the docs were
built.  Correct those comments so that we can enjoy our audio in the
absence of warning noise.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/DocBook/alsa-driver-api.tmpl |  2 +-
 include/sound/soc.h                        | 11 +++++++----
 sound/soc/soc-core.c                       | 13 +++++++++----
 sound/soc/soc-dapm.c                       |  2 +-
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
index 71f9246..e94a10b 100644
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
index 93df8bf..4537e81 100644
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
index 90d6335..3224251 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2798,6 +2798,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_component);
 /**
  * snd_soc_unregister_component - Unregister a component from the ASoC core
  *
+ * @dev: The device to unregister
  */
 void snd_soc_unregister_component(struct device *dev)
 {
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
index aa327c9..c4e3720 100644
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
2.5.0
