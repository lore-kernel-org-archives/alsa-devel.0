From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: hda - Drop power_save value
	indirection in hda_bus
Date: Thu, 26 Feb 2015 18:00:20 +0100
Message-ID: <1424970025-8082-6-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8FF6264EAA
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 779C2ADD0
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

We used to pass the power_save option value to hda_bus via a given
pointer.  This was needed to refer to the value from the HD-audio core
side.  However, after the transition to the runtime PM, this is no
longer needed.

This patch drops the power_save value indirection in hda_bus above,
and let the controller driver reprograms the autosuspend value
explicitly by a new helper, snd_hda_set_power_save().  Without this
call, the HD-audio core doesn't set up the autosuspend and flip the
runtime PM.  (User may still be able to set up via sysfs, though.)

Along with this change, the pointer argument of azx_bus_create() is
dropped as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 34 ++++++++++++++++++----------------
 sound/pci/hda/hda_codec.h      |  5 ++---
 sound/pci/hda/hda_controller.c |  5 +----
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 10 ++++------
 sound/pci/hda/hda_tegra.c      |  5 +++--
 6 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d0dbc62c9147..36cebe0e76b2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1175,10 +1175,8 @@ static int snd_hda_codec_dev_register(struct snd_device *device)
 	struct hda_codec *codec = device->device_data;
 
 	snd_hda_register_beep_device(codec);
-	if (device_is_registered(hda_codec_dev(codec))) {
-		snd_hda_power_sync(codec);
+	if (device_is_registered(hda_codec_dev(codec)))
 		pm_runtime_enable(hda_codec_dev(codec));
-	}
 	return 0;
 }
 
@@ -4778,21 +4776,10 @@ void snd_hda_power_down(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_power_down);
 
-/**
- * snd_hda_power_sync - Synchronize the power_save option
- * @codec: HD-audio codec
- *
- * Synchronize the runtime PM autosuspend state from the power_save option.
- */
-void snd_hda_power_sync(struct hda_codec *codec)
+static void codec_set_power_save(struct hda_codec *codec, int delay)
 {
 	struct device *dev = hda_codec_dev(codec);
-	int delay;
 
-	if (!codec->bus->power_save)
-		return;
-
-	delay = *codec->bus->power_save * 1000;
 	if (delay > 0) {
 		pm_runtime_set_autosuspend_delay(dev, delay);
 		pm_runtime_use_autosuspend(dev);
@@ -4804,7 +4791,22 @@ void snd_hda_power_sync(struct hda_codec *codec)
 		pm_runtime_forbid(dev);
 	}
 }
-EXPORT_SYMBOL_GPL(snd_hda_power_sync);
+
+/**
+ * snd_hda_set_power_save - reprogram autosuspend for the given delay
+ * @bus: HD-audio bus
+ * @delay: autosuspend delay in msec, 0 = off
+ *
+ * Synchronize the runtime PM autosuspend state from the power_save option.
+ */
+void snd_hda_set_power_save(struct hda_bus *bus, int delay)
+{
+	struct hda_codec *c;
+
+	list_for_each_entry(c, &bus->codec_list, list)
+		codec_set_power_save(c, delay);
+}
+EXPORT_SYMBOL_GPL(snd_hda_set_power_save);
 
 /**
  * snd_hda_check_amp_list_power - Check the amp list and update the power
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 593956fc384b..89908f5b9601 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -122,7 +122,6 @@ struct hda_bus {
 	void *private_data;
 	struct pci_dev *pci;
 	const char *modelname;
-	int *power_save;
 	struct hda_bus_ops ops;
 
 	/* codec linked list */
@@ -592,12 +591,12 @@ const char *snd_hda_get_jack_location(u32 cfg);
 #ifdef CONFIG_PM
 void snd_hda_power_up(struct hda_codec *codec);
 void snd_hda_power_down(struct hda_codec *codec);
-void snd_hda_power_sync(struct hda_codec *codec);
+void snd_hda_set_power_save(struct hda_bus *bus, int delay);
 void snd_hda_update_power_acct(struct hda_codec *codec);
 #else
 static inline void snd_hda_power_up(struct hda_codec *codec) {}
 static inline void snd_hda_power_down(struct hda_codec *codec) {}
-static inline void snd_hda_power_sync(struct hda_codec *codec) {}
+static inline void snd_hda_set_power_save(struct hda_bus *bus, int delay) {}
 #endif
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 522c54f94740..cfe2c55296b6 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1838,7 +1838,7 @@ static struct hda_bus_ops bus_ops = {
 };
 
 /* HD-audio bus initialization */
-int azx_bus_create(struct azx *chip, const char *model, int *power_save_to)
+int azx_bus_create(struct azx *chip, const char *model)
 {
 	struct hda_bus *bus;
 	int err;
@@ -1852,9 +1852,6 @@ int azx_bus_create(struct azx *chip, const char *model, int *power_save_to)
 	bus->pci = chip->pci;
 	bus->modelname = model;
 	bus->ops = bus_ops;
-#ifdef CONFIG_PM
-	bus->power_save = power_save_to;
-#endif
 
 	if (chip->driver_caps & AZX_DCAPS_RIRB_DELAY) {
 		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 0d09aa6b49ac..e4f46a21698a 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -432,7 +432,7 @@ void azx_enter_link_reset(struct azx *chip);
 irqreturn_t azx_interrupt(int irq, void *dev_id);
 
 /* Codec interface */
-int azx_bus_create(struct azx *chip, const char *model, int *power_save_to);
+int azx_bus_create(struct azx *chip, const char *model);
 int azx_probe_codecs(struct azx *chip, unsigned int max_slots);
 int azx_codec_configure(struct azx *chip);
 int azx_init_stream(struct azx *chip);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 26510e60cbe2..40540048b002 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -173,7 +173,6 @@ static struct kernel_param_ops param_ops_xint = {
 #define param_check_xint param_check_int
 
 static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
-static int *power_save_addr = &power_save;
 module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
@@ -186,7 +185,7 @@ static bool power_save_controller = 1;
 module_param(power_save_controller, bool, 0644);
 MODULE_PARM_DESC(power_save_controller, "Reset controller in power save mode.");
 #else
-static int *power_save_addr;
+#define power_save	0
 #endif /* CONFIG_PM */
 
 static int align_buffer_size = -1;
@@ -740,7 +739,6 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 {
 	struct hda_intel *hda;
 	struct azx *chip;
-	struct hda_codec *c;
 	int prev = power_save;
 	int ret = param_set_int(val, kp);
 
@@ -752,8 +750,7 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 		chip = &hda->chip;
 		if (!chip->bus || chip->disabled)
 			continue;
-		list_for_each_entry(c, &chip->bus->codec_list, list)
-			snd_hda_power_sync(c);
+		snd_hda_set_power_save(chip->bus, power_save * 1000);
 	}
 	mutex_unlock(&card_list_lock);
 	return 0;
@@ -1889,7 +1886,7 @@ static int azx_probe_continue(struct azx *chip)
 #endif
 
 	/* create codec instances */
-	err = azx_bus_create(chip, model[dev], power_save_addr);
+	err = azx_bus_create(chip, model[dev]);
 	if (err < 0)
 		goto out_free;
 
@@ -1933,6 +1930,7 @@ static int azx_probe_continue(struct azx *chip)
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
+	snd_hda_set_power_save(chip->bus, power_save * 1000);
 	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 		pm_runtime_put_noidle(&pci->dev);
 
diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index f6949e413a50..42bc17655df0 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -81,7 +81,7 @@ module_param(power_save, bint, 0644);
 MODULE_PARM_DESC(power_save,
 		 "Automatic power-saving timeout (in seconds, 0 = disable).");
 #else
-static int power_save = 0;
+#define power_save	0
 #endif
 
 /*
@@ -496,7 +496,7 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		goto out_free;
 
 	/* create codec instances */
-	err = azx_bus_create(chip, NULL, &power_save);
+	err = azx_bus_create(chip, NULL);
 	if (err < 0)
 		goto out_free;
 
@@ -525,6 +525,7 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	chip->running = 1;
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
+	snd_hda_set_power_save(chip->bus, power_save * 1000);
 
 	return 0;
 
-- 
2.3.0
