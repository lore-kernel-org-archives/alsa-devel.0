From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/15] ALSA: oxfw: Add hwdep interface
Date: Tue,  9 Dec 2014 00:10:49 +0900
Message-ID: <1418051449-18371-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 689852612DF
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:11:02 +0100 (CET)
In-Reply-To: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This interface is designed for mixer/control application. By using this
interface, an application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h       |   3 +-
 include/uapi/sound/firewire.h     |   3 +-
 sound/firewire/Kconfig            |   1 +
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw-hwdep.c  | 190 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw-midi.c   |  16 ++++
 sound/firewire/oxfw/oxfw-pcm.c    |  12 ++-
 sound/firewire/oxfw/oxfw-stream.c |  39 ++++++++
 sound/firewire/oxfw/oxfw.c        |   5 +
 sound/firewire/oxfw/oxfw.h        |  13 +++
 10 files changed, 280 insertions(+), 4 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 941d32f..1f23cd6 100644
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
index af4bd13..49122df 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -55,7 +55,8 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_DICE	1
 #define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
 #define SNDRV_FIREWIRE_TYPE_BEBOB	3
-/* AV/C, RME, MOTU, ... */
+#define SNDRV_FIREWIRE_TYPE_OXFW	4
+/* RME, MOTU, ... */
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 6364e5b..ecec547 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -26,6 +26,7 @@ config SND_DICE
 config SND_OXFW
 	tristate "Oxford Semiconductor FW970/971 chipset support"
 	select SND_FIREWIRE_LIB
+	select SND_HWDEP
 	help
 	  Say Y here to include support for FireWire devices based on
 	  Oxford Semiconductor FW970/971 chipset.
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 3904a30..a926850 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o \
-		 oxfw-proc.o oxfw-midi.o oxfw.o
+		 oxfw-proc.o oxfw-midi.o oxfw-hwdep.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-hwdep.c b/sound/firewire/oxfw/oxfw-hwdep.c
new file mode 100644
index 0000000..ff2687a
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-hwdep.c
@@ -0,0 +1,190 @@
+/*
+ * oxfw_hwdep.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
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
+#include "oxfw.h"
+
+static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+		       loff_t *offset)
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
+static unsigned int hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
+			       poll_table *wait)
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
+static int hwdep_get_info(struct snd_oxfw *oxfw, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(oxfw->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_OXFW;
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
+static int hwdep_lock(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	spin_lock_irq(&oxfw->lock);
+
+	if (oxfw->dev_lock_count == 0) {
+		oxfw->dev_lock_count = -1;
+		err = 0;
+	} else {
+		err = -EBUSY;
+	}
+
+	spin_unlock_irq(&oxfw->lock);
+
+	return err;
+}
+
+static int hwdep_unlock(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	spin_lock_irq(&oxfw->lock);
+
+	if (oxfw->dev_lock_count == -1) {
+		oxfw->dev_lock_count = 0;
+		err = 0;
+	} else {
+		err = -EBADFD;
+	}
+
+	spin_unlock_irq(&oxfw->lock);
+
+	return err;
+}
+
+static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
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
+static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+		       unsigned int cmd, unsigned long arg)
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
+int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw)
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
diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 334b11d..540a303 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -13,6 +13,10 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	struct snd_oxfw *oxfw = substream->rmidi->private_data;
 	int err;
 
+	err = snd_oxfw_stream_lock_try(oxfw);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&oxfw->mutex);
 
 	oxfw->capture_substreams++;
@@ -20,6 +24,9 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&oxfw->mutex);
 
+	if (err < 0)
+		snd_oxfw_stream_lock_release(oxfw);
+
 	return err;
 }
 
@@ -28,6 +35,10 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	struct snd_oxfw *oxfw = substream->rmidi->private_data;
 	int err;
 
+	err = snd_oxfw_stream_lock_try(oxfw);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&oxfw->mutex);
 
 	oxfw->playback_substreams++;
@@ -35,6 +46,9 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&oxfw->mutex);
 
+	if (err < 0)
+		snd_oxfw_stream_lock_release(oxfw);
+
 	return err;
 }
 
@@ -49,6 +63,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&oxfw->mutex);
 
+	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
 }
 
@@ -63,6 +78,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&oxfw->mutex);
 
+	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
 }
 
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index e84fc9c..9bc556b 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -192,10 +192,14 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	struct snd_oxfw *oxfw = substream->private_data;
 	int err;
 
-	err = init_hw_params(oxfw, substream);
+	err = snd_oxfw_stream_lock_try(oxfw);
 	if (err < 0)
 		goto end;
 
+	err = init_hw_params(oxfw, substream);
+	if (err < 0)
+		goto err_locked;
+
 	/*
 	 * When any PCM streams are already running, the available sampling
 	 * rate is limited at current value.
@@ -210,10 +214,16 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_set_sync(substream);
 end:
 	return err;
+err_locked:
+	snd_oxfw_stream_lock_release(oxfw);
+	return err;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_oxfw *oxfw = substream->private_data;
+
+	snd_oxfw_stream_lock_release(oxfw);
 	return 0;
 }
 
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index a38b3c3..b77cf80 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -644,3 +644,42 @@ int snd_oxfw_stream_discover(struct snd_oxfw *oxfw)
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
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 9cfbfb1..cf1d0b5 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -139,6 +139,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 	spin_lock_init(&oxfw->lock);
+	init_waitqueue_head(&oxfw->hwdep_wait);
 
 	err = snd_oxfw_stream_discover(oxfw);
 	if (err < 0)
@@ -164,6 +165,10 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_oxfw_create_hwdep(oxfw);
+	if (err < 0)
+		goto error;
+
 	err = snd_oxfw_stream_init_simplex(oxfw, &oxfw->rx_stream);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 83a54fc..cace5ad 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
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
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -64,6 +67,10 @@ struct snd_oxfw {
 	s16 volume[6];
 	s16 volume_min;
 	s16 volume_max;
+
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 /*
@@ -124,6 +131,10 @@ int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
 
 int snd_oxfw_stream_discover(struct snd_oxfw *oxfw);
 
+void snd_oxfw_stream_lock_changed(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_lock_try(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_lock_release(struct snd_oxfw *oxfw);
+
 int snd_oxfw_create_pcm(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
@@ -131,3 +142,5 @@ int snd_oxfw_create_mixer(struct snd_oxfw *oxfw);
 void snd_oxfw_proc_init(struct snd_oxfw *oxfw);
 
 int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
+
+int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw);
-- 
2.1.0
