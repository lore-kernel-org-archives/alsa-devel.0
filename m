From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: jack: Add support for GPIO
	descriptor defined jack pins
Date: Mon, 26 May 2014 14:34:37 +0300
Message-ID: <1401104077-25366-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1401104077-25366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id A70072650F7
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 13:35:22 +0200 (CEST)
In-Reply-To: <1401104077-25366-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Allow jack GPIO pins be defined also using GPIO descriptor-based interface
in addition to legacy GPIO numbers. This is done by adding two new fields to
struct snd_soc_jack_gpio: idx and gpiod_dev.

Legacy GPIO numbers are used only when GPIO consumer device gpiod_dev is
NULL and otherwise idx is the descriptor index within the GPIO consumer
device.

New function snd_soc_jack_add_gpiods() is added for typical cases where all
GPIO descriptor jack pins belong to same GPIO consumer device. For other
cases the caller must set the gpiod_dev in struct snd_soc_jack_gpio before
calling snd_soc_jack_add_gpios().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 include/sound/soc.h  | 16 +++++++++++-
 sound/soc/soc-jack.c | 73 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e9ec645911d9..98dca42487bc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -452,6 +452,9 @@ int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage);
 #ifdef CONFIG_GPIOLIB
 int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios);
+int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
+			    struct snd_soc_jack *jack,
+			    int count, struct snd_soc_jack_gpio *gpios);
 void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios);
 #else
@@ -461,6 +464,13 @@ static inline int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 	return 0;
 }
 
+int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
+			    struct snd_soc_jack *jack,
+			    int count, struct snd_soc_jack_gpio *gpios)
+{
+	return 0;
+}
+
 static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 					   struct snd_soc_jack_gpio *gpios)
 {
@@ -587,7 +597,9 @@ struct snd_soc_jack_zone {
 /**
  * struct snd_soc_jack_gpio - Describes a gpio pin for jack detection
  *
- * @gpio:         gpio number
+ * @gpio:         legacy gpio number
+ * @idx:          gpio descriptor index within the GPIO consumer device
+ * @gpiod_dev     GPIO consumer device
  * @name:         gpio name
  * @report:       value to report when jack detected
  * @invert:       report presence in low state
@@ -599,6 +611,8 @@ struct snd_soc_jack_zone {
  */
 struct snd_soc_jack_gpio {
 	unsigned int gpio;
+	unsigned int idx;
+	struct device *gpiod_dev;
 	const char *name;
 	int report;
 	int invert;
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7203842fea66..d0d98810af91 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -298,24 +298,41 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 	int i, ret;
 
 	for (i = 0; i < count; i++) {
-		if (!gpio_is_valid(gpios[i].gpio)) {
-			dev_err(jack->codec->dev, "ASoC: Invalid gpio %d\n",
-				gpios[i].gpio);
-			ret = -EINVAL;
-			goto undo;
-		}
 		if (!gpios[i].name) {
-			dev_err(jack->codec->dev, "ASoC: No name for gpio %d\n",
-				gpios[i].gpio);
+			dev_err(jack->codec->dev,
+				"ASoC: No name for gpio at index %d\n", i);
 			ret = -EINVAL;
 			goto undo;
 		}
 
-		ret = gpio_request(gpios[i].gpio, gpios[i].name);
-		if (ret)
-			goto undo;
-
-		gpios[i].desc = gpio_to_desc(gpios[i].gpio);
+		if (gpios[i].gpiod_dev) {
+			/* GPIO descriptor */
+			gpios[i].desc = gpiod_get_index(gpios[i].gpiod_dev,
+							gpios[i].name,
+							gpios[i].idx);
+			if (IS_ERR(gpios[i].desc)) {
+				ret = PTR_ERR(gpios[i].desc);
+				dev_err(gpios[i].gpiod_dev,
+					"ASoC: Cannot get gpio at index %d: %d",
+					i, ret);
+				goto undo;
+			}
+		} else {
+			/* legacy GPIO number */
+			if (!gpio_is_valid(gpios[i].gpio)) {
+				dev_err(jack->codec->dev,
+					"ASoC: Invalid gpio %d\n",
+					gpios[i].gpio);
+				ret = -EINVAL;
+				goto undo;
+			}
+
+			ret = gpio_request(gpios[i].gpio, gpios[i].name);
+			if (ret)
+				goto undo;
+
+			gpios[i].desc = gpio_to_desc(gpios[i].gpio);
+		}
 
 		ret = gpiod_direction_input(gpios[i].desc);
 		if (ret)
@@ -336,9 +353,9 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (gpios[i].wake) {
 			ret = irq_set_irq_wake(gpiod_to_irq(gpios[i].desc), 1);
 			if (ret != 0)
-				dev_err(jack->codec->dev, "ASoC: "
-				  "Failed to mark GPIO %d as wake source: %d\n",
-					gpios[i].gpio, ret);
+				dev_err(jack->codec->dev,
+					"ASoC: Failed to mark GPIO at index %d as wake source: %d\n",
+					i, ret);
 		}
 
 		/* Expose GPIO value over sysfs for diagnostic purposes */
@@ -361,6 +378,30 @@ undo:
 EXPORT_SYMBOL_GPL(snd_soc_jack_add_gpios);
 
 /**
+ * snd_soc_jack_add_gpiods - Associate GPIO descriptor pins with an ASoC jack
+ *
+ * @gpiod_dev: GPIO consumer device
+ * @jack:      ASoC jack
+ * @count:     number of pins
+ * @gpios:     array of gpio pins
+ *
+ * This function will request gpio, set data direction and request irq
+ * for each gpio in the array.
+ */
+int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
+			    struct snd_soc_jack *jack,
+			    int count, struct snd_soc_jack_gpio *gpios)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		gpios[i].gpiod_dev = gpiod_dev;
+
+	return snd_soc_jack_add_gpios(jack, count, gpios);
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_add_gpiods);
+
+/**
  * snd_soc_jack_free_gpios - Release GPIO pins' resources of an ASoC jack
  *
  * @jack:  ASoC jack
-- 
2.0.0.rc2
