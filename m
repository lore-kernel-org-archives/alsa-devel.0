From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/10] ALSA: hda - Use standard runtime PM for
	codec power-save control
Date: Thu, 26 Feb 2015 18:00:19 +0100
Message-ID: <1424970025-8082-5-git-send-email-tiwai@suse.de>
References: <1424970025-8082-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B4818261B33
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 18:00:31 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 70BFEADCF
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

Like the previous transition of suspend/resume, now move the
power-save code to the standard runtime PM.  As usual for runtime PM,
it's a bit tricky, but this simplified codes a lot in the end.

For keeping the usage compatibility, power_save module option still
controls the whole power-saving behavior on all codecs.  The value is
translated to pm_runtime_*_autosuspend() and pm_runtime_allow() /
pm_runtime_forbid() calls.

snd_hda_power_up() and snd_hda_power_down() are translated to
pm_runtime_get_sync() and pm_runtime_put_autosuspend(), respectively.
Since we can do call pm_runtime_get_sync() more reliably, the sync
version is used always and snd_hda_power_up_d3wait() is dropped.
Another slight difference is that snd_hda_power_up()/down() don't call
runtime_pm code during the suspend/resume transition phase.  Calling
them there isn't safe unlike our own code, resulted in unexpected
behavior (endless wakeups).

The hda_power_count tracepoint was removed, as it doesn't match well
with the new code.

Last but not least, we need to set ignore_children flag in the parent
dev.power field so that the runtime PM of the controller chip won't
get confused.  The notification is still done in the bus pm_notify
callback.  We'll get rid of this hack in the later patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 241 ++++++++++++++++-------------------------
 sound/pci/hda/hda_codec.h      |  67 ++----------
 sound/pci/hda/hda_controller.c |   2 +-
 sound/pci/hda/hda_intel.c      |   2 +
 sound/pci/hda/hda_trace.h      |  24 ----
 5 files changed, 106 insertions(+), 230 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3d6ff60e6c14..d0dbc62c9147 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -26,6 +26,8 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/async.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include <sound/asoundef.h>
@@ -41,10 +43,9 @@
 #include "hda_trace.h"
 
 #ifdef CONFIG_PM
-#define codec_in_pm(codec)	((codec)->in_pm)
-static void hda_power_work(struct work_struct *work);
-static void hda_keep_power_on(struct hda_codec *codec);
-#define hda_codec_is_power_on(codec)	((codec)->power_on)
+#define codec_in_pm(codec)	atomic_read(&(codec)->in_pm)
+#define hda_codec_is_power_on(codec) \
+	(!pm_runtime_suspended(hda_codec_dev(codec)))
 
 static void hda_call_pm_notify(struct hda_codec *codec, bool power_up)
 {
@@ -60,7 +61,6 @@ static void hda_call_pm_notify(struct hda_codec *codec, bool power_up)
 
 #else
 #define codec_in_pm(codec)	0
-static inline void hda_keep_power_on(struct hda_codec *codec) {}
 #define hda_codec_is_power_on(codec)	1
 #define hda_call_pm_notify(codec, state) {}
 #endif
@@ -1144,10 +1144,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 		device_del(hda_codec_dev(codec));
 	snd_hda_jack_tbl_clear(codec);
 	free_init_pincfgs(codec);
-#ifdef CONFIG_PM
-	cancel_delayed_work(&codec->power_work);
 	flush_workqueue(codec->bus->workq);
-#endif
 	list_del(&codec->list);
 	snd_array_free(&codec->mixers);
 	snd_array_free(&codec->nids);
@@ -1178,6 +1175,10 @@ static int snd_hda_codec_dev_register(struct snd_device *device)
 	struct hda_codec *codec = device->device_data;
 
 	snd_hda_register_beep_device(codec);
+	if (device_is_registered(hda_codec_dev(codec))) {
+		snd_hda_power_sync(codec);
+		pm_runtime_enable(hda_codec_dev(codec));
+	}
 	return 0;
 }
 
@@ -1274,13 +1275,14 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	codec->fixup_id = HDA_FIXUP_ID_NOT_SET;
 
 #ifdef CONFIG_PM
-	spin_lock_init(&codec->power_lock);
-	INIT_DELAYED_WORK(&codec->power_work, hda_power_work);
 	/* snd_hda_codec_new() marks the codec as power-up, and leave it as is.
 	 * the caller has to power down appropriatley after initialization
 	 * phase.
 	 */
-	hda_keep_power_on(codec);
+	pm_runtime_set_active(hda_codec_dev(codec));
+	pm_runtime_get_noresume(hda_codec_dev(codec));
+	codec->power_jiffies = jiffies;
+	hda_call_pm_notify(codec, true);
 #endif
 
 	snd_hda_sysfs_init(codec);
@@ -2453,10 +2455,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 
 	/* OK, let it free */
 	cancel_delayed_work_sync(&codec->jackpoll_work);
-#ifdef CONFIG_PM
-	cancel_delayed_work_sync(&codec->power_work);
 	flush_workqueue(bus->workq);
-#endif
 	snd_hda_ctls_clear(codec);
 	/* release PCMs */
 	for (i = 0; i < codec->num_pcms; i++) {
@@ -3893,31 +3892,40 @@ static inline void hda_exec_init_verbs(struct hda_codec *codec) {}
 #endif
 
 #ifdef CONFIG_PM
+/* update the power on/off account with the current jiffies */
+static void update_power_acct(struct hda_codec *codec, bool on)
+{
+	unsigned long delta = jiffies - codec->power_jiffies;
+
+	if (on)
+		codec->power_on_acct += delta;
+	else
+		codec->power_off_acct += delta;
+	codec->power_jiffies += delta;
+}
+
+void snd_hda_update_power_acct(struct hda_codec *codec)
+{
+	update_power_acct(codec, hda_codec_is_power_on(codec));
+}
+
 /*
  * call suspend and power-down; used both from PM and power-save
  * this function returns the power state in the end
  */
-static unsigned int hda_call_codec_suspend(struct hda_codec *codec, bool in_wq)
+static unsigned int hda_call_codec_suspend(struct hda_codec *codec)
 {
 	unsigned int state;
 
-	codec->in_pm = 1;
+	atomic_inc(&codec->in_pm);
 
 	if (codec->patch_ops.suspend)
 		codec->patch_ops.suspend(codec);
 	hda_cleanup_all_streams(codec);
 	state = hda_set_power_state(codec, AC_PWRST_D3);
-	/* Cancel delayed work if we aren't currently running from it. */
-	if (!in_wq)
-		cancel_delayed_work_sync(&codec->power_work);
-	spin_lock(&codec->power_lock);
-	snd_hda_update_power_acct(codec);
 	trace_hda_power_down(codec);
-	codec->power_on = 0;
-	codec->power_transition = 0;
-	codec->power_jiffies = jiffies;
-	spin_unlock(&codec->power_lock);
-	codec->in_pm = 0;
+	update_power_acct(codec, true);
+	atomic_dec(&codec->in_pm);
 	return state;
 }
 
@@ -3942,14 +3950,14 @@ static void hda_mark_cmd_cache_dirty(struct hda_codec *codec)
  */
 static void hda_call_codec_resume(struct hda_codec *codec)
 {
-	codec->in_pm = 1;
+	atomic_inc(&codec->in_pm);
 
+	trace_hda_power_up(codec);
 	hda_mark_cmd_cache_dirty(codec);
 
-	/* set as if powered on for avoiding re-entering the resume
-	 * in the resume / power-save sequence
-	 */
-	hda_keep_power_on(codec);
+	codec->power_jiffies = jiffies;
+	hda_call_pm_notify(codec, true);
+
 	hda_set_power_state(codec, AC_PWRST_D0);
 	restore_shutup_pins(codec);
 	hda_exec_init_verbs(codec);
@@ -3967,34 +3975,38 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		hda_jackpoll_work(&codec->jackpoll_work.work);
 	else
 		snd_hda_jack_report_sync(codec);
-
-	codec->in_pm = 0;
-	snd_hda_power_down(codec); /* flag down before returning */
+	atomic_dec(&codec->in_pm);
 }
 
-static int hda_codec_driver_suspend(struct device *dev)
+static int hda_codec_runtime_suspend(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
+	unsigned int state;
 	int i;
 
 	cancel_delayed_work_sync(&codec->jackpoll_work);
 	for (i = 0; i < codec->num_pcms; i++)
 		snd_pcm_suspend_all(codec->pcm_info[i].pcm);
-	hda_call_codec_suspend(codec, false);
+	state = hda_call_codec_suspend(codec);
+	if (!codec->bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK))
+		hda_call_pm_notify(codec, false);
 	return 0;
 }
 
-static int hda_codec_driver_resume(struct device *dev)
+static int hda_codec_runtime_resume(struct device *dev)
 {
 	hda_call_codec_resume(dev_to_hda_codec(dev));
+	pm_runtime_mark_last_busy(dev);
 	return 0;
 }
 #endif /* CONFIG_PM */
 
 /* referred in hda_bind.c */
 const struct dev_pm_ops hda_codec_driver_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(hda_codec_driver_suspend,
-				hda_codec_driver_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(hda_codec_runtime_suspend, hda_codec_runtime_resume,
+			   NULL)
 };
 
 /**
@@ -4733,127 +4745,66 @@ int snd_hda_add_new_ctls(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_add_new_ctls);
 
 #ifdef CONFIG_PM
-static void hda_power_work(struct work_struct *work)
+/**
+ * snd_hda_power_up - Power-up the codec
+ * @codec: HD-audio codec
+ *
+ * Increment the usage counter and resume the device if not done yet.
+ */
+void snd_hda_power_up(struct hda_codec *codec)
 {
-	struct hda_codec *codec =
-		container_of(work, struct hda_codec, power_work.work);
-	struct hda_bus *bus = codec->bus;
-	unsigned int state;
+	struct device *dev = hda_codec_dev(codec);
 
-	spin_lock(&codec->power_lock);
-	if (codec->power_transition > 0) { /* during power-up sequence? */
-		spin_unlock(&codec->power_lock);
+	if (codec_in_pm(codec))
 		return;
-	}
-	if (!codec->power_on || codec->power_count) {
-		codec->power_transition = 0;
-		spin_unlock(&codec->power_lock);
-		return;
-	}
-	spin_unlock(&codec->power_lock);
-
-	state = hda_call_codec_suspend(codec, true);
-	if (!bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK))
-		hda_call_pm_notify(codec, false);
+	pm_runtime_get_sync(dev);
 }
+EXPORT_SYMBOL_GPL(snd_hda_power_up);
 
-static void hda_keep_power_on(struct hda_codec *codec)
+/**
+ * snd_hda_power_down - Power-down the codec
+ * @codec: HD-audio codec
+ *
+ * Decrement the usage counter and schedules the autosuspend if none used.
+ */
+void snd_hda_power_down(struct hda_codec *codec)
 {
-	spin_lock(&codec->power_lock);
-	codec->power_count++;
-	codec->power_on = 1;
-	codec->power_jiffies = jiffies;
-	spin_unlock(&codec->power_lock);
-	hda_call_pm_notify(codec, true);
-}
+	struct device *dev = hda_codec_dev(codec);
 
-/* update the power on/off account with the current jiffies */
-void snd_hda_update_power_acct(struct hda_codec *codec)
-{
-	unsigned long delta = jiffies - codec->power_jiffies;
-	if (codec->power_on)
-		codec->power_on_acct += delta;
-	else
-		codec->power_off_acct += delta;
-	codec->power_jiffies += delta;
-}
-
-/* Transition to powered up, if wait_power_down then wait for a pending
- * transition to D3 to complete. A pending D3 transition is indicated
- * with power_transition == -1. */
-/* call this with codec->power_lock held! */
-static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
-{
-	/* Return if power_on or transitioning to power_on, unless currently
-	 * powering down. */
-	if ((codec->power_on || codec->power_transition > 0) &&
-	    !(wait_power_down && codec->power_transition < 0))
+	if (codec_in_pm(codec))
 		return;
-	spin_unlock(&codec->power_lock);
-
-	cancel_delayed_work_sync(&codec->power_work);
-
-	spin_lock(&codec->power_lock);
-	/* If the power down delayed work was cancelled above before starting,
-	 * then there is no need to go through power up here.
-	 */
-	if (codec->power_on) {
-		if (codec->power_transition < 0)
-			codec->power_transition = 0;
-		return;
-	}
-
-	trace_hda_power_up(codec);
-	snd_hda_update_power_acct(codec);
-	codec->power_on = 1;
-	codec->power_jiffies = jiffies;
-	codec->power_transition = 1; /* avoid reentrance */
-	spin_unlock(&codec->power_lock);
-
-	hda_call_codec_resume(codec);
-
-	spin_lock(&codec->power_lock);
-	codec->power_transition = 0;
-}
-
-#define power_save(codec)	\
-	((codec)->bus->power_save ? *(codec)->bus->power_save : 0)
-
-/* Transition to powered down */
-static void __snd_hda_power_down(struct hda_codec *codec)
-{
-	if (!codec->power_on || codec->power_count || codec->power_transition)
-		return;
-
-	if (power_save(codec)) {
-		codec->power_transition = -1; /* avoid reentrance */
-		queue_delayed_work(codec->bus->workq, &codec->power_work,
-				msecs_to_jiffies(power_save(codec) * 1000));
-	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
+EXPORT_SYMBOL_GPL(snd_hda_power_down);
 
 /**
- * snd_hda_power_save - Power-up/down/sync the codec
+ * snd_hda_power_sync - Synchronize the power_save option
  * @codec: HD-audio codec
- * @delta: the counter delta to change
- * @d3wait: sync for D3 transition complete
  *
- * Change the power-up counter via @delta, and power up or down the hardware
- * appropriately.  For the power-down, queue to the delayed action.
- * Passing zero to @delta means to synchronize the power state.
+ * Synchronize the runtime PM autosuspend state from the power_save option.
  */
-void snd_hda_power_save(struct hda_codec *codec, int delta, bool d3wait)
+void snd_hda_power_sync(struct hda_codec *codec)
 {
-	spin_lock(&codec->power_lock);
-	codec->power_count += delta;
-	trace_hda_power_count(codec);
-	if (delta > 0)
-		__snd_hda_power_up(codec, d3wait);
-	else
-		__snd_hda_power_down(codec);
-	spin_unlock(&codec->power_lock);
+	struct device *dev = hda_codec_dev(codec);
+	int delay;
+
+	if (!codec->bus->power_save)
+		return;
+
+	delay = *codec->bus->power_save * 1000;
+	if (delay > 0) {
+		pm_runtime_set_autosuspend_delay(dev, delay);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_allow(dev);
+		if (!pm_runtime_suspended(dev))
+			pm_runtime_mark_last_busy(dev);
+	} else {
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_forbid(dev);
+	}
 }
-EXPORT_SYMBOL_GPL(snd_hda_power_save);
+EXPORT_SYMBOL_GPL(snd_hda_power_sync);
 
 /**
  * snd_hda_check_amp_list_power - Check the amp list and update the power
@@ -5542,7 +5493,7 @@ void snd_hda_bus_reset(struct hda_bus *bus)
 		cancel_delayed_work_sync(&codec->jackpoll_work);
 #ifdef CONFIG_PM
 		if (hda_codec_is_power_on(codec)) {
-			hda_call_codec_suspend(codec, false);
+			hda_call_codec_suspend(codec);
 			hda_call_codec_resume(codec);
 		}
 #endif
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 1fa3dd9baf52..593956fc384b 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -372,17 +372,12 @@ struct hda_codec {
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 #ifdef CONFIG_PM
-	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	unsigned int pm_up_notified:1;	/* PM notified to controller */
-	unsigned int in_pm:1;		/* suspend/resume being performed */
-	int power_transition;	/* power-state in transition */
-	int power_count;	/* current (global) power refcount */
-	struct delayed_work power_work; /* delayed task for powerdown */
+	atomic_t in_pm;		/* suspend/resume being performed */
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
-	spinlock_t power_lock;
 #endif
 
 	/* filter the requested power state per nid */
@@ -595,64 +590,16 @@ const char *snd_hda_get_jack_location(u32 cfg);
  * power saving
  */
 #ifdef CONFIG_PM
-void snd_hda_power_save(struct hda_codec *codec, int delta, bool d3wait);
+void snd_hda_power_up(struct hda_codec *codec);
+void snd_hda_power_down(struct hda_codec *codec);
+void snd_hda_power_sync(struct hda_codec *codec);
 void snd_hda_update_power_acct(struct hda_codec *codec);
 #else
-static inline void snd_hda_power_save(struct hda_codec *codec, int delta,
-				      bool d3wait) {}
+static inline void snd_hda_power_up(struct hda_codec *codec) {}
+static inline void snd_hda_power_down(struct hda_codec *codec) {}
+static inline void snd_hda_power_sync(struct hda_codec *codec) {}
 #endif
 
-/**
- * snd_hda_power_up - Power-up the codec
- * @codec: HD-audio codec
- *
- * Increment the power-up counter and power up the hardware really when
- * not turned on yet.
- */
-static inline void snd_hda_power_up(struct hda_codec *codec)
-{
-	snd_hda_power_save(codec, 1, false);
-}
-
-/**
- * snd_hda_power_up_d3wait - Power-up the codec after waiting for any pending
- *   D3 transition to complete.  This differs from snd_hda_power_up() when
- *   power_transition == -1.  snd_hda_power_up sees this case as a nop,
- *   snd_hda_power_up_d3wait waits for the D3 transition to complete then powers
- *   back up.
- * @codec: HD-audio codec
- *
- * Cancel any power down operation hapenning on the work queue, then power up.
- */
-static inline void snd_hda_power_up_d3wait(struct hda_codec *codec)
-{
-	snd_hda_power_save(codec, 1, true);
-}
-
-/**
- * snd_hda_power_down - Power-down the codec
- * @codec: HD-audio codec
- *
- * Decrement the power-up counter and schedules the power-off work if
- * the counter rearches to zero.
- */
-static inline void snd_hda_power_down(struct hda_codec *codec)
-{
-	snd_hda_power_save(codec, -1, false);
-}
-
-/**
- * snd_hda_power_sync - Synchronize the power-save status
- * @codec: HD-audio codec
- *
- * Synchronize the actual power state with the power account;
- * called when power_save parameter is changed
- */
-static inline void snd_hda_power_sync(struct hda_codec *codec)
-{
-	snd_hda_power_save(codec, 0, false);
-}
-
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 /*
  * patch firmware
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 30ddb751806a..522c54f94740 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -836,7 +836,7 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 				   buff_step);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   buff_step);
-	snd_hda_power_up_d3wait(apcm->codec);
+	snd_hda_power_up(apcm->codec);
 	err = hinfo->ops.open(hinfo, apcm->codec, substream);
 	if (err < 0) {
 		azx_release_device(azx_dev);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9db1b078801f..26510e60cbe2 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1087,6 +1087,7 @@ static int azx_free(struct azx *chip)
 		azx_stop_chip(chip);
 	}
 
+	pci->dev.power.ignore_children = 0; /* FIXME */
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void*)chip);
 	if (chip->msi)
@@ -1796,6 +1797,7 @@ static int azx_probe(struct pci_dev *pci,
 		return err;
 	}
 
+	pci->dev.power.ignore_children = 1; /* FIXME */
 	err = azx_create(card, pci, dev, pci_id->driver_data,
 			 &pci_hda_ops, &chip);
 	if (err < 0)
diff --git a/sound/pci/hda/hda_trace.h b/sound/pci/hda/hda_trace.h
index 3a1c63161eb1..c0e1c7d24dbe 100644
--- a/sound/pci/hda/hda_trace.h
+++ b/sound/pci/hda/hda_trace.h
@@ -87,30 +87,6 @@ DEFINE_EVENT(hda_power, hda_power_up,
 	TP_PROTO(struct hda_codec *codec),
 	TP_ARGS(codec)
 );
-
-TRACE_EVENT(hda_power_count,
-	TP_PROTO(struct hda_codec *codec),
-	TP_ARGS(codec),
-	TP_STRUCT__entry(
-		__field( unsigned int, card )
-		__field( unsigned int, addr )
-		__field( int, power_count )
-		__field( int, power_on )
-		__field( int, power_transition )
-	),
-
-	TP_fast_assign(
-		__entry->card = (codec)->bus->card->number;
-		__entry->addr = (codec)->addr;
-		__entry->power_count = (codec)->power_count;
-		__entry->power_on = (codec)->power_on;
-		__entry->power_transition = (codec)->power_transition;
-	),
-
-	TP_printk("[%d:%d] power_count=%d, power_on=%d, power_transition=%d",
-		  __entry->card, __entry->addr, __entry->power_count,
-		  __entry->power_on, __entry->power_transition)
-);
 #endif /* CONFIG_PM */
 
 TRACE_EVENT(hda_unsol_event,
-- 
2.3.0
