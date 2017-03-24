From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jack - check status of GPIO-based pins
	on resume" to the asoc tree
Date: Fri, 24 Mar 2017 19:16:10 +0000
Message-ID: <E1crUh0-00062f-1f@debutante>
References: <20170321235043.GA9831@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 574582669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:16:22 +0100 (CET)
In-Reply-To: <20170321235043.GA9831@dtor-ws>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: jack - check status of GPIO-based pins on resume

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

>From 73548dd316adec41172c31d63a0c35a97bf9577f Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dtor@chromium.org>
Date: Tue, 21 Mar 2017 16:50:43 -0700
Subject: [PATCH] ASoC: jack - check status of GPIO-based pins on resume

For GPIO-backed pins that are not configured as wakeup sources, we may
miss change in their state that happens while system is suspended. Let's
use PM notifier to refresh their state upon resume.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  1 +
 sound/soc/soc-jack.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2b502f6cc6d0..1d20abec4995 100644
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
index fbaa1bb41102..a03dcbb94baf 100644
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
+		 * concurrently with work triggered by the interrupt handler.
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
2.11.0
