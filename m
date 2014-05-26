From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: jack: Basic GPIO descriptor
	conversion
Date: Mon, 26 May 2014 14:34:36 +0300
Message-ID: <1401104077-25366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 963AF2650F2
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 13:35:20 +0200 (CEST)
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

This patch does basic GPIO descriptor conversion to soc-jack. Even the GPIOs
are still passed and requested using legacy GPIO numbers the driver
internals are converted to use GPIO descriptor API.

Motivation for this is to prepare soc-jack so that it will allow registering
jack GPIO pins using both GPIO descriptors and legacy GPIO numbers.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-jack.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index dcdcc95efd1d..e9ec645911d9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -607,6 +607,7 @@ struct snd_soc_jack_gpio {
 
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
+	struct gpio_desc *desc;
 
 	void *data;
 	int (*jack_status_check)(void *data);
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index b903f822d1b2..7203842fea66 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -14,6 +14,7 @@
 #include <sound/jack.h>
 #include <sound/soc.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
@@ -240,7 +241,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 	int enable;
 	int report;
 
-	enable = gpio_get_value_cansleep(gpio->gpio);
+	enable = gpiod_get_value_cansleep(gpio->desc);
 	if (gpio->invert)
 		enable = !enable;
 
@@ -314,14 +315,16 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (ret)
 			goto undo;
 
-		ret = gpio_direction_input(gpios[i].gpio);
+		gpios[i].desc = gpio_to_desc(gpios[i].gpio);
+
+		ret = gpiod_direction_input(gpios[i].desc);
 		if (ret)
 			goto err;
 
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
-		ret = request_any_context_irq(gpio_to_irq(gpios[i].gpio),
+		ret = request_any_context_irq(gpiod_to_irq(gpios[i].desc),
 					      gpio_handler,
 					      IRQF_TRIGGER_RISING |
 					      IRQF_TRIGGER_FALLING,
@@ -331,7 +334,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			goto err;
 
 		if (gpios[i].wake) {
-			ret = irq_set_irq_wake(gpio_to_irq(gpios[i].gpio), 1);
+			ret = irq_set_irq_wake(gpiod_to_irq(gpios[i].desc), 1);
 			if (ret != 0)
 				dev_err(jack->codec->dev, "ASoC: "
 				  "Failed to mark GPIO %d as wake source: %d\n",
@@ -339,7 +342,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		}
 
 		/* Expose GPIO value over sysfs for diagnostic purposes */
-		gpio_export(gpios[i].gpio, false);
+		gpiod_export(gpios[i].desc, false);
 
 		/* Update initial jack status */
 		schedule_delayed_work(&gpios[i].work,
@@ -372,10 +375,10 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 	int i;
 
 	for (i = 0; i < count; i++) {
-		gpio_unexport(gpios[i].gpio);
-		free_irq(gpio_to_irq(gpios[i].gpio), &gpios[i]);
+		gpiod_unexport(gpios[i].desc);
+		free_irq(gpiod_to_irq(gpios[i].desc), &gpios[i]);
 		cancel_delayed_work_sync(&gpios[i].work);
-		gpio_free(gpios[i].gpio);
+		gpiod_put(gpios[i].desc);
 		gpios[i].jack = NULL;
 	}
 }
-- 
2.0.0.rc2
