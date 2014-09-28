From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/13] ALSA: dice: Split hwdep functionality
	into a file
Date: Mon, 29 Sep 2014 00:58:16 +0900
Message-ID: <1411919903-10981-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F2DA260597
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:51 +0200 (CEST)
In-Reply-To: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds a file and move some codes related to hwdep functionality.

This interface is designed for mixer/control application. By using hwdep
interface, the application can get information about firewire node, can
lock/unlock kernel streaming and can get notification at starting/stopping
kernel streaming.

Additionally, this interface give a way to read Dice notification.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile     |   3 +-
 sound/firewire/dice/dice-hwdep.c | 190 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c       | 182 +------------------------------------
 sound/firewire/dice/dice.h       |   2 +
 4 files changed, 195 insertions(+), 182 deletions(-)
 create mode 100644 sound/firewire/dice/dice-hwdep.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 1ddaeca..73b0e38 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,2 +1,3 @@
-snd-dice-objs := dice-transaction.o dice-stream.o dice-pcm.o dice.o
+snd-dice-objs := dice-transaction.o dice-stream.o dice-pcm.o dice-hwdep.o \
+		 dice.o
 obj-m += snd-dice.o
diff --git a/sound/firewire/dice/dice-hwdep.c b/sound/firewire/dice/dice-hwdep.c
new file mode 100644
index 0000000..a4dc02a
--- /dev/null
+++ b/sound/firewire/dice/dice-hwdep.c
@@ -0,0 +1,190 @@
+/*
+ * dice_hwdep.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2014 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "dice.h"
+
+static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
+			    long count, loff_t *offset)
+{
+	struct snd_dice *dice = hwdep->private_data;
+	DEFINE_WAIT(wait);
+	union snd_firewire_event event;
+
+	spin_lock_irq(&dice->lock);
+
+	while (!dice->dev_lock_changed && dice->notification_bits == 0) {
+		prepare_to_wait(&dice->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&dice->lock);
+		schedule();
+		finish_wait(&dice->hwdep_wait, &wait);
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		spin_lock_irq(&dice->lock);
+	}
+
+	memset(&event, 0, sizeof(event));
+	if (dice->dev_lock_changed) {
+		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+		event.lock_status.status = dice->dev_lock_count > 0;
+		dice->dev_lock_changed = false;
+
+		count = min_t(long, count, sizeof(event.lock_status));
+	} else {
+		event.dice_notification.type =
+					SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
+		event.dice_notification.notification = dice->notification_bits;
+		dice->notification_bits = 0;
+
+		count = min_t(long, count, sizeof(event.dice_notification));
+	}
+
+	spin_unlock_irq(&dice->lock);
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
+	struct snd_dice *dice = hwdep->private_data;
+	unsigned int events;
+
+	poll_wait(file, &dice->hwdep_wait, wait);
+
+	spin_lock_irq(&dice->lock);
+	if (dice->dev_lock_changed || dice->notification_bits != 0)
+		events = POLLIN | POLLRDNORM;
+	else
+		events = 0;
+	spin_unlock_irq(&dice->lock);
+
+	return events;
+}
+
+static int hwdep_get_info(struct snd_dice *dice, void __user *arg)
+{
+	struct fw_device *dev = fw_parent_device(dice->unit);
+	struct snd_firewire_get_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.type = SNDRV_FIREWIRE_TYPE_DICE;
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
+static int hwdep_lock(struct snd_dice *dice)
+{
+	int err;
+
+	spin_lock_irq(&dice->lock);
+
+	if (dice->dev_lock_count == 0) {
+		dice->dev_lock_count = -1;
+		err = 0;
+	} else {
+		err = -EBUSY;
+	}
+
+	spin_unlock_irq(&dice->lock);
+
+	return err;
+}
+
+static int hwdep_unlock(struct snd_dice *dice)
+{
+	int err;
+
+	spin_lock_irq(&dice->lock);
+
+	if (dice->dev_lock_count == -1) {
+		dice->dev_lock_count = 0;
+		err = 0;
+	} else {
+		err = -EBADFD;
+	}
+
+	spin_unlock_irq(&dice->lock);
+
+	return err;
+}
+
+static int hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+{
+	struct snd_dice *dice = hwdep->private_data;
+
+	spin_lock_irq(&dice->lock);
+	if (dice->dev_lock_count == -1)
+		dice->dev_lock_count = 0;
+	spin_unlock_irq(&dice->lock);
+
+	return 0;
+}
+
+static int hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	struct snd_dice *dice = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return hwdep_get_info(dice, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return hwdep_lock(dice);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return hwdep_unlock(dice);
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
+int snd_dice_create_hwdep(struct snd_dice *dice)
+{
+	static const struct snd_hwdep_ops ops = {
+		.read         = hwdep_read,
+		.release      = hwdep_release,
+		.poll         = hwdep_poll,
+		.ioctl        = hwdep_ioctl,
+		.ioctl_compat = hwdep_compat_ioctl,
+	};
+	struct snd_hwdep *hwdep;
+	int err;
+
+	err = snd_hwdep_new(dice->card, "DICE", 0, &hwdep);
+	if (err < 0)
+		return err;
+	strcpy(hwdep->name, "DICE");
+	hwdep->iface = SNDRV_HWDEP_IFACE_FW_DICE;
+	hwdep->ops = ops;
+	hwdep->private_data = dice;
+	hwdep->exclusive = true;
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index bce4652..daf333b 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -11,186 +11,6 @@ MODULE_DESCRIPTION("DICE driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
-static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
-			    long count, loff_t *offset)
-{
-	struct snd_dice *dice = hwdep->private_data;
-	DEFINE_WAIT(wait);
-	union snd_firewire_event event;
-
-	spin_lock_irq(&dice->lock);
-
-	while (!dice->dev_lock_changed && dice->notification_bits == 0) {
-		prepare_to_wait(&dice->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
-		spin_unlock_irq(&dice->lock);
-		schedule();
-		finish_wait(&dice->hwdep_wait, &wait);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-		spin_lock_irq(&dice->lock);
-	}
-
-	memset(&event, 0, sizeof(event));
-	if (dice->dev_lock_changed) {
-		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
-		event.lock_status.status = dice->dev_lock_count > 0;
-		dice->dev_lock_changed = false;
-
-		count = min_t(long, count, sizeof(event.lock_status));
-	} else {
-		event.dice_notification.type =
-					SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
-		event.dice_notification.notification = dice->notification_bits;
-		dice->notification_bits = 0;
-
-		count = min_t(long, count, sizeof(event.dice_notification));
-	}
-
-	spin_unlock_irq(&dice->lock);
-
-	if (copy_to_user(buf, &event, count))
-		return -EFAULT;
-
-	return count;
-}
-
-static unsigned int dice_hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
-				    poll_table *wait)
-{
-	struct snd_dice *dice = hwdep->private_data;
-	unsigned int events;
-
-	poll_wait(file, &dice->hwdep_wait, wait);
-
-	spin_lock_irq(&dice->lock);
-	if (dice->dev_lock_changed || dice->notification_bits != 0)
-		events = POLLIN | POLLRDNORM;
-	else
-		events = 0;
-	spin_unlock_irq(&dice->lock);
-
-	return events;
-}
-
-static int dice_hwdep_get_info(struct snd_dice *dice, void __user *arg)
-{
-	struct fw_device *dev = fw_parent_device(dice->unit);
-	struct snd_firewire_get_info info;
-
-	memset(&info, 0, sizeof(info));
-	info.type = SNDRV_FIREWIRE_TYPE_DICE;
-	info.card = dev->card->index;
-	*(__be32 *)&info.guid[0] = cpu_to_be32(dev->config_rom[3]);
-	*(__be32 *)&info.guid[4] = cpu_to_be32(dev->config_rom[4]);
-	strlcpy(info.device_name, dev_name(&dev->device),
-		sizeof(info.device_name));
-
-	if (copy_to_user(arg, &info, sizeof(info)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int dice_hwdep_lock(struct snd_dice *dice)
-{
-	int err;
-
-	spin_lock_irq(&dice->lock);
-
-	if (dice->dev_lock_count == 0) {
-		dice->dev_lock_count = -1;
-		err = 0;
-	} else {
-		err = -EBUSY;
-	}
-
-	spin_unlock_irq(&dice->lock);
-
-	return err;
-}
-
-static int dice_hwdep_unlock(struct snd_dice *dice)
-{
-	int err;
-
-	spin_lock_irq(&dice->lock);
-
-	if (dice->dev_lock_count == -1) {
-		dice->dev_lock_count = 0;
-		err = 0;
-	} else {
-		err = -EBADFD;
-	}
-
-	spin_unlock_irq(&dice->lock);
-
-	return err;
-}
-
-static int dice_hwdep_release(struct snd_hwdep *hwdep, struct file *file)
-{
-	struct snd_dice *dice = hwdep->private_data;
-
-	spin_lock_irq(&dice->lock);
-	if (dice->dev_lock_count == -1)
-		dice->dev_lock_count = 0;
-	spin_unlock_irq(&dice->lock);
-
-	return 0;
-}
-
-static int dice_hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
-			    unsigned int cmd, unsigned long arg)
-{
-	struct snd_dice *dice = hwdep->private_data;
-
-	switch (cmd) {
-	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
-		return dice_hwdep_get_info(dice, (void __user *)arg);
-	case SNDRV_FIREWIRE_IOCTL_LOCK:
-		return dice_hwdep_lock(dice);
-	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
-		return dice_hwdep_unlock(dice);
-	default:
-		return -ENOIOCTLCMD;
-	}
-}
-
-#ifdef CONFIG_COMPAT
-static int dice_hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
-				   unsigned int cmd, unsigned long arg)
-{
-	return dice_hwdep_ioctl(hwdep, file, cmd,
-				(unsigned long)compat_ptr(arg));
-}
-#else
-#define dice_hwdep_compat_ioctl NULL
-#endif
-
-static int dice_create_hwdep(struct snd_dice *dice)
-{
-	static const struct snd_hwdep_ops ops = {
-		.read         = dice_hwdep_read,
-		.release      = dice_hwdep_release,
-		.poll         = dice_hwdep_poll,
-		.ioctl        = dice_hwdep_ioctl,
-		.ioctl_compat = dice_hwdep_compat_ioctl,
-	};
-	struct snd_hwdep *hwdep;
-	int err;
-
-	err = snd_hwdep_new(dice->card, "DICE", 0, &hwdep);
-	if (err < 0)
-		return err;
-	strcpy(hwdep->name, "DICE");
-	hwdep->iface = SNDRV_HWDEP_IFACE_FW_DICE;
-	hwdep->ops = ops;
-	hwdep->private_data = dice;
-	hwdep->exclusive = true;
-
-	return 0;
-}
-
 static int dice_proc_read_mem(struct snd_dice *dice, void *buffer,
 			      unsigned int offset_q, unsigned int quadlets)
 {
@@ -696,7 +516,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto error;
 
-	err = dice_create_hwdep(dice);
+	err = snd_dice_create_hwdep(dice);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 4d9e55b..dcc8c78 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -173,4 +173,6 @@ void snd_dice_stream_lock_release(struct snd_dice *dice);
 
 int snd_dice_create_pcm(struct snd_dice *dice);
 
+int snd_dice_create_hwdep(struct snd_dice *dice);
+
 #endif
-- 
1.9.1
