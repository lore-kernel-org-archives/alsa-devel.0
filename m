From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/11] ALSA: digi00x: support unknown
	asynchronous message
Date: Mon, 30 Mar 2015 00:05:27 +0900
Message-ID: <1427641531-9047-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 70DDA2606CD
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:45 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family use asynchronous transaction for messaging.
The address to receive this message is stored on a certain register.

This commit allocates a certain range of address on OHCI 1394 host
controller, to handle this notification. Currently, the purpose of
this message is unknown.

Usually, these devices confirmedly notify these messages below:
 * Clock source is set as internal:
 - 0x00007051
 - 0x00007052
 - 0x00007054
 - 0x00007057
 - 0x00007058
 * Clock source is set as somewhat external:
 - 0x00009000
 - 0x00009010
 - 0x00009020
 - 0x00009021
 - 0x00009022

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h             |   7 ++
 sound/firewire/digi00x/Makefile           |   2 +-
 sound/firewire/digi00x/digi00x-hwdep.c    |  12 ++-
 sound/firewire/digi00x/digi00x-protocol.c | 131 ++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c          |  12 +++
 sound/firewire/digi00x/digi00x.h          |   8 ++
 6 files changed, 169 insertions(+), 3 deletions(-)
 create mode 100644 sound/firewire/digi00x/digi00x-protocol.c

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index f67d228..8e32b41 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -9,6 +9,7 @@
 #define SNDRV_FIREWIRE_EVENT_LOCK_STATUS	0x000010cc
 #define SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION	0xd1ce004e
 #define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE	0x4e617475
+#define SNDRV_FIREWIRE_EVENT_DIGI00x_MESSAGE	0x746e736c
 
 struct snd_firewire_event_common {
 	unsigned int type; /* SNDRV_FIREWIRE_EVENT_xxx */
@@ -40,11 +41,17 @@ struct snd_firewire_event_efw_response {
 	__be32 response[0];	/* some responses */
 };
 
+struct snd_firewire_event_digi00x_message {
+	unsigned int type;
+	__u32 message;	/* Digi00x-specific message */
+};
+
 union snd_firewire_event {
 	struct snd_firewire_event_common            common;
 	struct snd_firewire_event_lock_status       lock_status;
 	struct snd_firewire_event_dice_notification dice_notification;
 	struct snd_firewire_event_efw_response      efw_response;
+	struct snd_firewire_event_digi00x_message   digi00x_message;
 };
 
 
diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index deb3683..e42b5cc 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,3 +1,3 @@
 snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o digi00x-pcm.o \
-		    digi00x-midi.o digi00x-hwdep.o
+		    digi00x-midi.o digi00x-hwdep.o digi00x-protocol.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-hwdep.c b/sound/firewire/digi00x/digi00x-hwdep.c
index d629e41..a3e1c37 100644
--- a/sound/firewire/digi00x/digi00x-hwdep.c
+++ b/sound/firewire/digi00x/digi00x-hwdep.c
@@ -12,6 +12,7 @@
  * 1.get firewire node information
  * 2.get notification about starting/stopping stream
  * 3.lock/unlock stream
+ * 4.get asynchronous messaging
  */
 
 #include "digi00x.h"
@@ -25,7 +26,7 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 
 	spin_lock_irq(&dg00x->lock);
 
-	while (!dg00x->dev_lock_changed) {
+	while (!dg00x->dev_lock_changed && dg00x->msg == 0) {
 		prepare_to_wait(&dg00x->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&dg00x->lock);
 		schedule();
@@ -42,6 +43,13 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 		dg00x->dev_lock_changed = false;
 
 		count = min_t(long, count, sizeof(event.lock_status));
+	} else {
+		event.digi00x_message.type =
+					SNDRV_FIREWIRE_EVENT_DIGI00x_MESSAGE;
+		event.digi00x_message.message = dg00x->msg;
+		dg00x->msg = 0;
+
+		count = min_t(long, count, sizeof(event.digi00x_message));
 	}
 
 	spin_unlock_irq(&dg00x->lock);
@@ -61,7 +69,7 @@ static unsigned int hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
 	poll_wait(file, &dg00x->hwdep_wait, wait);
 
 	spin_lock_irq(&dg00x->lock);
-	if (dg00x->dev_lock_changed)
+	if (dg00x->dev_lock_changed || dg00x->msg)
 		events = POLLIN | POLLRDNORM;
 	else
 		events = 0;
diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
new file mode 100644
index 0000000..72c942a
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -0,0 +1,131 @@
+/*
+ * digi00x-protocol.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "digi00x.h"
+
+static struct snd_dg00x *instances[SNDRV_CARDS];
+static DEFINE_SPINLOCK(instances_lock);
+
+/*
+ * Use the same range of address for asynchronous messages from any devices, to
+ * save resources on host controller.
+ */
+static struct fw_address_handler async_handler;
+
+static void handle_unknown_message(struct snd_dg00x *dg00x,
+				   unsigned long long offset, u32 *buf)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dg00x->lock, flags);
+	dg00x->msg = be32_to_cpu(*buf);
+	spin_unlock_irqrestore(&dg00x->lock, flags);
+
+	wake_up(&dg00x->hwdep_wait);
+}
+
+static void handle_message(struct fw_card *card, struct fw_request *request,
+			   int tcode, int destination, int source,
+			   int generation, unsigned long long offset,
+			   void *data, size_t length, void *callback_data)
+{
+	u32 *buf = (__be32 *)data;
+	struct fw_device *device;
+	struct snd_dg00x *dg00x;
+	unsigned int i;
+
+	spin_lock_irq(&instances_lock);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		dg00x = instances[i];
+		if (dg00x == NULL)
+			continue;
+		device = fw_parent_device(dg00x->unit);
+		if (device->card != card)
+			continue;
+		smp_rmb();	/* node id vs. generation */
+		if (device->node_id != source)
+			continue;
+		break;
+	}
+
+	if (offset == async_handler.offset)
+		handle_unknown_message(dg00x, offset, buf);
+	else if (offset == async_handler.offset + 4)
+		handle_midi_control(dg00x, buf, length);
+
+	spin_unlock_irq(&instances_lock);
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x)
+{
+	struct fw_device *device = fw_parent_device(dg00x->unit);
+	__be32 data[2];
+	unsigned int i;
+	int err;
+
+	/* Unknown. 4bytes. */
+	data[0] = cpu_to_be32((device->card->node_id << 16) |
+			      (async_handler.offset >> 32));
+	data[1] = cpu_to_be32(async_handler.offset);
+	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	spin_lock_irq(&instances_lock);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (instances[i] != NULL)
+			continue;
+		instances[i] = dg00x;
+		break;
+	}
+	spin_unlock_irq(&instances_lock);
+
+	return 0;
+}
+
+void snd_dg00x_protocol_remove_instance(struct snd_dg00x *dg00x)
+{
+	unsigned int i;
+
+	spin_lock_irq(&instances_lock);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (instances[i] != dg00x)
+			continue;
+		instances[i] = NULL;
+		break;
+	}
+	spin_unlock_irq(&instances_lock);
+}
+
+int snd_dg00x_protocol_register(void)
+{
+	static const struct fw_address_region resp_register_region = {
+		.start	= 0xffffe0000000ull,
+		.end	= 0xffffe000ffffull,
+	};
+	int err;
+
+	async_handler.length = 4;
+	async_handler.address_callback = handle_message;
+	async_handler.callback_data = NULL;
+
+	err = fw_core_add_address_handler(&async_handler,
+					  &resp_register_region);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+void snd_dg00x_protocol_unregister(void)
+{
+	fw_core_remove_address_handler(&async_handler);
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index c170cbb..db0997d 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -48,6 +48,7 @@ static void dg00x_card_free(struct snd_card *card)
 	struct snd_dg00x *dg00x = card->private_data;
 
 	snd_dg00x_stream_destroy_duplex(dg00x);
+	snd_dg00x_protocol_remove_instance(dg00x);
 
 	fw_unit_put(dg00x->unit);
 
@@ -99,6 +100,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_protocol_add_instance(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -155,11 +160,18 @@ static struct fw_driver dg00x_driver = {
 
 static int __init snd_dg00x_init(void)
 {
+	int err;
+
+	err = snd_dg00x_protocol_register();
+	if (err < 0)
+		return err;
+
 	return driver_register(&dg00x_driver.driver);
 }
 
 static void __exit snd_dg00x_exit(void)
 {
+	snd_dg00x_protocol_unregister();
 	driver_unregister(&dg00x_driver.driver);
 }
 
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 5d9beaf..4e3d359 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -53,6 +53,9 @@ struct snd_dg00x {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	/* For asynchronous messages. */
+	u32 msg;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
@@ -103,6 +106,11 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPT_IFACE_MODE_COUNT,
 };
 
+int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x);
+void snd_dg00x_protocol_remove_instance(struct snd_dg00x *dg00x);
+int snd_dg00x_protocol_register(void);
+void snd_dg00x_protocol_unregister(void);
+
 extern const unsigned int snd_dg00x_stream_rates[SND_DG00X_RATE_COUNT];
 extern const unsigned int
 snd_dg00x_stream_mbla_data_channels[SND_DG00X_RATE_COUNT];
-- 
2.1.0
