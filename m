From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH] ASoC: add support for multiple jack types
Date: Wed,  9 Feb 2011 14:44:17 +0530
Message-ID: <1297242857-18663-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 385E024334
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 10:06:38 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds soc-jack support for adding voltage zones and for
detecting jack type

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 include/sound/soc.h  |   23 +++++++++++++++++++++++
 sound/soc/soc-jack.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4b6c0a8..4ccf1e4 100644
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
@@ -407,6 +411,24 @@ struct snd_soc_jack_pin {
 };
 
 /**
+ * struct snd_soc_jack_zone - Describes voltage zones of jack detection
+ *
+ * @min_mv: start voltage in mv
+ * @max_mv: end voltage in mv
+ * @jack_type: type of jack that is expected for this voltage
+ * @debounce_time: debounce_time for jack, codec driver should wait for this
+ *		duration before reading the adc for voltages
+ * @:list: list container
+ */
+struct snd_soc_jack_zone {
+	unsigned int min_mv;
+	unsigned int max_mv;
+	unsigned int jack_type;
+	unsigned int debounce_time;
+	struct list_head list;
+};
+
+/**
  * struct snd_soc_jack_gpio - Describes a gpio pin for jack detection
  *
  * @gpio:         gpio number
@@ -435,6 +457,7 @@ struct snd_soc_jack {
 	struct list_head pins;
 	int status;
 	struct blocking_notifier_head notifier;
+	struct list_head jack_zones;
 };
 
 /* SoC PCM stream information */
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index ac5a5bc..99dbaf7 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -37,6 +37,7 @@ int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 {
 	jack->codec = codec;
 	INIT_LIST_HEAD(&jack->pins);
+	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
 	return snd_jack_new(codec->card->snd_card, id, type, &jack->jack);
@@ -112,6 +113,51 @@ out:
 EXPORT_SYMBOL_GPL(snd_soc_jack_report);
 
 /**
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
+ */
+int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage)
+{
+	struct snd_soc_jack_zone *zone;
+
+	list_for_each_entry(zone, &jack->jack_zones, list) {
+		if (micbias_voltage >= zone->min_mv &&
+			micbias_voltage < zone->max_mv)
+				return zone->jack_type;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_get_type);
+
+/**
  * snd_soc_jack_add_pins - Associate DAPM pins with an ASoC jack
  *
  * @jack:  ASoC jack
-- 
1.7.2.3
