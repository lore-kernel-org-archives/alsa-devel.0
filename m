From: mengdong.lin@intel.com
Subject: [PATCH v4 1/1] ALSA: hda - add runtime PM support
Date: Thu, 23 Aug 2012 17:17:16 +0800
Message-ID: <1345713436-2971-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2627E2661BB
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 11:17:38 +0200 (CEST)
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
And runtime PM can provide a gerneral sysfs interface for a system policy
manager.

Runtime PM support is based on current HDA power saving implementation. The user
can enable runtime PM on platfroms that provide acceptable latency on transition
from D3 to D0.

Details:
- When both power saving and runtime PM are enabled:
  -- If a codec supports 'stop-clock' in D3, it will request suspending the
     controller after it enters D3 and request resuming the controller before
     back to D0. Thus the controller will be suspended only when all codecs are
     suspended and support stop-clock in D3.
  -- User IO operations and HW wakeup signal can resume the controller back to
     D0.
- If runtime PM is disabled, power saving just works as before.
- If power saving is disabled, the controller won't be suspended because the
  power usage counter can never be 0.

More about 'stop-clock' feature:
If a codec can support targeted pass-through operations in D3 state when there
is no BCLK present on the link, it will set CLKSTOP flag in the supported power
states and report PS-ClkStopOk when entering D3 state. Please refer to HDA spec
section 7.3.3.10 Power state and 7.3.4.12 Supported Power State.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
 sound/pci/hda/hda_codec.c |   20 ++++++++++--
 sound/pci/hda/hda_codec.h |    5 ++-
 sound/pci/hda/hda_intel.c |   75 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 81 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index f2f5347..72e6328 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include <sound/asoundef.h>
@@ -1209,6 +1210,9 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	kfree(codec);
 }
 
+static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
+				hda_nid_t fg, unsigned int power_state);
+
 static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 				unsigned int power_state);
 
@@ -1317,6 +1321,12 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 					   AC_VERB_GET_SUBSYSTEM_ID, 0);
 	}
 
+	codec->d3_stop_clk = snd_hda_codec_get_supported_ps(codec,
+					codec->afg ? codec->afg : codec->mfg,
+					AC_PWRST_CLKSTOP);
+	if (!codec->d3_stop_clk)
+		bus->power_keep_link_on = 1;
+
 	/* power-up all before initialization */
 	hda_set_power_state(codec,
 			    codec->afg ? codec->afg : codec->mfg,
@@ -3514,6 +3524,8 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 	int count;
 	unsigned int state;
 
+	codec->d3_stop_clk_ok = 0;
+
 	if (codec->patch_ops.set_power_state) {
 		codec->patch_ops.set_power_state(codec, fg, power_state);
 		return;
@@ -3536,6 +3548,10 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 		if (!(state & AC_PWRST_ERROR))
 			break;
 	}
+
+	if ((power_state == AC_PWRST_D3)
+		&& codec->d3_stop_clk && (state & AC_PWRST_CLK_STOP_OK))
+		codec->d3_stop_clk_ok = 1;
 }
 
 #ifdef CONFIG_SND_HDA_HWDEP
@@ -4385,7 +4401,7 @@ static void hda_power_work(struct work_struct *work)
 
 	hda_call_codec_suspend(codec);
 	if (bus->ops.pm_notify)
-		bus->ops.pm_notify(bus);
+		bus->ops.pm_notify(bus, codec);
 }
 
 static void hda_keep_power_on(struct hda_codec *codec)
@@ -4440,7 +4456,7 @@ static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
 	spin_unlock(&codec->power_lock);
 
 	if (bus->ops.pm_notify)
-		bus->ops.pm_notify(bus);
+		bus->ops.pm_notify(bus, codec);
 	hda_call_codec_resume(codec);
 
 	spin_lock(&codec->power_lock);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index fe6206b..b384c721 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -612,7 +612,7 @@ struct hda_bus_ops {
 	void (*bus_reset)(struct hda_bus *bus);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	/* notify power-up/down from codec to controller */
-	void (*pm_notify)(struct hda_bus *bus);
+	void (*pm_notify)(struct hda_bus *bus, struct hda_codec *codec);
 #endif
 };
 
@@ -870,6 +870,9 @@ struct hda_codec {
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
 	spinlock_t power_lock;
+
+	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
+	unsigned int d3_stop_clk_ok:1; /* BCLK can stop */
 #endif
 
 	/* codec-specific additional proc output */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b6a4ea7..2baa3ee 100644
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
@@ -1022,7 +1023,7 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 }
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-static void azx_power_notify(struct hda_bus *bus);
+static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec);
 #endif
 
 /* reset codec link */
@@ -1278,6 +1279,9 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 	u8 sd_status;
 	int i, ok;
 
+	if (chip->pci->dev.power.runtime_status != RPM_ACTIVE)
+		return IRQ_NONE;
+
 	spin_lock(&chip->reg_lock);
 
 	if (chip->disabled) {
@@ -2390,23 +2394,17 @@ static void azx_stop_chip(struct azx *chip)
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 /* power-up/down the controller */
-static void azx_power_notify(struct hda_bus *bus)
+static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec)
 {
 	struct azx *chip = bus->private_data;
-	struct hda_codec *c;
-	int power_on = 0;
 
-	list_for_each_entry(c, &bus->codec_list, list) {
-		if (c->power_on) {
-			power_on = 1;
-			break;
-		}
-	}
-	if (power_on)
-		azx_init_chip(chip, 1);
-	else if (chip->running && power_save_controller &&
-		 !bus->power_keep_link_on)
-		azx_stop_chip(chip);
+	if (bus->power_keep_link_on || !codec->d3_stop_clk_ok)
+		return;
+
+	if (codec->power_on)
+		pm_runtime_get_sync(&chip->pci->dev);
+	else
+		pm_runtime_put_sync(&chip->pci->dev);
 }
 
 static DEFINE_MUTEX(card_list_lock);
@@ -2511,7 +2509,35 @@ static int azx_resume(struct device *dev)
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
+	if (!power_save_controller)
+		return -EAGAIN;
+
+	azx_stop_chip(chip);
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
+	azx_init_chip(chip, 1);
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
@@ -3201,6 +3227,15 @@ static void power_down_all_codecs(struct azx *chip)
 #endif
 }
 
+static void rpm_get_all_codecs(struct azx *chip)
+{
+	struct hda_codec *codec;
+
+	list_for_each_entry(codec, &chip->bus->codec_list, list) {
+		pm_runtime_get_noresume(&chip->pci->dev);
+	}
+}
+
 static int __devinit azx_probe(struct pci_dev *pci,
 			       const struct pci_device_id *pci_id)
 {
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
+	rpm_get_all_codecs(chip); /* all codecs are active */
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
@@ -3303,6 +3342,10 @@ out_free:
 static void __devexit azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
+
+	if (pci_dev_run_wake(pci))
+		pm_runtime_get_noresume(&pci->dev);
+
 	if (card)
 		snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
-- 
1.7.9.5
