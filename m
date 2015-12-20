From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/11] fireface: add hwdep interface
Date: Sun, 20 Dec 2015 21:28:43 +0900
Message-ID: <1450614523-9367-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB40260708
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:50 +0100 (CET)
In-Reply-To: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
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
 include/uapi/sound/asound.h               |   3 +-
 include/uapi/sound/firewire.h             |   1 +
 sound/firewire/fireface/Makefile          |   2 +-
 sound/firewire/fireface/fireface-hwdep.c  | 191 ++++++++++++++++++++++++++++++
 sound/firewire/fireface/fireface-pcm.c    |  13 +-
 sound/firewire/fireface/fireface-stream.c |  39 ++++++
 sound/firewire/fireface/fireface.c        |   5 +
 sound/firewire/fireface/fireface.h        |  10 ++
 8 files changed, 260 insertions(+), 4 deletions(-)
 create mode 100644 sound/firewire/fireface/fireface-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index a82108e..f1cd38e 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -102,9 +102,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
 	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
+	SNDRV_HWDEP_IFACE_FW_FIREFACE,	/* RME Fireface series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_TASCAM
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREFACE
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index db79a12..f6e58ae 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -65,6 +65,7 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_OXFW	4
 #define SNDRV_FIREWIRE_TYPE_DIGI00X	5
 #define SNDRV_FIREWIRE_TYPE_TASCAM	6
+#define SNDRV_FIREWIRE_TYPE_FIREFACE	7
 /* RME, MOTU, ... */
 
 struct snd_firewire_get_info {
diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
index 4b6b9a9..9eea168 100644
--- a/sound/firewire/fireface/Makefile
+++ b/sound/firewire/fireface/Makefile
@@ -1,4 +1,4 @@
 snd-fireface-objs := fireface.o fireface-transaction.o fireface-midi.o \
 		     fireface-proc.o amdtp-ff.o fireface-stream.o \
-		     fireface-pcm.o
+		     fireface-pcm.o fireface-hwdep.o
 obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/fireface-hwdep.c b/sound/firewire/fireface/fireface-hwdep.c
new file mode 100644
index 0000000..bc86927
--- /dev/null
+++ b/sound/firewire/fireface/fireface-hwdep.c
@@ -0,0 +1,191 @@
+/*
+ * fireface-hwdep.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
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
+#include "fireface.h"
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
diff --git a/sound/firewire/fireface/fireface-pcm.c b/sound/firewire/fireface/fireface-pcm.c
index 705df28..2ddd248 100644
--- a/sound/firewire/fireface/fireface-pcm.c
+++ b/sound/firewire/fireface/fireface-pcm.c
@@ -155,10 +155,16 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	enum snd_ff_clock_src src;
 	int err;
 
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
 	err = snd_ff_stream_get_clock(ff, &rate, &src);
 	if (src != SND_FF_CLOCK_SRC_INTERNAL ||
 	    amdtp_stream_pcm_running(&ff->rx_stream) ||
@@ -169,11 +175,14 @@ static int pcm_open(struct snd_pcm_substream *substream)
 
 	snd_pcm_set_sync(substream);
 
-	return err;
+	return 0;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_ff *ff = substream->private_data;
+
+	snd_ff_stream_lock_release(ff);
 	return 0;
 }
 
diff --git a/sound/firewire/fireface/fireface-stream.c b/sound/firewire/fireface/fireface-stream.c
index c7743a8..252533a 100644
--- a/sound/firewire/fireface/fireface-stream.c
+++ b/sound/firewire/fireface/fireface-stream.c
@@ -356,3 +356,42 @@ void snd_ff_stream_update_duplex(struct snd_ff *ff)
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
diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
index 59f0441..f8f42cc 100644
--- a/sound/firewire/fireface/fireface.c
+++ b/sound/firewire/fireface/fireface.c
@@ -71,6 +71,10 @@ static void do_probe(struct work_struct *work)
 	if (err < 0)
 		goto end;
 
+	err = snd_ff_create_hwdep_devices(ff);
+	if (err < 0)
+		goto end;
+
 	err = snd_card_register(ff->card);
 	if (err < 0)
 		goto end;
@@ -109,6 +113,7 @@ static int snd_ff_probe(struct fw_unit *unit,
 
 	mutex_init(&ff->mutex);
 	spin_lock_init(&ff->lock);
+	init_waitqueue_head(&ff->hwdep_wait);
 	dev_set_drvdata(&unit->device, ff);
 
 	ff->spec = (const struct snd_ff_spec *)entry->driver_data;
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
index 63834e7..4860bab 100644
--- a/sound/firewire/fireface/fireface.h
+++ b/sound/firewire/fireface/fireface.h
@@ -73,6 +73,10 @@ struct snd_ff {
 	struct amdtp_stream rx_stream;
 	struct fw_iso_resources tx_resources;
 	struct fw_iso_resources rx_resources;
+
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 #define SND_FF_ADDR_CONTROLLER_ADDR_HI	0x0000801003f4
@@ -112,10 +116,16 @@ void snd_ff_stream_update_duplex(struct snd_ff *ff);
 int snd_ff_stream_get_clock(struct snd_ff *ff, unsigned int *rate,
 			    enum snd_ff_clock_src *src);
 
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
2.5.0
