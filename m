From: mengdong.lin@intel.com
Subject: [PATCH v2] ALSA: hda - suspend codecs in parallel
Date: Tue, 26 Nov 2013 01:43:32 -0500
Message-ID: <80986b9a2c4a68e7d537a3c3010cdecda1f8f9fc.1385446616.git.mengdong.lin@intel.com>
References: <66cb89707dd2109e0cfa2f80561eb25f7bbd686d.1385350212.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EFD2A26030E
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 14:40:05 +0100 (CET)
In-Reply-To: <66cb89707dd2109e0cfa2f80561eb25f7bbd686d.1385350212.git.mengdong.lin@intel.com>
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

The time to suspend a single codec may be several hundreds of ms. When runtime
power saving is disabled, driver suspend time can be long especially when there
are more than one codec on the bus.

To reduce driver suspend time, this patch creates a work queue for the bus, and
suspends the codecs in parallel if there are multiple codecs on the bus.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index cb0c776..8d4190e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -104,6 +104,7 @@ static inline void hda_call_pm_notify(struct hda_bus *bus, bool power_up)
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus, power_up);
 }
+static void hda_pm_work(struct work_struct *work);
 #else
 #define codec_in_pm(codec)	0
 static inline void hda_keep_power_on(struct hda_codec *codec) {}
@@ -831,6 +832,12 @@ static int snd_hda_bus_free(struct hda_bus *bus)
 		bus->ops.private_free(bus);
 	if (bus->workq)
 		destroy_workqueue(bus->workq);
+
+#ifdef CONFIG_PM
+	if (bus->pm_wq)
+		destroy_workqueue(bus->pm_wq);
+#endif
+
 	kfree(bus);
 	return 0;
 }
@@ -911,6 +918,16 @@ int snd_hda_bus_new(struct snd_card *card,
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_PM
+	bus->pm_wq = create_workqueue("hda-pm-workq");
+	if (!bus->pm_wq) {
+		snd_printk(KERN_ERR "cannot create PM workqueue\n");
+		snd_hda_bus_free(bus);
+		return -ENOMEM;
+	}
+	workqueue_set_max_active(bus->pm_wq, HDA_MAX_NUM_CODECS);
+#endif
+
 	err = snd_device_new(card, SNDRV_DEV_BUS, bus, &dev_ops);
 	if (err < 0) {
 		snd_hda_bus_free(bus);
@@ -1434,6 +1451,8 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	 */
 	hda_keep_power_on(codec);
 	hda_call_pm_notify(bus, true);
+
+	INIT_WORK(&codec->pm_work, hda_pm_work);
 #endif
 
 	if (codec->bus->modelname) {
@@ -1445,6 +1464,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	}
 
 	list_add_tail(&codec->list, &bus->codec_list);
+	bus->num_codecs++;
 	bus->caddr_tbl[codec_addr] = codec;
 
 	codec->vendor_id = snd_hda_param_read(codec, AC_NODE_ROOT,
@@ -5032,6 +5052,14 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_check_amp_list_power);
+
+static void hda_pm_work(struct work_struct *work)
+{
+	struct hda_codec *codec =
+		container_of(work, struct hda_codec, pm_work);
+
+	hda_call_codec_suspend(codec, false);
+}
 #endif
 
 /*
@@ -5595,11 +5623,27 @@ EXPORT_SYMBOL_HDA(snd_hda_add_imux_item);
 int snd_hda_suspend(struct hda_bus *bus)
 {
 	struct hda_codec *codec;
+	unsigned int mask = 0;
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
 		cancel_delayed_work_sync(&codec->jackpoll_work);
-		if (hda_codec_is_power_on(codec))
-			hda_call_codec_suspend(codec, false);
+		if (hda_codec_is_power_on(codec)) {
+			if (bus->num_codecs == 1)
+				hda_call_codec_suspend(codec, false);
+			else {
+				mask |= 1 << codec->addr;
+				queue_work(bus->pm_wq, &codec->pm_work);
+			}
+		}
+	}
+
+	if (!mask)
+		return 0;
+
+	list_for_each_entry(codec, &bus->codec_list, list) {
+		if (mask & (1 << codec->addr))
+			flush_work(&codec->pm_work);
+
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 7aa9870..e1de3df 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -571,6 +571,7 @@ enum {
 
 /* max. codec address */
 #define HDA_MAX_CODEC_ADDRESS	0x0f
+#define HDA_MAX_NUM_CODECS	15
 
 /*
  * generic arrays
@@ -673,6 +674,7 @@ struct hda_bus {
 
 	/* codec linked list */
 	struct list_head codec_list;
+	unsigned int num_codecs;
 	/* link caddr -> codec */
 	struct hda_codec *caddr_tbl[HDA_MAX_CODEC_ADDRESS + 1];
 
@@ -683,6 +685,9 @@ struct hda_bus {
 	struct hda_bus_unsolicited *unsol;
 	char workq_name[16];
 	struct workqueue_struct *workq;	/* common workqueue for codecs */
+#ifdef CONFIG_PM
+	struct workqueue_struct *pm_wq;	/* workqueue to parallel codec PM */
+#endif
 
 	/* assigned PCMs */
 	DECLARE_BITMAP(pcm_dev_bits, SNDRV_PCM_DEVICES);
@@ -916,6 +921,7 @@ struct hda_codec {
 	unsigned long power_off_acct;
 	unsigned long power_jiffies;
 	spinlock_t power_lock;
+	struct work_struct pm_work; /* task to parallel multi-codec PM */
 #endif
 
 	/* filter the requested power state per nid */
-- 
1.8.1.2
