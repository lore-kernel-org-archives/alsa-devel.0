From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: hda - Move some codes up to hdac_bus
	struct
Date: Wed, 18 Mar 2015 16:16:32 +0100
Message-ID: <1426691797-17178-3-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DA69D26510C
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ABBFDAD03
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 15:16:40 +0000 (UTC)
In-Reply-To: <1426691797-17178-1-git-send-email-tiwai@suse.de>
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

A few basic codes for communicating over HD-audio bus are moved to
struct hdac_bus now.  It has only command and get_response ops in
addition to the unsolicited event handling.

Note that the codec-side tracing support is disabled temporarily
during this transition due to the code shuffling.  It will be
re-enabled later once when all pieces are settled down.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h        |  61 +++++++++++++
 sound/hda/Makefile             |   2 +-
 sound/hda/hdac_bus.c           | 181 ++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_bind.c       |  10 +++
 sound/pci/hda/hda_codec.c      | 191 ++++++++++++++---------------------------
 sound/pci/hda/hda_codec.h      |  34 +++-----
 sound/pci/hda/hda_controller.c |   8 +-
 sound/pci/hda/hda_intel.c      |   4 +-
 sound/pci/hda/hda_sysfs.c      |   2 +-
 sound/pci/hda/patch_conexant.c |   4 +-
 10 files changed, 335 insertions(+), 162 deletions(-)
 create mode 100644 sound/hda/hdac_bus.c

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 2381509bee9f..848ab6e68099 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -6,6 +6,11 @@
 #define __SOUND_HDAUDIO_H
 
 #include <linux/device.h>
+#include <sound/hda_verbs.h>
+
+struct hdac_bus;
+struct hdac_device;
+struct hdac_driver;
 
 /*
  * exported bus type
@@ -18,6 +23,9 @@ extern struct bus_type snd_hda_bus_type;
 struct hdac_device {
 	struct device dev;
 	int type;
+	struct hdac_bus *bus;
+	unsigned int addr;		/* codec address */
+	struct list_head list;		/* list point for bus codec_list */
 };
 
 /* device/driver type used for matching */
@@ -35,8 +43,61 @@ struct hdac_driver {
 	struct device_driver driver;
 	int type;
 	int (*match)(struct hdac_device *dev, struct hdac_driver *drv);
+	void (*unsol_event)(struct hdac_device *dev, unsigned int event);
 };
 
 #define drv_to_hdac_driver(_drv) container_of(_drv, struct hdac_driver, driver)
 
+/*
+ * HD-audio bus base driver
+ */
+struct hdac_bus_ops {
+	/* send a single command */
+	int (*command)(struct hdac_bus *bus, unsigned int cmd);
+	/* get a response from the last command */
+	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
+			    unsigned int *res);
+};
+
+#define HDA_UNSOL_QUEUE_SIZE	64
+
+struct hdac_bus {
+	struct device *dev;
+	const struct hdac_bus_ops *ops;
+
+	/* codec linked list */
+	struct list_head codec_list;
+	unsigned int num_codecs;
+
+	/* link caddr -> codec */
+	struct hdac_device *caddr_tbl[HDA_MAX_CODEC_ADDRESS + 1];
+
+	/* unsolicited event queue */
+	u32 unsol_queue[HDA_UNSOL_QUEUE_SIZE * 2]; /* ring buffer */
+	unsigned int unsol_rp, unsol_wp;
+	struct work_struct unsol_work;
+
+	/* bit flags of powered codecs */
+	unsigned long codec_powered;
+
+	/* flags */
+	bool sync_write:1;		/* sync after verb write */
+
+	/* locks */
+	struct mutex cmd_mutex;
+};
+
+int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
+		      const struct hdac_bus_ops *ops);
+void snd_hdac_bus_exit(struct hdac_bus *bus);
+int snd_hdac_bus_exec_verb(struct hdac_bus *bus, unsigned int addr,
+			   unsigned int cmd, unsigned int *res);
+int snd_hdac_bus_exec_verb_unlocked(struct hdac_bus *bus, unsigned int addr,
+				    unsigned int cmd, unsigned int *res);
+void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex);
+
+int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec);
+void snd_hdac_bus_remove_device(struct hdac_bus *bus,
+				struct hdac_device *codec);
+
 #endif /* __SOUND_HDAUDIO_H */
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 59c8d1feb5aa..828680b282fa 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,3 +1,3 @@
-snd-hda-core-objs := hda_bus_type.o
+snd-hda-core-objs := hda_bus_type.o hdac_bus.o
 
 obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
new file mode 100644
index 000000000000..364f64c0e4a3
--- /dev/null
+++ b/sound/hda/hdac_bus.c
@@ -0,0 +1,181 @@
+/*
+ * HD-audio core bus driver
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <sound/hdaudio.h>
+
+static void process_unsol_events(struct work_struct *work);
+
+/**
+ * snd_hdac_bus_init - initialize a HD-audio bas bus
+ * @bus: the pointer to bus object
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
+		      const struct hdac_bus_ops *ops)
+{
+	memset(bus, 0, sizeof(*bus));
+	bus->dev = dev;
+	bus->ops = ops;
+	INIT_LIST_HEAD(&bus->codec_list);
+	INIT_WORK(&bus->unsol_work, process_unsol_events);
+	mutex_init(&bus->cmd_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_init);
+
+/**
+ * snd_hdac_bus_exit - clean up a HD-audio bas bus
+ * @bus: the pointer to bus object
+ */
+void snd_hdac_bus_exit(struct hdac_bus *bus)
+{
+	WARN_ON(!list_empty(&bus->codec_list));
+	cancel_work_sync(&bus->unsol_work);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_exit);
+
+/**
+ * snd_hdac_bus_exec_verb - execute a HD-audio verb on the given bus
+ * @bus: bus object
+ * @cmd: HD-audio encoded verb
+ * @res: pointer to store the response, NULL if performing asynchronously
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_bus_exec_verb(struct hdac_bus *bus, unsigned int addr,
+			   unsigned int cmd, unsigned int *res)
+{
+	int err;
+
+	mutex_lock(&bus->cmd_mutex);
+	err = snd_hdac_bus_exec_verb_unlocked(bus, addr, cmd, res);
+	mutex_unlock(&bus->cmd_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_exec_verb);
+
+/**
+ * snd_hdac_bus_exec_verb_unlocked - unlocked version
+ * @bus: bus object
+ * @cmd: HD-audio encoded verb
+ * @res: pointer to store the response, NULL if performing asynchronously
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_bus_exec_verb_unlocked(struct hdac_bus *bus, unsigned int addr,
+				    unsigned int cmd, unsigned int *res)
+{
+	unsigned int tmp;
+	int err;
+
+	if (cmd == ~0)
+		return -EINVAL;
+
+	if (res)
+		*res = -1;
+	else if (bus->sync_write)
+		res = &tmp;
+	for (;;) {
+		err = bus->ops->command(bus, cmd);
+		if (err != -EAGAIN)
+			break;
+		/* process pending verbs */
+		err = bus->ops->get_response(bus, addr, &tmp);
+		if (err)
+			break;
+	}
+	if (!err && res)
+		err = bus->ops->get_response(bus, addr, res);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_exec_verb_unlocked);
+
+/**
+ * snd_hdac_bus_queue_event - add an unsolicited event to queue
+ * @bus: the BUS
+ * @res: unsolicited event (lower 32bit of RIRB entry)
+ * @res_ex: codec addr and flags (upper 32bit or RIRB entry)
+ *
+ * Adds the given event to the queue.  The events are processed in
+ * the workqueue asynchronously.  Call this function in the interrupt
+ * hanlder when RIRB receives an unsolicited event.
+ */
+void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex)
+{
+	unsigned int wp;
+
+	if (!bus)
+		return;
+
+	wp = (bus->unsol_wp + 1) % HDA_UNSOL_QUEUE_SIZE;
+	bus->unsol_wp = wp;
+
+	wp <<= 1;
+	bus->unsol_queue[wp] = res;
+	bus->unsol_queue[wp + 1] = res_ex;
+
+	schedule_work(&bus->unsol_work);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_queue_event);
+
+/*
+ * process queued unsolicited events
+ */
+static void process_unsol_events(struct work_struct *work)
+{
+	struct hdac_bus *bus = container_of(work, struct hdac_bus, unsol_work);
+	struct hdac_device *codec;
+	struct hdac_driver *drv;
+	unsigned int rp, caddr, res;
+
+	while (bus->unsol_rp != bus->unsol_wp) {
+		rp = (bus->unsol_rp + 1) % HDA_UNSOL_QUEUE_SIZE;
+		bus->unsol_rp = rp;
+		rp <<= 1;
+		res = bus->unsol_queue[rp];
+		caddr = bus->unsol_queue[rp + 1];
+		if (!(caddr & (1 << 4))) /* no unsolicited event? */
+			continue;
+		codec = bus->caddr_tbl[caddr & 0x0f];
+		if (!codec || !codec->dev.driver)
+			continue;
+		drv = drv_to_hdac_driver(codec->dev.driver);
+		if (drv->unsol_event)
+			drv->unsol_event(codec, res);
+	}
+}
+
+int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec)
+{
+	if (bus->caddr_tbl[codec->addr]) {
+		dev_err(bus->dev, "address 0x%x is already occupied\n",
+			codec->addr);
+		return -EBUSY;
+	}
+
+	list_add_tail(&codec->list, &bus->codec_list);
+	bus->caddr_tbl[codec->addr] = codec;
+	set_bit(codec->addr, &bus->codec_powered);
+	bus->num_codecs++;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_add_device);
+
+void snd_hdac_bus_remove_device(struct hdac_bus *bus,
+				struct hdac_device *codec)
+{
+	WARN_ON(bus != codec->bus);
+	if (list_empty(&codec->list))
+		return;
+	list_del_init(&codec->list);
+	bus->caddr_tbl[codec->addr] = NULL;
+	clear_bit(codec->addr, &bus->codec_powered);
+	bus->num_codecs--;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_remove_device);
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index e3bd2807b644..0b9ea70c546b 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -74,6 +74,15 @@ static int hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
 	return 0;
 }
 
+/* process an unsolicited event */
+static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
+{
+	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
+
+	if (codec->patch_ops.unsol_event)
+		codec->patch_ops.unsol_event(codec, ev);
+}
+
 /* reset the codec name from the preset */
 static int codec_refresh_name(struct hda_codec *codec, const char *name)
 {
@@ -163,6 +172,7 @@ int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
 	drv->core.driver.pm = &hda_codec_driver_pm;
 	drv->core.type = HDA_DEV_LEGACY;
 	drv->core.match = hda_codec_match;
+	drv->core.unsol_event = hda_codec_unsol_event;
 	return driver_register(&drv->core.driver);
 }
 EXPORT_SYMBOL_GPL(__hda_codec_driver_register);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e14f9f562874..f96bff37c787 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -39,9 +39,6 @@
 #include "hda_jack.h"
 #include <sound/hda_hwdep.h>
 
-#define CREATE_TRACE_POINTS
-#include "hda_trace.h"
-
 #ifdef CONFIG_PM
 #define codec_in_pm(codec)	atomic_read(&(codec)->in_pm)
 #define hda_codec_is_power_on(codec) \
@@ -128,16 +125,17 @@ static inline unsigned int
 make_codec_cmd(struct hda_codec *codec, hda_nid_t nid, int flags,
 	       unsigned int verb, unsigned int parm)
 {
+	unsigned int addr = codec->core.addr;
 	u32 val;
 
-	if ((codec->addr & ~0xf) || (nid & ~0x7f) ||
+	if ((addr & ~0xf) || (nid & ~0x7f) ||
 	    (verb & ~0xfff) || (parm & ~0xffff)) {
 		codec_err(codec, "hda-codec: out of range cmd %x:%x:%x:%x\n",
-		       codec->addr, nid, verb, parm);
+			  addr, nid, verb, parm);
 		return ~0;
 	}
 
-	val = (u32)codec->addr << 28;
+	val = (u32)addr << 28;
 	val |= (u32)nid << 20;
 	val |= verb << 8;
 	val |= parm;
@@ -156,33 +154,20 @@ static int codec_exec_verb(struct hda_codec *codec, unsigned int cmd,
 	if (cmd == ~0)
 		return -1;
 
-	if (res)
-		*res = -1;
  again:
 	snd_hda_power_up(codec);
-	mutex_lock(&bus->cmd_mutex);
+	mutex_lock(&bus->core.cmd_mutex);
 	if (flags & HDA_RW_NO_RESPONSE_FALLBACK)
 		bus->no_response_fallback = 1;
-	for (;;) {
-		trace_hda_send_cmd(codec, cmd);
-		err = bus->ops.command(bus, cmd);
-		if (err != -EAGAIN)
-			break;
-		/* process pending verbs */
-		bus->ops.get_response(bus, codec->addr);
-	}
-	if (!err && res) {
-		*res = bus->ops.get_response(bus, codec->addr);
-		trace_hda_get_response(codec, *res);
-	}
+	err = snd_hdac_bus_exec_verb_unlocked(&bus->core, codec->core.addr,
+					      cmd, res);
 	bus->no_response_fallback = 0;
-	mutex_unlock(&bus->cmd_mutex);
+	mutex_unlock(&bus->core.cmd_mutex);
 	snd_hda_power_down(codec);
-	if (!codec_in_pm(codec) && res && *res == -1 && bus->rirb_error) {
+	if (!codec_in_pm(codec) && res && err < 0 && bus->rirb_error) {
 		if (bus->response_reset) {
 			codec_dbg(codec,
 				  "resetting BUS due to fatal communication error\n");
-			trace_hda_bus_reset(bus);
 			bus->ops.bus_reset(bus);
 		}
 		goto again;
@@ -233,9 +218,7 @@ int snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 			unsigned int verb, unsigned int parm)
 {
 	unsigned int cmd = make_codec_cmd(codec, nid, flags, verb, parm);
-	unsigned int res;
-	return codec_exec_verb(codec, cmd, flags,
-			       codec->bus->sync_write ? &res : NULL);
+	return codec_exec_verb(codec, cmd, flags, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_write);
 
@@ -664,65 +647,6 @@ int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 	return devices;
 }
 
-/**
- * snd_hda_queue_unsol_event - add an unsolicited event to queue
- * @bus: the BUS
- * @res: unsolicited event (lower 32bit of RIRB entry)
- * @res_ex: codec addr and flags (upper 32bit or RIRB entry)
- *
- * Adds the given event to the queue.  The events are processed in
- * the workqueue asynchronously.  Call this function in the interrupt
- * hanlder when RIRB receives an unsolicited event.
- *
- * Returns 0 if successful, or a negative error code.
- */
-int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex)
-{
-	struct hda_bus_unsolicited *unsol;
-	unsigned int wp;
-
-	if (!bus)
-		return 0;
-
-	trace_hda_unsol_event(bus, res, res_ex);
-	unsol = &bus->unsol;
-	wp = (unsol->wp + 1) % HDA_UNSOL_QUEUE_SIZE;
-	unsol->wp = wp;
-
-	wp <<= 1;
-	unsol->queue[wp] = res;
-	unsol->queue[wp + 1] = res_ex;
-
-	schedule_work(&unsol->work);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_queue_unsol_event);
-
-/*
- * process queued unsolicited events
- */
-static void process_unsol_events(struct work_struct *work)
-{
-	struct hda_bus *bus = container_of(work, struct hda_bus, unsol.work);
-	struct hda_bus_unsolicited *unsol = &bus->unsol;
-	struct hda_codec *codec;
-	unsigned int rp, caddr, res;
-
-	while (unsol->rp != unsol->wp) {
-		rp = (unsol->rp + 1) % HDA_UNSOL_QUEUE_SIZE;
-		unsol->rp = rp;
-		rp <<= 1;
-		res = unsol->queue[rp];
-		caddr = unsol->queue[rp + 1];
-		if (!(caddr & (1 << 4))) /* no unsolicited event? */
-			continue;
-		codec = bus->caddr_tbl[caddr & 0x0f];
-		if (codec && codec->patch_ops.unsol_event)
-			codec->patch_ops.unsol_event(codec, res);
-	}
-}
-
 /*
  * destructor
  */
@@ -730,11 +654,9 @@ static void snd_hda_bus_free(struct hda_bus *bus)
 {
 	if (!bus)
 		return;
-
-	WARN_ON(!list_empty(&bus->codec_list));
-	cancel_work_sync(&bus->unsol.work);
 	if (bus->ops.private_free)
 		bus->ops.private_free(bus);
+	snd_hdac_bus_exit(&bus->core);
 	kfree(bus);
 }
 
@@ -751,6 +673,26 @@ static int snd_hda_bus_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
+/* hdac_bus_ops translations */
+static int _hda_bus_command(struct hdac_bus *_bus, unsigned int cmd)
+{
+	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
+	return bus->ops.command(bus, cmd);
+}
+
+static int _hda_bus_get_response(struct hdac_bus *_bus, unsigned int addr,
+				 unsigned int *res)
+{
+	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
+	*res = bus->ops.get_response(bus, addr);
+	return bus->rirb_error ? -EIO : 0;
+}
+
+static const struct hdac_bus_ops bus_ops = {
+	.command = _hda_bus_command,
+	.get_response = _hda_bus_get_response,
+};
+
 /**
  * snd_hda_bus_new - create a HDA bus
  * @card: the card entry
@@ -775,11 +717,14 @@ int snd_hda_bus_new(struct snd_card *card,
 	if (!bus)
 		return -ENOMEM;
 
+	err = snd_hdac_bus_init(&bus->core, card->dev, &bus_ops);
+	if (err < 0) {
+		kfree(bus);
+		return err;
+	}
+
 	bus->card = card;
-	mutex_init(&bus->cmd_mutex);
 	mutex_init(&bus->prepare_mutex);
-	INIT_LIST_HEAD(&bus->codec_list);
-	INIT_WORK(&bus->unsol.work, process_unsol_events);
 
 	err = snd_device_new(card, SNDRV_DEV_BUS, bus, &dev_ops);
 	if (err < 0) {
@@ -1233,9 +1178,7 @@ static void snd_hda_codec_dev_release(struct device *dev)
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
 	free_init_pincfgs(codec);
-	list_del(&codec->list);
-	codec->bus->caddr_tbl[codec->addr] = NULL;
-	clear_bit(codec->addr, &codec->bus->codec_powered);
+	snd_hdac_bus_remove_device(&codec->bus->core, &codec->core);
 	snd_hda_sysfs_clear(codec);
 	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
@@ -1243,7 +1186,6 @@ static void snd_hda_codec_dev_release(struct device *dev)
 	kfree(codec->chip_name);
 	kfree(codec->modelname);
 	kfree(codec->wcaps);
-	codec->bus->num_codecs--;
 	kfree(codec);
 }
 
@@ -1274,27 +1216,23 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
 		return -EINVAL;
 
-	if (bus->caddr_tbl[codec_addr]) {
-		dev_err(card->dev,
-			"address 0x%x is already occupied\n",
-			codec_addr);
-		return -EBUSY;
-	}
-
 	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
 	if (!codec)
 		return -ENOMEM;
 
+	codec->core.bus = &bus->core;
+	codec->core.addr = codec_addr;
+	codec->core.type = HDA_DEV_LEGACY;
+
 	dev = hda_codec_dev(codec);
 	device_initialize(dev);
-	dev->parent = card->dev;
+	dev->parent = bus->core.dev;
 	dev->bus = &snd_hda_bus_type;
 	dev->release = snd_hda_codec_dev_release;
 	dev->groups = snd_hda_dev_attr_groups;
 	dev_set_name(dev, "hdaudioC%dD%d", card->number, codec_addr);
 	dev_set_drvdata(dev, codec); /* for sysfs */
 	device_enable_async_suspend(dev);
-	codec->core.type = HDA_DEV_LEGACY;
 
 	codec->bus = bus;
 	codec->card = card;
@@ -1323,7 +1261,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	/* snd_hda_codec_new() marks the codec as power-up, and leave it as is.
 	 * it's powered down later in snd_hda_codec_dev_register().
 	 */
-	set_bit(codec->addr, &bus->codec_powered);
+	set_bit(codec->core.addr, &bus->core.codec_powered);
 	pm_runtime_set_active(hda_codec_dev(codec));
 	pm_runtime_get_noresume(hda_codec_dev(codec));
 	codec->power_jiffies = jiffies;
@@ -1339,10 +1277,9 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		}
 	}
 
-	list_add_tail(&codec->list, &bus->codec_list);
-	bus->num_codecs++;
-
-	bus->caddr_tbl[codec_addr] = codec;
+	err = snd_hdac_bus_add_device(&bus->core, &codec->core);
+	if (err < 0)
+		goto error;
 
 	codec->vendor_id = snd_hda_param_read(codec, AC_NODE_ROOT,
 					      AC_PAR_VENDOR_ID);
@@ -1516,7 +1453,7 @@ void snd_hda_codec_setup_stream(struct hda_codec *codec, hda_nid_t nid,
 
 	/* make other inactive cvts with the same stream-tag dirty */
 	type = get_wcaps_type(get_wcaps(codec, nid));
-	list_for_each_entry(c, &codec->bus->codec_list, list) {
+	list_for_each_codec(c, codec->bus) {
 		for (i = 0; i < c->cvt_setups.used; i++) {
 			p = snd_array_elem(&c->cvt_setups, i);
 			if (!p->active && p->stream_tag == stream_tag &&
@@ -1583,7 +1520,7 @@ static void purify_inactive_streams(struct hda_codec *codec)
 	struct hda_codec *c;
 	int i;
 
-	list_for_each_entry(c, &codec->bus->codec_list, list) {
+	list_for_each_codec(c, codec->bus) {
 		for (i = 0; i < c->cvt_setups.used; i++) {
 			struct hda_cvt_setup *p;
 			p = snd_array_elem(&c->cvt_setups, i);
@@ -2436,7 +2373,7 @@ int snd_hda_lock_devices(struct hda_bus *bus)
 	if (!list_empty(&card->ctl_files))
 		goto err_clear;
 
-	list_for_each_entry(codec, &bus->codec_list, list) {
+	list_for_each_codec(codec, bus) {
 		struct hda_pcm *cpcm;
 		list_for_each_entry(cpcm, &codec->pcm_list_head, list) {
 			if (!cpcm->pcm)
@@ -3607,13 +3544,13 @@ int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
 	verb = verb | (parm >> 8);
 	parm &= 0xff;
 	key = build_cmd_cache_key(nid, verb);
-	mutex_lock(&codec->bus->cmd_mutex);
+	mutex_lock(&codec->bus->core.cmd_mutex);
 	c = get_alloc_hash(&codec->cmd_cache, key);
 	if (c) {
 		c->val = parm;
 		c->dirty = cache_only;
 	}
-	mutex_unlock(&codec->bus->cmd_mutex);
+	mutex_unlock(&codec->bus->core.cmd_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_write_cache);
@@ -3642,13 +3579,13 @@ int snd_hda_codec_update_cache(struct hda_codec *codec, hda_nid_t nid,
 	verb = verb | (parm >> 8);
 	parm &= 0xff;
 	key = build_cmd_cache_key(nid, verb);
-	mutex_lock(&codec->bus->cmd_mutex);
+	mutex_lock(&codec->bus->core.cmd_mutex);
 	c = get_hash(&codec->cmd_cache, key);
 	if (c && c->val == parm) {
-		mutex_unlock(&codec->bus->cmd_mutex);
+		mutex_unlock(&codec->bus->core.cmd_mutex);
 		return 0;
 	}
-	mutex_unlock(&codec->bus->cmd_mutex);
+	mutex_unlock(&codec->bus->core.cmd_mutex);
 	return snd_hda_codec_write_cache(codec, nid, flags, verb, parm);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_update_cache);
@@ -3927,7 +3864,6 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec)
 		codec->patch_ops.suspend(codec);
 	hda_cleanup_all_streams(codec);
 	state = hda_set_power_state(codec, AC_PWRST_D3);
-	trace_hda_power_down(codec);
 	update_power_acct(codec, true);
 	atomic_dec(&codec->in_pm);
 	return state;
@@ -3956,7 +3892,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 {
 	atomic_inc(&codec->in_pm);
 
-	trace_hda_power_up(codec);
 	hda_mark_cmd_cache_dirty(codec);
 
 	codec->power_jiffies = jiffies;
@@ -3992,7 +3927,7 @@ static int hda_codec_runtime_suspend(struct device *dev)
 		snd_pcm_suspend_all(pcm->pcm);
 	state = hda_call_codec_suspend(codec);
 	if (codec->d3_stop_clk && codec->epss && (state & AC_PWRST_CLK_STOP_OK))
-		clear_bit(codec->addr, &codec->bus->codec_powered);
+		clear_bit(codec->core.addr, &codec->bus->core.codec_powered);
 	return 0;
 }
 
@@ -4000,7 +3935,7 @@ static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
-	set_bit(codec->addr, &codec->bus->codec_powered);
+	set_bit(codec->core.addr, &codec->bus->core.codec_powered);
 	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
 	return 0;
@@ -4582,7 +4517,7 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
 	err = codec->patch_ops.build_pcms(codec);
 	if (err < 0) {
 		codec_err(codec, "cannot build PCMs for #%d (error %d)\n",
-			  codec->addr, err);
+			  codec->core.addr, err);
 		return err;
 	}
 
@@ -4638,7 +4573,7 @@ int snd_hda_codec_build_pcms(struct hda_codec *codec)
 		if (err < 0) {
 			codec_err(codec,
 				  "cannot attach PCM stream %d for codec #%d\n",
-				  dev, codec->addr);
+				  dev, codec->core.addr);
 			continue; /* no fatal error */
 		}
 	}
@@ -4681,8 +4616,8 @@ int snd_hda_add_new_ctls(struct hda_codec *codec,
 			 * the codec addr; if it still fails (or it's the
 			 * primary codec), then try another control index
 			 */
-			if (!addr && codec->addr)
-				addr = codec->addr;
+			if (!addr && codec->core.addr)
+				addr = codec->core.addr;
 			else if (!idx && !knew->index) {
 				idx = find_empty_mixer_ctl_idx(codec,
 							       knew->name, 0);
@@ -4757,7 +4692,7 @@ void snd_hda_set_power_save(struct hda_bus *bus, int delay)
 {
 	struct hda_codec *c;
 
-	list_for_each_entry(c, &bus->codec_list, list)
+	list_for_each_codec(c, bus)
 		codec_set_power_save(c, delay);
 }
 EXPORT_SYMBOL_GPL(snd_hda_set_power_save);
@@ -5344,7 +5279,7 @@ void snd_hda_bus_reset(struct hda_bus *bus)
 {
 	struct hda_codec *codec;
 
-	list_for_each_entry(codec, &bus->codec_list, list) {
+	list_for_each_codec(codec, bus) {
 		/* FIXME: maybe a better way needed for forced reset */
 		cancel_delayed_work_sync(&codec->jackpoll_work);
 #ifdef CONFIG_PM
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 9874d5b6a8a7..7ebad1bf29bc 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -98,16 +98,6 @@ struct hda_bus_ops {
 #endif
 };
 
-/* unsolicited event handler */
-#define HDA_UNSOL_QUEUE_SIZE	64
-struct hda_bus_unsolicited {
-	/* ring buffer */
-	u32 queue[HDA_UNSOL_QUEUE_SIZE * 2];
-	unsigned int rp, wp;
-	/* workqueue */
-	struct work_struct work;
-};
-
 /*
  * codec bus
  *
@@ -115,6 +105,8 @@ struct hda_bus_unsolicited {
  * A hda_bus contains several codecs in the list codec_list.
  */
 struct hda_bus {
+	struct hdac_bus core;
+
 	struct snd_card *card;
 
 	void *private_data;
@@ -122,25 +114,14 @@ struct hda_bus {
 	const char *modelname;
 	struct hda_bus_ops ops;
 
-	/* codec linked list */
-	struct list_head codec_list;
-	unsigned int num_codecs;
-	/* link caddr -> codec */
-	struct hda_codec *caddr_tbl[HDA_MAX_CODEC_ADDRESS + 1];
-
-	struct mutex cmd_mutex;
 	struct mutex prepare_mutex;
 
-	/* unsolicited event queue */
-	struct hda_bus_unsolicited unsol;
-
 	/* assigned PCMs */
 	DECLARE_BITMAP(pcm_dev_bits, SNDRV_PCM_DEVICES);
 
 	/* misc op flags */
 	unsigned int needs_damn_long_delay :1;
 	unsigned int allow_bus_reset:1;	/* allow bus reset at fatal error */
-	unsigned int sync_write:1;	/* sync after verb write */
 	/* status for codec/controller */
 	unsigned int shutdown :1;	/* being unloaded */
 	unsigned int rirb_error:1;	/* error in codec communication */
@@ -149,7 +130,6 @@ struct hda_bus {
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
-	unsigned long codec_powered;	/* bit flags of powered codecs */
 };
 
 /*
@@ -281,7 +261,6 @@ struct hda_codec {
 	struct hda_bus *bus;
 	struct snd_card *card;
 	unsigned int addr;	/* codec addr*/
-	struct list_head list;	/* list point */
 
 	hda_nid_t afg;	/* AFG node id */
 	hda_nid_t mfg;	/* MFG node id */
@@ -413,6 +392,9 @@ struct hda_codec {
 #define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, core.dev)
 #define hda_codec_dev(_dev)	(&(_dev)->core.dev)
 
+#define list_for_each_codec(c, bus) \
+	list_for_each_entry(c, &(bus)->core.codec_list, core.list)
+
 /* direction */
 enum {
 	HDA_INPUT, HDA_OUTPUT
@@ -473,7 +455,11 @@ void snd_hda_sequence_write(struct hda_codec *codec,
 			    const struct hda_verb *seq);
 
 /* unsolicited event */
-int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex);
+static inline void
+snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex)
+{
+	snd_hdac_bus_queue_event(&bus->core, res, res_ex);
+}
 
 /* cached write */
 int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 4fd0b2ef26e9..26ce990592a0 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1764,12 +1764,12 @@ static int probe_codec(struct azx *chip, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res;
 
-	mutex_lock(&chip->bus->cmd_mutex);
+	mutex_lock(&chip->bus->core.cmd_mutex);
 	chip->probing = 1;
 	azx_send_cmd(chip->bus, cmd);
 	res = azx_get_response(chip->bus, addr);
 	chip->probing = 0;
-	mutex_unlock(&chip->bus->cmd_mutex);
+	mutex_unlock(&chip->bus->core.cmd_mutex);
 	if (res == -1)
 		return -EIO;
 	dev_dbg(chip->card->dev, "codec #%d probed OK\n", addr);
@@ -1848,7 +1848,7 @@ int azx_bus_create(struct azx *chip, const char *model)
 	 */
 	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
 		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
-		bus->sync_write = 1;
+		bus->core.sync_write = 1;
 		bus->allow_bus_reset = 1;
 	}
 
@@ -1913,7 +1913,7 @@ EXPORT_SYMBOL_GPL(azx_probe_codecs);
 int azx_codec_configure(struct azx *chip)
 {
 	struct hda_codec *codec;
-	list_for_each_entry(codec, &chip->bus->codec_list, list) {
+	list_for_each_codec(codec, chip->bus) {
 		snd_hda_codec_configure(codec);
 	}
 	return 0;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 060f7a2b1aeb..feebc1dda912 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -891,7 +891,7 @@ static int azx_runtime_resume(struct device *dev)
 
 	bus = chip->bus;
 	if (status && bus) {
-		list_for_each_entry(codec, &bus->codec_list, list)
+		list_for_each_codec(codec, bus)
 			if (status & (1 << codec->addr))
 				schedule_delayed_work(&codec->jackpoll_work,
 						      codec->jackpoll_interval);
@@ -919,7 +919,7 @@ static int azx_runtime_idle(struct device *dev)
 		return 0;
 
 	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
-	    chip->bus->codec_powered)
+	    chip->bus->core.codec_powered)
 		return -EBUSY;
 
 	return 0;
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index e13c75d67847..3b5ed1108f9f 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -552,7 +552,7 @@ static void parse_codec_mode(char *buf, struct hda_bus *bus,
 
 	*codecp = NULL;
 	if (sscanf(buf, "%i %i %i", &vendorid, &subid, &caddr) == 3) {
-		list_for_each_entry(codec, &bus->codec_list, list) {
+		list_for_each_codec(codec, bus) {
 			if ((vendorid <= 0 || codec->vendor_id == vendorid) &&
 			    (subid <= 0 || codec->subsystem_id == subid) &&
 			    codec->addr == caddr) {
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5aa466a13e43..142a6cf786da 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -919,10 +919,10 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	 * which falls into the single-cmd mode.
 	 * Better to make reset, then.
 	 */
-	if (!codec->bus->sync_write) {
+	if (!codec->bus->core.sync_write) {
 		codec_info(codec,
 			   "Enable sync_write for stable communication\n");
-		codec->bus->sync_write = 1;
+		codec->bus->core.sync_write = 1;
 		codec->bus->allow_bus_reset = 1;
 	}
 
-- 
2.3.3
