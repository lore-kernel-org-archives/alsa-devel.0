From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/7] ALSA: firewire-digi00x: add hwdep interface
Date: Wed, 30 Sep 2015 09:39:21 +0900
Message-ID: <1443573562-24088-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1443573562-24088-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 66CDD265A10
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 02:39:33 +0200 (CEST)
In-Reply-To: <1443573562-24088-1-git-send-email-o-takashi@sakamocchi.jp>
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
 include/uapi/sound/asound.h             |   3 +-
 include/uapi/sound/firewire.h           |   1 +
 sound/firewire/Kconfig                  |   1 +
 sound/firewire/digi00x/Makefile         |   2 +-
 sound/firewire/digi00x/digi00x-hwdep.c  | 192 ++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-pcm.c    |  23 +++-
 sound/firewire/digi00x/digi00x-stream.c |  39 +++++++
 sound/firewire/digi00x/digi00x.c        |   6 +
 sound/firewire/digi00x/digi00x.h        |  14 +++
 9 files changed, 273 insertions(+), 8 deletions(-)
 create mode 100644 sound/firewire/digi00x/digi00x-hwdep.c

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index a45be6b..aa32913 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -100,9 +100,10 @@ enum {
 	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
 	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
 	SNDRV_HWDEP_IFACE_FW_OXFW,	/* Oxford OXFW970/971 based device */
+	SNDRV_HWDEP_IFACE_FW_DIGI00X,	/* Digidesign Digi 002/003 family */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_OXFW
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_DIGI00X
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index 49122df..f67d228 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -56,6 +56,7 @@ union snd_firewire_event {
 #define SNDRV_FIREWIRE_TYPE_FIREWORKS	2
 #define SNDRV_FIREWIRE_TYPE_BEBOB	3
 #define SNDRV_FIREWIRE_TYPE_OXFW	4
+#define SNDRV_FIREWIRE_TYPE_DIGI00X	5
 /* RME, MOTU, ... */
 
 struct snd_firewire_get_info {
diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 74f17a8..e61445e 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -123,6 +123,7 @@ config SND_BEBOB
 config SND_FIREWIRE_DIGI00X
 	tristate "Digidesign Digi 002/003 family support"
 	select SND_FIREWIRE_LIB
+	select SND_HWDEP
 	help
 	 Say Y here to include support for Digidesign Digi 002/003 family.
 	  * Digi 002 Console
diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index 3c0ff6f..5bc3c77 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x-proc.o \
-			     digi00x-pcm.o digi00x.o
+			     digi00x-pcm.o digi00x-hwdep.o digi00x.o
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-hwdep.c b/sound/firewire/digi00x/digi00x-hwdep.c
new file mode 100644
index 0000000..d629e41
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-hwdep.c
@@ -0,0 +1,192 @@
+/*
+ * digi00x-hwdep.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
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
+#include "digi00x.h"
+
+static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+		       loff_t *offset)
+{
+	struct snd_dg00x *dg00x = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&dg00x->lock);
+
+	while (!dg00x->dev_lock_changed) {
+		prepare_to_wait(&dg00x->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&dg00x->lock);
+		schedule();
+		finish_wait(&dg00x->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&dg00x->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (dg00x->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = (dg00x->dev_lock_count > 0);
+		dg00x->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	}
+
+	spin_unlock_irq(&dg00x->lock);
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
+	struct snd_dg00x *dg00x = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &dg00x->hwdep_wait, wait);
+
+	spin_lock_irq(&dg00x->lock);
+	if (dg00x->dev_lock_changed)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&dg00x->lock);
+
+	return events;
+}
+
+static int hwdep_get_info(struct snd_dg00x *dg00x, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(dg00x->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_DIGI00X;
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
+static int hwdep_lock(struct snd_dg00x *dg00x)
+{
+	int err;
+
+	spin_lock_irq(&dg00x->lock);
+
+	if (dg00x->dev_lock_count == 0) {
+		dg00x->dev_lock_count = -1;
+		err = 0;
+	} else {
+		err = -EBUSY;
+	}
+
+	spin_unlock_irq(&dg00x->lock);
+
+	return err;
+}
+
+static int hwdep_unlock(struct snd_dg00x *dg00x)
+{
+	int err;
+
+	spin_lock_irq(&dg00x->lock);
+
+	if (dg00x->dev_lock_count == -1) {
+		dg00x->dev_lock_count = 0;
+		err = 0;
+	} else {
+		err = -EBADFD;
+	}
+
+	spin_unlock_irq(&dg00x->lock);
+
+	return err;
+}
+
+static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_dg00x *dg00x = hwdep->private_data;
+
+	spin_lock_irq(&dg00x->lock);
+	if (dg00x->dev_lock_count == -1)
+		dg00x->dev_lock_count = 0;
+	spin_unlock_irq(&dg00x->lock);
+
+	return 0;
+}
+
+static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+	    unsigned int cmd, unsigned long arg)
+{
+	struct snd_dg00x *dg00x = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(dg00x, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(dg00x);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(dg00x);
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
+int snd_dg00x_create_hwdep_device(struct snd_dg00x *dg00x)
+{
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(dg00x->card, "Digi00x", 0, &hwdep);
+	if (err < 0)
+		return err;
+
+	strcpy(hwdep->name, "Digi00x");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_DIGI00X;
+	hwdep->ops = hwdep_ops;
+	hwdep->private_data = dg00x;
+	hwdep->exclusive = true;
+
+	return err;
+}
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index 87c9aa2..cac28f7 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -118,21 +118,25 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	unsigned int rate;
 	int err;
 
+	err = snd_dg00x_stream_lock_try(dg00x);
+	if (err < 0)
+		goto end;
+
 	err = pcm_init_hw_params(dg00x, substream);
 	if (err < 0)
-		return err;
+		goto err_locked;
 
 	/* Check current clock source. */
 	err = snd_dg00x_stream_get_clock(dg00x, &clock);
 	if (err < 0)
-		return err;
+		goto err_locked;
 	if (clock != SND_DG00X_CLOCK_INTERNAL) {
 		err = snd_dg00x_stream_check_external_clock(dg00x, &detect);
 		if (err < 0)
-			return err;
+			goto err_locked;
 		if (!detect) {
 			err = -EBUSY;
-			return err;
+			goto err_locked;
 		}
 	}
 
@@ -141,18 +145,25 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	    amdtp_stream_pcm_running(&dg00x->tx_stream)) {
 		err = snd_dg00x_stream_get_external_rate(dg00x, &rate);
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
+	snd_dg00x_stream_lock_release(dg00x);
 	return err;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
 {
+	struct snd_dg00x *dg00x = substream->private_data;
+
+	snd_dg00x_stream_lock_release(dg00x);
+
 	return 0;
 }
 
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 3278c3e..8aac31b 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -379,3 +379,42 @@ void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x)
 	amdtp_stream_update(&dg00x->tx_stream);
 	amdtp_stream_update(&dg00x->rx_stream);
 }
+
+void snd_dg00x_stream_lock_changed(struct snd_dg00x *dg00x)
+{
+	dg00x->dev_lock_changed = true;
+	wake_up(&dg00x->hwdep_wait);
+}
+
+int snd_dg00x_stream_lock_try(struct snd_dg00x *dg00x)
+{
+	int err;
+
+	spin_lock_irq(&dg00x->lock);
+
+	/* user land lock this */
+	if (dg00x->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto end;
+	}
+
+	/* this is the first time */
+	if (dg00x->dev_lock_count++ == 0)
+		snd_dg00x_stream_lock_changed(dg00x);
+	err = 0;
+end:
+	spin_unlock_irq(&dg00x->lock);
+	return err;
+}
+
+void snd_dg00x_stream_lock_release(struct snd_dg00x *dg00x)
+{
+	spin_lock_irq(&dg00x->lock);
+
+	if (WARN_ON(dg00x->dev_lock_count <= 0))
+		goto end;
+	if (--dg00x->dev_lock_count == 0)
+		snd_dg00x_stream_lock_changed(dg00x);
+end:
+	spin_unlock_irq(&dg00x->lock);
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 15af645..542b2c0 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -74,6 +74,8 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	dg00x->unit = fw_unit_get(unit);
 
 	mutex_init(&dg00x->mutex);
+	spin_lock_init(&dg00x->lock);
+	init_waitqueue_head(&dg00x->hwdep_wait);
 
 	err = name_card(dg00x);
 	if (err < 0)
@@ -89,6 +91,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_create_hwdep_device(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 1990645..5ba5318 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -22,6 +22,8 @@
 #include <sound/info.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
 
 #include "../lib.h"
 #include "../iso-resources.h"
@@ -32,6 +34,7 @@ struct snd_dg00x {
 	struct fw_unit *unit;
 
 	struct mutex mutex;
+	spinlock_t lock;
 
 	struct amdtp_stream tx_stream;
 	struct fw_iso_resources tx_resources;
@@ -40,6 +43,12 @@ struct snd_dg00x {
 	struct fw_iso_resources rx_resources;
 
 	unsigned int substreams_counter;
+
+	/* for uapi */
+	int dev_lock_count;
+	bool dev_lock_changed;
+	wait_queue_head_t hwdep_wait;
+
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
@@ -118,8 +127,13 @@ void snd_dg00x_stream_stop_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_update_duplex(struct snd_dg00x *dg00x);
 void snd_dg00x_stream_destroy_duplex(struct snd_dg00x *dg00x);
 
+void snd_dg00x_stream_lock_changed(struct snd_dg00x *dg00x);
+int snd_dg00x_stream_lock_try(struct snd_dg00x *dg00x);
+void snd_dg00x_stream_lock_release(struct snd_dg00x *dg00x);
+
 void snd_dg00x_proc_init(struct snd_dg00x *dg00x);
 
 int snd_dg00x_create_pcm_devices(struct snd_dg00x *dg00x);
 
+int snd_dg00x_create_hwdep_device(struct snd_dg00x *dg00x);
 #endif
-- 
2.1.4
