From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: hda - Use common reboot notifier
Date: Mon, 30 Jun 2014 14:20:59 +0200
Message-ID: <1404130862-3152-5-git-send-email-tiwai@suse.de>
References: <1404130862-3152-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B2276265598
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:21:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 91173AD61
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:21:05 +0000 (UTC)
In-Reply-To: <1404130862-3152-1-git-send-email-tiwai@suse.de>
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

The very same notifier code is used in both hda_intel.c and
hda_tegra.c.  Move it to the generic code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 26 ++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h |  3 +++
 sound/pci/hda/hda_intel.c      | 24 ------------------------
 sound/pci/hda/hda_tegra.c      | 29 ++---------------------------
 4 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index a562d86c02fb..8d9398a4c7c9 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/reboot.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include "hda_priv.h"
@@ -1946,5 +1947,30 @@ int azx_init_stream(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_init_stream);
 
+/*
+ * reboot notifier for hang-up problem at power-down
+ */
+static int azx_halt(struct notifier_block *nb, unsigned long event, void *buf)
+{
+	struct azx *chip = container_of(nb, struct azx, reboot_notifier);
+	snd_hda_bus_reboot_notify(chip->bus);
+	azx_stop_chip(chip);
+	return NOTIFY_OK;
+}
+
+void azx_notifier_register(struct azx *chip)
+{
+	chip->reboot_notifier.notifier_call = azx_halt;
+	register_reboot_notifier(&chip->reboot_notifier);
+}
+EXPORT_SYMBOL_GPL(azx_notifier_register);
+
+void azx_notifier_unregister(struct azx *chip)
+{
+	if (chip->reboot_notifier.notifier_call)
+		unregister_reboot_notifier(&chip->reboot_notifier);
+}
+EXPORT_SYMBOL_GPL(azx_notifier_unregister);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 91f04958e2b0..c90d10fd4d8f 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -50,4 +50,7 @@ int azx_codec_configure(struct azx *chip);
 int azx_mixer_create(struct azx *chip);
 int azx_init_stream(struct azx *chip);
 
+void azx_notifier_register(struct azx *chip);
+void azx_notifier_unregister(struct azx *chip);
+
 #endif /* __SOUND_HDA_CONTROLLER_H */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bbb446aef67a..1e971e2f1d50 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -44,7 +44,6 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/mutex.h>
-#include <linux/reboot.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/clocksource.h>
@@ -952,29 +951,6 @@ static const struct dev_pm_ops azx_pm = {
 #endif /* CONFIG_PM */
 
 
-/*
- * reboot notifier for hang-up problem at power-down
- */
-static int azx_halt(struct notifier_block *nb, unsigned long event, void *buf)
-{
-	struct azx *chip = container_of(nb, struct azx, reboot_notifier);
-	snd_hda_bus_reboot_notify(chip->bus);
-	azx_stop_chip(chip);
-	return NOTIFY_OK;
-}
-
-static void azx_notifier_register(struct azx *chip)
-{
-	chip->reboot_notifier.notifier_call = azx_halt;
-	register_reboot_notifier(&chip->reboot_notifier);
-}
-
-static void azx_notifier_unregister(struct azx *chip)
-{
-	if (chip->reboot_notifier.notifier_call)
-		unregister_reboot_notifier(&chip->reboot_notifier);
-}
-
 static int azx_probe_continue(struct azx *chip);
 
 #ifdef SUPPORT_VGA_SWITCHEROO
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 12920b99d238..cf69dafa91c0 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -29,7 +29,6 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
-#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 
@@ -295,30 +294,6 @@ static const struct dev_pm_ops hda_tegra_pm = {
 };
 
 /*
- * reboot notifier for hang-up problem at power-down
- */
-static int hda_tegra_halt(struct notifier_block *nb, unsigned long event,
-			  void *buf)
-{
-	struct azx *chip = container_of(nb, struct azx, reboot_notifier);
-	snd_hda_bus_reboot_notify(chip->bus);
-	azx_stop_chip(chip);
-	return NOTIFY_OK;
-}
-
-static void hda_tegra_notifier_register(struct azx *chip)
-{
-	chip->reboot_notifier.notifier_call = hda_tegra_halt;
-	register_reboot_notifier(&chip->reboot_notifier);
-}
-
-static void hda_tegra_notifier_unregister(struct azx *chip)
-{
-	if (chip->reboot_notifier.notifier_call)
-		unregister_reboot_notifier(&chip->reboot_notifier);
-}
-
-/*
  * destructor
  */
 static int hda_tegra_dev_free(struct snd_device *device)
@@ -326,7 +301,7 @@ static int hda_tegra_dev_free(struct snd_device *device)
 	int i;
 	struct azx *chip = device->device_data;
 
-	hda_tegra_notifier_unregister(chip);
+	azx_notifier_unregister(chip);
 
 	if (chip->initialized) {
 		for (i = 0; i < chip->num_streams; i++)
@@ -557,7 +532,7 @@ static int hda_tegra_probe(struct platform_device *pdev)
 
 	chip->running = 1;
 	power_down_all_codecs(chip);
-	hda_tegra_notifier_register(chip);
+	azx_notifier_register(chip);
 
 	return 0;
 
-- 
2.0.0
