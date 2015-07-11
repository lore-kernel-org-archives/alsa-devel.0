From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 33/37] ALSA: firewire-motu: add
	transaction functionality
Date: Sat, 11 Jul 2015 23:12:44 +0900
Message-ID: <1436623968-10780-34-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 584012605D2
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

MOTU FireWire series can transfer messages to registered address. These
messages are transferred for the status of internal clock synchronization
just after starting streams.

When the synchronization is stable, it's 0x01ffffff. Else, it's 0x05ffffff.

This commit adds a functionality to receive the message. Currently, the
received message are output to system logging.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile           |  2 +-
 sound/firewire/motu/motu-transaction.c | 97 ++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c             |  8 +++
 sound/firewire/motu/motu.h             |  7 +++
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-transaction.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 1547a98..e41c693 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu.o
+snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu-transaction.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-transaction.c b/sound/firewire/motu/motu-transaction.c
new file mode 100644
index 0000000..af08ecd
--- /dev/null
+++ b/sound/firewire/motu/motu-transaction.c
@@ -0,0 +1,97 @@
+/*
+ * motu-transaction.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+static void handle_message(struct fw_card *card, struct fw_request *request,
+			   int tcode, int destination, int source,
+			   int generation, unsigned long long offset,
+			   void *data, size_t length, void *callback_data)
+{
+//	struct snd_motu *motu = callback_data;
+	u32 *buf = (__be32 *)data;
+
+	/*
+	if (offset == motu->async_handler.offset) {
+		spin_lock_irqsave(&motu->lock, flags);
+		motu->msg = be32_to_cpu(*buf);
+		spin_unlock_irqrestore(&motu->lock, flags);
+
+		wake_up(&motu->hwdep_wait);
+	}
+	*/
+
+	snd_printk(KERN_INFO"%08x, %ld\n", be32_to_cpu(buf[0]), length / 4);
+
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+int snd_motu_transaction_reregister(struct snd_motu *motu)
+{
+	struct fw_device *device = fw_parent_device(motu->unit);
+	__be32 data;
+	int err;
+
+	/* Register messaging address. Block transaction is not allowed. */
+	data = cpu_to_be32((device->card->node_id << 16) |
+			   (motu->async_handler.offset >> 32));
+	err = snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+				 MOTU_REG_BASE + 0x0b04,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	data = cpu_to_be32(motu->async_handler.offset);
+	return snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  MOTU_REG_BASE + 0x0b08,
+				  &data, sizeof(data), 0);
+}
+
+int snd_motu_transaction_register(struct snd_motu *motu)
+{
+	static const struct fw_address_region resp_register_region = {
+		.start	= 0xffffe0000000ull,
+		.end	= 0xffffe000ffffull,
+	};
+	int err;
+
+	/* Perhaps, 4 byte messages are transferred. */
+	motu->async_handler.length = 4;
+	motu->async_handler.address_callback = handle_message;
+	motu->async_handler.callback_data = motu;
+
+	err = fw_core_add_address_handler(&motu->async_handler,
+					  &resp_register_region);
+	if (err < 0)
+		return err;
+
+	err = snd_motu_transaction_reregister(motu);
+	if (err < 0) {
+		fw_core_remove_address_handler(&motu->async_handler);
+		motu->async_handler.address_callback = NULL;
+	}
+
+	return err;
+}
+
+void snd_motu_transaction_unregister(struct snd_motu *motu)
+{
+	__be32 data;
+
+	if (motu->async_handler.address_callback != NULL)
+		fw_core_remove_address_handler(&motu->async_handler);
+	motu->async_handler.address_callback = 0;
+
+	/* Unregister the address. */
+	data = cpu_to_be32(0x00000000);
+	snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   MOTU_REG_BASE + 0x0b04,
+			   &data, sizeof(data), 0);
+	snd_fw_transaction(motu->unit, TCODE_WRITE_QUADLET_REQUEST,
+			   MOTU_REG_BASE + 0x0b08,
+			   &data, sizeof(data), 0);
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 8666819..3c7a51f 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -42,6 +42,7 @@ static void motu_card_free(struct snd_card *card)
 	struct snd_motu *motu = card->private_data;
 
 	snd_motu_stream_destroy_duplex(motu);
+	snd_motu_transaction_unregister(motu);
 	fw_unit_put(motu->unit);
 
 	mutex_destroy(&motu->mutex);
@@ -71,6 +72,10 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto error;
 
+	err = snd_motu_transaction_register(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
@@ -95,6 +100,9 @@ static void motu_bus_update(struct fw_unit *unit)
 {
 	struct snd_motu *motu = dev_get_drvdata(&unit->device);
 
+	/* The handler address register becomes initialized. */
+	snd_motu_transaction_reregister(motu);
+
 	mutex_lock(&motu->mutex);
 	snd_motu_stream_update_duplex(motu);
 	mutex_unlock(&motu->mutex);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index b3fc558..1597e99 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -60,6 +60,9 @@ struct snd_motu {
 	/* Between pcm.open() and pcm.prepare(). */
 	unsigned int tx_pcm_channels[3];
 	unsigned int rx_pcm_channels[3];
+
+	/* For messaging. */
+	struct fw_address_handler async_handler;
 };
 
 #define MOTU_REG_BASE		0xfffff0000000ull
@@ -98,4 +101,8 @@ int snd_motu_stream_get_clock(struct snd_motu *motu,
 			      enum snd_motu_clock *src);
 int snd_motu_stream_update_current_channels(struct snd_motu *motu);
 
+int snd_motu_transaction_register(struct snd_motu *motu);
+int snd_motu_transaction_reregister(struct snd_motu *motu);
+void snd_motu_transaction_unregister(struct snd_motu *motu);
+
 #endif
-- 
2.1.4
