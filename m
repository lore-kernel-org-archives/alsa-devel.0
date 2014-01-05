From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/8] oxfw: Add hwdep interface
Date: Sun,  5 Jan 2014 20:13:37 +0900
Message-ID: <1388920417-5584-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 48252265176
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:13:57 +0100 (CET)
In-Reply-To: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
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
 include/uapi/sound/asound.h       |   3 +-
 include/uapi/sound/firewire.h     |   3 +-
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw.c        |   5 +
 sound/firewire/oxfw/oxfw.h        |  13 +++
 sound/firewire/oxfw/oxfw_hwdep.c  | 197 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw_midi.c   |  25 ++++-
 sound/firewire/oxfw/oxfw_pcm.c    |  13 ++-
 sound/firewire/oxfw/oxfw_stream.c |  39 ++++++++
 9 files changed, 293 insertions(+), 7 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw_hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 2249483..0c1872a 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -96,9 +96,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
 	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
 	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
+	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_OXFW
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index d69c0b6..1894e32 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -54,7 +54,8 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_DICE	1
 #define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
 #define SNDRV_FIREWIRE_TYPE_BEBOB	3
-/* AV/C, RME, MOTU, ... */
+#define SNDRV_FIREWIRE_TYPE_OXFW	4
+/* RME, MOTU, ... */
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index d119c06..c325245 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw_command.o oxfw_stream.o oxfw_proc.o oxfw_midi.o \
-		 oxfw_pcm.o oxfw.o
+		 oxfw_pcm.o oxfw_hwdep.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index d636463..b09d8ae 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -129,6 +129,7 @@ oxfw_probe(struct fw_unit *unit,
 	oxfw->card_index = -1;
 	mutex_init(&oxfw->mutex);
 	spin_lock_init(&oxfw->lock);
+	init_waitqueue_head(&oxfw->hwdep_wait);
 
 	err = name_device(oxfw, entry->vendor_id);
 	if (err < 0)
@@ -155,6 +156,10 @@ oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_oxfw_create_hwdep_device(oxfw);
+	if (err < 0)
+		goto error;
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 4be43ae..01c9c32 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -24,6 +24,8 @@
 #include <sound/rawmidi.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/hwdep.h>
+#include <sound/firewire.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -61,6 +63,11 @@ struct snd_oxfw {
 	struct amdtp_stream tx_stream;
 	struct cmp_connection in_conn;
 	struct amdtp_stream rx_stream;
+
+	/* for uapi */
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 /* AV/C Stream Format Information Specification 1.1 (Apr 2005, 1394TA) */
@@ -110,12 +117,18 @@ void snd_oxfw_stream_destroy_duplex(struct snd_oxfw *oxfw);
 
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 
+void snd_oxfw_stream_lock_changed(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_lock_try(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_lock_release(struct snd_oxfw *oxfw);
+
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_midi_devices(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_pcm_devices(struct snd_oxfw *oxfw);
 
+int snd_oxfw_create_hwdep_device(struct snd_oxfw *oxfw);
+
 #define SND_OXFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/oxfw/oxfw_hwdep.c b/sound/firewire/oxfw/oxfw_hwdep.c
new file mode 100644
index 0000000..4289626
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_hwdep.c
@@ -0,0 +1,197 @@
+/*
+ * oxfw_hwdep.c - a part of driver for OXFW970/971 based devices
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
+#include "oxfw.h"
+
+static long
+hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+	   loff_t *offset)
+{
+	struct snd_oxfw *oxfw = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&oxfw->lock);
+
+	while (!oxfw->dev_lock_changed) {
+		prepare_to_wait(&oxfw->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&oxfw->lock);
+		schedule();
+		finish_wait(&oxfw->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&oxfw->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (oxfw->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (oxfw->dev_lock_count > 0);
+		oxfw->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	}
+
+	spin_unlock_irq(&oxfw->lock);
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
+	struct snd_oxfw *oxfw = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &oxfw->hwdep_wait, wait);
+
+	spin_lock_irq(&oxfw->lock);
+	if (oxfw->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&oxfw->lock);
+
+	return events;
+}
+
+static int
+hwdep_get_info(struct snd_oxfw *oxfw, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(oxfw->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_BEBOB;
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
+hwdep_lock(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	spin_lock_irq(&oxfw->lock);
+
+	if (oxfw->dev_lock_count == 0) {
+		oxfw->dev_lock_count = -1;
+		err = 0;
+	} else
+		err = -EBUSY;
+
+	spin_unlock_irq(&oxfw->lock);
+
+	return err;
+}
+
+static int
+hwdep_unlock(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	spin_lock_irq(&oxfw->lock);
+
+	if (oxfw->dev_lock_count == -1) {
+		oxfw->dev_lock_count = 0;
+		err = 0;
+	} else
+		err = -EBADFD;
+
+	spin_unlock_irq(&oxfw->lock);
+
+	return err;
+}
+
+static int
+hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_oxfw *oxfw = hwdep->private_data;
+
+	spin_lock_irq(&oxfw->lock);
+	if (oxfw->dev_lock_count == -1)
+		oxfw->dev_lock_count = 0;
+	spin_unlock_irq(&oxfw->lock);
+
+	return 0;
+}
+
+static int
+hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct snd_oxfw *oxfw = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(oxfw, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(oxfw);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(oxfw);
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
+static const struct snd_hwdep_ops hwdep_ops = {
+	.read		= hwdep_read,
+	.release	= hwdep_release,
+	.poll		= hwdep_poll,
+	.ioctl		= hwdep_ioctl,
+	.ioctl_compat	= hwdep_compat_ioctl,
+};
+
+int snd_oxfw_create_hwdep_device(struct snd_oxfw *oxfw)
+{
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(oxfw->card, oxfw->card->driver, 0, &hwdep);
+	if (err < 0)
+		goto end;
+	strcpy(hwdep->name, oxfw->card->driver);
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_OXFW;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = oxfw;
+	hwdep->exclusive = true;
+end:
+	return err;
+}
+
diff --git a/sound/firewire/oxfw/oxfw_midi.c b/sound/firewire/oxfw/oxfw_midi.c
index 41c14ec..d18c195 100644
--- a/sound/firewire/oxfw/oxfw_midi.c
+++ b/sound/firewire/oxfw/oxfw_midi.c
@@ -11,19 +11,40 @@
 static int midi_capture_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->rmidi->private_data;
-	return snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream, 0);
+	int err;
+
+	err = snd_oxfw_stream_lock_try(oxfw);
+	if (err < 0)
+		goto end;
+
+	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->tx_stream, 0);
+	if (err < 0)
+		snd_oxfw_stream_lock_release(oxfw);
+end:
+	return err;
 }
 
 static int midi_playback_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->rmidi->private_data;
-	return snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream, 0);
+	int err;
+
+	err = snd_oxfw_stream_lock_try(oxfw);
+	if (err < 0)
+		goto end;
+
+	err = snd_oxfw_stream_start_duplex(oxfw, &oxfw->rx_stream, 0);
+	if (err < 0)
+		snd_oxfw_stream_lock_release(oxfw);
+end:
+	return err;
 }
 
 static int midi_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->rmidi->private_data;
 	snd_oxfw_stream_stop_duplex(oxfw);
+	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
 }
 
diff --git a/sound/firewire/oxfw/oxfw_pcm.c b/sound/firewire/oxfw/oxfw_pcm.c
index dbd5731..b911ddc 100644
--- a/sound/firewire/oxfw/oxfw_pcm.c
+++ b/sound/firewire/oxfw/oxfw_pcm.c
@@ -236,10 +236,14 @@ pcm_open(struct snd_pcm_substream *substream)
 	unsigned int sampling_rate;
 	int err;
 
-	err = pcm_init_hw_params(oxfw, substream);
+	err = snd_oxfw_stream_lock_try(oxfw);
 	if (err < 0)
 		goto end;
 
+	err = pcm_init_hw_params(oxfw, substream);
+	if (err < 0)
+		goto err_locked;
+
 	/*
 	 * When any PCM stream are running, the available sampling rate is
 	 * limited at current sampling rate.
@@ -248,7 +252,7 @@ pcm_open(struct snd_pcm_substream *substream)
 	    amdtp_stream_pcm_running(&oxfw->rx_stream)) {
 		err = snd_oxfw_stream_get_rate(oxfw, &sampling_rate);
 		if (err < 0)
-			goto end;
+			goto err_locked;
 
 		substream->runtime->hw.rate_min = sampling_rate;
 		substream->runtime->hw.rate_max = sampling_rate;
@@ -257,11 +261,16 @@ pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_set_sync(substream);
 end:
 	return err;
+err_locked:
+	snd_oxfw_stream_lock_release(oxfw);
+	return err;
 }
 
 static int
 pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_oxfw *oxfw = substream->private_data;
+	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
 }
 
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
index ad2dd86..5a06fe4 100644
--- a/sound/firewire/oxfw/oxfw_stream.c
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -598,3 +598,42 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
 end:
 	return err;
 }
+
+void snd_oxfw_stream_lock_changed(struct snd_oxfw *oxfw)
+{
+	oxfw->dev_lock_changed = true;
+	wake_up(&oxfw->hwdep_wait);
+}
+
+int snd_oxfw_stream_lock_try(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	spin_lock_irq(&oxfw->lock);
+
+	/* user land lock this */
+	if (oxfw->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (oxfw->dev_lock_count++ == 0)
+		snd_oxfw_stream_lock_changed(oxfw);
+	err = 0;
+end:
+	spin_unlock_irq(&oxfw->lock);
+	return err;
+}
+
+void snd_oxfw_stream_lock_release(struct snd_oxfw *oxfw)
+{
+	spin_lock_irq(&oxfw->lock);
+
+	if (WARN_ON(oxfw->dev_lock_count <= 0))
+		goto end;
+	if (--oxfw->dev_lock_count == 0)
+		snd_oxfw_stream_lock_changed(oxfw);
+end:
+	spin_unlock_irq(&oxfw->lock);
+}
-- 
1.8.3.2
