From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: jack: Manage gpios via devres" to the
	asoc tree
Date: Tue, 22 Aug 2017 13:47:49 +0100
Message-ID: <E1dk8az-0008WO-3x@finisterre>
References: <20170822115951.6679-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 44393267658
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:47:49 +0200 (CEST)
In-Reply-To: <20170822115951.6679-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: jack: Manage gpios via devres

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

>From bd29ae969042c87413157c02d4f2a787d0212da3 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 22 Aug 2017 13:59:44 +0200
Subject: [PATCH] ASoC: jack: Manage gpios via devres

Let's be lazy -- this patch adds the devres code to
snd_soc_jack_add_gpios() for releasing the gpio resources at device
removal automagically.  After this patch, you don't have to call
snd_soc_jack_free_gpios() manually as long as it's managed from the
machine driver.

What about the gpios assigned in other levels?  Well, you might still
need to free the resources manually, depending on how the component
unbind works.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-jack.c | 52 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 42ca9f19843b..4c83734ae596 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -22,6 +22,12 @@
 #include <linux/suspend.h>
 #include <trace/events/asoc.h>
 
+struct jack_gpio_tbl {
+	int count;
+	struct snd_soc_jack *jack;
+	struct snd_soc_jack_gpio *gpios;
+};
+
 /**
  * snd_soc_codec_set_jack - configure codec jack.
  * @codec: CODEC
@@ -333,6 +339,28 @@ static int snd_soc_jack_pm_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void jack_free_gpios(struct snd_soc_jack *jack, int count,
+			    struct snd_soc_jack_gpio *gpios)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		gpiod_unexport(gpios[i].desc);
+		unregister_pm_notifier(&gpios[i].pm_notifier);
+		free_irq(gpiod_to_irq(gpios[i].desc), &gpios[i]);
+		cancel_delayed_work_sync(&gpios[i].work);
+		gpiod_put(gpios[i].desc);
+		gpios[i].jack = NULL;
+	}
+}
+
+static void jack_devres_free_gpios(struct device *dev, void *res)
+{
+	struct jack_gpio_tbl *tbl = res;
+
+	jack_free_gpios(tbl->jack, tbl->count, tbl->gpios);
+}
+
 /**
  * snd_soc_jack_add_gpios - Associate GPIO pins with an ASoC jack
  *
@@ -347,6 +375,14 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios)
 {
 	int i, ret;
+	struct jack_gpio_tbl *tbl;
+
+	tbl = devres_alloc(jack_devres_free_gpios, sizeof(*tbl), GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+	tbl->jack = jack;
+	tbl->count = count;
+	tbl->gpios = gpios;
 
 	for (i = 0; i < count; i++) {
 		if (!gpios[i].name) {
@@ -424,12 +460,14 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 				      msecs_to_jiffies(gpios[i].debounce_time));
 	}
 
+	devres_add(jack->card->dev, tbl);
 	return 0;
 
 err:
 	gpio_free(gpios[i].gpio);
 undo:
-	snd_soc_jack_free_gpios(jack, i, gpios);
+	jack_free_gpios(jack, i, gpios);
+	devres_free(tbl);
 
 	return ret;
 }
@@ -471,16 +509,8 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_add_gpiods);
 void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios)
 {
-	int i;
-
-	for (i = 0; i < count; i++) {
-		gpiod_unexport(gpios[i].desc);
-		unregister_pm_notifier(&gpios[i].pm_notifier);
-		free_irq(gpiod_to_irq(gpios[i].desc), &gpios[i]);
-		cancel_delayed_work_sync(&gpios[i].work);
-		gpiod_put(gpios[i].desc);
-		gpios[i].jack = NULL;
-	}
+	jack_free_gpios(jack, count, gpios);
+	devres_destroy(jack->card->dev, jack_devres_free_gpios, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_free_gpios);
 #endif	/* CONFIG_GPIOLIB */
-- 
2.13.2
