From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/30] ASoC: Allow to register jacks at the
	card level
Date: Wed,  4 Mar 2015 10:33:17 +0100
Message-ID: <1425461626-21103-3-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C741264F0D
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:33:52 +0100 (CET)
In-Reply-To: <1425461626-21103-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Jacks are typically card level elements, but are currently registered with a
CODEC. When it was originally introduced snd_soc_jack_new() took a
snd_soc_card as its parameter, but at that time DAPM was only implemented at
the CODEC level and there was only one CODEC per card. This made it clear
which CODEC to use for the jack DAPM operations. But the multi-component
patchset added support for having multiple CODECs per card and with it the
API was updated to register jacks with a specific CODEC instance instead.
Subsequently DAPM support at the card level has been introduced, but the
snd_soc_jack_new() API has so remained unchanged.

This leaves us with the issue that the DAPM pins that are managed by the
jack detection logic usually are part of the card DAPM context but are
accessed through a CODEC DAPM context. Currently this works fine, but might
break in the future if we take a more hierarchical approach to DAPM
contexts.

Furthermore with componentization progressing systems that do not register
a snd_soc_codec might appear, while these system may still want to able to
register a jack.

This patch addresses these issues by adding a new function called
snd_soc_card_jack_new() that can be used to register jacks with the card
rather than a CODEC.

This new function is mostly identical to snd_soc_jack_new() except that it
additionally allows to directly specify the DAPM pins associated with the
jack. This was done since most users of snd_soc_jack_new() typically call
snd_soc_jack_add_pins() right after it, which is not necessary with the new
API and allows to reduce the amount of boiler plate code.

The old snd_soc_jack_new() is re-implemented as a wrapper around
snd_soc_card_jack_new().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 28 +++++++++++++++++++++++++---
 sound/soc/soc-jack.c | 42 ++++++++++++++++++++++++++----------------
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a8ccc1de..e750e4b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -450,8 +450,10 @@ int soc_dai_hw_params(struct snd_pcm_substream *substream,
 		      struct snd_soc_dai *dai);
 
 /* Jack reporting */
-int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
-		     struct snd_soc_jack *jack);
+int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
+	struct snd_soc_jack *jack, struct snd_soc_jack_pin *pins,
+	unsigned int num_pins);
+
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask);
 int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 			  struct snd_soc_jack_pin *pins);
@@ -659,7 +661,7 @@ struct snd_soc_jack_gpio {
 struct snd_soc_jack {
 	struct mutex mutex;
 	struct snd_jack *jack;
-	struct snd_soc_codec *codec;
+	struct snd_soc_card *card;
 	struct list_head pins;
 	int status;
 	struct blocking_notifier_head notifier;
@@ -1490,6 +1492,26 @@ static inline struct snd_soc_platform *snd_soc_kcontrol_platform(
 	return snd_soc_component_to_platform(snd_soc_kcontrol_component(kcontrol));
 }
 
+/**
+ * snd_soc_jack_new - Create a new jack
+ * @codec: ASoC CODEC
+ * @id:    an identifying string for this jack
+ * @type:  a bitmask of enum snd_jack_type values that can be detected by
+ *         this jack
+ * @jack:  structure to use for the jack
+ *
+ * Creates a new jack object.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ * On success jack will be initialised.
+ */
+static inline int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id,
+	int type, struct snd_soc_jack *jack)
+{
+	return snd_soc_card_jack_new(codec->component.card, id, type, jack,
+		NULL, 0);
+}
+
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 4380dcc..9f60c25 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -22,30 +22,42 @@
 #include <trace/events/asoc.h>
 
 /**
- * snd_soc_jack_new - Create a new jack
- * @codec: ASoC codec
+ * snd_soc_card_jack_new - Create a new jack
+ * @card:  ASoC card
  * @id:    an identifying string for this jack
  * @type:  a bitmask of enum snd_jack_type values that can be detected by
  *         this jack
  * @jack:  structure to use for the jack
+ * @pins:  Array of jack pins to be added to the jack or NULL
+ * @num_pins: Number of elements in the @pins array
  *
  * Creates a new jack object.
  *
  * Returns zero if successful, or a negative error code on failure.
  * On success jack will be initialised.
  */
-int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
-		     struct snd_soc_jack *jack)
+int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
+	struct snd_soc_jack *jack, struct snd_soc_jack_pin *pins,
+	unsigned int num_pins)
 {
+	int ret;
+
 	mutex_init(&jack->mutex);
-	jack->codec = codec;
+	jack->card = card;
 	INIT_LIST_HEAD(&jack->pins);
 	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	return snd_jack_new(codec->component.card->snd_card, id, type, &jack->jack);
+	ret = snd_jack_new(card->snd_card, id, type, &jack->jack);
+	if (ret)
+		return ret;
+
+	if (num_pins)
+		return snd_soc_jack_add_pins(jack, num_pins, pins);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_jack_new);
+EXPORT_SYMBOL_GPL(snd_soc_card_jack_new);
 
 /**
  * snd_soc_jack_report - Report the current status for a jack
@@ -63,7 +75,6 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_new);
  */
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 {
-	struct snd_soc_codec *codec;
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack_pin *pin;
 	unsigned int sync = 0;
@@ -74,8 +85,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	if (!jack)
 		return;
 
-	codec = jack->codec;
-	dapm =  &codec->dapm;
+	dapm = &jack->card->dapm;
 
 	mutex_lock(&jack->mutex);
 
@@ -175,12 +185,12 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 
 	for (i = 0; i < count; i++) {
 		if (!pins[i].pin) {
-			dev_err(jack->codec->dev, "ASoC: No name for pin %d\n",
+			dev_err(jack->card->dev, "ASoC: No name for pin %d\n",
 				i);
 			return -EINVAL;
 		}
 		if (!pins[i].mask) {
-			dev_err(jack->codec->dev, "ASoC: No mask for pin %d"
+			dev_err(jack->card->dev, "ASoC: No mask for pin %d"
 				" (%s)\n", i, pins[i].pin);
 			return -EINVAL;
 		}
@@ -260,7 +270,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 static irqreturn_t gpio_handler(int irq, void *data)
 {
 	struct snd_soc_jack_gpio *gpio = data;
-	struct device *dev = gpio->jack->codec->component.card->dev;
+	struct device *dev = gpio->jack->card->dev;
 
 	trace_snd_soc_jack_irq(gpio->name);
 
@@ -299,7 +309,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 	for (i = 0; i < count; i++) {
 		if (!gpios[i].name) {
-			dev_err(jack->codec->dev,
+			dev_err(jack->card->dev,
 				"ASoC: No name for gpio at index %d\n", i);
 			ret = -EINVAL;
 			goto undo;
@@ -320,7 +330,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		} else {
 			/* legacy GPIO number */
 			if (!gpio_is_valid(gpios[i].gpio)) {
-				dev_err(jack->codec->dev,
+				dev_err(jack->card->dev,
 					"ASoC: Invalid gpio %d\n",
 					gpios[i].gpio);
 				ret = -EINVAL;
@@ -350,7 +360,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (gpios[i].wake) {
 			ret = irq_set_irq_wake(gpiod_to_irq(gpios[i].desc), 1);
 			if (ret != 0)
-				dev_err(jack->codec->dev,
+				dev_err(jack->card->dev,
 					"ASoC: Failed to mark GPIO at index %d as wake source: %d\n",
 					i, ret);
 		}
-- 
1.8.0
