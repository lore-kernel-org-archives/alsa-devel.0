From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] ASoC: jack - check status of GPIO-based pins on resume
Date: Fri, 24 Mar 2017 12:20:24 -0700
Message-ID: <20170324192024.GA13029@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For GPIO-backed pins that are not configured as wakeup sources, we may
miss change in their state that happens while system is suspended. Let's
use PM notifier to refresh their state upon resume.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-jack.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b86168a21d56..c0b8bf463940 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -722,6 +722,7 @@ struct snd_soc_jack_gpio {
 	/* private: */
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
+	struct notifier_block pm_notifier;
 	struct gpio_desc *desc;
 
 	void *data;
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fbaa1bb41102..d90af94ec1be 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 #include <trace/events/asoc.h>
 
 /**
@@ -293,6 +294,27 @@ static void gpio_work(struct work_struct *work)
 	snd_soc_jack_gpio_detect(gpio);
 }
 
+static int snd_soc_jack_pm_notifier(struct notifier_block *nb,
+				    unsigned long action, void *data)
+{
+	struct snd_soc_jack_gpio *gpio =
+			container_of(nb, struct snd_soc_jack_gpio, pm_notifier);
+
+	switch (action) {
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		/*
+		 * Use workqueue so we do not have to care about running
+		 * concurrently with work triggered by interrupt handler.
+		 */
+		queue_delayed_work(system_power_efficient_wq, &gpio->work, 0);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * snd_soc_jack_add_gpios - Associate GPIO pins with an ASoC jack
  *
@@ -369,6 +391,13 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 					i, ret);
 		}
 
+		/*
+		 * Register PM notifier so we do not miss state transitions
+		 * happening while system is asleep.
+		 */
+		gpios[i].pm_notifier.notifier_call = snd_soc_jack_pm_notifier;
+		register_pm_notifier(&gpios[i].pm_notifier);
+
 		/* Expose GPIO value over sysfs for diagnostic purposes */
 		gpiod_export(gpios[i].desc, false);
 
@@ -428,6 +457,7 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 
 	for (i = 0; i < count; i++) {
 		gpiod_unexport(gpios[i].desc);
+		unregister_pm_notifier(&gpios[i].pm_notifier);
 		free_irq(gpiod_to_irq(gpios[i].desc), &gpios[i]);
 		cancel_delayed_work_sync(&gpios[i].work);
 		gpiod_put(gpios[i].desc);
-- 
2.12.1.578.ge9c3154ca4-goog


-- 
Dmitry
