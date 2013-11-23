From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/13] bebob: Add hwdep interface to
	lock/unlock streaming
Date: Sat, 23 Nov 2013 15:09:19 +0900
Message-ID: <1385186965-8303-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D0F8E26530D
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:36 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is for mixer/control application in user land. The application can
lock/unlock kernel streaming or get notification at starting kernel streaming
to use hwdep interface.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h         |   3 +-
 include/uapi/sound/firewire.h       |   1 +
 sound/firewire/Kconfig              |   1 +
 sound/firewire/bebob/Makefile       |   2 +-
 sound/firewire/bebob/bebob.c        |   5 +
 sound/firewire/bebob/bebob.h        |  13 +++
 sound/firewire/bebob/bebob_hwdep.c  | 207 ++++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c   |  10 ++
 sound/firewire/bebob/bebob_pcm.c    |  14 ++-
 sound/firewire/bebob/bebob_stream.c |  39 +++++++
 10 files changed, 290 insertions(+), 5 deletions(-)
 create mode 100644 sound/firewire/bebob/bebob_hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 9fc6219..d8bc723 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -94,9 +94,10 @@ enum {
 	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
 	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
 	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
+	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based Device */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_DICE
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index 59f5961..c600b143 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -34,6 +34,7 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_IOCTL_UNLOCK    _IO('H', 0xfa)
 
 #define SNDRV_FIREWIRE_TYPE_DICE	1
+#define SNDRV_FIREWIRE_TYPE_BEBOB	2
 /* Fireworks, AV/C, RME, MOTU, ... */
 
 struct snd_firewire_get_info {
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 7641772..c46578e 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -65,6 +65,7 @@ config SND_BEBOB
 	tristate "BridgeCo BeBoB chipset support"
 	select SND_RAWMIDI
 	select SND_PCM
+	select SND_HWDEP
 	select SND_FIREWIRE_LIB
         help
 	 Say Y here to include support for FireWire devices based
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 30e79e6..81e14fa 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
-		  bebob_midi.o bebob_pcm.o \
+		  bebob_midi.o bebob_pcm.o bebob_hwdep.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 2fdd14b..219eac7 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -171,12 +171,17 @@ snd_bebob_probe(struct fw_unit *unit,
 	bebob->card_index = -1;
 	mutex_init(&bebob->mutex);
 	spin_lock_init(&bebob->lock);
+	init_waitqueue_head(&bebob->hwdep_wait);
 
 	/* name device with communication */
 	err = name_device(bebob, entry->vendor_id);
 	if (err < 0)
 		goto error;
 
+	err = snd_bebob_create_hwdep_device(bebob);
+	if (err < 0)
+		goto error;
+
 	err = snd_bebob_create_pcm_devices(bebob);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 04842b2..3950b02 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -34,6 +34,8 @@
 #include <sound/rawmidi.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -79,6 +81,11 @@ struct snd_bebob {
 		rx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
 
 	struct snd_ctl_elem_id *ctl_id_freq;
+
+        /* for uapi */
+        int dev_lock_count;
+        bool dev_lock_changed;
+        wait_queue_head_t hwdep_wait;
 };
 
 static inline int
@@ -152,6 +159,10 @@ int snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
+void snd_bebob_stream_lock_changed(struct snd_bebob *bebob);
+int snd_bebob_stream_lock_try(struct snd_bebob *bebob);
+void snd_bebob_stream_lock_release(struct snd_bebob *bebob);
+
 void snd_bebob_proc_init(struct snd_bebob *bebob);
 
 int snd_bebob_create_control_devices(struct snd_bebob *bebob);
@@ -160,6 +171,8 @@ int snd_bebob_create_midi_devices(struct snd_bebob *bebob);
 
 int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 
+int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_hwdep.c b/sound/firewire/bebob/bebob_hwdep.c
new file mode 100644
index 0000000..be423b7
--- /dev/null
+++ b/sound/firewire/bebob/bebob_hwdep.c
@@ -0,0 +1,207 @@
+/*
+ * fireworks_hwdep.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * This codes give three functionality.
+ * 
+ * 1.get firewire node reference
+ * 2.lock/unlock stream
+ *  dice driver implements the same functionality.
+ */
+
+#include "bebob.h"
+
+static long
+hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+	   loff_t *offset)
+{
+	struct snd_bebob *bebob = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&bebob->lock);
+
+	while (!bebob->dev_lock_changed) {
+		prepare_to_wait(&bebob->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&bebob->lock);
+		schedule();
+		finish_wait(&bebob->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&bebob->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (bebob->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (bebob->dev_lock_count > 0);
+		bebob->dev_lock_changed = false;
+
+		count = min(count, (long)sizeof(event.lock_status));
+	} 
+
+	spin_unlock_irq(&bebob->lock);
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
+	struct snd_bebob *bebob = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &bebob->hwdep_wait, wait);
+
+	spin_lock_irq(&bebob->lock);
+	if (bebob->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&bebob->lock);
+
+	return events;
+}
+
+static int
+hwdep_get_info(struct snd_bebob *bebob, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(bebob->unit);
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
+hwdep_lock(struct snd_bebob *bebob)
+{
+	int err;
+
+	spin_lock_irq(&bebob->lock);
+
+	if (bebob->dev_lock_count == 0) {
+		bebob->dev_lock_count = -1;
+		err = 0;
+	} else
+		err = -EBUSY;
+
+	spin_unlock_irq(&bebob->lock);
+
+	return err;
+}
+
+static int
+hwdep_unlock(struct snd_bebob *bebob)
+{
+	int err;
+
+	spin_lock_irq(&bebob->lock);
+
+	if (bebob->dev_lock_count == -1) {
+		bebob->dev_lock_count = 0;
+		err = 0;
+	} else
+		err = -EBADFD;
+
+	spin_unlock_irq(&bebob->lock);
+
+	return err;
+}
+
+static int
+hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_bebob *bebob = hwdep->private_data;
+
+	spin_lock_irq(&bebob->lock);
+	if (bebob->dev_lock_count == -1)
+		bebob->dev_lock_count = 0;
+	spin_unlock_irq(&bebob->lock);
+
+	return 0;
+}
+
+static int
+hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct snd_bebob *bebob = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(bebob, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(bebob);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(bebob);
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
+int snd_bebob_create_hwdep_device(struct snd_bebob *bebob)
+{
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(bebob->card, "BeBoB", 0, &hwdep);
+	if (err < 0)
+		goto end;
+	strcpy(hwdep->name, "BeBoB");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_BEBOB;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = bebob;
+	hwdep->exclusive = true;
+end:
+	return err;
+}
+
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 56c7115..a5a4028 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -26,6 +26,10 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 	int err;
 
+	err = snd_bebob_stream_lock_try(bebob);
+	if (err < 0)
+		goto end;
+
 	err = snd_bebob_stream_start_duplex(bebob, &bebob->tx_stream, 0);
 	if (err < 0)
 		goto end;
@@ -40,6 +44,10 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	struct snd_bebob *bebob = substream->rmidi->private_data;
 	int err;
 
+	err = snd_bebob_stream_lock_try(bebob);
+	if (err < 0)
+		goto end;
+
 	err = snd_bebob_stream_start_duplex(bebob, &bebob->rx_stream, 0);
 	if (err < 0)
 		goto end;
@@ -55,6 +63,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 
 	amdtp_stream_midi_remove(&bebob->tx_stream, substream);
 	snd_bebob_stream_stop_duplex(bebob);
+	snd_bebob_stream_lock_release(bebob);
 
 	return 0;
 }
@@ -65,6 +74,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 
 	amdtp_stream_midi_remove(&bebob->rx_stream, substream);
 	snd_bebob_stream_stop_duplex(bebob);
+	snd_bebob_stream_lock_release(bebob);
 
 	return 0;
 }
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 04913b2..c7cca80 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -239,29 +239,37 @@ pcm_open(struct snd_pcm_substream *substream)
 	unsigned int sampling_rate;
 	int err;
 
-	err = pcm_init_hw_params(bebob, substream);
+	err = snd_bebob_stream_lock_try(bebob);
 	if (err < 0)
 		goto end;
 
+	err = pcm_init_hw_params(bebob, substream);
+	if (err < 0)
+		goto err_locked;
+
 	if (amdtp_stream_pcm_running(&bebob->tx_stream) ||
 	    amdtp_stream_pcm_running(&bebob->rx_stream)) {
 		err = snd_bebob_stream_get_rate(bebob, &sampling_rate);
 		if (err < 0)
-			goto end;
+			goto err_locked;
 
 		substream->runtime->hw.rate_min = sampling_rate;
 		substream->runtime->hw.rate_max = sampling_rate;
 	}
 
 	snd_pcm_set_sync(substream);
-
 end:
 	return err;
+err_locked:
+	snd_bebob_stream_lock_release(bebob);
+	return err;
 }
 
 static int
 pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_bebob *bebob = substream->private_data;
+	snd_bebob_stream_lock_release(bebob);
 	return 0;
 }
 
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 773dffb..f2527bf 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -666,3 +666,42 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob)
 end:
 	return err;
 }
+
+void snd_bebob_stream_lock_changed(struct snd_bebob *bebob)
+{
+	bebob->dev_lock_changed = true;
+	wake_up(&bebob->hwdep_wait);
+}
+
+int snd_bebob_stream_lock_try(struct snd_bebob *bebob)
+{
+	int err;
+
+	spin_lock_irq(&bebob->lock);
+
+	/* user land lock this */
+	if (bebob->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (bebob->dev_lock_count++ == 0)
+		snd_bebob_stream_lock_changed(bebob);
+	err = 0;
+end:
+	spin_unlock_irq(&bebob->lock);
+	return err;
+}
+
+void snd_bebob_stream_lock_release(struct snd_bebob *bebob)
+{
+	spin_lock_irq(&bebob->lock);
+
+	if (WARN_ON(bebob->dev_lock_count <= 0))
+		goto end;
+	if (--bebob->dev_lock_count == 0)
+		snd_bebob_stream_lock_changed(bebob);
+end:
+	spin_unlock_irq(&bebob->lock);
+}
-- 
1.8.3.2
