From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 25/37] ALSA: firewire-tascam: add hwdep
	interface
Date: Sat, 11 Jul 2015 23:12:36 +0900
Message-ID: <1436623968-10780-26-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 713912605B0
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:06 +0200 (CEST)
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
 include/uapi/sound/asound.h           |   3 +-
 include/uapi/sound/firewire.h         |   1 +
 sound/firewire/Kconfig                |   1 +
 sound/firewire/tascam/Makefile        |   2 +-
 sound/firewire/tascam/tascam-hwdep.c  | 202 ++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam-pcm.c    |  17 ++-
 sound/firewire/tascam/tascam-stream.c |  39 +++++++
 sound/firewire/tascam/tascam.c        |   4 +
 sound/firewire/tascam/tascam.h        |  11 ++
 9 files changed, 275 insertions(+), 5 deletions(-)
 create mode 100644 sound/firewire/tascam/tascam-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index aa32913..a82108e 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -101,9 +101,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
 	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
 	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
+	SNDRV_HWDEP_IFACE_FW_TASCAM,	/* TASCAM FireWire series */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_DIGI00X
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_TASCAM
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index deb041c..db79a12 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -64,6 +64,7 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_BEBOB	3
 #define SNDRV_FIREWIRE_TYPE_OXFW	4
 #define SNDRV_FIREWIRE_TYPE_DIGI00X	5
+#define SNDRV_FIREWIRE_TYPE_TASCAM	6
 /* RME, MOTU, ... */
 
 struct snd_firewire_get_info {
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index ce51fdd..12993fa 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -138,6 +138,7 @@ config SND_FIREWIRE_DIGI00X
 config SND_FIREWIRE_TASCAM
 	tristate "TASCAM FireWire series support"
 	select SND_FIREWIRE_LIB
+	select SND_HWDEP
 	help
 	 Say Y here to include support for TASCAM.
 	  * FW-1884
diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index fcfe125..983d20d 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,4 +1,4 @@
 snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam-stream.o \
 			    tascam-pcm.o tascam-transaction.o tascam-midi.o \
-			    tascam.o
+			    tascam-hwdep.o tascam.o
 obj-m += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
new file mode 100644
index 0000000..4b539f5
--- /dev/null
+++ b/sound/firewire/tascam/tascam-hwdep.c
@@ -0,0 +1,202 @@
+/*
+ * tascam-hwdep.c - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
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
+ * 4.get asynchronous messaging
+ */
+
+#include "tascam.h"
+
+static long hwdep_read_locked(struct snd_tscm *tscm, char __user *buf,
+			      long count)
+{
+	union snd_firewire_event event;
+
+	memset(&event, 0, sizeof(event));
+
+	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+	event.lock_status.status = (tscm->dev_lock_count > 0);
+	tscm->dev_lock_changed = false;
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
+	struct snd_tscm *tscm = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&tscm->lock);
+
+	while (!tscm->dev_lock_changed) {
+		prepare_to_wait(&tscm->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&tscm->lock);
+		schedule();
+		finish_wait(&tscm->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&tscm->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	count = hwdep_read_locked(tscm, buf, count);
+	spin_unlock_irq(&tscm->lock);
+
+	return count;
+}
+
+static unsigned int hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
+			       poll_table *wait)
+{
+	struct snd_tscm *tscm = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &tscm->hwdep_wait, wait);
+
+	spin_lock_irq(&tscm->lock);
+	if (tscm->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&tscm->lock);
+
+	return events;
+}
+
+static int hwdep_get_info(struct snd_tscm *tscm, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(tscm->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_TASCAM;
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
+static int hwdep_lock(struct snd_tscm *tscm)
+{
+	int err;
+
+	spin_lock_irq(&tscm->lock);
+
+	if (tscm->dev_lock_count == 0) {
+		tscm->dev_lock_count = -1;
+		err = 0;
+	} else {
+		err = -EBUSY;
+	}
+
+	spin_unlock_irq(&tscm->lock);
+
+	return err;
+}
+
+static int hwdep_unlock(struct snd_tscm *tscm)
+{
+	int err;
+
+	spin_lock_irq(&tscm->lock);
+
+	if (tscm->dev_lock_count == -1) {
+		tscm->dev_lock_count = 0;
+		err = 0;
+	} else {
+		err = -EBADFD;
+	}
+
+	spin_unlock_irq(&tscm->lock);
+
+	return err;
+}
+
+static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_tscm *tscm = hwdep->private_data;
+
+	spin_lock_irq(&tscm->lock);
+	if (tscm->dev_lock_count == -1)
+		tscm->dev_lock_count = 0;
+	spin_unlock_irq(&tscm->lock);
+
+	return 0;
+}
+
+static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct snd_tscm *tscm = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(tscm, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(tscm);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(tscm);
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
+	.release	= hwdep_release,
+	.poll		= hwdep_poll,
+	.ioctl		= hwdep_ioctl,
+	.ioctl_compat	= hwdep_compat_ioctl,
+};
+
+int snd_tscm_create_hwdep_device(struct snd_tscm *tscm)
+{
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(tscm->card, "Digi00x", 0, &hwdep);
+	if (err < 0)
+		return err;
+
+	strcpy(hwdep->name, "Digi00x");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_TASCAM;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = tscm;
+	hwdep->exclusive = true;
+
+	return err;
+}
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index b1bdb9f..70ab68b 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -86,9 +86,13 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	unsigned int rate;
 	int err;
 
+	err = snd_tscm_stream_lock_try(tscm);
+	if (err < 0)
+		goto end;
+
 	err = pcm_init_hw_params(tscm, substream);
 	if (err < 0)
-		return err;
+		goto err_locked;
 
 	err = snd_tscm_stream_get_clock(tscm, &clock);
 	if ((clock != SND_TSCM_CLOCK_INTERNAL) |
@@ -96,18 +100,25 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	    amdtp_stream_pcm_running(&tscm->tx_stream)) {
 		err = snd_tscm_stream_get_rate(tscm, &rate);
 		if (err < 0)
-			return err;
+			goto err_locked;
 		substream->runtime->hw.rate_min = rate;
 		substream->runtime->hw.rate_max = rate;
 	}
 
 	snd_pcm_set_sync(substream);
-
+end:
+	return err;
+err_locked:
+	snd_tscm_stream_lock_release(tscm);
 	return err;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_tscm *tscm = substream->private_data;
+
+	snd_tscm_stream_lock_release(tscm);
+
 	return 0;
 }
 
diff --git a/sound/firewire/tascam/tascam-stream.c b/sound/firewire/tascam/tascam-stream.c
index deef60b..23124fb 100644
--- a/sound/firewire/tascam/tascam-stream.c
+++ b/sound/firewire/tascam/tascam-stream.c
@@ -456,3 +456,42 @@ void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm)
 	finish_session(tscm);
 	release_resources(tscm);
 }
+
+void snd_tscm_stream_lock_changed(struct snd_tscm *tscm)
+{
+	tscm->dev_lock_changed = true;
+	wake_up(&tscm->hwdep_wait);
+}
+
+int snd_tscm_stream_lock_try(struct snd_tscm *tscm)
+{
+	int err;
+
+	spin_lock_irq(&tscm->lock);
+
+	/* user land lock this */
+	if (tscm->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (tscm->dev_lock_count++ == 0)
+		snd_tscm_stream_lock_changed(tscm);
+	err = 0;
+end:
+	spin_unlock_irq(&tscm->lock);
+	return err;
+}
+
+void snd_tscm_stream_lock_release(struct snd_tscm *tscm)
+{
+	spin_lock_irq(&tscm->lock);
+
+	if (WARN_ON(tscm->dev_lock_count <= 0))
+		goto end;
+	if (--tscm->dev_lock_count == 0)
+		snd_tscm_stream_lock_changed(tscm);
+end:
+	spin_unlock_irq(&tscm->lock);
+}
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 5523a57..2afb291 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -144,6 +144,10 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_tscm_create_hwdep_device(tscm);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 732b410..053a8bf 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -22,6 +22,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
+#include <sound/hwdep.h>
 
 #include "../lib.h"
 #include "../packets-buffer.h"
@@ -65,6 +66,10 @@ struct snd_tscm {
 	/* For MIDI message outgoing transactions. */
 	struct snd_fw_async_midi_port out_ports[TSCM_MIDI_OUT_PORT_MAX];
 	u8 running_status[TSCM_MIDI_OUT_PORT_MAX];
+
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
@@ -116,6 +121,10 @@ void snd_tscm_stream_destroy_duplex(struct snd_tscm *tscm);
 int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate);
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm);
 
+void snd_tscm_stream_lock_changed(struct snd_tscm *tscm);
+int snd_tscm_stream_lock_try(struct snd_tscm *tscm);
+void snd_tscm_stream_lock_release(struct snd_tscm *tscm);
+
 int snd_tscm_transaction_register(struct snd_tscm *tscm);
 int snd_tscm_transaction_reregister(struct snd_tscm *tscm);
 void snd_tscm_transaction_unregister(struct snd_tscm *tscm);
@@ -125,3 +134,5 @@ void snd_tscm_proc_init(struct snd_tscm *tscm);
 int snd_tscm_create_pcm_devices(struct snd_tscm *tscm);
 
 int snd_tscm_create_midi_devices(struct snd_tscm *tscm);
+
+int snd_tscm_create_hwdep_device(struct snd_tscm *tscm);
-- 
2.1.4
