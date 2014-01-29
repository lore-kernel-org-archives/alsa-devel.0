From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 31/52] bebob: Add hwdep interface
Date: Wed, 29 Jan 2014 22:44:38 +0900
Message-ID: <1391003099-7109-32-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This interface is designed for mixer/control application. To use hwdep
interface, the application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h         |   3 +-
 include/uapi/sound/firewire.h       |   1 +
 sound/firewire/Kconfig              |   1 +
 sound/firewire/bebob/Makefile       |   2 +-
 sound/firewire/bebob/bebob.c        |   5 +
 sound/firewire/bebob/bebob.h        |  13 +++
 sound/firewire/bebob/bebob_hwdep.c  | 197 ++++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_midi.c   |  28 +++--
 sound/firewire/bebob/bebob_pcm.c    |  16 ++-
 sound/firewire/bebob/bebob_stream.c |  39 +++++++
 10 files changed, 293 insertions(+), 12 deletions(-)
 create mode 100644 sound/firewire/bebob/bebob_hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 5dfbfdf..2249483 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -95,9 +95,10 @@ enum {
 	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
 	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
 	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
+	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREWORKS
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index 7f4c419..d69c0b6 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -53,6 +53,7 @@ union snd_firewire_event {
 
 #define SNDRV_FIREWIRE_TYPE_DICE	1
 #define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
+#define SNDRV_FIREWIRE_TYPE_BEBOB	3
 /* AV/C, RME, MOTU, ... */
 
 struct snd_firewire_get_info {
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 022fee0..060fe7e 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -84,6 +84,7 @@ config SND_BEBOB
 	select SND_FIREWIRE_LIB
 	select SND_RAWMIDI
 	select SND_PCM
+	select SND_HWDEP
         help
 	 Say Y here to include support for FireWire devices based
 	 on BridgeCo DM1000/1500 with BeBoB firmware:
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 533718a..7808777 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
-		  bebob_pcm.o \
+		  bebob_pcm.o bebob_hwdep.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index a56917d..19f2831 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -154,6 +154,7 @@ bebob_probe(struct fw_unit *unit,
 	bebob->card_index = -1;
 	mutex_init(&bebob->mutex);
 	spin_lock_init(&bebob->lock);
+	init_waitqueue_head(&bebob->hwdep_wait);
 
 	err = name_device(bebob, entry->vendor_id);
 	if (err < 0)
@@ -180,6 +181,10 @@ bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_bebob_create_hwdep_device(bebob);
+	if (err < 0)
+		goto error;
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0) {
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index ddd31a2..57ad5e6 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -24,6 +24,8 @@
 #include <sound/rawmidi.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../lib.h"
 #include "../fcp.h"
@@ -70,6 +72,11 @@ struct snd_bebob {
 		rx_stream_formations[SND_BEBOB_STRM_FMT_ENTRIES];
 
 	int sync_input_plug;
+
+	/* for uapi */
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 static inline int
@@ -179,12 +186,18 @@ int snd_bebob_stream_stop_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_update_duplex(struct snd_bebob *bebob);
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob);
 
+void snd_bebob_stream_lock_changed(struct snd_bebob *bebob);
+int snd_bebob_stream_lock_try(struct snd_bebob *bebob);
+void snd_bebob_stream_lock_release(struct snd_bebob *bebob);
+
 void snd_bebob_proc_init(struct snd_bebob *bebob);
 
 int snd_bebob_create_midi_devices(struct snd_bebob *bebob);
 
 int snd_bebob_create_pcm_devices(struct snd_bebob *bebob);
 
+int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_hwdep.c b/sound/firewire/bebob/bebob_hwdep.c
new file mode 100644
index 0000000..54937c0
--- /dev/null
+++ b/sound/firewire/bebob/bebob_hwdep.c
@@ -0,0 +1,197 @@
+/*
+ * bebob_hwdep.c - a part of driver for BeBoB based devices
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
+		count = min_t(long, count, sizeof(event.lock_status));
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
index 10945fe16..2eb2813 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -11,26 +11,40 @@
 static int midi_capture_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
-	int err = 0;
+	int err;
+
+	err = snd_bebob_stream_lock_try(bebob);
+	if (err < 0)
+		goto end;
 
 	bebob->tx_midi_substreams++;
-	if (!amdtp_stream_running(&bebob->tx_stream))
+	if (!amdtp_stream_running(&bebob->tx_stream)) {
 		err = snd_bebob_stream_start_duplex(bebob,
 						    &bebob->tx_stream, 0);
-
+		if (err < 0)
+			snd_bebob_stream_lock_release(bebob);
+	}
+end:
 	return err;
 }
 
 static int midi_playback_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_bebob *bebob = substream->rmidi->private_data;
-	int err = 0;
+	int err;
+
+	err = snd_bebob_stream_lock_try(bebob);
+	if (err < 0)
+		goto end;
 
 	bebob->rx_midi_substreams++;
-	if (!amdtp_stream_running(&bebob->rx_stream))
+	if (!amdtp_stream_running(&bebob->rx_stream)) {
 		err = snd_bebob_stream_start_duplex(bebob,
 						    &bebob->rx_stream, 0);
-
+		if (err < 0)
+			snd_bebob_stream_lock_release(bebob);
+	}
+end:
 	return err;
 }
 
@@ -41,6 +55,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 	if (--bebob->tx_midi_substreams == 0)
 		snd_bebob_stream_stop_duplex(bebob);
 
+	snd_bebob_stream_lock_release(bebob);
 	return 0;
 }
 
@@ -51,6 +66,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	if (--bebob->rx_midi_substreams == 0)
 		snd_bebob_stream_stop_duplex(bebob);
 
+	snd_bebob_stream_lock_release(bebob);
 	return 0;
 }
 
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index e4c6c11..70fa53a 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -228,13 +228,17 @@ pcm_open(struct snd_pcm_substream *substream)
 	bool internal;
 	int err;
 
-	err = pcm_init_hw_params(bebob, substream);
+	err = snd_bebob_stream_lock_try(bebob);
 	if (err < 0)
 		goto end;
 
+	err = pcm_init_hw_params(bebob, substream);
+	if (err < 0)
+		goto err_locked;
+
 	err = snd_bebob_stream_check_internal_clock(bebob, &internal);
 	if (err < 0)
-		goto end;
+		goto err_locked;
 
 	/*
 	 * When source of clock is internal or any PCM stream are running,
@@ -245,21 +249,25 @@ pcm_open(struct snd_pcm_substream *substream)
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
index f70b8c0..273843b 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -786,3 +786,42 @@ int snd_bebob_stream_discover(struct snd_bebob *bebob)
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


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
