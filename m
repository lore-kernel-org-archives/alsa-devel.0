From: mengdong.lin@intel.com
Subject: [PATCH v3 2/2] [ALSA] hda - suspend the controller
	only if all codecs support stop-clk in D3
Date: Wed, 22 Aug 2012 18:46:43 +0800
Message-ID: <1345632404-5629-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FF32660EA
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 12:46:39 +0200 (CEST)
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

If a codec can support targeted pass-through operations in D3 state when there
is no BCLK present on the link, it will set CLKSTOP flag in the supported power
states and report PS-ClkStopOk when entering D3 state.

So only if a codec supports this stop-clock feature, it will request suspending
the controller after it enters D3 and requst resuming the controller before back
to D0. Thus the controller will be suspended only when all codecs are suspended
and support stop-clock in D3.

Please refer to HDA spec section 7.3.3.10 Power state and 7.3.4.12 Supported
Power States.

Details:
- azx_power_notify() add 'codec' as 2nd parameter to check its stop-clock flag.
- each codec count 1 on the controller's power usage counter, and inc/dec the
  count independently from each other.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
 sound/pci/hda/hda_codec.c |   23 +++++++++++++++++++++--
 sound/pci/hda/hda_codec.h |    5 ++++-
 sound/pci/hda/hda_intel.c |   25 +++++++++++--------------
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index f2f5347..5d09662 100644
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
@@ -1206,9 +1207,14 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	kfree(codec->chip_name);
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
+	/* undo get in snd_hda_codec_new() */
+	pm_runtime_put_noidle(&codec->bus->pci->dev);
 	kfree(codec);
 }
 
+static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
+				hda_nid_t fg, unsigned int power_state);
+
 static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 				unsigned int power_state);
 
@@ -1317,10 +1323,17 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
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
 			    AC_PWRST_D0);
+	pm_runtime_get_noresume(&bus->pci->dev); /* active by default */
 
 	snd_hda_codec_proc_new(codec);
 
@@ -3514,6 +3527,8 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 	int count;
 	unsigned int state;
 
+	codec->d3_stop_clk_ok = 0;
+
 	if (codec->patch_ops.set_power_state) {
 		codec->patch_ops.set_power_state(codec, fg, power_state);
 		return;
@@ -3536,6 +3551,10 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 		if (!(state & AC_PWRST_ERROR))
 			break;
 	}
+
+	if ((power_state == AC_PWRST_D3)
+		&& codec->d3_stop_clk && (state & AC_PWRST_CLK_STOP_OK))
+		codec->d3_stop_clk_ok = 1;
 }
 
 #ifdef CONFIG_SND_HDA_HWDEP
@@ -4385,7 +4404,7 @@ static void hda_power_work(struct work_struct *work)
 
 	hda_call_codec_suspend(codec);
 	if (bus->ops.pm_notify)
-		bus->ops.pm_notify(bus);
+		bus->ops.pm_notify(bus, codec);
 }
 
 static void hda_keep_power_on(struct hda_codec *codec)
@@ -4440,7 +4459,7 @@ static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
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
index 4c30fd7..16f037c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1023,7 +1023,7 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 }
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-static void azx_power_notify(struct hda_bus *bus);
+static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec);
 #endif
 
 /* reset codec link */
@@ -2394,7 +2394,7 @@ static void azx_stop_chip(struct azx *chip)
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 /* power-up/down the controller */
-static void azx_power_notify(struct hda_bus *bus)
+static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec)
 {
 	struct azx *chip = bus->private_data;
 	struct hda_codec *c;
@@ -2406,19 +2406,20 @@ static void azx_power_notify(struct hda_bus *bus)
 			break;
 		}
 	}
-	if (power_on) {
-		if (!chip->initialized)
-			pm_runtime_get_sync(&chip->pci->dev);
+
+	if (!bus->power_keep_link_on
+		&& codec->power_on && codec->d3_stop_clk_ok)
+		pm_runtime_get_sync(&chip->pci->dev);
+
+	if (power_on)
 		azx_init_chip(chip, 1);
-	}
 	else if (chip->running && power_save_controller &&
-		 !bus->power_keep_link_on) {
+		 !bus->power_keep_link_on)
 		azx_stop_chip(chip);
 
-		/* TODO: Suspend controller only if all codec support
-		stop-clock in D3, for wakeup consideration */
+	if (!bus->power_keep_link_on
+		&& !codec->power_on && codec->d3_stop_clk_ok)
 		pm_runtime_put_sync(&chip->pci->dev);
-	}
 }
 
 static DEFINE_MUTEX(card_list_lock);
@@ -3327,7 +3328,6 @@ static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip)
 		goto out_free;
 
 	chip->running = 1;
-	pm_runtime_get_noresume(&chip->pci->dev); /* active by default */
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
@@ -3343,9 +3343,6 @@ static void __devexit azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 
-	/* undo 'get' in azx_probe_continue() */
-	pm_runtime_put_noidle(&pci->dev);
-
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 
-- 
1.7.9.5
