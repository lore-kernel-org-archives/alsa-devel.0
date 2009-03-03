From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: Add GPIO support for jack reporting
	interface
Date: Tue, 3 Mar 2009 15:25:04 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6DD49@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 865AA1037F7
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 22:25:22 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Add GPIO support to jack reporting framework in ASoC using gpiolib calls.
The gpio support exports two new functions: snd_soc_jack_add_gpios and
snd_soc_jack_free_gpios.

Client drivers using gpio feature must pass an array of jack_gpio pins
belonging to a specific jack to the snd_soc_jack_add_gpios function. The
framework will request the gpios, set the data direction and request irq.
The framework will update power status of related jack_pins when an event on
the gpio pins comes according to the reporting bits defined for each gpio.

All gpio resources allocated when adding jack_gpio pins can be released
using snd_soc_jack_free_gpios function.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 include/sound/soc.h  |   32 ++++++++++++
 sound/soc/soc-jack.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 68d8149..e5b4fd0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/control.h>
@@ -168,6 +170,9 @@ struct soc_enum;
 struct snd_soc_ac97_ops;
 struct snd_soc_jack;
 struct snd_soc_jack_pin;
+#ifdef CONFIG_GPIOLIB
+struct snd_soc_jack_gpio;
+#endif
 
 typedef int (*hw_write_t)(void *,const char* ,int);
 typedef int (*hw_read_t)(void *,char* ,int);
@@ -194,6 +199,12 @@ int snd_soc_jack_new(struct snd_soc_card *card, const char *id, int type,
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask);
 int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 			  struct snd_soc_jack_pin *pins);
+#ifdef CONFIG_GPIOLIB
+int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
+			struct snd_soc_jack_gpio *gpios);
+void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
+			struct snd_soc_jack_gpio *gpios);
+#endif
 
 /* codec IO */
 #define snd_soc_read(codec, reg) codec->read(codec, reg)
@@ -262,6 +273,27 @@ struct snd_soc_jack_pin {
 	bool invert;
 };
 
+/**
+ * struct snd_soc_jack_gpio - Describes a gpio pin for jack detection
+ *
+ * @gpio:         gpio number
+ * @name:         gpio name
+ * @report:       value to report when jack detected
+ * @invert:       report presence in low state
+ * @debouce_time: debouce time in ms
+ */
+#ifdef CONFIG_GPIOLIB
+struct snd_soc_jack_gpio {
+	unsigned int gpio;
+	const char *name;
+	int report;
+	int invert;
+	int debounce_time;
+	struct snd_soc_jack *jack;
+	struct work_struct work;
+};
+#endif
+
 struct snd_soc_jack {
 	struct snd_jack *jack;
 	struct snd_soc_card *card;
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 8cc00c3..15bb80f 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -14,6 +14,10 @@
 #include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
 
 /**
  * snd_soc_jack_new - Create a new jack
@@ -136,3 +140,128 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_add_pins);
+
+#ifdef CONFIG_GPIOLIB
+/* gpio detect */
+void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
+{
+	struct snd_soc_jack *jack = gpio->jack;
+	int enable;
+	int report;
+
+	if (gpio->debounce_time > 0)
+		mdelay(gpio->debounce_time);
+
+	enable = gpio_get_value(gpio->gpio);
+	if (gpio->invert)
+		enable = !enable;
+
+	if (enable)
+		report = gpio->report;
+	else
+		report = 0;
+
+	snd_soc_jack_report(jack, report, gpio->report);
+}
+
+/* irq handler for gpio pin */
+static irqreturn_t gpio_handler(int irq, void *data)
+{
+	struct snd_soc_jack_gpio *gpio = data;
+
+	schedule_work(&gpio->work);
+
+	return IRQ_HANDLED;
+}
+
+/* gpio work */
+static void gpio_work(struct work_struct *work)
+{
+	struct snd_soc_jack_gpio *gpio;
+
+	gpio = container_of(work, struct snd_soc_jack_gpio, work);
+	snd_soc_jack_gpio_detect(gpio);
+}
+
+/**
+ * snd_soc_jack_add_gpios - Associate GPIO pins with an ASoC jack
+ *
+ * @jack:  ASoC jack
+ * @count: number of pins
+ * @gpios: array of gpio pins
+ *
+ * This function will request gpio, set data direction and request irq
+ * for each gpio in the array.
+ */
+int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
+			struct snd_soc_jack_gpio *gpios)
+{
+	int i, ret;
+
+	for (i = 0; i < count; i++) {
+		if (!gpio_is_valid(gpios[i].gpio)) {
+			printk(KERN_ERR "Invalid gpio %d\n",
+				gpios[i].gpio);
+			ret = -EINVAL;
+			goto undo;
+		}
+		if (!gpios[i].name) {
+			printk(KERN_ERR "No name for gpio %d\n",
+				gpios[i].gpio);
+			ret = -EINVAL;
+			goto undo;
+		}
+
+		ret = gpio_request(gpios[i].gpio, gpios[i].name);
+		if (ret)
+			goto undo;
+
+		ret = gpio_direction_input(gpios[i].gpio);
+		if (ret)
+			goto err;
+
+		ret = request_irq(gpio_to_irq(gpios[i].gpio),
+				gpio_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				jack->card->dev->driver->name,
+				&gpios[i]);
+		if (ret)
+			goto err;
+
+		INIT_WORK(&gpios[i].work, gpio_work);
+		gpios[i].jack = jack;
+	}
+
+	return 0;
+
+err:
+	gpio_free(gpios[i].gpio);
+undo:
+	snd_soc_jack_free_gpios(jack, i, gpios);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_add_gpios);
+
+/**
+ * snd_soc_jack_free_gpios - Release GPIO pins' resources of an ASoC jack
+ *
+ * @jack:  ASoC jack
+ * @count: number of pins
+ * @gpios: array of gpio pins
+ *
+ * Release gpio and irq resources for gpio pins associated with an ASoC jack.
+ */
+void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
+			struct snd_soc_jack_gpio *gpios)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		free_irq(gpio_to_irq(gpios[i].gpio), &gpios[i]);
+		gpio_free(gpios[i].gpio);
+		gpios[i].jack = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_free_gpios);
+#endif	/* CONFIG_GPIOLIB */
-- 
1.5.4.3
