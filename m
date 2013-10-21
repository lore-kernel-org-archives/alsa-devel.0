From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [07/29] ALSA: dice: implement hwdep device
Date: Mon, 21 Oct 2013 21:24:49 +0200
Message-ID: <52657F81.3090409@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Implement the hwdep locking and notification mechanisms.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |  225 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 203 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index d0575a9..7225878 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -5,6 +5,7 @@
  * Licensed under the terms of the GNU General Public License, version 2.
  */

+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/firewire.h>
@@ -13,8 +14,11 @@
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <sound/control.h>
 #include <sound/core.h>
+#include <sound/firewire.h>
 #include <sound/hwdep.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -233,13 +237,18 @@
 struct dice {
 	struct snd_card *card;
 	struct fw_unit *unit;
+	spinlock_t lock;
 	struct mutex mutex;
 	unsigned int global_offset;
 	unsigned int rx_offset;
 	struct fw_address_handler notification_handler;
 	int owner_generation;
+	int dev_lock_count; /* > 0 driver, < 0 userspace */
+	bool dev_lock_changed;
 	bool global_enabled;
 	bool stream_running;
+	wait_queue_head_t hwdep_wait;
+	u32 notification_bits;
 	struct snd_pcm_substream *pcm;
 	struct fw_iso_resources resources;
 	struct amdtp_out_stream stream;
@@ -259,6 +268,47 @@ static const unsigned int dice_rates[] = {
 	[6] = 192000,
 };

+static void dice_lock_changed(struct dice *dice)
+{
+	dice->dev_lock_changed = true;
+	wake_up(&dice->hwdep_wait);
+}
+
+static int dice_try_lock(struct dice *dice)
+{
+	int err;
+
+	spin_lock_irq(&dice->lock);
+
+	if (dice->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (dice->dev_lock_count++ == 0)
+		dice_lock_changed(dice);
+	err = 0;
+
+out:
+	spin_unlock_irq(&dice->lock);
+
+	return err;
+}
+
+static void dice_unlock(struct dice *dice)
+{
+	spin_lock_irq(&dice->lock);
+
+	if (WARN_ON(dice->dev_lock_count <= 0))
+		goto out;
+
+	if (--dice->dev_lock_count == 0)
+		dice_lock_changed(dice);
+
+out:
+	spin_unlock_irq(&dice->lock);
+}
+
 static inline u64 global_address(struct dice *dice, unsigned int offset)
 {
 	return DICE_PRIVATE_SPACE + dice->global_offset + offset;
@@ -496,6 +546,7 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 			      void *data, size_t length, void *callback_data)
 {
 	struct dice *dice = callback_data;
+	unsigned long flags;

 	if (tcode != TCODE_WRITE_QUADLET_REQUEST) {
 		fw_send_response(card, request, RCODE_TYPE_ERROR);
@@ -505,9 +556,11 @@ static void dice_notification(struct fw_card *card, struct fw_request *request,
 		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
 		return;
 	}
-	dev_dbg(&dice->unit->device,
-		"notification: %08x\n", be32_to_cpup(data));
+	spin_lock_irqsave(&dice->lock, flags);
+	dice->notification_bits |= be32_to_cpup(data);
+	spin_unlock_irqrestore(&dice->lock, flags);
 	fw_send_response(card, request, RCODE_COMPLETE);
+	wake_up(&dice->hwdep_wait);
 }

 static int dice_open(struct snd_pcm_substream *substream)
@@ -531,26 +584,32 @@ static int dice_open(struct snd_pcm_substream *substream)
 	unsigned int rate;
 	int err;

+	err = dice_try_lock(dice);
+	if (err < 0)
+		goto error;
+
 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 global_address(dice, GLOBAL_CLOCK_SELECT),
 				 &clock_sel, 4);
 	if (err < 0)
-		return err;
+		goto err_lock;
 	rate = (be32_to_cpu(clock_sel) & CLOCK_RATE_MASK) >> CLOCK_RATE_SHIFT;
-	if (rate >= ARRAY_SIZE(dice_rates))
-		return -ENXIO;
+	if (rate >= ARRAY_SIZE(dice_rates)) {
+		err = -ENXIO;
+		goto err_lock;
+	}
 	rate = dice_rates[rate];

 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 rx_address(dice, RX_NUMBER_AUDIO),
 				 &number_audio, 4);
 	if (err < 0)
-		return err;
+		goto err_lock;
 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 rx_address(dice, RX_NUMBER_MIDI),
 				 &number_midi, 4);
 	if (err < 0)
-		return err;
+		goto err_lock;

 	runtime->hw = hardware;

@@ -568,17 +627,26 @@ static int dice_open(struct snd_pcm_substream *substream)
 					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
 					   5000, 8192000);
 	if (err < 0)
-		return err;
+		goto err_lock;

 	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
 	if (err < 0)
-		return err;
+		goto err_lock;

 	return 0;
+
+err_lock:
+	dice_unlock(dice);
+error:
+	return err;
 }

 static int dice_close(struct snd_pcm_substream *substream)
 {
+	struct dice *dice = substream->private_data;
+
+	dice_unlock(dice);
+
 	return 0;
 }

@@ -783,45 +851,156 @@ static int dice_create_pcm(struct dice *dice)
 	return 0;
 }

-// TODO: implement these
-
 static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
 			    long count, loff_t *offset)
 {
-	return -EIO;
+	struct dice *dice = hwdep->private_data;
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
+		count = min(count, (long)sizeof(event.lock_status));
+	} else {
+		event.dice_notification.type = SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
+		event.dice_notification.notification = dice->notification_bits;
+		dice->notification_bits = 0;
+
+		count = min(count, (long)sizeof(event.dice_notification));
+	}
+
+	spin_unlock_irq(&dice->lock);
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
+	return count;
 }

-static int dice_hwdep_open(struct snd_hwdep *hwdep, struct file *file)
+static unsigned int dice_hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
+				    poll_table *wait)
 {
-	return -EIO;
+	struct dice *dice = hwdep->private_data;
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
 }

-static int dice_hwdep_release(struct snd_hwdep *hwdep, struct file *file)
+static int dice_hwdep_get_info(struct dice *dice, void __user *arg)
 {
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
 	return 0;
 }

-static unsigned int dice_hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
-				    poll_table *wait)
+static int dice_hwdep_lock(struct dice *dice)
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
+static int dice_hwdep_unlock(struct dice *dice)
 {
-	return POLLERR | POLLHUP;
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
 }

 static int dice_hwdep_ioctl(struct snd_hwdep *hwdep, struct file *file,
 			    unsigned int cmd, unsigned long arg)
 {
-	return -EIO;
+	struct dice *dice = hwdep->private_data;
+
+	switch (cmd) {
+	case SNDRV_FIREWIRE_IOCTL_GET_INFO:
+		return dice_hwdep_get_info(dice, (void __user *)arg);
+	case SNDRV_FIREWIRE_IOCTL_LOCK:
+		return dice_hwdep_lock(dice);
+	case SNDRV_FIREWIRE_IOCTL_UNLOCK:
+		return dice_hwdep_unlock(dice);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static int dice_hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
+				   unsigned int cmd, unsigned long arg)
+{
+	return dice_hwdep_ioctl(hwdep, file, cmd,
+				(unsigned long)compat_ptr(arg));
 }
+#else
+#define dice_hwdep_compat_ioctl NULL
+#endif

 static int dice_create_hwdep(struct dice *dice)
 {
 	static const struct snd_hwdep_ops ops = {
 		.read         = dice_hwdep_read,
-		.open         = dice_hwdep_open,
-		.release      = dice_hwdep_release,
 		.poll         = dice_hwdep_poll,
 		.ioctl        = dice_hwdep_ioctl,
-		.ioctl_compat = dice_hwdep_ioctl,
+		.ioctl_compat = dice_hwdep_compat_ioctl,
 	};
 	struct snd_hwdep *hwdep;
 	int err;
@@ -922,8 +1101,10 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)

 	dice = card->private_data;
 	dice->card = card;
+	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
 	dice->unit = unit;
+	init_waitqueue_head(&dice->hwdep_wait);

 	err = dice_init_offsets(dice);
 	if (err < 0)

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
