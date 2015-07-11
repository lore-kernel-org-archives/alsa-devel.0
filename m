From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 15/37] ALSA: firewire-digi00x: add support
	for asynchronous messaging
Date: Sat, 11 Jul 2015 23:12:26 +0900
Message-ID: <1436623968-10780-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C0C260589
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:05 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, Damien Zammit <damien@zamaudio.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family uses asynchronous transaction for messaging.
The address to transmit this message is stored on a certain register.

This commit allocates a certain range of address on OHCI 1394 host
controller, to handle the messaging. Currently, the purpose of
this message seems to notify losts of synchronization.

Actual examples of this messaging:
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

The meaning of these contents is unknown.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Robin Gareus <robin@gareus.org>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h                |  7 +++
 sound/firewire/digi00x/Makefile              |  2 +-
 sound/firewire/digi00x/digi00x-hwdep.c       | 11 +++-
 sound/firewire/digi00x/digi00x-transaction.c | 81 ++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c             |  7 +++
 sound/firewire/digi00x/digi00x.h             |  7 +++
 6 files changed, 112 insertions(+), 3 deletions(-)
 create mode 100644 sound/firewire/digi00x/digi00x-transaction.c

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index f67d228..deb041c 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -9,6 +9,7 @@
 #define SNDRV_FIREWIRE_EVENT_LOCK_STATUS	0x000010cc
 #define SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION	0xd1ce004e
 #define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE	0x4e617475
+#define SNDRV_FIREWIRE_EVENT_DIGI00X_MESSAGE	0x746e736c
 
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
index 91e6671..f5dbc20 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,4 +1,4 @@
 snd-firewire-digi00x-objs := amdtp-dot.o digi00x-stream.o digi00x-proc.o \
 			     digi00x-pcm.o digi00x-midi.o digi00x-hwdep.o \
-			     digi00x.o
+			     digi00x-transaction.o digi00x.o
 obj-m += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-hwdep.c b/sound/firewire/digi00x/digi00x-hwdep.c
index 6c157dd..f188e47 100644
--- a/sound/firewire/digi00x/digi00x-hwdep.c
+++ b/sound/firewire/digi00x/digi00x-hwdep.c
@@ -26,7 +26,7 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 
 	spin_lock_irq(&dg00x->lock);
 
-	while (!dg00x->dev_lock_changed) {
+	while (!dg00x->dev_lock_changed && dg00x->msg == 0) {
 		prepare_to_wait(&dg00x->hwdep_wait, &wait, TASK_INTERRUPTIBLE);
 		spin_unlock_irq(&dg00x->lock);
 		schedule();
@@ -43,6 +43,13 @@ static long hwdep_read(struct snd_hwdep *hwdep, char __user *buf,  long count,
 		dg00x->dev_lock_changed = false;
 
 		count = min_t(long, count, sizeof(event.lock_status));
+	} else {
+		event.digi00x_message.type =
+					SNDRV_FIREWIRE_EVENT_DIGI00X_MESSAGE;
+		event.digi00x_message.message = dg00x->msg;
+		dg00x->msg = 0;
+
+		count = min_t(long, count, sizeof(event.digi00x_message));
 	}
 
 	spin_unlock_irq(&dg00x->lock);
@@ -62,7 +69,7 @@ static unsigned int hwdep_poll(struct snd_hwdep *hwdep, struct file *file,
 	poll_wait(file, &dg00x->hwdep_wait, wait);
 
 	spin_lock_irq(&dg00x->lock);
-	if (dg00x->dev_lock_changed)
+	if (dg00x->dev_lock_changed || dg00x->msg)
 		events = POLLIN | POLLRDNORM;
 	else
 		events = 0;
diff --git a/sound/firewire/digi00x/digi00x-transaction.c b/sound/firewire/digi00x/digi00x-transaction.c
new file mode 100644
index 0000000..4568d98
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-transaction.c
@@ -0,0 +1,81 @@
+/*
+ * digi00x-transaction.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <sound/asound.h>
+#include "digi00x.h"
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
+	struct snd_dg00x *dg00x = callback_data;
+	u32 *buf = (__be32 *)data;
+
+	if (offset == dg00x->async_handler.offset)
+		handle_unknown_message(dg00x, offset, buf);
+
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+int snd_dg00x_transaction_reregister(struct snd_dg00x *dg00x)
+{
+	struct fw_device *device = fw_parent_device(dg00x->unit);
+	__be32 data[2];
+
+	/* Unknown. 4bytes. */
+	data[0] = cpu_to_be32((device->card->node_id << 16) |
+			      (dg00x->async_handler.offset >> 32));
+	data[1] = cpu_to_be32(dg00x->async_handler.offset);
+	return snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
+				   DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
+				   &data, sizeof(data), 0);
+}
+
+int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
+{
+	static const struct fw_address_region resp_register_region = {
+		.start	= 0xffffe0000000ull,
+		.end	= 0xffffe000ffffull,
+	};
+	int err;
+
+	dg00x->async_handler.length = 4;
+	dg00x->async_handler.address_callback = handle_message;
+	dg00x->async_handler.callback_data = dg00x;
+
+	err = fw_core_add_address_handler(&dg00x->async_handler,
+					  &resp_register_region);
+	if (err < 0)
+		return err;
+
+	err = snd_dg00x_transaction_reregister(dg00x);
+	if (err < 0) {
+		fw_core_remove_address_handler(&dg00x->async_handler);
+		dg00x->async_handler.address_callback = NULL;
+	}
+
+	return err;
+}
+
+void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x)
+{
+	fw_core_remove_address_handler(&dg00x->async_handler);
+}
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 0f2c331..c93cb2827 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -48,6 +48,7 @@ static void dg00x_card_free(struct snd_card *card)
 	struct snd_dg00x *dg00x = card->private_data;
 
 	snd_dg00x_stream_destroy_duplex(dg00x);
+	snd_dg00x_transaction_unregister(dg00x);
 
 	fw_unit_put(dg00x->unit);
 
@@ -99,6 +100,10 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_dg00x_transaction_register(dg00x);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -115,6 +120,8 @@ static void snd_dg00x_update(struct fw_unit *unit)
 {
 	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
 
+	snd_dg00x_transaction_reregister(dg00x);
+
 	mutex_lock(&dg00x->mutex);
 	snd_dg00x_stream_update_duplex(dg00x);
 	mutex_unlock(&dg00x->mutex);
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 2776408..1ecc4a7 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -51,6 +51,9 @@ struct snd_dg00x {
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
 
+	/* For asynchronous messages. */
+	struct fw_address_handler async_handler;
+	u32 msg;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
@@ -112,6 +115,10 @@ void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
 void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			    struct snd_rawmidi_substream *midi);
 
+int snd_dg00x_transaction_register(struct snd_dg00x *dg00x);
+int snd_dg00x_transaction_reregister(struct snd_dg00x *dg00x);
+void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x);
+
 extern const unsigned int snd_dg00x_stream_rates[SND_DG00X_RATE_COUNT];
 extern const unsigned int snd_dg00x_stream_pcm_channels[SND_DG00X_RATE_COUNT];
 int snd_dg00x_stream_get_external_rate(struct snd_dg00x *dg00x,
-- 
2.1.4
