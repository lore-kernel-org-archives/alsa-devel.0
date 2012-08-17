From: mengdong.lin@intel.com
Subject: [RFC PATCH] ALSA: hda - add support for runtime power
	management
Date: Fri, 17 Aug 2012 17:30:14 +0800
Message-ID: <1345195814-2287-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D85B2652D1
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 11:00:38 +0200 (CEST)
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

This patch is a basic idea about adding runtime PM support to HD audio.

Support for runtime PM is based on current HDA power saving implementation.
When both power saving and runtime PM are enabled, and if all codecs are
suspended (in D3), the HDA controller can also be suspended to a low power
state by decreasing the power usage counter and triggering PCI device
runtime suspend. And the user IO operation can resume the controller back
to D0.

The user can enable runtime PM on HDA controller on platfroms that can
provide acceptable latency on transition from D3 to D0. If the runtime PM
is disabled, power saving just works as without runtime PM before. And
if power saving is disabled, the power usage counter will never be 0 so
the HDA controller will not be suspended.

I've verified this patch on a platfrom on which the HD-A controller can enter
D3hot when suspended. And I plan to allow the controller to suspened only
if all codecs support "stop-clock" in D3, for wakeup request.

Is this idea doable? Any comments are welcome.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
 sound/pci/hda/hda_codec.c |    1 +
 sound/pci/hda/hda_intel.c |   70 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index f2f5347..c88a95e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4383,6 +4383,7 @@ static void hda_power_work(struct work_struct *work)
 	}
 	spin_unlock(&codec->power_lock);
 
+	snd_printd("hda codec %d suspend\n", codec->addr);
 	hda_call_codec_suspend(codec);
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b6a4ea7..543a5c4 100644
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
@@ -2402,11 +2403,22 @@ static void azx_power_notify(struct hda_bus *bus)
 			break;
 		}
 	}
-	if (power_on)
+	if (power_on) {
+		if (!chip->initialized) {
+			snd_printd(SFX "request resume controller\n");
+			pm_runtime_get_sync(&chip->pci->dev);
+		}
 		azx_init_chip(chip, 1);
+	}
 	else if (chip->running && power_save_controller &&
-		 !bus->power_keep_link_on)
+		 !bus->power_keep_link_on) {
 		azx_stop_chip(chip);
+
+		/* TODO: Suspend controller only if all codec support
+		stop-clock in D3, for wakeup consideration */
+		snd_printd(SFX "request suspend controller\n");
+		pm_runtime_put_sync(&chip->pci->dev);
+	}
 }
 
 static DEFINE_MUTEX(card_list_lock);
@@ -2511,7 +2523,48 @@ static int azx_resume(struct device *dev)
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
-static SIMPLE_DEV_PM_OPS(azx_pm, azx_suspend, azx_resume);
+
+static int azx_runtime_suspend(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct azx_pcm *p;
+
+	snd_printd(SFX "controller runtime suspend\n");
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	azx_clear_irq_pending(chip);
+	list_for_each_entry(p, &chip->pcm_list, list)
+		snd_pcm_suspend_all(p->pcm);
+
+	if (chip->irq >= 0) {
+		free_irq(chip->irq, chip);
+		chip->irq = -1;
+	}
+	return 0;
+}
+
+static int azx_runtime_resume(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+
+	snd_printd(SFX "controller runtime resume\n");
+
+	if (azx_acquire_irq(chip, 1) < 0)
+		return -EIO;
+
+	azx_init_pci(chip);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
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
@@ -3238,6 +3291,9 @@ static int __devinit azx_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(pci, card);
 
+	if (pci_dev_run_wake(pci))
+		pm_runtime_put_noidle(&pci->dev);
+
 	dev++;
 	return 0;
 
@@ -3289,6 +3345,7 @@ static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip)
 		goto out_free;
 
 	chip->running = 1;
+	pm_runtime_get_noresume(&chip->pci->dev); /* active by default */
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
@@ -3303,6 +3360,13 @@ out_free:
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
