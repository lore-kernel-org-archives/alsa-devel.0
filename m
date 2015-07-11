From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 37/37] ALSA: firewire-motu: add hwdep
	interface
Date: Sat, 11 Jul 2015 23:12:48 +0900
Message-ID: <1436623968-10780-38-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 105542605C7
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:07 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds hwdep interface so as the other firewire sound devices
has.

This interface is designed for mixer/control applications. By using this
interface, an application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h       |   3 +-
 include/uapi/sound/firewire.h     |   3 +-
 sound/firewire/motu/Makefile      |   2 +-
 sound/firewire/motu/motu-hwdep.c  | 210 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-midi.c   |   8 ++
 sound/firewire/motu/motu-pcm.c    |  22 +++-
 sound/firewire/motu/motu-stream.c |  38 +++++++
 sound/firewire/motu/motu.c        |   5 +
 sound/firewire/motu/motu.h        |  11 ++
 sound/firewire/tascam/tascam.c    |   1 +
 10 files changed, 295 insertions(+), 8 deletions(-)
 create mode 100644 sound/firewire/motu/motu-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index a82108e..31bc352 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -102,9 +102,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
 	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
+	SNDRV_HWDEP_IFACE_FW_MOTU,	/* MOTU FireWire series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_TASCAM
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_MOTU
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index c5cb86d..1fe4c87 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -65,7 +65,8 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_OXFW	4
 #define SNDRV_FIREWIRE_TYPE_DIGI00X	5
 #define SNDRV_FIREWIRE_TYPE_TASCAM	6
-/* RME, MOTU, ... */
+#define SNDRV_FIREWIRE_TYPE_MOTU	7
+/* RME, ... */
 
 struct snd_firewire_get_info {
 	unsigned int type; /* SNDRV_FIREWIRE_TYPE_xxx */
diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index e8055b9..b137da6 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu-transaction.o \
-			  motu-proc.o motu-pcm.o motu-midi.o motu.o
+			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-hwdep.c b/sound/firewire/motu/motu-hwdep.c
new file mode 100644
index 0000000..eb94e47
--- /dev/null
+++ b/sound/firewire/motu/motu-hwdep.c
@@ -0,0 +1,210 @@
+/*
+ * motu-hwdep.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
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
+static long hwdep_read_locked(struct snd_motu *motu, char __user *buf,
+			      long count,
+		  loff_t *offset)
+{
+	union snd_firewire_event event;
+
+	memset(&event, 0, sizeof(event));
+
+	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+	event.lock_status.status = (motu->dev_lock_count > 0);
+	motu->dev_lock_changed = false;
+
+	count = min_t(long, count, sizeof(event.lock_status));
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
+	return count;
+}
+
+static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
+		       loff_t *offset)
+{
+	struct snd_motu *motu = hwdep->private_data;
+	DEFINE_WAIT(wait);
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
+	if (motu->dev_lock_changed)
+		count = hwdep_read_locked(motu, buf, count, offset);
+
+	spin_unlock_irq(&motu->lock);
+
+	return count;
+}
+
+static long hwdep_write(struct snd_hwdep *hwdep, const char __user *data,
+			long count, loff_t *offset)
+{
+	/* TODO: Do something. */
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
+static const struct snd_hwdep_ops hwdep_ops = {
+	.read		= hwdep_read,
+	.write		= hwdep_write,
+	.release	= hwdep_release,
+	.poll		= hwdep_poll,
+	.ioctl		= hwdep_ioctl,
+	.ioctl_compat	= hwdep_compat_ioctl,
+};
+
+int snd_motu_create_hwdep_device(struct snd_motu *motu)
+{
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(motu->card, "MOTU", 0, &hwdep);
+	if (err < 0)
+		goto end;
+	strcpy(hwdep->name, "MOTU");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_FIREWORKS;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = motu;
+	hwdep->exclusive = true;
+end:
+	return err;
+}
diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
index ab40fb2..c58d249 100644
--- a/sound/firewire/motu/motu-midi.c
+++ b/sound/firewire/motu/motu-midi.c
@@ -12,6 +12,10 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 	struct snd_motu *motu = substream->rmidi->private_data;
 	int err;
 
+	err = snd_motu_stream_lock_try(motu);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&motu->mutex);
 
 	motu->substreams_counter++;
@@ -19,6 +23,9 @@ static int midi_open(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&motu->mutex);
 
+	if (err < 0)
+		snd_motu_stream_lock_release(motu);
+
 	return err;
 }
 
@@ -33,6 +40,7 @@ static int midi_close(struct snd_rawmidi_substream *substream)
 
 	mutex_unlock(&motu->mutex);
 
+	snd_motu_stream_lock_release(motu);
 	return 0;
 }
 
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
index b6c201f..b6e8ef9 100644
--- a/sound/firewire/motu/motu-pcm.c
+++ b/sound/firewire/motu/motu-pcm.c
@@ -163,19 +163,23 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	unsigned int rate;
 	int err;
 
+	err = snd_motu_stream_lock_try(motu);
+	if (err < 0)
+		return err;
+
 	mutex_lock(&motu->mutex);
 
 	err = snd_motu_stream_update_current_channels(motu);
 	if (err < 0)
-		goto end;
+		return err;
 
 	err = init_hw_info(motu, substream);
 	if (err < 0)
-		goto end;
+		goto err_locked;
 
 	err = snd_motu_stream_get_clock(motu, &src);
 	if (err < 0)
-		goto end;
+		goto err_locked;
 
 	/*
 	 * When source of clock is not internal or any PCM streams are running,
@@ -186,20 +190,28 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	    amdtp_stream_pcm_running(&motu->rx_stream)) {
 		err = snd_motu_stream_get_rate(motu, &rate);
 		if (err < 0)
-			goto end;
+			goto err_locked;
 		substream->runtime->hw.rate_min = rate;
 		substream->runtime->hw.rate_max = rate;
 	}
 
 	snd_pcm_set_sync(substream);
-end:
+
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
index d6fc84f..104fdc4 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -630,3 +630,41 @@ void snd_motu_stream_update_duplex(struct snd_motu *motu)
 	fw_iso_resources_update(&motu->tx_resources);
 	fw_iso_resources_update(&motu->rx_resources);
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
index 6c539ed..b3f3728 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -66,6 +66,7 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	mutex_init(&motu->mutex);
 	spin_lock_init(&motu->lock);
+	init_waitqueue_head(&motu->hwdep_wait);
 
 	name_card(motu);
 
@@ -87,6 +88,10 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto error;
 
+	err = snd_motu_create_hwdep_device(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 7ca8542..76347b2 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -16,6 +16,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/compat.h>
 
 #include <sound/control.h>
 #include <sound/core.h>
@@ -24,6 +25,8 @@
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../amdtp-stream.h"
 #include "../iso-resources.h"
@@ -65,6 +68,11 @@ struct snd_motu {
 
 	/* For messaging. */
 	struct fw_address_handler async_handler;
+
+	/* For uapi */
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 #define MOTU_REG_BASE		0xfffff0000000ull
@@ -96,6 +104,8 @@ void snd_motu_stream_destroy_duplex(struct snd_motu *motu);
 int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate);
 void snd_motu_stream_stop_duplex(struct snd_motu *motu);
 void snd_motu_stream_update_duplex(struct snd_motu *motu);
+int snd_motu_stream_lock_try(struct snd_motu *motu);
+void snd_motu_stream_lock_release(struct snd_motu *motu);
 
 int snd_motu_stream_get_rate(struct snd_motu *motu, unsigned int *rate);
 int snd_motu_stream_set_rate(struct snd_motu *motu, unsigned int rate);
@@ -113,4 +123,5 @@ int snd_motu_create_pcm_devices(struct snd_motu *motu);
 
 int snd_motu_create_midi_devices(struct snd_motu *motu);
 
+int snd_motu_create_hwdep_device(struct snd_motu *motu);
 #endif
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 80e8780..5bb27ea 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -122,6 +122,7 @@ static int snd_tscm_probe(struct fw_unit *unit,
 
 	mutex_init(&tscm->mutex);
 	spin_lock_init(&tscm->lock);
+	init_waitqueue_head(&tscm->hwdep_wait);
 
 	err = check_name(tscm);
 	if (err < 0)
-- 
2.1.4
