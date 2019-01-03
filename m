From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/10] ASoC: es8316: Add jack-detect support
Date: Thu,  3 Jan 2019 14:45:26 +0100
Message-ID: <20190103134535.13861-2-hdegoede@redhat.com>
References: <20190103134535.13861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CAEB267BD0
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:45:42 +0100 (CET)
In-Reply-To: <20190103134535.13861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux@endlessm.com, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Adding jack-detect support may seem weird for a codec with only
a single output, but it is necessary. The ES8316 appnote showing
the intended usage uses a jack-receptacle which physically disconnects
the speakers from the output when a jack is plugged in.

But all 3 devices using the es8316 which I have (2 Cherry Trail
devices and one Bay Trail CR device), use an analog mux to disconnect
the speakers, driven by a GPIO. In order to enable/disable the speakers
at the right time, we need jack-detect.

The same goes for the microphone where we must correctly set the mux
for the single ADC to either the internal or the headset microphone.

All devices I have support the es8316's builtin jack-detect functionality.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/es8316.c | 195 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/es8316.h |   7 ++
 2 files changed, 198 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index e97d12d578b0..26413851e434 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -15,12 +15,14 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
+#include <sound/jack.h>
 #include "es8316.h"
 
 /* In slave mode at single speed, the codec is documented as accepting 5
@@ -33,6 +35,11 @@ static const unsigned int supported_mclk_lrck_ratios[] = {
 };
 
 struct es8316_priv {
+	struct mutex lock;
+	struct regmap *regmap;
+	struct snd_soc_component *component;
+	struct snd_soc_jack *jack;
+	int irq;
 	unsigned int sysclk;
 	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
@@ -529,8 +536,162 @@ static struct snd_soc_dai_driver es8316_dai = {
 	.symmetric_rates = 1,
 };
 
+static void es8316_enable_micbias_for_mic_gnd_short_detect(
+	struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "Bias");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "Analog power");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "Mic Bias");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	msleep(20);
+}
+
+static void es8316_disable_micbias_for_mic_gnd_short_detect(
+	struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Bias");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "Analog power");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "Bias");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static irqreturn_t es8316_irq(int irq, void *data)
+{
+	struct es8316_priv *es8316 = data;
+	struct snd_soc_component *comp = es8316->component;
+	unsigned int flags;
+
+	mutex_lock(&es8316->lock);
+
+	regmap_read(es8316->regmap, ES8316_GPIO_FLAG, &flags);
+	if (flags == 0x00)
+		goto out; /* Powered-down / reset */
+
+	/* Catch spurious IRQ before set_jack is called */
+	if (!es8316->jack)
+		goto out;
+
+	dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
+	if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
+		/* Jack removed, or spurious IRQ? */
+		if (es8316->jack->status & SND_JACK_MICROPHONE)
+			es8316_disable_micbias_for_mic_gnd_short_detect(comp);
+
+		if (es8316->jack->status & SND_JACK_HEADPHONE) {
+			snd_soc_jack_report(es8316->jack, 0,
+					    SND_JACK_HEADSET | SND_JACK_BTN_0);
+			dev_dbg(comp->dev, "jack unplugged\n");
+		}
+	} else if (!(es8316->jack->status & SND_JACK_HEADPHONE)) {
+		/* Jack inserted, determine type */
+		es8316_enable_micbias_for_mic_gnd_short_detect(comp);
+		regmap_read(es8316->regmap, ES8316_GPIO_FLAG, &flags);
+		dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
+		if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
+			/* Jack unplugged underneath us */
+			es8316_disable_micbias_for_mic_gnd_short_detect(comp);
+		} else if (flags & ES8316_GPIO_FLAG_GM_NOT_SHORTED) {
+			/* Open, headset */
+			snd_soc_jack_report(es8316->jack,
+					    SND_JACK_HEADSET,
+					    SND_JACK_HEADSET);
+			/* Keep mic-gnd-short detection on for button press */
+		} else {
+			/* Shorted, headphones */
+			snd_soc_jack_report(es8316->jack,
+					    SND_JACK_HEADPHONE,
+					    SND_JACK_HEADSET);
+			/* No longer need mic-gnd-short detection */
+			es8316_disable_micbias_for_mic_gnd_short_detect(comp);
+		}
+	} else if (es8316->jack->status & SND_JACK_MICROPHONE) {
+		/* Interrupt while jack inserted, report button state */
+		if (flags & ES8316_GPIO_FLAG_GM_NOT_SHORTED) {
+			/* Open, button release */
+			snd_soc_jack_report(es8316->jack, 0, SND_JACK_BTN_0);
+		} else {
+			/* Short, button press */
+			snd_soc_jack_report(es8316->jack,
+					    SND_JACK_BTN_0,
+					    SND_JACK_BTN_0);
+		}
+	}
+
+out:
+	mutex_unlock(&es8316->lock);
+	return IRQ_HANDLED;
+}
+
+static void es8316_enable_jack_detect(struct snd_soc_component *component,
+				      struct snd_soc_jack *jack)
+{
+	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&es8316->lock);
+
+	es8316->jack = jack;
+
+	if (es8316->jack->status & SND_JACK_MICROPHONE)
+		es8316_enable_micbias_for_mic_gnd_short_detect(component);
+
+	snd_soc_component_update_bits(component, ES8316_GPIO_DEBOUNCE,
+				      ES8316_GPIO_ENABLE_INTERRUPT,
+				      ES8316_GPIO_ENABLE_INTERRUPT);
+
+	mutex_unlock(&es8316->lock);
+
+	/* Enable irq and sync initial jack state */
+	enable_irq(es8316->irq);
+	es8316_irq(es8316->irq, es8316);
+}
+
+static void es8316_disable_jack_detect(struct snd_soc_component *component)
+{
+	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+
+	disable_irq(es8316->irq);
+
+	mutex_lock(&es8316->lock);
+
+	snd_soc_component_update_bits(component, ES8316_GPIO_DEBOUNCE,
+				      ES8316_GPIO_ENABLE_INTERRUPT, 0);
+
+	if (es8316->jack->status & SND_JACK_MICROPHONE) {
+		es8316_disable_micbias_for_mic_gnd_short_detect(component);
+		snd_soc_jack_report(es8316->jack, 0, SND_JACK_BTN_0);
+	}
+
+	es8316->jack = NULL;
+
+	mutex_unlock(&es8316->lock);
+}
+
+static int es8316_set_jack(struct snd_soc_component *component,
+			   struct snd_soc_jack *jack, void *data)
+{
+	if (jack)
+		es8316_enable_jack_detect(component, jack);
+	else
+		es8316_disable_jack_detect(component);
+
+	return 0;
+}
+
 static int es8316_probe(struct snd_soc_component *component)
 {
+	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+
+	es8316->component = component;
+
 	/* Reset codec and enable current state machine */
 	snd_soc_component_write(component, ES8316_RESET, 0x3f);
 	usleep_range(5000, 5500);
@@ -555,6 +716,7 @@ static int es8316_probe(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver soc_component_dev_es8316 = {
 	.probe			= es8316_probe,
+	.set_jack		= es8316_set_jack,
 	.controls		= es8316_snd_controls,
 	.num_controls		= ARRAY_SIZE(es8316_snd_controls),
 	.dapm_widgets		= es8316_dapm_widgets,
@@ -566,18 +728,29 @@ static const struct snd_soc_component_driver soc_component_dev_es8316 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct regmap_range es8316_volatile_ranges[] = {
+	regmap_reg_range(ES8316_GPIO_FLAG, ES8316_GPIO_FLAG),
+};
+
+static const struct regmap_access_table es8316_volatile_table = {
+	.yes_ranges	= es8316_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(es8316_volatile_ranges),
+};
+
 static const struct regmap_config es8316_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x53,
+	.volatile_table	= &es8316_volatile_table,
 	.cache_type = REGCACHE_RBTREE,
 };
 
 static int es8316_i2c_probe(struct i2c_client *i2c_client,
 			    const struct i2c_device_id *id)
 {
+	struct device *dev = &i2c_client->dev;
 	struct es8316_priv *es8316;
-	struct regmap *regmap;
+	int ret;
 
 	es8316 = devm_kzalloc(&i2c_client->dev, sizeof(struct es8316_priv),
 			      GFP_KERNEL);
@@ -586,9 +759,23 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client,
 
 	i2c_set_clientdata(i2c_client, es8316);
 
-	regmap = devm_regmap_init_i2c(i2c_client, &es8316_regmap);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	es8316->regmap = devm_regmap_init_i2c(i2c_client, &es8316_regmap);
+	if (IS_ERR(es8316->regmap))
+		return PTR_ERR(es8316->regmap);
+
+	es8316->irq = i2c_client->irq;
+	mutex_init(&es8316->lock);
+
+	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"es8316", es8316);
+	if (ret == 0) {
+		/* Gets re-enabled by es8316_set_jack() */
+		disable_irq(es8316->irq);
+	} else {
+		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
+		es8316->irq = -ENXIO;
+	}
 
 	return devm_snd_soc_register_component(&i2c_client->dev,
 				      &soc_component_dev_es8316,
diff --git a/sound/soc/codecs/es8316.h b/sound/soc/codecs/es8316.h
index 6bcdd63ea459..439a0130cbb7 100644
--- a/sound/soc/codecs/es8316.h
+++ b/sound/soc/codecs/es8316.h
@@ -126,4 +126,11 @@
 #define ES8316_SERDATA2_LEN_16		0x0c
 #define ES8316_SERDATA2_LEN_32		0x10
 
+/* ES8316_GPIO_DEBOUNCE	*/
+#define ES8316_GPIO_ENABLE_INTERRUPT		0x02
+
+/* ES8316_GPIO_FLAG */
+#define ES8316_GPIO_FLAG_GM_NOT_SHORTED		0x02
+#define ES8316_GPIO_FLAG_HP_NOT_INSERTED	0x04
+
 #endif
-- 
2.20.1
