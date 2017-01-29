From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/19] firewire-motu: handle transactions
	specific for MOTU FireWire models
Date: Sun, 29 Jan 2017 12:54:07 +0900
Message-ID: <20170129035417.2095-10-o-takashi@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5EA93266A09
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 04:54:26 +0100 (CET)
In-Reply-To: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
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

All models of MOTU FireWire series can be controlled by write transaction
to addresses in a range from 0x'ffff'f0000'0b00 to 0x'ffff'f000'0cff.

The models support asynchronous notification. This notification has 32 bit
field data, and is transferred when status of clock changes. Meaning of
the value is not enough clear yet.

Drivers can register its address to receive the notification. Write
transaction to 0x'ffff'f000'0b04 registers higher 16 bits of the address.
Write transaction to 0x'ffff'f0000'0b08 registers the rest of bits. The
address includes node ID, thus it should be registered every time of bus
reset.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile           |   2 +-
 sound/firewire/motu/motu-transaction.c | 117 +++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c             |  10 +++
 sound/firewire/motu/motu.h             |  12 ++++
 4 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-transaction.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 37391f5..03b0769 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-motu-objs := motu.o amdtp-motu.o
+snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-transaction.c b/sound/firewire/motu/motu-transaction.c
new file mode 100644
index 0000000..416dd98
--- /dev/null
+++ b/sound/firewire/motu/motu-transaction.c
@@ -0,0 +1,117 @@
+/*
+ * motu-transaction.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+
+#include "motu.h"
+
+#define SND_MOTU_ADDR_BASE	0xfffff0000000ULL
+#define ASYNC_ADDR_HI  0x0b04
+#define ASYNC_ADDR_LO  0x0b08
+
+int snd_motu_transaction_read(struct snd_motu *motu, u32 offset, __be32 *reg,
+			      size_t size)
+{
+	int tcode;
+
+	if (size % sizeof(__be32) > 0 || size <= 0)
+		return -EINVAL;
+	if (size == sizeof(__be32))
+		tcode = TCODE_READ_QUADLET_REQUEST;
+	else
+		tcode = TCODE_READ_BLOCK_REQUEST;
+
+	return snd_fw_transaction(motu->unit, tcode,
+				  SND_MOTU_ADDR_BASE + offset, reg, size, 0);
+}
+
+int snd_motu_transaction_write(struct snd_motu *motu, u32 offset, __be32 *reg,
+			       size_t size)
+{
+	int tcode;
+
+	if (size % sizeof(__be32) > 0 || size <= 0)
+		return -EINVAL;
+	if (size == sizeof(__be32))
+		tcode = TCODE_WRITE_QUADLET_REQUEST;
+	else
+		tcode = TCODE_WRITE_BLOCK_REQUEST;
+
+	return snd_fw_transaction(motu->unit, tcode,
+				  SND_MOTU_ADDR_BASE + offset, reg, size, 0);
+}
+
+static void handle_message(struct fw_card *card, struct fw_request *request,
+			   int tcode, int destination, int source,
+			   int generation, unsigned long long offset,
+			   void *data, size_t length, void *callback_data)
+{
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+int snd_motu_transaction_reregister(struct snd_motu *motu)
+{
+	struct fw_device *device = fw_parent_device(motu->unit);
+	__be32 data;
+	int err;
+
+	if (motu->async_handler.callback_data == NULL)
+		return -EINVAL;
+
+	/* Register messaging address. Block transaction is not allowed. */
+	data = cpu_to_be32((device->card->node_id << 16) |
+			   (motu->async_handler.offset >> 32));
+	err = snd_motu_transaction_write(motu, ASYNC_ADDR_HI, &data,
+					 sizeof(data));
+	if (err < 0)
+		return err;
+
+	data = cpu_to_be32(motu->async_handler.offset);
+	return snd_motu_transaction_write(motu, ASYNC_ADDR_LO, &data,
+					  sizeof(data));
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
+	motu->async_handler.address_callback = NULL;
+
+	/* Unregister the address. */
+	data = cpu_to_be32(0x00000000);
+	snd_motu_transaction_write(motu, ASYNC_ADDR_HI, &data, sizeof(data));
+	snd_motu_transaction_write(motu, ASYNC_ADDR_LO, &data, sizeof(data));
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 1e6fc74..db6014c 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -54,6 +54,8 @@ static void name_card(struct snd_motu *motu)
 
 static void motu_free(struct snd_motu *motu)
 {
+	snd_motu_transaction_unregister(motu);
+
 	fw_unit_put(motu->unit);
 
 	mutex_destroy(&motu->mutex);
@@ -86,6 +88,10 @@ static void do_registration(struct work_struct *work)
 
 	name_card(motu);
 
+	err = snd_motu_transaction_register(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(motu->card);
 	if (err < 0)
 		goto error;
@@ -100,6 +106,7 @@ static void do_registration(struct work_struct *work)
 
 	return;
 error:
+	snd_motu_transaction_unregister(motu);
 	snd_card_free(motu->card);
 	dev_info(&motu->unit->device,
 		 "Sound card registration failed: %d\n", err);
@@ -155,6 +162,9 @@ static void motu_bus_update(struct fw_unit *unit)
 	/* Postpone a workqueue for deferred registration. */
 	if (!motu->registered)
 		snd_fw_schedule_registration(unit, &motu->dwork);
+
+	/* The handler address register becomes initialized. */
+	snd_motu_transaction_reregister(motu);
 }
 
 #define SND_MOTU_DEV_ENTRY(model, data)			\
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index cd1b3dd..ed1d779 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -48,6 +48,10 @@ struct snd_motu {
 	struct snd_motu_packet_format rx_packet_formats;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
+
+	/* For notification. */
+	struct fw_address_handler async_handler;
+	u32 msg;
 };
 
 enum snd_motu_spec_flags {
@@ -106,4 +110,12 @@ int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
 			      struct snd_motu_packet_format *formats);
 int amdtp_motu_add_pcm_hw_constraints(struct amdtp_stream *s,
 				      struct snd_pcm_runtime *runtime);
+
+int snd_motu_transaction_read(struct snd_motu *motu, u32 offset, __be32 *reg,
+			      size_t size);
+int snd_motu_transaction_write(struct snd_motu *motu, u32 offset, __be32 *reg,
+			       size_t size);
+int snd_motu_transaction_register(struct snd_motu *motu);
+int snd_motu_transaction_reregister(struct snd_motu *motu);
+void snd_motu_transaction_unregister(struct snd_motu *motu);
 #endif
-- 
2.9.3
