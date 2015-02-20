From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: hda - Introduce azx_has_pm_runtime()
	macro
Date: Fri, 20 Feb 2015 08:08:24 +0100
Message-ID: <1424416107-32470-4-git-send-email-tiwai@suse.de>
References: <1424416107-32470-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ACEC260603
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:08:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5990AAABA
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 07:08:30 +0000 (UTC)
In-Reply-To: <1424416107-32470-1-git-send-email-tiwai@suse.de>
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

For making the debugging of runtime PM easier, introduce
azx_has_pm_runtime() and use it in all places checking the runtime pm
driver capability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c |  4 ++--
 sound/pci/hda/hda_intel.c      | 12 +++++-------
 sound/pci/hda/hda_priv.h       |  3 +++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 31ff8b55f386..3589fc2165b0 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1681,7 +1681,7 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
 	int i;
 
 #ifdef CONFIG_PM
-	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
+	if (azx_has_pm_runtime(chip))
 		if (!pm_runtime_active(chip->card->dev))
 			return IRQ_NONE;
 #endif
@@ -1784,7 +1784,7 @@ static void azx_power_notify(struct hda_bus *bus, bool power_up)
 {
 	struct azx *chip = bus->private_data;
 
-	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+	if (!azx_has_pm_runtime(chip))
 		return;
 
 	if (power_up)
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 36d2f20db7a4..589883291f4e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -852,7 +852,7 @@ static int azx_runtime_suspend(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+	if (!azx_has_pm_runtime(chip))
 		return 0;
 
 	/* enable controller wake up event */
@@ -885,7 +885,7 @@ static int azx_runtime_resume(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+	if (!azx_has_pm_runtime(chip))
 		return 0;
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
@@ -928,8 +928,7 @@ static int azx_runtime_idle(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (!power_save_controller ||
-	    !(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+	if (!power_save_controller || !azx_has_pm_runtime(chip))
 		return -EBUSY;
 
 	return 0;
@@ -1071,8 +1070,7 @@ static int azx_free(struct azx *chip)
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
 	int i;
 
-	if ((chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
-			&& chip->running)
+	if (azx_has_pm_runtime(chip) && chip->running)
 		pm_runtime_get_noresume(&pci->dev);
 
 	azx_del_card_list(chip);
@@ -1938,7 +1936,7 @@ static int azx_probe_continue(struct azx *chip)
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
-	if ((chip->driver_caps & AZX_DCAPS_PM_RUNTIME) || hda->use_vga_switcheroo)
+	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 		pm_runtime_put_noidle(&pci->dev);
 
 out_free:
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index daf458299753..a7b4a25c571c 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -403,4 +403,7 @@ struct azx {
 #define azx_sd_readb(chip, dev, reg) \
 	((chip)->ops->reg_readb((dev)->sd_addr + AZX_REG_##reg))
 
+#define azx_has_pm_runtime(chip) \
+	(!AZX_DCAPS_PM_RUNTIME || ((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME))
+
 #endif /* __SOUND_HDA_PRIV_H */
-- 
2.3.0
