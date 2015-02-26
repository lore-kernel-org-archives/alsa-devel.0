From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: hda - Move codec suspend/resume to
	codec driver
Date: Thu, 26 Feb 2015 18:00:18 +0100
Message-ID: <1424970025-8082-4-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9B282615B7
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6A27AADCC
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 17:00:31 +0000 (UTC)
In-Reply-To: <1424970025-8082-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

This patch moves the suspend/resume mechanisms down to each codec
driver level, as we have a proper codec driver bound on the bus now.
Then we get the asynchronous PM gratis without fiddling much in the
driver level.

As a soft-landing transition, implement the common suspend/resume pm
ops for hda_codec_driver and keep the each codec driver intact.  Only
the callers of suspend/resume in the controller side (azx_suspend()
and azx_resume()) are removed.

Another involved place is azx_bus_reset() calling the temporary
suspend and resume as a hackish method of bus reset.  The HD-audio
core provide a helper function snd_hda_bus_reset() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c       |  3 +-
 sound/pci/hda/hda_codec.c      | 93 +++++++++++++++---------------------------
 sound/pci/hda/hda_codec.h      |  6 +--
 sound/pci/hda/hda_controller.c | 11 +----
 sound/pci/hda/hda_intel.c      |  6 ---
 sound/pci/hda/hda_tegra.c      |  6 ---
 6 files changed, 39 insertions(+), 86 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index adf6b475dee1..ce2dd7b0dc07 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/export.h>
+#include <linux/pm.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -138,7 +139,7 @@ int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
 	drv->driver.bus = &snd_hda_bus_type;
 	drv->driver.probe = hda_codec_driver_probe;
 	drv->driver.remove = hda_codec_driver_remove;
-	/* TODO: PM and others */
+	drv->driver.pm = &hda_codec_driver_pm;
 	return driver_register(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(__hda_codec_driver_register);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 61c8174e8013..3d6ff60e6c14 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1250,6 +1250,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	dev->groups = snd_hda_dev_attr_groups;
 	dev_set_name(dev, "hdaudioC%dD%d", bus->card->number, codec_addr);
 	dev_set_drvdata(dev, codec); /* for sysfs */
+	device_enable_async_suspend(dev);
 
 	codec->bus = bus;
 	codec->addr = codec_addr;
@@ -3970,8 +3971,31 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	codec->in_pm = 0;
 	snd_hda_power_down(codec); /* flag down before returning */
 }
+
+static int hda_codec_driver_suspend(struct device *dev)
+{
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+	int i;
+
+	cancel_delayed_work_sync(&codec->jackpoll_work);
+	for (i = 0; i < codec->num_pcms; i++)
+		snd_pcm_suspend_all(codec->pcm_info[i].pcm);
+	hda_call_codec_suspend(codec, false);
+	return 0;
+}
+
+static int hda_codec_driver_resume(struct device *dev)
+{
+	hda_call_codec_resume(dev_to_hda_codec(dev));
+	return 0;
+}
 #endif /* CONFIG_PM */
 
+/* referred in hda_bind.c */
+const struct dev_pm_ops hda_codec_driver_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(hda_codec_driver_suspend,
+				hda_codec_driver_resume)
+};
 
 /**
  * snd_hda_build_controls - build mixer controls
@@ -5505,77 +5529,26 @@ int snd_hda_add_imux_item(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_add_imux_item);
 
-
-#ifdef CONFIG_PM
-/*
- * power management
- */
-
-
-static void hda_async_suspend(void *data, async_cookie_t cookie)
-{
-	hda_call_codec_suspend(data, false);
-}
-
-static void hda_async_resume(void *data, async_cookie_t cookie)
-{
-	hda_call_codec_resume(data);
-}
-
 /**
- * snd_hda_suspend - suspend the codecs
- * @bus: the HDA bus
- *
- * Returns 0 if successful.
+ * snd_hda_bus_reset - Reset the bus
+ * @bus: HD-audio bus
  */
-int snd_hda_suspend(struct hda_bus *bus)
+void snd_hda_bus_reset(struct hda_bus *bus)
 {
 	struct hda_codec *codec;
-	ASYNC_DOMAIN_EXCLUSIVE(domain);
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
+		/* FIXME: maybe a better way needed for forced reset */
 		cancel_delayed_work_sync(&codec->jackpoll_work);
+#ifdef CONFIG_PM
 		if (hda_codec_is_power_on(codec)) {
-			if (bus->num_codecs > 1)
-				async_schedule_domain(hda_async_suspend, codec,
-						      &domain);
-			else
-				hda_call_codec_suspend(codec, false);
-		}
-	}
-
-	if (bus->num_codecs > 1)
-		async_synchronize_full_domain(&domain);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_suspend);
-
-/**
- * snd_hda_resume - resume the codecs
- * @bus: the HDA bus
- *
- * Returns 0 if successful.
- */
-int snd_hda_resume(struct hda_bus *bus)
-{
-	struct hda_codec *codec;
-	ASYNC_DOMAIN_EXCLUSIVE(domain);
-
-	list_for_each_entry(codec, &bus->codec_list, list) {
-		if (bus->num_codecs > 1)
-			async_schedule_domain(hda_async_resume, codec, &domain);
-		else
+			hda_call_codec_suspend(codec, false);
 			hda_call_codec_resume(codec);
+		}
+#endif
 	}
-
-	if (bus->num_codecs > 1)
-		async_synchronize_full_domain(&domain);
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_hda_resume);
-#endif /* CONFIG_PM */
+EXPORT_SYMBOL_GPL(snd_hda_bus_reset);
 
 /*
  * generic arrays
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 3d42717e0e65..1fa3dd9baf52 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -567,14 +567,12 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 
 int snd_hda_lock_devices(struct hda_bus *bus);
 void snd_hda_unlock_devices(struct hda_bus *bus);
+void snd_hda_bus_reset(struct hda_bus *bus);
 
 /*
  * power management
  */
-#ifdef CONFIG_PM
-int snd_hda_suspend(struct hda_bus *bus);
-int snd_hda_resume(struct hda_bus *bus);
-#endif
+extern const struct dev_pm_ops hda_codec_driver_pm;
 
 static inline
 int hda_call_check_power_status(struct hda_codec *codec, hda_nid_t nid)
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 4c7a6f9bfcde..30ddb751806a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1780,15 +1780,8 @@ static void azx_bus_reset(struct hda_bus *bus)
 	bus->in_reset = 1;
 	azx_stop_chip(chip);
 	azx_init_chip(chip, true);
-#ifdef CONFIG_PM
-	if (chip->initialized) {
-		struct azx_pcm *p;
-		list_for_each_entry(p, &chip->pcm_list, list)
-			snd_pcm_suspend_all(p->pcm);
-		snd_hda_suspend(chip->bus);
-		snd_hda_resume(chip->bus);
-	}
-#endif
+	if (chip->initialized)
+		snd_hda_bus_reset(chip->bus);
 	bus->in_reset = 0;
 }
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5e00cc4a722f..9db1b078801f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -772,7 +772,6 @@ static int azx_suspend(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
 	struct hda_intel *hda;
-	struct azx_pcm *p;
 
 	if (!card)
 		return 0;
@@ -784,10 +783,6 @@ static int azx_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	azx_clear_irq_pending(chip);
-	list_for_each_entry(p, &chip->pcm_list, list)
-		snd_pcm_suspend_all(p->pcm);
-	if (chip->initialized)
-		snd_hda_suspend(chip->bus);
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	if (chip->irq >= 0) {
@@ -830,7 +825,6 @@ static int azx_resume(struct device *dev)
 
 	azx_init_chip(chip, true);
 
-	snd_hda_resume(chip->bus);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 1bd7a9e04046..f6949e413a50 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -249,14 +249,9 @@ static int hda_tegra_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
-	struct azx_pcm *p;
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	list_for_each_entry(p, &chip->pcm_list, list)
-		snd_pcm_suspend_all(p->pcm);
-	if (chip->initialized)
-		snd_hda_suspend(chip->bus);
 
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
@@ -277,7 +272,6 @@ static int hda_tegra_resume(struct device *dev)
 
 	azx_init_chip(chip, 1);
 
-	snd_hda_resume(chip->bus);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 
 	return 0;
-- 
2.3.0
