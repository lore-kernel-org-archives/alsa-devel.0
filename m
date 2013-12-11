From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/8] fireworks: Add command/response
	functionality into hwdep interface
Date: Wed, 11 Dec 2013 18:15:59 +0900
Message-ID: <1386753359-12458-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F9FF261B05
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:40 +0100 (CET)
In-Reply-To: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit adds two functionality for hwdep interface, adds two parameters for
this module, add a node for proc interface.

To receive responses from devices, this module already allocate own callback
into private address area in host controller. This means no one can allocate
its own callback to the address. So this module must give a way for user
applications to receive responses.

This commit adds a functionality to receive responses via hwdep interface. The
application can receive responses to read from this interface. To achieve this,
this commit adds a buffer to queue responses. The default size of this buffer is
1024 bytes. This size can be changed to give preferrable size to
'resp_buf_size' parameter for this module. The application should notice rest
of space in this buffer because this module don't push responses when this
buffer has no space.

Additionaly, this commit adds a functionality to transmit commands via hwdep
interface. The application can transmit commands to write into this interface.
I note that the application can transmit one command at once, but can receive
as many responses as possible untill the user-buffer is full.

When using these interfaces, the application must keep maximum number of
sequence number within the number in firewire.h because this module uses this
number to distinguish the response is against the command by the application or
this module.

Usually responses against commands which the application transmits are pushed
into this buffer. But to enable 'resp_buf_debug' parameter for this module, all
responses are pushed into the buffer. When using this mode, I reccomend to
expand the size of buffer.

Finally this commit adds a new node into proc interface to output status of the
buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h                    |  18 +++
 sound/firewire/fireworks/fireworks.c             |  17 +++
 sound/firewire/fireworks/fireworks.h             |  23 +--
 sound/firewire/fireworks/fireworks_command.c     |   6 +-
 sound/firewire/fireworks/fireworks_hwdep.c       | 133 +++++++++++++++--
 sound/firewire/fireworks/fireworks_proc.c        |  20 ++-
 sound/firewire/fireworks/fireworks_transaction.c | 176 ++++++++++++++++++++---
 7 files changed, 345 insertions(+), 48 deletions(-)

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index ac4f7ea..48dadb8 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -7,6 +7,7 @@
 
 #define SNDRV_FIREWIRE_EVENT_LOCK_STATUS	0x000010cc
 #define SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION	0xd1ce004e
+#define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE	0x57616269
 
 struct snd_firewire_event_common {
 	unsigned int type; /* SNDRV_FIREWIRE_EVENT_xxx */
@@ -22,10 +23,27 @@ struct snd_firewire_event_dice_notification {
 	unsigned int notification; /* DICE-specific bits */
 };
 
+#define SND_EFW_TRANSACTION_SEQNUM_MAX	((uint32_t)(BIT(28) - 1))
+/* each field should be in big endian */
+struct snd_efw_transaction {
+	uint32_t length;
+	uint32_t version;
+	uint32_t seqnum;
+	uint32_t category;
+	uint32_t command;
+	uint32_t status;
+	uint32_t params[0];
+};
+struct snd_firewire_event_efw_response {
+	unsigned int type;
+	uint32_t response[0];	/* some responses */
+};
+
 union snd_firewire_event {
 	struct snd_firewire_event_common            common;
 	struct snd_firewire_event_lock_status       lock_status;
 	struct snd_firewire_event_dice_notification dice_notification;
+	struct snd_firewire_event_efw_response      efw_response;
 };
 
 
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index a44b0e5..4f9120c 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -34,6 +34,8 @@ MODULE_LICENSE("GPL v2");
 static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
+unsigned int resp_buf_size	= 1024;
+bool resp_buf_debug		= false;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "card index");
@@ -41,6 +43,10 @@ module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "enable Fireworks sound card");
+module_param(resp_buf_size, uint, 0444);
+MODULE_PARM_DESC(resp_buf_size, "response buffer size (default 1024)");
+module_param(resp_buf_debug, bool, 0444);
+MODULE_PARM_DESC(resp_buf_debug, "store all responses to buffer");
 
 static DEFINE_MUTEX(devices_mutex);
 static unsigned int devices_used;
@@ -180,6 +186,7 @@ efw_probe(struct fw_unit *unit,
 {
 	struct snd_card *card;
 	struct snd_efw *efw;
+	void *resp_buf;
 	int card_index, err;
 
 	mutex_lock(&devices_mutex);
@@ -193,6 +200,13 @@ efw_probe(struct fw_unit *unit,
 		goto end;
 	}
 
+	/* prepare response buffer */
+	resp_buf = kzalloc(resp_buf_size, GFP_KERNEL);
+	if (resp_buf == NULL) {
+		err = -ENOMEM;
+		goto end;
+	}
+
 	err = snd_card_create(index[card_index], id[card_index],
 			      THIS_MODULE, sizeof(struct snd_efw), &card);
 	if (err < 0)
@@ -207,6 +221,7 @@ efw_probe(struct fw_unit *unit,
 	mutex_init(&efw->mutex);
 	spin_lock_init(&efw->lock);
 	init_waitqueue_head(&efw->hwdep_wait);
+	efw->resp_buf = efw->pull_ptr = efw->push_ptr = resp_buf;
 
 	err = get_hardware_info(efw);
 	if (err < 0)
@@ -228,6 +243,7 @@ efw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_efw_transaction_register_instance(efw);
 	err = snd_efw_create_hwdep_device(efw);
 	if (err < 0)
 		goto error;
@@ -264,6 +280,7 @@ static void efw_remove(struct fw_unit *unit)
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
 	snd_efw_stream_destroy_duplex(efw);
+	snd_efw_transaction_unregister_instance(efw);
 
 	snd_card_disconnect(efw->card);
 	snd_card_free_when_closed(efw->card);
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 2c08ad4..dd51a22 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -50,6 +50,9 @@
 #define HWINFO_NAME_SIZE_BYTES		32
 #define HWINFO_MAX_CAPS_GROUPS		8
 
+extern unsigned int resp_buf_size;
+extern bool resp_buf_debug;
+
 struct snd_efw_phys_grp {
 	u8 type;	/* see enum snd_efw_grp_type */
 	u8 count;
@@ -92,25 +95,25 @@ struct snd_efw {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
-};
 
-/* for transaction */
-struct snd_efw_transaction {
-	u32 length;
-	u32 version;
-	u32 seqnum;
-	u32 category;
-	u32 command;
-	u32 status;
-	u32 params[0];
+	/* response queue */
+	u8 *resp_buf;
+	u8 *pull_ptr;
+	u8 *push_ptr;
+	unsigned int resp_queues;
 };
 
+/* for transaction */
+int snd_efw_transaction_cmd(struct fw_unit *unit,
+			    const void *cmd, unsigned int size);
 int snd_efw_transaction_run(struct fw_unit *unit,
 			    const void *cmd, unsigned int cmd_size,
 			    void *resp, unsigned int resp_size, u32 seqnum);
 int snd_efw_transaction_register(void);
 void snd_efw_transaction_unregister(void);
 void snd_efw_transaction_bus_reset(struct fw_unit *unit);
+void snd_efw_transaction_register_instance(struct snd_efw *efw);
+void snd_efw_transaction_unregister_instance(struct snd_efw *efw);
 
 /* for needed commands */
 struct snd_efw_hwinfo {
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index 14906bb..c5b0904 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -31,6 +31,7 @@
  * there are some commands which FFADO don't implement
  */
 
+#define EFW_TRANSACTION_SEQNUM_MIN	(SND_EFW_TRANSACTION_SEQNUM_MAX + 1)
 #define EFW_TRANSACTION_SEQNUM_MAX	((u32)~0)
 
 /* for clock source and sampling rate */
@@ -129,8 +130,9 @@ efw_transaction(struct snd_efw *efw, unsigned int category,
 
 	/* to keep consistency of sequence number */
 	spin_lock(&efw->lock);
-	if (efw->seqnum + 1 >= EFW_TRANSACTION_SEQNUM_MAX)
-		efw->seqnum = 0;
+	if ((efw->seqnum < EFW_TRANSACTION_SEQNUM_MIN) ||
+	    (efw->seqnum >= EFW_TRANSACTION_SEQNUM_MAX - 2))
+		efw->seqnum = EFW_TRANSACTION_SEQNUM_MIN;
 	else
 		efw->seqnum += 2;
 	seqnum = efw->seqnum;
diff --git a/sound/firewire/fireworks/fireworks_hwdep.c b/sound/firewire/fireworks/fireworks_hwdep.c
index 6f430fa..be004b3 100644
--- a/sound/firewire/fireworks/fireworks_hwdep.c
+++ b/sound/firewire/fireworks/fireworks_hwdep.c
@@ -17,26 +17,101 @@
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
+	/* data type is SNDRV_FIREWIRE_EVENT_EFW_RESPONSE */
+	if (remained < sizeof(type))
+		goto err;
+	type = SNDRV_FIREWIRE_EVENT_EFW_RESPONSE;
+	if (copy_to_user(buf, &type, sizeof(type)))
+		goto err;
+	remained -= sizeof(type);
+	buf += sizeof(type);
+
+	/* write into buffer as many responses as possible */
+	while (efw->resp_queues > 0) {
+		t = (struct snd_efw_transaction *)(efw->pull_ptr);
+		length = be32_to_cpu(t->length) * sizeof(t->length);
+
+		/* confirm enough space for this response */
+		if (remained < length)
+			break;
+
+		/* copy from ring buffer to user buffer */
+		while (length > 0) {
+			till_end = resp_buf_size -
+				(unsigned int)(efw->pull_ptr - efw->resp_buf);
+			till_end = min_t(unsigned int, length, till_end);
+
+			if (copy_to_user(buf, efw->pull_ptr, till_end))
+				goto err;
+
+			efw->pull_ptr += till_end;
+			if (efw->pull_ptr >= efw->resp_buf + resp_buf_size)
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
+err:
+	return -EFAULT;
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
@@ -46,20 +121,47 @@ hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
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
+	return count;
+}
+
+static long
+hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
+	    loff_t *offset)
+{
+	struct snd_efw *efw = hwdep->private_data;
+	u32 seqnum;
+	u8 *buf;
+
+	if (count < sizeof(struct snd_efw_transaction))
+		return -EFAULT;
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (buf == NULL)
 		return -EFAULT;
 
+	if (copy_from_user(buf, data, count)) {
+		count = -EFAULT;
+		goto end;
+	}
+
+	/* check seqnum is not for kernel-land */
+	seqnum = ((struct snd_efw_transaction *)buf)->seqnum;
+	if (seqnum + 2 > SND_EFW_TRANSACTION_SEQNUM_MAX) {
+		count = -EFAULT;
+		goto end;
+	}
+
+	if (snd_efw_transaction_cmd(efw->unit, buf, count) < 0)
+		count = -EFAULT;
+end:
+	kfree(buf);
 	return count;
 }
 
@@ -72,13 +174,13 @@ hwdep_poll(struct snd_hwdep *hwdep, struct file *file, poll_table *wait)
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
@@ -182,6 +284,7 @@ hwdep_compat_ioctl(struct snd_hwdep *hwdep, struct file *file,
 
 static const struct snd_hwdep_ops hwdep_ops = {
 	.read		= hwdep_read,
+	.write		= hwdep_write,
 	.release	= hwdep_release,
 	.poll		= hwdep_poll,
 	.ioctl		= hwdep_ioctl,
diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
index 2b0f936..d33eb90 100644
--- a/sound/firewire/fireworks/fireworks_proc.c
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -122,7 +122,6 @@ proc_read_clock(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 
 	snd_iprintf(buffer, "Clock Source: %d\n", clock_source);
 	snd_iprintf(buffer, "Sampling Rate: %d\n", sampling_rate);
-
 end:
 	return;
 }
@@ -184,12 +183,31 @@ end:
 	return;
 }
 
+static void
+proc_read_queues_state(struct snd_info_entry *entry,
+		       struct snd_info_buffer *buffer)
+{
+	struct snd_efw *efw = entry->private_data;
+	unsigned int consumed;
+
+	if (efw->pull_ptr > efw->push_ptr)
+		consumed = resp_buf_size -
+			   (unsigned int)(efw->pull_ptr - efw->push_ptr);
+	else
+		consumed = (unsigned int)(efw->push_ptr - efw->pull_ptr);
+
+	snd_iprintf(buffer, "%d %d/%d\n",
+		    efw->resp_queues, consumed, resp_buf_size);
+}
+
 void snd_efw_proc_init(struct snd_efw *efw)
 {
 	struct snd_info_entry *entry;
 
 	if (!snd_card_proc_new(efw->card, "#hardware", &entry))
 		snd_info_set_text_ops(entry, efw, proc_read_hwinfo);
+	if (!snd_card_proc_new(efw->card, "#queues", &entry))
+		snd_info_set_text_ops(entry, efw, proc_read_queues_state);
 	if (!snd_card_proc_new(efw->card, "#clock", &entry))
 		snd_info_set_text_ops(entry, efw, proc_read_clock);
 	if (!snd_card_proc_new(efw->card, "#meters", &entry))
diff --git a/sound/firewire/fireworks/fireworks_transaction.c b/sound/firewire/fireworks/fireworks_transaction.c
index a701e76..f28a673 100644
--- a/sound/firewire/fireworks/fireworks_transaction.c
+++ b/sound/firewire/fireworks/fireworks_transaction.c
@@ -53,6 +53,9 @@
 #define ERROR_DELAY_MS 5
 #define EFC_TIMEOUT_MS 125
 
+static DEFINE_SPINLOCK(instances_lock);
+static struct snd_efw *instances[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+
 static DEFINE_SPINLOCK(transaction_queues_lock);
 static LIST_HEAD(transaction_queues);
 
@@ -72,6 +75,14 @@ struct transaction_queue {
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
 			    void *resp, unsigned int resp_size, u32 seqnum)
@@ -93,9 +104,7 @@ int snd_efw_transaction_run(struct fw_unit *unit,
 
 	tries = 0;
 	do {
-		ret = snd_fw_transaction(unit, TCODE_WRITE_BLOCK_REQUEST,
-					 MEMORY_SPACE_EFW_COMMAND,
-					 (void *)cmd, cmd_size, 0);
+		ret = snd_efw_transaction_cmd(t.unit, (void *)cmd, cmd_size);
 		if (ret < 0)
 			break;
 
@@ -122,27 +131,92 @@ int snd_efw_transaction_run(struct fw_unit *unit,
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
+		capacity = resp_buf_size -
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
+		till_end = resp_buf_size -
+			   (unsigned int)(efw->push_ptr - efw->resp_buf);
+		till_end = min_t(unsigned int, length, till_end);
+
+		memcpy(efw->push_ptr, data, till_end);
+
+		efw->push_ptr += till_end;
+		if (efw->push_ptr >= efw->resp_buf + resp_buf_size)
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
+		smp_rmb();	/* node id vs.generation */
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
@@ -159,14 +233,76 @@ efw_response(struct fw_card *card, struct fw_request *request,
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
+	if (seqnum > SND_EFW_TRANSACTION_SEQNUM_MAX) {
+		handle_resp_for_kernel(card, generation, source,
+				       data, length, &rcode, seqnum);
+		if (resp_buf_debug)
+			handle_resp_for_user(card, generation, source,
+					     data, length, &dummy);
+	} else {
+		handle_resp_for_user(card, generation, source,
+				     data, length, &rcode);
+	}
 end:
 	fw_send_response(card, request, rcode);
 }
 
+void snd_efw_transaction_register_instance(struct snd_efw *efw)
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
+void snd_efw_transaction_unregister_instance(struct snd_efw *efw)
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
