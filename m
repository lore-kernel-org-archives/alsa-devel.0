From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/11] ALSA: digi00x: support unknown
	asynchronous message
Date: Mon, 16 Mar 2015 01:01:05 +0900
Message-ID: <1426435269-17059-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F1A6A26087E
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 17:01:20 +0100 (CET)
In-Reply-To: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, robin@gareus.org, damien@zamaudio.com
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family use asynchronous transaction for messaging.
The address to receive this message is stored on a certain register.

This commit allocates a certain range of address on OHCI 1394 host
controller, to handle this notification. Currently, the purpose of
this message is unknown.

Usually, these devices notify 0x00007051. But there're cases that
0x00007052/0200007058. In these cases, the device sounds quite a
short gap.

I guess that this notification is related to clock synchronization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile           |   2 +-
 sound/firewire/digi00x/digi00x-protocol.c | 122 ++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.c          |  12 +++
 sound/firewire/digi00x/digi00x.h          |   5 ++
 4 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/digi00x-protocol.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index deb3683..e42b5cc 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,3 +1,3 @@
 snd-digi00x-objs := digi00x.o digi00x-stream.o digi00x-proc.o digi00x-pcm.o \
-		    digi00x-midi.o digi00x-hwdep.o
+		    digi00x-midi.o digi00x-hwdep.o digi00x-protocol.o
 obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
new file mode 100644
index 0000000..b19708d
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -0,0 +1,122 @@
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
+static void handle_unknown_message(struct snd_dg00x *dg00x,
+				   unsigned long long offset, u32 *buf)
+{
+	snd_printk(KERN_INFO"%08llx: %08x\n", offset, be32_to_cpu(*buf));
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
+	if (offset == 0xffffe0000000)
+		handle_unknown_message(dg00x, offset, buf);
+
+	spin_unlock_irq(&instances_lock);
+	fw_send_response(card, request, RCODE_COMPLETE);
+}
+
+/*
+ * Use the same range of address for asynchronous messages from any devices, to
+ * save resources on host controller.
+ */
+static struct fw_address_handler async_handler;
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
+				 0xffffe0000014ull, &data, sizeof(data), 0);
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
index 7503d31..85cfb39 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -78,6 +78,11 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPTICAL_MODE_SPDIF,
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
