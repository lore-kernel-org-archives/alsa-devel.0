From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 32/49] fireworks: Add command/response functionality into
	hwdep interface
Date: Fri, 25 Apr 2014 22:45:13 +0900
Message-ID: <1398433530-13136-33-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds two functionality for hwdep interface, adds two parameters for
this driver, add a node for proc interface.

To receive responses from devices, this driver already allocate own callback
into initial memory space in host controller. This means no one can allocate
its own callback to the address. So this driver must give a way for user
applications to receive responses.

This commit adds a functionality to receive responses via hwdep interface. The
application can receive responses to read from this interface. To achieve this,
this commit adds a buffer to queue responses. The default size of this buffer is
1024 bytes. This size can be changed to give preferrable size to
'resp_buf_size' parameter for this driver. The application should notice rest
of space in this buffer because this driver don't push responses when this
buffer has no space.

Additionaly, this commit adds a functionality to transmit commands via hwdep
interface. The application can transmit commands to write into this interface.
I note that the application can transmit one command at once, but can receive
as many responses as possible untill the user-buffer is full.

When using these interfaces, the application must keep maximum number of
sequence number in command within the number in firewire.h because this driver
uses this number to distinguish the response is against the command by the
application or this driver.

Usually responses against commands which the application transmits are pushed
into this buffer. But to enable 'resp_buf_debug' parameter for this driver, all
responses are pushed into the buffer. When using this mode, I reccomend to
expand the size of buffer.

Finally this commit adds a new node into proc interface to output status of the
buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h                    |  19 +++
 sound/firewire/fireworks/fireworks.c             |  21 +++
 sound/firewire/fireworks/fireworks.h             |  22 +--
 sound/firewire/fireworks/fireworks_command.c     |   8 +-
 sound/firewire/fireworks/fireworks_hwdep.c       | 131 ++++++++++++++---
 sound/firewire/fireworks/fireworks_proc.c        |  18 +++
 sound/firewire/fireworks/fireworks_transaction.c | 176 ++++++++++++++++++++---
 7 files changed, 347 insertions(+), 48 deletions(-)

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index fc9afb2..bfc0e23e4 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -2,11 +2,13 @@
 #define _UAPI_SOUND_FIREWIRE_H_INCLUDED
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 /* events can be read() from the hwdep device */
 
 #define SNDRV_FIREWIRE_EVENT_LOCK_STATUS	0x000010cc
 #define SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION	0xd1ce004e
+#define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE	0x4e617475
 
 struct snd_firewire_event_common {
 	unsigned int type; /* SNDRV_FIREWIRE_EVENT_xxx */
@@ -22,10 +24,27 @@ struct snd_firewire_event_dice_notification {
 	unsigned int notification; /* DICE-specific bits */
 };
 
+#define SND_EFW_TRANSACTION_USER_SEQNUM_MAX	((__u32)((__u16)~0) - 1)
+/* each field should be in big endian */
+struct snd_efw_transaction {
+	__be32 length;
+	__be32 version;
+	__be32 seqnum;
+	__be32 category;
+	__be32 command;
+	__be32 status;
+	__be32 params[0];
+};
+struct snd_firewire_event_efw_response {
+	unsigned int type;
+	__be32 response[0];	/* some responses */
+};
+
 union snd_firewire_event {
 	struct snd_firewire_event_common            common;
 	struct snd_firewire_event_lock_status       lock_status;
 	struct snd_firewire_event_dice_notification dice_notification;
+	struct snd_firewire_event_efw_response      efw_response;
 };
 
 
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index f8d06f5..a354d26 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -24,6 +24,8 @@ MODULE_LICENSE("GPL v2");
 static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
+unsigned int snd_efw_resp_buf_size	= 1024;
+bool snd_efw_resp_buf_debug		= false;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "card index");
@@ -31,6 +33,11 @@ module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "enable Fireworks sound card");
+module_param_named(resp_buf_size, snd_efw_resp_buf_size, uint, 0444);
+MODULE_PARM_DESC(resp_buf_size,
+		 "response buffer size (max 4096, default 1024)");
+module_param_named(resp_buf_debug, snd_efw_resp_buf_debug, bool, 0444);
+MODULE_PARM_DESC(resp_buf_debug, "store all responses to buffer");
 
 static DEFINE_MUTEX(devices_mutex);
 static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
@@ -182,6 +189,7 @@ efw_card_free(struct snd_card *card)
 	}
 
 	mutex_destroy(&efw->mutex);
+	kfree(efw->resp_buf);
 }
 
 static int
@@ -219,6 +227,17 @@ efw_probe(struct fw_unit *unit,
 	spin_lock_init(&efw->lock);
 	init_waitqueue_head(&efw->hwdep_wait);
 
+	/* prepare response buffer */
+	snd_efw_resp_buf_size = clamp(snd_efw_resp_buf_size,
+				      SND_EFW_RESPONSE_MAXIMUM_BYTES, 4096U);
+	efw->resp_buf = kzalloc(snd_efw_resp_buf_size, GFP_KERNEL);
+	if (efw->resp_buf == NULL) {
+		err = -ENOMEM;
+		goto error;
+	}
+	efw->pull_ptr = efw->push_ptr = efw->resp_buf;
+	snd_efw_transaction_add_instance(efw);
+
 	err = get_hardware_info(efw);
 	if (err < 0)
 		goto error;
@@ -256,6 +275,7 @@ end:
 	mutex_unlock(&devices_mutex);
 	return err;
 error:
+	snd_efw_transaction_remove_instance(efw);
 	mutex_unlock(&devices_mutex);
 	snd_card_free(card);
 	return err;
@@ -274,6 +294,7 @@ static void efw_remove(struct fw_unit *unit)
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
 	snd_efw_stream_destroy_duplex(efw);
+	snd_efw_transaction_remove_instance(efw);
 
 	snd_card_disconnect(efw->card);
 	snd_card_free_when_closed(efw->card);
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 4aaf2dc..494195b 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -49,6 +49,9 @@
  */
 #define SND_EFW_RESPONSE_MAXIMUM_BYTES	0x200U
 
+extern unsigned int snd_efw_resp_buf_size;
+extern bool snd_efw_resp_buf_debug;
+
 struct snd_efw_phys_grp {
 	u8 type;	/* see enum snd_efw_grp_type */
 	u8 count;
@@ -97,23 +100,24 @@ struct snd_efw {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
-};
 
-struct snd_efw_transaction {
-	__be32 length;
-	__be32 version;
-	__be32 seqnum;
-	__be32 category;
-	__be32 command;
-	__be32 status;
-	__be32 params[0];
+	/* response queue */
+	u8 *resp_buf;
+	u8 *pull_ptr;
+	u8 *push_ptr;
+	unsigned int resp_queues;
 };
+
+int snd_efw_transaction_cmd(struct fw_unit *unit,
+			    const void *cmd, unsigned int size);
 int snd_efw_transaction_run(struct fw_unit *unit,
 			    const void *cmd, unsigned int cmd_size,
 			    void *resp, unsigned int resp_size);
 int snd_efw_transaction_register(void);
 void snd_efw_transaction_unregister(void);
 void snd_efw_transaction_bus_reset(struct fw_unit *unit);
+void snd_efw_transaction_add_instance(struct snd_efw *efw);
+void snd_efw_transaction_remove_instance(struct snd_efw *efw);
 
 struct snd_efw_hwinfo {
 	u32 flags;
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index d5ea705..166f805 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -22,7 +22,8 @@
  * Information commands. But this module don't use them.
  */
 
-#define EFW_TRANSACTION_SEQNUM_MAX	((u32)~0)
+#define KERNEL_SEQNUM_MIN	(SND_EFW_TRANSACTION_USER_SEQNUM_MAX + 2)
+#define KERNEL_SEQNUM_MAX	((u32)~0)
 
 /* for clock source and sampling rate */
 struct efc_clock {
@@ -120,8 +121,9 @@ efw_transaction(struct snd_efw *efw, unsigned int category,
 
 	/* to keep consistency of sequence number */
 	spin_lock(&efw->lock);
-	if (efw->seqnum + 2 >= EFW_TRANSACTION_SEQNUM_MAX)
-		efw->seqnum = 0;
+	if ((efw->seqnum < KERNEL_SEQNUM_MIN) ||
+	    (efw->seqnum >= KERNEL_SEQNUM_MAX - 2))
+		efw->seqnum = KERNEL_SEQNUM_MIN;
 	else
 		efw->seqnum += 2;
 	seqnum = efw->seqnum;
diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
index 1cf491d..6b50a67 100644
--- a/sound/firewire/fireworks/fireworks_hwdep.c
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -7,26 +7,101 @@
  */
 
 /*
- * This codes have three functionalities.
+ * This codes have five functionalities.
  *
  * 1.get information about firewire node
  * 2.get notification about starting/stopping stream
  * 3.lock/unlock streaming
+ * 4.transmit command of EFW transaction
+ * 5.receive response of EFW transaction
+ *
  */
 
 #include "fireworks.h"
 
 static long
-hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
+hwdep_read_resp_buf(struct snd_efw *efw, char __user *buf, long remained,
+		    loff_t *offset)
+{
+	unsigned int length, till_end, type;
+	struct snd_efw_transaction *t;
+	long count = 0;
+
+	if (remained < sizeof(type) + sizeof(struct snd_efw_transaction))
+		return -ENOSPC;
+
+	/* data type is SNDRV_FIREWIRE_EVENT_EFW_RESPONSE */
+	type = SNDRV_FIREWIRE_EVENT_EFW_RESPONSE;
+	if (copy_to_user(buf, &type, sizeof(type)))
+		return -EFAULT;
+	remained -= sizeof(type);
+	buf += sizeof(type);
+
+	/* write into buffer as many responses as possible */
+	while (efw->resp_queues > 0) {
+		t = (struct snd_efw_transaction *)(efw->pull_ptr);
+		length = be32_to_cpu(t->length) * sizeof(__be32);
+
+		/* confirm enough space for this response */
+		if (remained < length)
+			break;
+
+		/* copy from ring buffer to user buffer */
+		while (length > 0) {
+			till_end = snd_efw_resp_buf_size -
+				(unsigned int)(efw->pull_ptr - efw->resp_buf);
+			till_end = min_t(unsigned int, length, till_end);
+
+			if (copy_to_user(buf, efw->pull_ptr, till_end))
+				return -EFAULT;
+
+			efw->pull_ptr += till_end;
+			if (efw->pull_ptr >= efw->resp_buf +
+					     snd_efw_resp_buf_size)
+				efw->pull_ptr = efw->resp_buf;
+
+			length -= till_end;
+			buf += till_end;
+			count += till_end;
+			remained -= till_end;
+		}
+
+		efw->resp_queues--;
+	}
+
+	return count;
+}
+
+static long
+hwdep_read_locked(struct snd_efw *efw, char __user *buf, long count,
+		  loff_t *offset)
+{
+	union snd_firewire_event event;
+
+	memset(&event, 0, sizeof(event));
+
+	event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
+	event.lock_status.status = (efw->dev_lock_count > 0);
+	efw->dev_lock_changed = false;
+
+	count = min_t(long, count, sizeof(event.lock_status));
+
+	if (copy_to_user(buf, &event, count))
+		return -EFAULT;
+
+	return count;
+}
+
+static long
+hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 	   loff_t *offset)
 {
 	struct snd_efw *efw = hwdep->private_data;
 	DEFINE_WAIT(wait);
-	union snd_firewire_event event;
 
 	spin_lock_irq(&efw->lock);
 
-	while (!efw->dev_lock_changed) {
+	while ((!efw->dev_lock_changed) && (efw->resp_queues == 0)) {
 		prepare_to_wait(&efw->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&efw->lock);
 		schedule();
@@ -36,20 +111,43 @@ hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 		spin_lock_irq(&efw->lock);
 	}
 
-	memset(&event, 0, sizeof(event));
-	if (efw->dev_lock_changed) {
-		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
-		event.lock_status.status = (efw->dev_lock_count > 0);
-		efw->dev_lock_changed = false;
-
-		count = min_t(long, count, sizeof(event.lock_status));
-	}
+	if (efw->dev_lock_changed)
+		count = hwdep_read_locked(efw, buf, count, offset);
+	else if (efw->resp_queues > 0)
+		count = hwdep_read_resp_buf(efw, buf, count, offset);
 
 	spin_unlock_irq(&efw->lock);
 
-	if (copy_to_user(buf, &event, count))
-		return -EFAULT;
+	return count;
+}
 
+static long
+hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
+	    loff_t *offset)
+{
+	struct snd_efw *efw = hwdep->private_data;
+	u32 seqnum;
+	u8 *buf;
+
+	if (count < sizeof(struct snd_efw_transaction) ||
+	    SND_EFW_RESPONSE_MAXIMUM_BYTES < count)
+		return -EINVAL;
+
+	buf = memdup_user(data, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(data);
+
+	/* check seqnum is not for kernel-land */
+	seqnum = be32_to_cpu(((struct snd_efw_transaction *)buf)->seqnum);
+	if (seqnum > SND_EFW_TRANSACTION_USER_SEQNUM_MAX) {
+		count = -EINVAL;
+		goto end;
+	}
+
+	if (snd_efw_transaction_cmd(efw->unit, buf, count) < 0)
+		count = -EIO;
+end:
+	kfree(buf);
 	return count;
 }
 
@@ -62,13 +160,13 @@ hwdep_poll(struct snd_hwdep *hwdep, struct file *file, poll_table *wait)
 	poll_wait(file, &efw->hwdep_wait, wait);
 
 	spin_lock_irq(&efw->lock);
-	if (efw->dev_lock_changed)
+	if (efw->dev_lock_changed || (efw->resp_queues > 0))
 		events = POLLIN | POLLRDNORM;
 	else
 		events = 0;
 	spin_unlock_irq(&efw->lock);
 
-	return events;
+	return events | POLLOUT;
 }
 
 static int
@@ -174,6 +272,7 @@ hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
 
 static const struct snd_hwdep_ops hwdep_ops = {
 	.read		= hwdep_read,
+	.write		= hwdep_write,
 	.release	= hwdep_release,
 	.poll		= hwdep_poll,
 	.ioctl		= hwdep_ioctl,
diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
index 631c91f..f29d4aa 100644
--- a/sound/firewire/fireworks/fireworks_proc.c
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -176,6 +176,23 @@ end:
 }
 
 static void
+proc_read_queues_state(struct snd_info_entry *entry,
+		       struct snd_info_buffer *buffer)
+{
+	struct snd_efw *efw = entry->private_data;
+	unsigned int consumed;
+
+	if (efw->pull_ptr > efw->push_ptr)
+		consumed = snd_efw_resp_buf_size -
+			   (unsigned int)(efw->pull_ptr - efw->push_ptr);
+	else
+		consumed = (unsigned int)(efw->push_ptr - efw->pull_ptr);
+
+	snd_iprintf(buffer, "%d %d/%d\n",
+		    efw->resp_queues, consumed, snd_efw_resp_buf_size);
+}
+
+static void
 add_node(struct snd_efw *efw, struct snd_info_entry *root, const char *name,
 	 void (*op)(struct snd_info_entry *e, struct snd_info_buffer *b))
 {
@@ -211,4 +228,5 @@ void snd_efw_proc_init(struct snd_efw *efw)
 	add_node(efw, root, "clock", proc_read_clock);
 	add_node(efw, root, "firmware", proc_read_hwinfo);
 	add_node(efw, root, "meters", proc_read_phys_meters);
+	add_node(efw, root, "queues", proc_read_queues_state);
 }
diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
index aac91d8..81a65eb 100644
--- a/sound/firewire/fireworks/fireworks_transaction.c
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -38,6 +38,9 @@
 #define ERROR_DELAY_MS 5
 #define EFC_TIMEOUT_MS 125
 
+static DEFINE_SPINLOCK(instances_lock);
+static struct snd_efw *instances[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+
 static DEFINE_SPINLOCK(transaction_queues_lock);
 static LIST_HEAD(transaction_queues);
 
@@ -57,6 +60,14 @@ struct transaction_queue {
 	wait_queue_head_t wait;
 };
 
+int snd_efw_transaction_cmd(struct fw_unit *unit,
+			    const void *cmd, unsigned int size)
+{
+	return snd_fw_transaction(unit, TCODE_WRITE_BLOCK_REQUEST,
+				  MEMORY_SPACE_EFW_COMMAND,
+				  (void *)cmd, size, 0);
+}
+
 int snd_efw_transaction_run(struct fw_unit *unit,
 			    const void *cmd, unsigned int cmd_size,
 			    void *resp, unsigned int resp_size)
@@ -78,9 +89,7 @@ int snd_efw_transaction_run(struct fw_unit *unit,
 
 	tries = 0;
 	do {
-		ret = snd_fw_transaction(unit, TCODE_WRITE_BLOCK_REQUEST,
-					 MEMORY_SPACE_EFW_COMMAND,
-					 (void *)cmd, cmd_size, 0);
+		ret = snd_efw_transaction_cmd(t.unit, (void *)cmd, cmd_size);
 		if (ret < 0)
 			break;
 
@@ -107,27 +116,92 @@ int snd_efw_transaction_run(struct fw_unit *unit,
 }
 
 static void
-efw_response(struct fw_card *card, struct fw_request *request,
-	     int tcode, int destination, int source,
-	     int generation, unsigned long long offset,
-	     void *data, size_t length, void *callback_data)
+copy_resp_to_buf(struct snd_efw *efw, void *data, size_t length, int *rcode)
 {
-	struct fw_device *device;
-	struct transaction_queue *t;
-	unsigned long flags;
-	int rcode;
-	u32 seqnum;
+	size_t capacity, till_end;
+	struct snd_efw_transaction *t;
 
-	rcode = RCODE_TYPE_ERROR;
-	if (length < sizeof(struct snd_efw_transaction)) {
-		rcode = RCODE_DATA_ERROR;
-		goto end;
-	} else if (offset != MEMORY_SPACE_EFW_RESPONSE) {
-		rcode = RCODE_ADDRESS_ERROR;
+	spin_lock_irq(&efw->lock);
+
+	t = (struct snd_efw_transaction *)data;
+	length = min_t(size_t, t->length * sizeof(t->length), length);
+
+	if (efw->push_ptr < efw->pull_ptr)
+		capacity = (unsigned int)(efw->pull_ptr - efw->push_ptr);
+	else
+		capacity = snd_efw_resp_buf_size -
+			   (unsigned int)(efw->push_ptr - efw->pull_ptr);
+
+	/* confirm enough space for this response */
+	if (capacity < length) {
+		*rcode = RCODE_CONFLICT_ERROR;
 		goto end;
 	}
 
-	seqnum = be32_to_cpu(((struct snd_efw_transaction *)data)->seqnum);
+	/* copy to ring buffer */
+	while (length > 0) {
+		till_end = snd_efw_resp_buf_size -
+			   (unsigned int)(efw->push_ptr - efw->resp_buf);
+		till_end = min_t(unsigned int, length, till_end);
+
+		memcpy(efw->push_ptr, data, till_end);
+
+		efw->push_ptr += till_end;
+		if (efw->push_ptr >= efw->resp_buf + snd_efw_resp_buf_size)
+			efw->push_ptr = efw->resp_buf;
+
+		length -= till_end;
+		data += till_end;
+	}
+
+	/* for hwdep */
+	efw->resp_queues++;
+	wake_up(&efw->hwdep_wait);
+
+	*rcode = RCODE_COMPLETE;
+end:
+	spin_unlock_irq(&efw->lock);
+}
+
+static void
+handle_resp_for_user(struct fw_card *card, int generation, int source,
+		     void *data, size_t length, int *rcode)
+{
+	struct fw_device *device;
+	struct snd_efw *efw;
+	unsigned int i;
+
+	spin_lock_irq(&instances_lock);
+
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		efw = instances[i];
+		if (efw == NULL)
+			continue;
+		device = fw_parent_device(efw->unit);
+		if ((device->card != card) ||
+		    (device->generation != generation))
+			continue;
+		smp_rmb();	/* node id vs. generation */
+		if (device->node_id != source)
+			continue;
+
+		break;
+	}
+	if (i == SNDRV_CARDS)
+		goto end;
+
+	copy_resp_to_buf(efw, data, length, rcode);
+end:
+	spin_unlock_irq(&instances_lock);
+}
+
+static void
+handle_resp_for_kernel(struct fw_card *card, int generation, int source,
+		       void *data, size_t length, int *rcode, u32 seqnum)
+{
+	struct fw_device *device;
+	struct transaction_queue *t;
+	unsigned long flags;
 
 	spin_lock_irqsave(&transaction_queues_lock, flags);
 	list_for_each_entry(t, &transaction_queues, list) {
@@ -144,14 +218,76 @@ efw_response(struct fw_card *card, struct fw_request *request,
 			t->size = min_t(unsigned int, length, t->size);
 			memcpy(t->buf, data, t->size);
 			wake_up(&t->wait);
-			rcode = RCODE_COMPLETE;
+			*rcode = RCODE_COMPLETE;
 		}
 	}
 	spin_unlock_irqrestore(&transaction_queues_lock, flags);
+}
+
+static void
+efw_response(struct fw_card *card, struct fw_request *request,
+	     int tcode, int destination, int source,
+	     int generation, unsigned long long offset,
+	     void *data, size_t length, void *callback_data)
+{
+	int rcode, dummy;
+	u32 seqnum;
+
+	rcode = RCODE_TYPE_ERROR;
+	if (length < sizeof(struct snd_efw_transaction)) {
+		rcode = RCODE_DATA_ERROR;
+		goto end;
+	} else if (offset != MEMORY_SPACE_EFW_RESPONSE) {
+		rcode = RCODE_ADDRESS_ERROR;
+		goto end;
+	}
+
+	seqnum = be32_to_cpu(((struct snd_efw_transaction *)data)->seqnum);
+	if (seqnum > SND_EFW_TRANSACTION_USER_SEQNUM_MAX + 1) {
+		handle_resp_for_kernel(card, generation, source,
+				       data, length, &rcode, seqnum);
+		if (snd_efw_resp_buf_debug)
+			handle_resp_for_user(card, generation, source,
+					     data, length, &dummy);
+	} else {
+		handle_resp_for_user(card, generation, source,
+				     data, length, &rcode);
+	}
 end:
 	fw_send_response(card, request, rcode);
 }
 
+void snd_efw_transaction_add_instance(struct snd_efw *efw)
+{
+	unsigned int i;
+
+	spin_lock_irq(&instances_lock);
+
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (instances[i] != NULL)
+			continue;
+		instances[i] = efw;
+		break;
+	}
+
+	spin_unlock_irq(&instances_lock);
+}
+
+void snd_efw_transaction_remove_instance(struct snd_efw *efw)
+{
+	unsigned int i;
+
+	spin_lock_irq(&instances_lock);
+
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (instances[i] != efw)
+			continue;
+		instances[i] = NULL;
+	}
+
+	spin_unlock_irq(&instances_lock);
+}
+
 void snd_efw_transaction_bus_reset(struct fw_unit *unit)
 {
 	struct transaction_queue *t;
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
