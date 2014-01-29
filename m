From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/52] fireworks: Add hwdep interface
Date: Wed, 29 Jan 2014 22:44:31 +0900
Message-ID: <1391003099-7109-25-git-send-email-o-takashi@sakamocchi.jp>
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
 include/uapi/sound/asound.h                 |   3 +-
 include/uapi/sound/firewire.h               |   3 +-
 sound/firewire/Kconfig                      |   1 +
 sound/firewire/fireworks/Makefile           |   2 +-
 sound/firewire/fireworks/fireworks.c        |   5 +
 sound/firewire/fireworks/fireworks.h        |  12 ++
 sound/firewire/fireworks/fireworks_hwdep.c  | 197 ++++++++++++++++++++++++++++
 sound/firewire/fireworks/fireworks_midi.c   |  28 +++-
 sound/firewire/fireworks/fireworks_pcm.c    |  15 ++-
 sound/firewire/fireworks/fireworks_stream.c |  39 ++++++
 10 files changed, 293 insertions(+), 12 deletions(-)
 create mode 100644 sound/firewire/fireworks/fireworks_hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 9fc6219..5dfbfdf 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -94,9 +94,10 @@ enum {
 	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
 	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
 	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
+	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_DICE
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_FIREWORKS
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index 59f5961..fc9afb2 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -34,7 +34,8 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_IOCTL_UNLOCK    _IO('H', 0xfa)
 
 #define SNDRV_FIREWIRE_TYPE_DICE	1
-/* Fireworks, AV/C, RME, MOTU, ... */
+#define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
+/* AV/C, RME, MOTU, ... */
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index fb39f9c..875af02 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -66,6 +66,7 @@ config SND_FIREWORKS
 	select SND_FIREWIRE_LIB
 	select SND_RAWMIDI
 	select SND_PCM
+	select SND_HWDEP
 	help
 	  Say Y here to include support for FireWire devices based
 	  on Echo Digital Audio Fireworks board:
diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index d7ebf83..0c74408 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,4 +1,4 @@
 snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
 		      fireworks_stream.o fireworks_proc.o fireworks_midi.o \
-		      fireworks_pcm.o fireworks.o
+		      fireworks_pcm.o fireworks_hwdep.o fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index cd6e9cd..d845aec 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -192,6 +192,7 @@ efw_probe(struct fw_unit *unit,
 	efw->card_index = -1;
 	mutex_init(&efw->mutex);
 	spin_lock_init(&efw->lock);
+	init_waitqueue_head(&efw->hwdep_wait);
 
 	err = get_hardware_info(efw);
 	if (err < 0)
@@ -213,6 +214,10 @@ efw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_efw_create_hwdep_device(efw);
+	if (err < 0)
+		goto error;
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index d7e0198..713066d 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -24,6 +24,8 @@
 #include <sound/info.h>
 #include <sound/rawmidi.h>
 #include <sound/pcm_params.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -76,6 +78,11 @@ struct snd_efw {
 	unsigned int phys_in_grp_count;
 	struct snd_efw_phys_grp phys_out_grps[HWINFO_MAX_CAPS_GROUPS];
 	struct snd_efw_phys_grp phys_in_grps[HWINFO_MAX_CAPS_GROUPS];
+
+	/* for uapi */
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 struct snd_efw_transaction {
@@ -188,6 +195,9 @@ int snd_efw_stream_start_duplex(struct snd_efw *efw,
 int snd_efw_stream_stop_duplex(struct snd_efw *efw);
 void snd_efw_stream_update_duplex(struct snd_efw *efw);
 void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
+void snd_efw_stream_lock_changed(struct snd_efw *efw);
+int snd_efw_stream_lock_try(struct snd_efw *efw);
+void snd_efw_stream_lock_release(struct snd_efw *efw);
 
 void snd_efw_proc_init(struct snd_efw *efw);
 
@@ -196,6 +206,8 @@ int snd_efw_create_midi_devices(struct snd_efw *efw);
 int snd_efw_create_pcm_devices(struct snd_efw *efw);
 int snd_efw_get_multiplier_mode(unsigned int sampling_rate, unsigned int *mode);
 
+int snd_efw_create_hwdep_device(struct snd_efw *efw);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
new file mode 100644
index 0000000..4c28b6c
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -0,0 +1,197 @@
+/*
+ * fireworks_hwdep.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+/*
+ * This codes have three functionalities.
+ *
+ * 1.get information about firewire node
+ * 2.get notification about starting/stopping stream
+ * 3.lock/unlock streaming
+ */
+
+#include "fireworks.h"
+
+static long
+hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+	   loff_t *offset)
+{
+	struct snd_efw *efw = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&efw->lock);
+
+	while (!efw->dev_lock_changed) {
+		prepare_to_wait(&efw->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&efw->lock);
+		schedule();
+		finish_wait(&efw->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&efw->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (efw->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (efw->dev_lock_count > 0);
+		efw->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	}
+
+	spin_unlock_irq(&efw->lock);
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
+	struct snd_efw *efw = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &efw->hwdep_wait, wait);
+
+	spin_lock_irq(&efw->lock);
+	if (efw->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&efw->lock);
+
+	return events;
+}
+
+static int
+hwdep_get_info(struct snd_efw *efw, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(efw->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_FIREWORKS;
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
+hwdep_lock(struct snd_efw *efw)
+{
+	int err;
+
+	spin_lock_irq(&efw->lock);
+
+	if (efw->dev_lock_count == 0) {
+		efw->dev_lock_count = -1;
+		err = 0;
+	} else
+		err = -EBUSY;
+
+	spin_unlock_irq(&efw->lock);
+
+	return err;
+}
+
+static int
+hwdep_unlock(struct snd_efw *efw)
+{
+	int err;
+
+	spin_lock_irq(&efw->lock);
+
+	if (efw->dev_lock_count == -1) {
+		efw->dev_lock_count = 0;
+		err = 0;
+	} else
+		err = -EBADFD;
+
+	spin_unlock_irq(&efw->lock);
+
+	return err;
+}
+
+static int
+hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_efw *efw = hwdep->private_data;
+
+	spin_lock_irq(&efw->lock);
+	if (efw->dev_lock_count == -1)
+		efw->dev_lock_count = 0;
+	spin_unlock_irq(&efw->lock);
+
+	return 0;
+}
+
+static int
+hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct snd_efw *efw = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(efw, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(efw);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(efw);
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
+int snd_efw_create_hwdep_device(struct snd_efw *efw)
+{
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(efw->card, "Fireworks", 0, &hwdep);
+	if (err < 0)
+		goto end;
+	strcpy(hwdep->name, "Fireworks");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_FIREWORKS;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = efw;
+	hwdep->exclusive = true;
+end:
+	return err;
+}
+
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index 00bb747..748a75b 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -11,24 +11,38 @@
 static int midi_capture_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_efw *efw = substream->rmidi->private_data;
-	int err = 0;
+	int err;
+
+	err = snd_efw_stream_lock_try(efw);
+	if (err < 0)
+		goto end;
 
 	efw->tx_midi_substreams++;
-	if (!amdtp_stream_running(&efw->tx_stream))
+	if (!amdtp_stream_running(&efw->tx_stream)) {
 		err = snd_efw_stream_start_duplex(efw, &efw->tx_stream, 0);
-
+		if (err < 0)
+			snd_efw_stream_lock_release(efw);
+	}
+end:
 	return err;
 }
 
 static int midi_playback_open(struct snd_rawmidi_substream *substream)
 {
 	struct snd_efw *efw = substream->rmidi->private_data;
-	int err = 0;
+	int err;
+
+	err = snd_efw_stream_lock_try(efw);
+	if (err < 0)
+		goto end;
 
 	efw->rx_midi_substreams++;
-	if (!amdtp_stream_running(&efw->rx_stream))
+	if (!amdtp_stream_running(&efw->rx_stream)) {
 		err = snd_efw_stream_start_duplex(efw, &efw->rx_stream, 0);
-
+		if (err < 0)
+			snd_efw_stream_lock_release(efw);
+	}
+end:
 	return err;
 }
 
@@ -39,6 +53,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 	if (--efw->tx_midi_substreams == 0)
 		snd_efw_stream_stop_duplex(efw);
 
+	snd_efw_stream_lock_release(efw);
 	return 0;
 }
 
@@ -49,6 +64,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 	if (--efw->rx_midi_substreams == 0)
 		snd_efw_stream_stop_duplex(efw);
 
+	snd_efw_stream_lock_release(efw);
 	return 0;
 }
 
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 34da354..89126f1 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -264,13 +264,17 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	unsigned int clock_source;
 	int err;
 
-	err = pcm_init_hw_params(efw, substream);
+	err = snd_efw_stream_lock_try(efw);
 	if (err < 0)
 		goto end;
 
+	err = pcm_init_hw_params(efw, substream);
+	if (err < 0)
+		goto err_locked;
+
 	err = snd_efw_command_get_clock_source(efw, &clock_source);
 	if (err < 0)
-		goto end;
+		goto err_locked;
 
 	/*
 	 * When source of clock is not internal or any PCM streams are running,
@@ -281,7 +285,7 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	    amdtp_stream_pcm_running(&efw->rx_stream)) {
 		err = snd_efw_command_get_sampling_rate(efw, &sampling_rate);
 		if (err < 0)
-			goto end;
+			goto err_locked;
 		substream->runtime->hw.rate_min = sampling_rate;
 		substream->runtime->hw.rate_max = sampling_rate;
 	}
@@ -289,10 +293,15 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_set_sync(substream);
 end:
 	return err;
+err_locked:
+	snd_efw_stream_lock_release(efw);
+	return err;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_efw *efw = substream->private_data;
+	snd_efw_stream_lock_release(efw);
 	return 0;
 }
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index bd8febd..e92c9e5 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -315,3 +315,42 @@ void snd_efw_stream_destroy_duplex(struct snd_efw *efw)
 
 	mutex_unlock(&efw->mutex);
 }
+
+void snd_efw_stream_lock_changed(struct snd_efw *efw)
+{
+	efw->dev_lock_changed = true;
+	wake_up(&efw->hwdep_wait);
+}
+
+int snd_efw_stream_lock_try(struct snd_efw *efw)
+{
+	int err;
+
+	spin_lock_irq(&efw->lock);
+
+	/* user land lock this */
+	if (efw->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (efw->dev_lock_count++ == 0)
+		snd_efw_stream_lock_changed(efw);
+	err = 0;
+end:
+	spin_unlock_irq(&efw->lock);
+	return err;
+}
+
+void snd_efw_stream_lock_release(struct snd_efw *efw)
+{
+	spin_lock_irq(&efw->lock);
+
+	if (WARN_ON(efw->dev_lock_count <= 0))
+		goto end;
+	if (--efw->dev_lock_count == 0)
+		snd_efw_stream_lock_changed(efw);
+end:
+	spin_unlock_irq(&efw->lock);
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
