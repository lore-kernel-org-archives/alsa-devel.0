From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/18] ALSA: firewire-motu: add hwdep interface
Date: Wed, 22 Mar 2017 21:30:24 +0900
Message-ID: <20170322123028.24148-15-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 165A22673C7
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:42 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

This commit adds hwdep interface so as the other sound drivers for units
on IEEE 1394 bus have.

This interface is designed for mixer/control applications. By using this
interface, an application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h       |   3 +-
 include/uapi/sound/firewire.h     |   3 +-
 sound/firewire/motu/Makefile      |   2 +-
 sound/firewire/motu/motu-hwdep.c  | 192 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-midi.c   |  16 ++++
 sound/firewire/motu/motu-pcm.c    |  20 +++-
 sound/firewire/motu/motu-stream.c |  38 ++++++++
 sound/firewire/motu/motu.c        |   5 +
 sound/firewire/motu/motu.h        |  13 +++
 9 files changed, 285 insertions(+), 7 deletions(-)
 create mode 100644 sound/firewire/motu/motu-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index be353a7..fd7b561 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -107,9 +107,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 	SNDRV_HWDEP_IFACE_LINE6,	/* Line6 USB processors */
+	SNDRV_HWDEP_IFACE_FW_MOTU,	/* MOTU FireWire series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_LINE6
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_MOTU
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index db79a12..59c6d81 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -65,7 +65,8 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_OXFW	4
 #define SNDRV_FIREWIRE_TYPE_DIGI00X	5
 #define SNDRV_FIREWIRE_TYPE_TASCAM	6
-/* RME, MOTU, ... */
+#define SNDRV_FIREWIRE_TYPE_MOTU	7
+/* RME... */
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index a512c1e..cc195d5 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
-			  motu-proc.o motu-pcm.o motu-midi.o
+			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-hwdep.c b/sound/firewire/motu/motu-hwdep.c
new file mode 100644
index 0000000..e795a52
--- /dev/null
+++ b/sound/firewire/motu/motu-hwdep.c
@@ -0,0 +1,192 @@
+/*
+ * motu-hwdep.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+/*
+ * This codes have five functionalities.
+ *
+ * 1.get information about firewire node
+ * 2.get notification about starting/stopping stream
+ * 3.lock/unlock streaming
+ *
+ */
+
+#include "motu.h"
+
+static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
+		       loff_t *offset)
+{
+	struct snd_motu *motu = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&motu->lock);
+
+	while (!motu->dev_lock_changed) {
+		prepare_to_wait(&motu->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&motu->lock);
+		schedule();
+		finish_wait(&motu->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&motu->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (motu->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (motu->dev_lock_count > 0);
+		motu->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	}
+
+	spin_unlock_irq(&motu->lock);
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
+	struct snd_motu *motu = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &motu->hwdep_wait, wait);
+
+	spin_lock_irq(&motu->lock);
+	if (motu->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&motu->lock);
+
+	return events | POLLOUT;
+}
+
+static int hwdep_get_info(struct snd_motu *motu, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(motu->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_MOTU;
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
+static int hwdep_lock(struct snd_motu *motu)
+{
+	int err;
+
+	spin_lock_irq(&motu->lock);
+
+	if (motu->dev_lock_count == 0) {
+		motu->dev_lock_count = -1;
+		err = 0;
+	} else {
+		err = -EBUSY;
+	}
+
+	spin_unlock_irq(&motu->lock);
+
+	return err;
+}
+
+static int hwdep_unlock(struct snd_motu *motu)
+{
+	int err;
+
+	spin_lock_irq(&motu->lock);
+
+	if (motu->dev_lock_count == -1) {
+		motu->dev_lock_count = 0;
+		err = 0;
+	} else {
+		err = -EBADFD;
+	}
+
+	spin_unlock_irq(&motu->lock);
+
+	return err;
+}
+
+static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_motu *motu = hwdep->private_data;
+
+	spin_lock_irq(&motu->lock);
+	if (motu->dev_lock_count == -1)
+		motu->dev_lock_count = 0;
+	spin_unlock_irq(&motu->lock);
+
+	return 0;
+}
+
+static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct snd_motu *motu = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(motu, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(motu);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(motu);
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
+int snd_motu_create_hwdep_device(struct snd_motu *motu)
+{
+	static const struct snd_hwdep_ops ops = {
+		.read		= hwdep_read,
+		.release	= hwdep_release,
+		.poll		= hwdep_poll,
+		.ioctl		= hwdep_ioctl,
+		.ioctl_compat	= hwdep_compat_ioctl,
+	};
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(motu->card, motu->card->driver, 0, &hwdep);
+	if (err < 0)
+		return err;
+
+	strcpy(hwdep->name, "MOTU");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_MOTU;
+	hwdep->ops = ops;
+	hwdep->private_data = motu;
+	hwdep->exclusive = true;
+
+	return 0;
+}
diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
index f232f29..e3acfcc 100644
--- a/sound/firewire/motu/motu-midi.c
+++ b/sound/firewire/motu/motu-midi.c
@@ -12,6 +12,10 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 	struct snd_motu *motu = substream->rmidi->private_data;
 	int err;
 
+	err = snd_motu_stream_lock_try(motu);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&motu->mutex);
 
 	motu->capture_substreams++;
@@ -19,6 +23,9 @@ static int midi_capture_open(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&motu->mutex);
 
+	if (err < 0)
+		snd_motu_stream_lock_release(motu);
+
 	return err;
 }
 
@@ -27,6 +34,10 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	struct snd_motu *motu = substream->rmidi->private_data;
 	int err;
 
+	err = snd_motu_stream_lock_try(motu);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&motu->mutex);
 
 	motu->playback_substreams++;
@@ -34,6 +45,9 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&motu->mutex);
 
+	if (err < 0)
+		snd_motu_stream_lock_release(motu);
+
 	return err;
 }
 
@@ -48,6 +62,7 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&motu->mutex);
 
+	snd_motu_stream_lock_release(motu);
 	return 0;
 }
 
@@ -62,6 +77,7 @@ static int midi_playback_close(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&motu->mutex);
 
+	snd_motu_stream_lock_release(motu);
 	return 0;
 }
 
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index a50bcd6..94558f3 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -159,15 +159,19 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	unsigned int rate;
 	int err;
 
+	err = snd_motu_stream_lock_try(motu);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&motu->mutex);
 
 	err = protocol->cache_packet_formats(motu);
 	if (err < 0)
-		return err;
+		goto err_locked;
 
 	err = init_hw_info(motu, substream);
 	if (err < 0)
-		return err;
+		goto err_locked;
 
 	/*
 	 * When source of clock is not internal or any PCM streams are running,
@@ -175,13 +179,13 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	 */
 	err = protocol->get_clock_source(motu, &src);
 	if (err < 0)
-		return err;
+		goto err_locked;
 	if (src != SND_MOTU_CLOCK_SOURCE_INTERNAL ||
 	    amdtp_stream_pcm_running(&motu->tx_stream) ||
 	    amdtp_stream_pcm_running(&motu->rx_stream)) {
 		err = protocol->get_clock_rate(motu, &rate);
 		if (err < 0)
-			return err;
+			goto err_locked;
 		substream->runtime->hw.rate_min = rate;
 		substream->runtime->hw.rate_max = rate;
 	}
@@ -191,10 +195,18 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	mutex_unlock(&motu->mutex);
 
 	return err;
+err_locked:
+	mutex_unlock(&motu->mutex);
+	snd_motu_stream_lock_release(motu);
+	return err;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_motu *motu = substream->private_data;
+
+	snd_motu_stream_lock_release(motu);
+
 	return 0;
 }
 
diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 911d348..bd45802 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -341,3 +341,41 @@ void snd_motu_stream_destroy_duplex(struct snd_motu *motu)
 	motu->playback_substreams = 0;
 	motu->capture_substreams = 0;
 }
+
+static void motu_lock_changed(struct snd_motu *motu)
+{
+	motu->dev_lock_changed = true;
+	wake_up(&motu->hwdep_wait);
+}
+
+int snd_motu_stream_lock_try(struct snd_motu *motu)
+{
+	int err;
+
+	spin_lock_irq(&motu->lock);
+
+	if (motu->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (motu->dev_lock_count++ == 0)
+		motu_lock_changed(motu);
+	err = 0;
+out:
+	spin_unlock_irq(&motu->lock);
+	return err;
+}
+
+void snd_motu_stream_lock_release(struct snd_motu *motu)
+{
+	spin_lock_irq(&motu->lock);
+
+	if (WARN_ON(motu->dev_lock_count <= 0))
+		goto out;
+
+	if (--motu->dev_lock_count == 0)
+		motu_lock_changed(motu);
+out:
+	spin_unlock_irq(&motu->lock);
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index d4da137..619554b 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -109,6 +109,10 @@ static void do_registration(struct work_struct *work)
 			goto error;
 	}
 
+	err = snd_motu_create_hwdep_device(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(motu->card);
 	if (err < 0)
 		goto error;
@@ -145,6 +149,7 @@ static int motu_probe(struct fw_unit *unit,
 
 	mutex_init(&motu->mutex);
 	spin_lock_init(&motu->lock);
+	init_waitqueue_head(&motu->hwdep_wait);
 
 	/* Allocate and register this sound card later. */
 	INIT_DEFERRABLE_WORK(&motu->dwork, do_registration);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 338b351..7b1d85f 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -16,12 +16,16 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/compat.h>
+#include <linux/sched/signal.h>
 
 #include <sound/control.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
 #include <sound/rawmidi.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
@@ -62,6 +66,11 @@ struct snd_motu {
 	/* For notification. */
 	struct fw_address_handler async_handler;
 	u32 msg;
+
+	/* For uapi */
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 enum snd_motu_spec_flags {
@@ -136,10 +145,14 @@ int snd_motu_stream_init_duplex(struct snd_motu *motu);
 void snd_motu_stream_destroy_duplex(struct snd_motu *motu);
 int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate);
 void snd_motu_stream_stop_duplex(struct snd_motu *motu);
+int snd_motu_stream_lock_try(struct snd_motu *motu);
+void snd_motu_stream_lock_release(struct snd_motu *motu);
 
 void snd_motu_proc_init(struct snd_motu *motu);
 
 int snd_motu_create_pcm_devices(struct snd_motu *motu);
 
 int snd_motu_create_midi_devices(struct snd_motu *motu);
+
+int snd_motu_create_hwdep_device(struct snd_motu *motu);
 #endif
-- 
2.9.3
