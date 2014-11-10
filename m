From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ASoC: Fix kerneldoc errors
Date: Mon, 10 Nov 2014 21:47:07 +0100
Message-ID: <1415652427-827-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F8BF261AA1
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 21:47:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lots of typos and missing parameter descriptions.

Some private struct fields are moved to the end of struct and put
markers to make kerneldoc happy (and it make even easier for human
readers).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc.h    | 16 +++++++++++-----
 sound/soc/soc-core.c   | 21 ++++++++++++++-------
 sound/soc/soc-dapm.c   |  2 +-
 sound/soc/soc-devres.c |  2 +-
 sound/soc/soc-jack.c   |  2 +-
 5 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ba7130037a0..10129be3cbb1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -588,10 +588,11 @@ int snd_soc_put_strobe(struct snd_kcontrol *kcontrol,
  * @invert: if non-zero then pin is enabled when status is not reported
  */
 struct snd_soc_jack_pin {
-	struct list_head list;
 	const char *pin;
 	int mask;
 	bool invert;
+	/* private: */
+	struct list_head list;
 };
 
 /**
@@ -602,13 +603,13 @@ struct snd_soc_jack_pin {
  * @jack_type: type of jack that is expected for this voltage
  * @debounce_time: debounce_time for jack, codec driver should wait for this
  *		duration before reading the adc for voltages
- * @:list: list container
  */
 struct snd_soc_jack_zone {
 	unsigned int min_mv;
 	unsigned int max_mv;
 	unsigned int jack_type;
 	unsigned int debounce_time;
+	/* private: */
 	struct list_head list;
 };
 
@@ -618,16 +619,19 @@ struct snd_soc_jack_zone {
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
+ * @debounce_time: debouce time in ms
  * @wake:	  enable as wake source
+ * @jack:         assigned jack
+ * @desc:         GPIO descriptor
  * @jack_status_check: callback function which overrides the detection
  *		       to provide more complex checks (eg, reading an
  *		       ADC).
+ * @data:         arbitrary data passed to jack_status_check callback
  */
 struct snd_soc_jack_gpio {
 	unsigned int gpio;
@@ -640,11 +644,13 @@ struct snd_soc_jack_gpio {
 	bool wake;
 
 	struct snd_soc_jack *jack;
-	struct delayed_work work;
 	struct gpio_desc *desc;
 
 	void *data;
 	int (*jack_status_check)(void *data);
+
+	/* private: */
+	struct delayed_work work;
 };
 
 struct snd_soc_jack {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4c8f8a23a0e9..74a8a80e2d9a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2113,6 +2113,8 @@ EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops);
 
 /**
  * snd_soc_set_ac97_ops_of_reset - Set ac97 ops with generic ac97 reset functions
+ * @ops: AC97 opts to set
+ * @pdev: platform to deal with
  *
  * This function sets the reset and warm_reset properties of ops and parses
  * the device node of pdev to get pinctrl states and gpio numbers to use.
@@ -2685,7 +2687,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 /**
  * snd_soc_put_volsw_sx - double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double mixer control that spans 2 registers.
  *
@@ -3458,7 +3460,7 @@ EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
 /**
  * snd_soc_dai_set_bclk_ratio - configure BCLK to sample rate ratio.
  * @dai: DAI
- * @ratio Ratio of BCLK to Sample rate.
+ * @ratio: Ratio of BCLK to Sample rate.
  *
  * Configures the DAI for a preset BCLK to sample rate ratio.
  */
@@ -4082,6 +4084,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_component);
 
 /**
  * snd_soc_unregister_component - Unregister a component from the ASoC core
+ * @dev: device to unregister
  *
  */
 void snd_soc_unregister_component(struct device *dev)
@@ -4119,7 +4122,7 @@ static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
  * @platform: The platform to add
- * @platform_driver: The driver for the platform
+ * @platform_drv: The driver for the platform
  */
 int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		const struct snd_soc_platform_driver *platform_drv)
@@ -4158,7 +4161,8 @@ EXPORT_SYMBOL_GPL(snd_soc_add_platform);
 /**
  * snd_soc_register_platform - Register a platform with the ASoC core
  *
- * @platform: platform to register
+ * @dev: platform to register
+ * @platform_drv: the driver for the platform
  */
 int snd_soc_register_platform(struct device *dev,
 		const struct snd_soc_platform_driver *platform_drv)
@@ -4215,7 +4219,7 @@ EXPORT_SYMBOL_GPL(snd_soc_lookup_platform);
 /**
  * snd_soc_unregister_platform - Unregister a platform from the ASoC core
  *
- * @platform: platform to unregister
+ * @dev: platform to unregister
  */
 void snd_soc_unregister_platform(struct device *dev)
 {
@@ -4306,7 +4310,10 @@ static int snd_soc_codec_set_bias_level(struct snd_soc_dapm_context *dapm,
 /**
  * snd_soc_register_codec - Register a codec with the ASoC core
  *
- * @codec: codec to register
+ * @dev: codec to register
+ * @codec_drv: the codec driver to register
+ * @dai_drv: the array of DAI drivers to register
+ * @num_dai: the number of DAIs to register
  */
 int snd_soc_register_codec(struct device *dev,
 			   const struct snd_soc_codec_driver *codec_drv,
@@ -4406,7 +4413,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_codec);
 /**
  * snd_soc_unregister_codec - Unregister a codec from the ASoC core
  *
- * @codec: codec to unregister
+ * @dev: codec to unregister
  */
 void snd_soc_unregister_codec(struct device *dev)
 {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c61cb9cedbcd..7050ec1d5b72 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2680,7 +2680,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_weak_routes);
 
 /**
  * snd_soc_dapm_new_widgets - add new dapm widgets
- * @dapm: DAPM context
+ * @card: card object containing widgets
  *
  * Checks the codec for any new dapm widgets and creates them if found.
  *
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index 057e5ef7dcce..a57921eeee81 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -60,7 +60,7 @@ static void devm_platform_release(struct device *dev, void *res)
 /**
  * devm_snd_soc_register_platform - resource managed platform registration
  * @dev: Device used to manage platform
- * @platform: platform to register
+ * @platform_drv: platform to register
  *
  * Register a platform driver with automatic unregistration when the device is
  * unregistered.
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index ab47fea997a3..ef1d42d7c6f6 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_report);
  *
  * @jack:  ASoC jack
  * @count: Number of zones
- * @zone:  Array of zones
+ * @zones:  Array of zones
  *
  * After this function has been called the zones specified in the
  * array will be associated with the jack.
-- 
2.1.3
