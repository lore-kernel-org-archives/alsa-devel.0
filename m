From: mengdong.lin@intel.com
Subject: [PATCH v3 1/2] ALSA: hda - add runtime PM support
Date: Wed, 22 Aug 2012 18:46:30 +0800
Message-ID: <1345632390-5594-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 13FB82660DD
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 12:46:35 +0200 (CEST)
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Runtime PM can bring more power saving:
- When the controller is suspended, its parent device will also have a chance
  to suspend.
- PCI subsystem can choose the lowest power state the controller can signal
  wake up from. This state can be D3cold on platforms with ACPI PM support.
And runtime PM can provide a gernel sysfs interface for a system policy manager.

Runtime PM support is based on current HDA power saving implementation. The user
can enable runtime PM on platfroms that provide acceptable latency on transition
from D3 to D0.

Details:
- When both power saving and runtime PM are enabled, and if all codecs are
  suspended (in D3), the HDA controller can also be suspended to a low power
  state by decreasing the power usage counter. And the user IO operation can
  resume the controller back to D0.
- If runtime PM is disabled, power saving just works as before.
- If power saving is disabled, the controller won't be suspended because the
  power usage counter can never be 0.

TODO: Suspend the controller only if all codecs support CLKSTOP in D3, for
pass-through operations and wakeup.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
 sound/pci/hda/hda_intel.c |   52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b6a4ea7..4c30fd7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -46,6 +46,7 @@
 #include <linux/mutex.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #ifdef CONFIG_X86
 /* for snoop control */
 #include <asm/pgtable.h>
@@ -1278,6 +1279,9 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 	u8 sd_status;
 	int i, ok;
 
+	if (chip->pci->dev.power.runtime_status != RPM_ACTIVE)
+		return IRQ_NONE;
+
 	spin_lock(&chip->reg_lock);
 
 	if (chip->disabled) {
@@ -2402,11 +2406,19 @@ static void azx_power_notify(struct hda_bus *bus)
 			break;
 		}
 	}
-	if (power_on)
+	if (power_on) {
+		if (!chip->initialized)
+			pm_runtime_get_sync(&chip->pci->dev);
 		azx_init_chip(chip, 1);
+	}
 	else if (chip->running && power_save_controller &&
-		 !bus->power_keep_link_on)
+		 !bus->power_keep_link_on) {
 		azx_stop_chip(chip);
+
+		/* TODO: Suspend controller only if all codec support
+		stop-clock in D3, for wakeup consideration */
+		pm_runtime_put_sync(&chip->pci->dev);
+	}
 }
 
 static DEFINE_MUTEX(card_list_lock);
@@ -2511,7 +2523,30 @@ static int azx_resume(struct device *dev)
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
-static SIMPLE_DEV_PM_OPS(azx_pm, azx_suspend, azx_resume);
+
+static int azx_runtime_suspend(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+
+	azx_clear_irq_pending(chip);
+	return 0;
+}
+
+static int azx_runtime_resume(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+
+	azx_init_pci(chip);
+	return 0;
+}
+
+static const struct dev_pm_ops azx_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
+	SET_RUNTIME_PM_OPS(azx_runtime_suspend, azx_runtime_resume, NULL)
+};
+
 #define AZX_PM_OPS	&azx_pm
 #else
 #define azx_suspend(dev)
@@ -3238,6 +3273,9 @@ static int __devinit azx_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(pci, card);
 
+	if (pci_dev_run_wake(pci))
+		pm_runtime_put_noidle(&pci->dev);
+
 	dev++;
 	return 0;
 
@@ -3289,6 +3327,7 @@ static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip)
 		goto out_free;
 
 	chip->running = 1;
+	pm_runtime_get_noresume(&chip->pci->dev); /* active by default */
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
@@ -3303,6 +3342,13 @@ out_free:
 static void __devexit azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
+
+	/* undo 'get' in azx_probe_continue() */
+	pm_runtime_put_noidle(&pci->dev);
+
+	if (pci_dev_run_wake(pci))
+		pm_runtime_get_noresume(&pci->dev);
+
 	if (card)
 		snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
-- 
1.7.9.5
