From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/14] ALSA: fireface: add hwdep interface
Date: Fri, 31 Mar 2017 22:06:11 +0900
Message-ID: <20170331130612.18331-14-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6A31F267238
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:25 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds hwdep interface so as the other drivers for audio and
music units on IEEE 1394 have.

This interface is designed for mixer/control applications. By using this
interface, an application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h         |   3 +-
 include/uapi/sound/firewire.h       |   2 +-
 sound/firewire/Kconfig              |   1 +
 sound/firewire/fireface/Makefile    |   2 +-
 sound/firewire/fireface/ff-hwdep.c  | 191 ++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff-pcm.c    |  20 +++-
 sound/firewire/fireface/ff-stream.c |  39 ++++++++
 sound/firewire/fireface/ff.c        |   5 +
 sound/firewire/fireface/ff.h        |  13 +++
 9 files changed, 270 insertions(+), 6 deletions(-)
 create mode 100644 sound/firewire/fireface/ff-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index fd7b561..fd41697 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -108,9 +108,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 	SNDRV_HWDEP_IFACE_LINE6,	/* Line6 USB processors */
 	SNDRV_HWDEP_IFACE_FW_MOTU,	/* MOTU FireWire series */
+	SNDRV_HWDEP_IFACE_FW_FIREFACE,	/* RME Fireface series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_MOTU
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREFACE
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index 29afc5e..6229004 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -73,7 +73,7 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_DIGI00X	5
 #define SNDRV_FIREWIRE_TYPE_TASCAM	6
 #define SNDRV_FIREWIRE_TYPE_MOTU	7
-/* RME... */
+#define SNDRV_FIREWIRE_TYPE_FIREFACE	8
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index b75a822..70f02ee 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -155,6 +155,7 @@ config SND_FIREWIRE_MOTU
 config SND_FIREFACE
 	tristate "RME Fireface series support"
 	select SND_FIREWIRE_LIB
+	select SND_HWDEP
 	help
 	 Say Y here to include support for RME fireface series.
 
diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index e626938..8d6c612 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,3 +1,3 @@
 snd-fireface-objs := ff.o ff-transaction.o ff-midi.o ff-proc.o amdtp-ff.o \
-		     ff-stream.o ff-pcm.o
+		     ff-stream.o ff-pcm.o ff-hwdep.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff-hwdep.c b/sound/firewire/fireface/ff-hwdep.c
new file mode 100644
index 0000000..3ee04b0
--- /dev/null
+++ b/sound/firewire/fireface/ff-hwdep.c
@@ -0,0 +1,191 @@
+/*
+ * ff-hwdep.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+/*
+ * This codes give three functionality.
+ *
+ * 1.get firewire node information
+ * 2.get notification about starting/stopping stream
+ * 3.lock/unlock stream
+ */
+
+#include "ff.h"
+
+static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+		       loff_t *offset)
+{
+	struct snd_ff *ff = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&ff->lock);
+
+	while (!ff->dev_lock_changed) {
+		prepare_to_wait(&ff->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&ff->lock);
+		schedule();
+		finish_wait(&ff->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&ff->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (ff->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (ff->dev_lock_count > 0);
+		ff->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	}
+
+	spin_unlock_irq(&ff->lock);
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
+	return count;
+}
+
+static unsigned int hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
+			       poll_table *wait)
+{
+	struct snd_ff *ff = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &ff->hwdep_wait, wait);
+
+	spin_lock_irq(&ff->lock);
+	if (ff->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&ff->lock);
+
+	return events;
+}
+
+static int hwdep_get_info(struct snd_ff *ff, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(ff->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_FIREFACE;
+	info.card = dev->card->index;
+	*(__be32 *)&info.guid[0] = cpu_to_be32(dev->config_rom[3]);
+	*(__be32 *)&info.guid[4] = cpu_to_be32(dev->config_rom[4]);
+	strlcpy(info.device_name, dev_name(&dev->device),
+		sizeof(info.device_name));
+
+	if (copy_to_user(arg, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int hwdep_lock(struct snd_ff *ff)
+{
+	int err;
+
+	spin_lock_irq(&ff->lock);
+
+	if (ff->dev_lock_count == 0) {
+		ff->dev_lock_count = -1;
+		err = 0;
+	} else {
+		err = -EBUSY;
+	}
+
+	spin_unlock_irq(&ff->lock);
+
+	return err;
+}
+
+static int hwdep_unlock(struct snd_ff *ff)
+{
+	int err;
+
+	spin_lock_irq(&ff->lock);
+
+	if (ff->dev_lock_count == -1) {
+		ff->dev_lock_count = 0;
+		err = 0;
+	} else {
+		err = -EBADFD;
+	}
+
+	spin_unlock_irq(&ff->lock);
+
+	return err;
+}
+
+static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_ff *ff = hwdep->private_data;
+
+	spin_lock_irq(&ff->lock);
+	if (ff->dev_lock_count == -1)
+		ff->dev_lock_count = 0;
+	spin_unlock_irq(&ff->lock);
+
+	return 0;
+}
+
+static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	struct snd_ff *ff = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(ff, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(ff);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(ff);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static int hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
+			      unsigned int cmd, unsigned long arg)
+{
+	return hwdep_ioctl(hwdep, file, cmd,
+			   (unsigned long)compat_ptr(arg));
+}
+#else
+#define hwdep_compat_ioctl NULL
+#endif
+
+int snd_ff_create_hwdep_devices(struct snd_ff *ff)
+{
+	static const struct snd_hwdep_ops hwdep_ops = {
+		.read		= hwdep_read,
+		.release	= hwdep_release,
+		.poll		= hwdep_poll,
+		.ioctl		= hwdep_ioctl,
+		.ioctl_compat	= hwdep_compat_ioctl,
+	};
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(ff->card, ff->card->driver, 0, &hwdep);
+	if (err < 0)
+		return err;
+
+	strcpy(hwdep->name, ff->card->driver);
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_FIREFACE;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = ff;
+	hwdep->exclusive = true;
+
+	return 0;
+}
diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index d282467..93cee19 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -154,13 +154,21 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	enum snd_ff_clock_src src;
 	int i, err;
 
-	err = pcm_init_hw_params(ff, substream);
+	err = snd_ff_stream_lock_try(ff);
 	if (err < 0)
 		return err;
 
+	err = pcm_init_hw_params(ff, substream);
+	if (err < 0) {
+		snd_ff_stream_lock_release(ff);
+		return err;
+	}
+
 	err = ff->spec->protocol->get_clock(ff, &rate, &src);
-	if (err < 0)
+	if (err < 0) {
+		snd_ff_stream_lock_release(ff);
 		return err;
+	}
 
 	if (src != SND_FF_CLOCK_SRC_INTERNAL) {
 		for (i = 0; i < CIP_SFC_COUNT; ++i) {
@@ -171,8 +179,10 @@ static int pcm_open(struct snd_pcm_substream *substream)
 		 * The unit is configured at sampling frequency which packet
 		 * streaming engine can't support.
 		 */
-		if (i >= CIP_SFC_COUNT)
+		if (i >= CIP_SFC_COUNT) {
+			snd_ff_stream_lock_release(ff);
 			return -EIO;
+		}
 
 		substream->runtime->hw.rate_min = rate;
 		substream->runtime->hw.rate_max = rate;
@@ -192,6 +202,10 @@ static int pcm_open(struct snd_pcm_substream *substream)
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_ff *ff = substream->private_data;
+
+	snd_ff_stream_lock_release(ff);
+
 	return 0;
 }
 
diff --git a/sound/firewire/fireface/ff-stream.c b/sound/firewire/fireface/ff-stream.c
index 0ef6177..7888092 100644
--- a/sound/firewire/fireface/ff-stream.c
+++ b/sound/firewire/fireface/ff-stream.c
@@ -241,3 +241,42 @@ void snd_ff_stream_update_duplex(struct snd_ff *ff)
 	fw_iso_resources_update(&ff->tx_resources);
 	fw_iso_resources_update(&ff->rx_resources);
 }
+
+void snd_ff_stream_lock_changed(struct snd_ff *ff)
+{
+	ff->dev_lock_changed = true;
+	wake_up(&ff->hwdep_wait);
+}
+
+int snd_ff_stream_lock_try(struct snd_ff *ff)
+{
+	int err;
+
+	spin_lock_irq(&ff->lock);
+
+	/* user land lock this */
+	if (ff->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (ff->dev_lock_count++ == 0)
+		snd_ff_stream_lock_changed(ff);
+	err = 0;
+end:
+	spin_unlock_irq(&ff->lock);
+	return err;
+}
+
+void snd_ff_stream_lock_release(struct snd_ff *ff)
+{
+	spin_lock_irq(&ff->lock);
+
+	if (WARN_ON(ff->dev_lock_count <= 0))
+		goto end;
+	if (--ff->dev_lock_count == 0)
+		snd_ff_stream_lock_changed(ff);
+end:
+	spin_unlock_irq(&ff->lock);
+}
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index ff62d16..f57b434 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -76,6 +76,10 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
+	err = snd_ff_create_hwdep_devices(ff);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(ff->card);
 	if (err < 0)
 		goto error;
@@ -108,6 +112,7 @@ static int snd_ff_probe(struct fw_unit *unit,
 
 	mutex_init(&ff->mutex);
 	spin_lock_init(&ff->lock);
+	init_waitqueue_head(&ff->hwdep_wait);
 
 	ff->spec = (const struct snd_ff_spec *)entry->driver_data;
 
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 0d5228c..a143b5a 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -17,12 +17,15 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/sched/signal.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/rawmidi.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/hwdep.h>
+#include <sound/firewire.h>
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
@@ -77,6 +80,10 @@ struct snd_ff {
 	struct amdtp_stream rx_stream;
 	struct fw_iso_resources tx_resources;
 	struct fw_iso_resources rx_resources;
+
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 enum snd_ff_clock_src {
@@ -122,10 +129,16 @@ int snd_ff_stream_start_duplex(struct snd_ff *ff, unsigned int rate);
 void snd_ff_stream_stop_duplex(struct snd_ff *ff);
 void snd_ff_stream_update_duplex(struct snd_ff *ff);
 
+void snd_ff_stream_lock_changed(struct snd_ff *ff);
+int snd_ff_stream_lock_try(struct snd_ff *ff);
+void snd_ff_stream_lock_release(struct snd_ff *ff);
+
 void snd_ff_proc_init(struct snd_ff *ff);
 
 int snd_ff_create_midi_devices(struct snd_ff *ff);
 
 int snd_ff_create_pcm_devices(struct snd_ff *ff);
 
+int snd_ff_create_hwdep_devices(struct snd_ff *ff);
+
 #endif
-- 
2.9.3
