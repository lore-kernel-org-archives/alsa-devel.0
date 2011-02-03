From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 1/3] ASoC: soc_jack - add function to add jack
	zones and determine jack type
Date: Thu,  3 Feb 2011 16:55:43 +0530
Message-ID: <1296732343-22627-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CDBD103A50
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 12:10:27 +0100 (CET)
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
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Based on the voltage value in adc channel,jack plugged in needs to be determined

This patch adds a helper functions that adds the adc voltage zones and
determines the jack type given the mic bias value.

When a jack is created, the voltage zones can to be added to it. Later when a
jack is inserted, the micbias voltage can be measured and used to find the
jack type

For any codec that would give the mic bias value on a jack insertion,
this function would return the type of jack based on mic bias range

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h  |   20 +++++++++++++++
 sound/soc/soc-jack.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4b6c0a8..97f2a3a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -234,6 +234,7 @@ struct snd_soc_codec;
 struct snd_soc_codec_driver;
 struct soc_enum;
 struct snd_soc_jack;
+struct snd_soc_jack_zone;
 struct snd_soc_jack_pin;
 struct snd_soc_cache_ops;
 #include <sound/soc-dapm.h>
@@ -307,6 +308,9 @@ void snd_soc_jack_notifier_register(struct snd_soc_jack *jack,
 				    struct notifier_block *nb);
 void snd_soc_jack_notifier_unregister(struct snd_soc_jack *jack,
 				      struct notifier_block *nb);
+int snd_soc_jack_add_zones(struct snd_soc_jack *jack, int count,
+			  struct snd_soc_jack_zone *zones);
+int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage);
 #ifdef CONFIG_GPIOLIB
 int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios);
@@ -406,6 +410,21 @@ struct snd_soc_jack_pin {
 	bool invert;
 };
 
+/* struct snd_soc_jack_zone - Describes voltage zones of jack detection
+ *
+ * @adc_value_start: start range of voltage value in adc channel
+ *			when jack is pluggedin
+ * @adc_value_end: end range of voltage value in adc channel
+ *			when jack is pluggedin
+ * @jack_type: type of jack that is expected for this voltage
+ */
+struct snd_soc_jack_zone {
+	unsigned int adc_value_start;
+	unsigned int adc_value_end;
+	unsigned int jack_type;
+	struct list_head list;
+};
+
 /**
  * struct snd_soc_jack_gpio - Describes a gpio pin for jack detection
  *
@@ -435,6 +454,7 @@ struct snd_soc_jack {
 	struct list_head pins;
 	int status;
 	struct blocking_notifier_head notifier;
+	struct list_head jack_zones;
 };
 
 /* SoC PCM stream information */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index ac5a5bc..66bd68f 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -37,6 +37,7 @@ int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 {
 	jack->codec = codec;
 	INIT_LIST_HEAD(&jack->pins);
+	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
 	return snd_jack_new(codec->card->snd_card, id, type, &jack->jack);
@@ -111,6 +112,72 @@ out:
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_report);
 
+static int snd_soc_validate_jack_type(int type)
+{
+	switch (type) {
+	case SND_JACK_HEADPHONE:
+	case SND_JACK_MICROPHONE:
+	case SND_JACK_HEADSET:
+	case SND_JACK_LINEOUT:
+	case SND_JACK_MECHANICAL:
+	case SND_JACK_VIDEOOUT:
+	case SND_JACK_AVOUT:
+		break;
+	default:
+		return -EINVAL;
+
+	};
+	return 0;
+}
+
+/**
+ * snd_soc_jack_add_zones - Associate voltage zones with jack
+ *
+ * @jack:  ASoC jack
+ * @count: Number of zones
+ * @zone:  Array of zones
+ *
+ * After this function has been called the zones specified in the
+ * array will be associated with the jack.
+ */
+int snd_soc_jack_add_zones(struct snd_soc_jack *jack, int count,
+			  struct snd_soc_jack_zone *zones)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (snd_soc_validate_jack_type(zones[i].jack_type)) {
+			printk(KERN_ERR "Unknown jack type given %d\n", i);
+			return -EINVAL;
+		}
+		INIT_LIST_HEAD(&zones[i].list);
+		list_add(&(zones[i].list), &jack->jack_zones);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_add_zones);
+
+/**
+ * snd_soc_jack_get_type - Based on the mic bias value, this function returns
+ * the type of jack from the zones delcared in the jack type
+ *
+ * @micbias_voltage:  mic bias voltage at adc channel when jack is plugged in
+ *
+ * Based on the mic bias value passed, this function helps identify
+ * the type of jack from the already delcared jack zones
+ **/
+int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage)
+{
+	struct snd_soc_jack_zone *zone;
+
+	list_for_each_entry(zone, &jack->jack_zones, list) {
+		if (micbias_voltage >= zone->adc_value_start &&
+			micbias_voltage < zone->adc_value_end)
+				return zone->jack_type;
+	}
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_get_type);
 /**
  * snd_soc_jack_add_pins - Associate DAPM pins with an ASoC jack
  *
-- 
1.7.3.4
