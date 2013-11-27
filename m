From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - resume codecs in parallel
Date: Tue, 26 Nov 2013 23:32:23 -0500
Message-ID: <f41bb56ff9142ab400fca482bdefb5273ead0e93.1385526316.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A39D5261AA5
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 12:28:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

To reduce driver resume time, this patch resumes the codecs in parallel
if there are multiple codecs on the bus.

- The PM workqueue of bus is also used to parallel resuming multiple codecs.
- The work item 'pm_work' is renamed to 'suspend_work' to parallel suspending
  codecs.
- Add a work item 'resume_work' to parallel resuming codecs.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 60ff45a..1e04a20 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -104,7 +104,8 @@ static inline void hda_call_pm_notify(struct hda_bus *bus, bool power_up)
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus, power_up);
 }
-static void hda_pm_work(struct work_struct *work);
+static void hda_suspend_work(struct work_struct *work);
+static void hda_resume_work(struct work_struct *work);
 #else
 #define codec_in_pm(codec)	0
 static inline void hda_keep_power_on(struct hda_codec *codec) {}
@@ -1447,7 +1448,8 @@ int snd_hda_codec_new(struct hda_bus *bus,
 #ifdef CONFIG_PM
 	spin_lock_init(&codec->power_lock);
 	INIT_DELAYED_WORK(&codec->power_work, hda_power_work);
-	INIT_WORK(&codec->pm_work, hda_pm_work);
+	INIT_WORK(&codec->suspend_work, hda_suspend_work);
+	INIT_WORK(&codec->resume_work, hda_resume_work);
 	/* snd_hda_codec_new() marks the codec as power-up, and leave it as is.
 	 * the caller has to power down appropriatley after initialization
 	 * phase.
@@ -5058,13 +5060,21 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_HDA(snd_hda_check_amp_list_power);
 
-static void hda_pm_work(struct work_struct *work)
+static void hda_suspend_work(struct work_struct *work)
 {
 	struct hda_codec *codec =
-		container_of(work, struct hda_codec, pm_work);
+		container_of(work, struct hda_codec, suspend_work);
 
 	hda_call_codec_suspend(codec, false);
 }
+
+static void hda_resume_work(struct work_struct *work)
+{
+	struct hda_codec *codec =
+		container_of(work, struct hda_codec, resume_work);
+
+	hda_call_codec_resume(codec);
+}
 #endif
 
 /*
@@ -5633,7 +5643,7 @@ int snd_hda_suspend(struct hda_bus *bus)
 		cancel_delayed_work_sync(&codec->jackpoll_work);
 		if (hda_codec_is_power_on(codec)) {
 			if (bus->num_codecs > 1)
-				queue_work(bus->pm_wq, &codec->pm_work);
+				queue_work(bus->pm_wq, &codec->suspend_work);
 			else
 				hda_call_codec_suspend(codec, false);
 		}
@@ -5659,9 +5669,15 @@ int snd_hda_resume(struct hda_bus *bus)
 	printk("snd_hda_resume, pci device 0x%04x\n", bus->pci->device);
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
-		hda_call_codec_resume(codec);
+		if (bus->num_codecs > 1)
+			queue_work(bus->pm_wq, &codec->resume_work);
+		else
+			hda_call_codec_resume(codec);
 	}
 
+	if (bus->num_codecs > 1)
+		flush_workqueue(bus->pm_wq);
+
 	printk("snd_hda_resume ok, pci device 0x%04x\n", bus->pci->device);
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 82807ef..bedb436 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -920,7 +920,9 @@ struct hda_codec {
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
 	spinlock_t power_lock;
-	struct work_struct pm_work; /* task to parallel multi-codec PM */
+	/* tasks to parallel multi-codec suspend/resume */
+	struct work_struct suspend_work;
+	struct work_struct resume_work;
 #endif
 
 	/* filter the requested power state per nid */
-- 
1.8.1.2
