From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/13] speakers: Add hwdep interface
Date: Sat, 11 Jan 2014 00:29:35 +0900
Message-ID: <1389367775-21360-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 57EAF2654F6
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:30:05 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This interface is designed for mixer/control application. To use hwdep
interface, the application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h               |   3 +-
 include/uapi/sound/firewire.h             |   3 +-
 sound/firewire/speakers/Makefile          |   2 +-
 sound/firewire/speakers/speakers.c        |   5 +
 sound/firewire/speakers/speakers.h        |  13 ++
 sound/firewire/speakers/speakers_hwdep.c  | 195 ++++++++++++++++++++++++++++++
 sound/firewire/speakers/speakers_stream.c |  39 ++++++
 7 files changed, 257 insertions(+), 3 deletions(-)
 create mode 100644 sound/firewire/speakers/speakers_hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 2249483..5d6fa42 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -96,9 +96,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
 	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
 	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
+	SNDRV_HWDEP_IFACE_FW_FWSPK,	/* Oxford FW970/971 based devices */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FWSPK
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index d69c0b6..147349e 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -54,7 +54,8 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_DICE	1
 #define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
 #define SNDRV_FIREWIRE_TYPE_BEBOB	3
-/* AV/C, RME, MOTU, ... */
+#define SNDRV_FIREWIRE_TYPE_FWSPK	4
+/* RME, MOTU, ... */
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index d98d4f7..b7b1e45 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-speakers-objs := speakers_command.o speakers_stream.o speakers_pcm.o speakers_control.o \
-			      speakers_proc.o speakers_midi.o speakers.o
+			      speakers_proc.o speakers_midi.o speakers_hwdep.o speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index fd16e59..4eff180 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -116,6 +116,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	fwspk->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&fwspk->mutex);
 	spin_lock_init(&fwspk->lock);
+	init_waitqueue_head(&fwspk->hwdep_wait);
 
 	if (fwspk->device_info == &griffin_firewave)
 		err = firewave_stream_discover(fwspk);
@@ -152,6 +153,10 @@ static int fwspk_probe(struct fw_unit *unit,
 			goto err_card;
 	}
 
+	err = snd_fwspk_create_hwdep(fwspk);
+	if (err < 0)
+		goto err_card;
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
index 2c54946..73eecb0 100644
--- a/sound/firewire/speakers/speakers.h
+++ b/sound/firewire/speakers/speakers.h
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/compat.h>
 
 #include <sound/control.h>
 #include <sound/core.h>
@@ -20,6 +21,8 @@
 #include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/rawmidi.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../cmp.h"
 #include "../fcp.h"
@@ -64,6 +67,10 @@ struct fwspk {
 	s16 volume[6];
 	s16 volume_min;
 	s16 volume_max;
+
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 /* AV/C Stream Format Information Specification 1.1 (Apr 2005, 1394TA) */
@@ -118,6 +125,10 @@ int firewave_stream_discover(struct fwspk *fwspk);
 int lacie_speakers_stream_discover(struct fwspk *fwspk);
 int snd_fwspk_stream_discover(struct fwspk *fwspk);
 
+void snd_fwspk_stream_lock_changed(struct fwspk *fwspk);
+int snd_fwspk_stream_lock_try(struct fwspk *fwspk);
+void snd_fwspk_stream_lock_release(struct fwspk *fwspk);
+
 int snd_fwspk_create_pcm(struct fwspk *fwspk);
 
 int snd_fwspk_create_mixer(struct fwspk *fwspk);
@@ -125,3 +136,5 @@ int snd_fwspk_create_mixer(struct fwspk *fwspk);
 void snd_fwspk_proc_init(struct fwspk *fwspk);
 
 int snd_fwspk_create_midi(struct fwspk *fwspk);
+
+int snd_fwspk_create_hwdep(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_hwdep.c b/sound/firewire/speakers/speakers_hwdep.c
new file mode 100644
index 0000000..eae7e184
--- /dev/null
+++ b/sound/firewire/speakers/speakers_hwdep.c
@@ -0,0 +1,195 @@
+/*
+ * speakers_hwdep.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+/*
+ * This codes give three functionality.
+ *
+ * 1.get firewire node infomation
+ * 2.get notification about starting/stopping stream
+ * 3.lock/unlock stream
+ */
+
+#include "speakers.h"
+
+static long
+hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+	   loff_t *offset)
+{
+	struct fwspk *fwspk = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&fwspk->lock);
+
+	while (!fwspk->dev_lock_changed) {
+		prepare_to_wait(&fwspk->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&fwspk->lock);
+		schedule();
+		finish_wait(&fwspk->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&fwspk->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (fwspk->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (fwspk->dev_lock_count > 0);
+		fwspk->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	}
+
+	spin_unlock_irq(&fwspk->lock);
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
+	return count;
+}
+
+static unsigned int
+hwdep_poll(struct snd_hwdep *hwdep, struct file *file, poll_table *wait)
+{
+	struct fwspk *fwspk = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &fwspk->hwdep_wait, wait);
+
+	spin_lock_irq(&fwspk->lock);
+	if (fwspk->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&fwspk->lock);
+
+	return events;
+}
+
+static int
+hwdep_get_info(struct fwspk *fwspk, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(fwspk->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_FWSPK;
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
+static int
+hwdep_lock(struct fwspk *fwspk)
+{
+	int err;
+
+	spin_lock_irq(&fwspk->lock);
+
+	if (fwspk->dev_lock_count == 0) {
+		fwspk->dev_lock_count = -1;
+		err = 0;
+	} else
+		err = -EBUSY;
+
+	spin_unlock_irq(&fwspk->lock);
+
+	return err;
+}
+
+static int
+hwdep_unlock(struct fwspk *fwspk)
+{
+	int err;
+
+	spin_lock_irq(&fwspk->lock);
+
+	if (fwspk->dev_lock_count == -1) {
+		fwspk->dev_lock_count = 0;
+		err = 0;
+	} else
+		err = -EBADFD;
+
+	spin_unlock_irq(&fwspk->lock);
+
+	return err;
+}
+
+static int
+hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct fwspk *fwspk = hwdep->private_data;
+
+	spin_lock_irq(&fwspk->lock);
+	if (fwspk->dev_lock_count == -1)
+		fwspk->dev_lock_count = 0;
+	spin_unlock_irq(&fwspk->lock);
+
+	return 0;
+}
+
+static int
+hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct fwspk *fwspk = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(fwspk, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(fwspk);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(fwspk);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static int
+hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
+		   unsigned int cmd, unsigned long arg)
+{
+	return hwdep_ioctl(hwdep, file, cmd,
+			   (unsigned long)compat_ptr(arg));
+}
+#else
+#define hwdep_compat_ioctl NULL
+#endif
+
+int snd_fwspk_create_hwdep(struct fwspk *fwspk)
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
+	err = snd_hwdep_new(fwspk->card, fwspk->card->driver, 0, &hwdep);
+	if (err < 0)
+		goto end;
+	strcpy(hwdep->name, fwspk->card->driver);
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_FWSPK;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = fwspk;
+	hwdep->exclusive = true;
+end:
+	return err;
+}
diff --git a/sound/firewire/speakers/speakers_stream.c b/sound/firewire/speakers/speakers_stream.c
index 2649f02..cc91160 100644
--- a/sound/firewire/speakers/speakers_stream.c
+++ b/sound/firewire/speakers/speakers_stream.c
@@ -493,3 +493,42 @@ int snd_fwspk_streams_init(struct fwspk *fwspk)
 end:
 	return err;
 }
+
+void snd_fwspk_stream_lock_changed(struct fwspk *fwspk)
+{
+	fwspk->dev_lock_changed = true;
+	wake_up(&fwspk->hwdep_wait);
+}
+
+int snd_fwspk_stream_lock_try(struct fwspk *fwspk)
+{
+	int err;
+
+	spin_lock_irq(&fwspk->lock);
+
+	/* user land lock this */
+	if (fwspk->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (fwspk->dev_lock_count++ == 0)
+		snd_fwspk_stream_lock_changed(fwspk);
+	err = 0;
+end:
+	spin_unlock_irq(&fwspk->lock);
+	return err;
+}
+
+void snd_fwspk_stream_lock_release(struct fwspk *fwspk)
+{
+	spin_lock_irq(&fwspk->lock);
+
+	if (WARN_ON(fwspk->dev_lock_count <= 0))
+		goto end;
+	if (--fwspk->dev_lock_count == 0)
+		snd_fwspk_stream_lock_changed(fwspk);
+end:
+	spin_unlock_irq(&fwspk->lock);
+}
-- 
1.8.3.2
