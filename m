From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-digi00x: remove transaction
	handler for unknown purpose
Date: Sun,  2 Apr 2017 23:48:27 +0900
Message-ID: <20170402144827.32497-5-o-takashi@sakamocchi.jp>
References: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 243A6266884
 for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2017 16:48:32 +0200 (CEST)
In-Reply-To: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
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

For digi00x series, asynchronous transaction is not used to transfer MIDI
messages to/from control surface. One of transction handlers in my previous
work loses its practical meaning.

This commit removes the handler. I note that unit of console type
transfers 0x00001000 to registered address of host space when switching
to 'standalone' mode. Then the unit generates bus reset.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-transaction.c | 88 +++++-----------------------
 sound/firewire/digi00x/digi00x.h             |  6 +-
 2 files changed, 17 insertions(+), 77 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-transaction.c b/sound/firewire/digi00x/digi00x-transaction.c
index 735d356..af9bc85 100644
--- a/sound/firewire/digi00x/digi00x-transaction.c
+++ b/sound/firewire/digi00x/digi00x-transaction.c
@@ -9,40 +9,6 @@
 #include <sound/asound.h>
 #include "digi00x.h"
 
-static int fill_midi_message(struct snd_rawmidi_substream *substream, u8 *buf)
-{
-	int bytes;
-
-	buf[0] = 0x80;
-	bytes = snd_rawmidi_transmit_peek(substream, buf + 1, 2);
-	if (bytes >= 0)
-		buf[3] = 0xc0 | bytes;
-
-	return bytes;
-}
-
-static void handle_midi_control(struct snd_dg00x *dg00x, __be32 *buf,
-				unsigned int length)
-{
-	struct snd_rawmidi_substream *substream;
-	unsigned int i;
-	unsigned int len;
-	u8 *b;
-
-	substream = ACCESS_ONCE(dg00x->in_control);
-	if (substream == NULL)
-		return;
-
-	length /= 4;
-
-	for (i = 0; i < length; i++) {
-		b = (u8 *)&buf[i];
-		len = b[3] & 0xf;
-		if (len > 0)
-			snd_rawmidi_receive(dg00x->in_control, b + 1, len);
-	}
-}
-
 static void handle_unknown_message(struct snd_dg00x *dg00x,
 				   unsigned long long offset, __be32 *buf)
 {
@@ -63,39 +29,36 @@ static void handle_message(struct fw_card *card, struct fw_request *request,
 	struct snd_dg00x *dg00x = callback_data;
 	__be32 *buf = (__be32 *)data;
 
+	fw_send_response(card, request, RCODE_COMPLETE);
+
 	if (offset == dg00x->async_handler.offset)
 		handle_unknown_message(dg00x, offset, buf);
-	else if (offset == dg00x->async_handler.offset + 4)
-		handle_midi_control(dg00x, buf, length);
-
-	fw_send_response(card, request, RCODE_COMPLETE);
 }
 
 int snd_dg00x_transaction_reregister(struct snd_dg00x *dg00x)
 {
 	struct fw_device *device = fw_parent_device(dg00x->unit);
 	__be32 data[2];
-	int err;
 
 	/* Unknown. 4bytes. */
 	data[0] = cpu_to_be32((device->card->node_id << 16) |
 			      (dg00x->async_handler.offset >> 32));
 	data[1] = cpu_to_be32(dg00x->async_handler.offset);
-	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
-				 DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
-				 &data, sizeof(data), 0);
-	if (err < 0)
-		return err;
-
-	/* Asynchronous transactions for MIDI control message. */
-	data[0] = cpu_to_be32((device->card->node_id << 16) |
-			      (dg00x->async_handler.offset >> 32));
-	data[1] = cpu_to_be32(dg00x->async_handler.offset + 4);
 	return snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
-				  DG00X_ADDR_BASE + DG00X_OFFSET_MIDI_CTL_ADDR,
+				  DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
 				  &data, sizeof(data), 0);
 }
 
+void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x)
+{
+	if (dg00x->async_handler.callback_data == NULL)
+		return;
+
+	fw_core_remove_address_handler(&dg00x->async_handler);
+
+	dg00x->async_handler.callback_data = NULL;
+}
+
 int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 {
 	static const struct fw_address_region resp_register_region = {
@@ -104,7 +67,7 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 	};
 	int err;
 
-	dg00x->async_handler.length = 12;
+	dg00x->async_handler.length = 4;
 	dg00x->async_handler.address_callback = handle_message;
 	dg00x->async_handler.callback_data = dg00x;
 
@@ -115,28 +78,7 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 
 	err = snd_dg00x_transaction_reregister(dg00x);
 	if (err < 0)
-		goto error;
-
-	err = snd_fw_async_midi_port_init(&dg00x->out_control, dg00x->unit,
-					  DG00X_ADDR_BASE + DG00X_OFFSET_MMC,
-					  4, fill_midi_message);
-	if (err < 0)
-		goto error;
+		snd_dg00x_transaction_unregister(dg00x);
 
 	return err;
-error:
-	fw_core_remove_address_handler(&dg00x->async_handler);
-	dg00x->async_handler.callback_data = NULL;
-	return err;
-}
-
-void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x)
-{
-	if (dg00x->async_handler.callback_data == NULL)
-		return;
-
-	snd_fw_async_midi_port_destroy(&dg00x->out_control);
-	fw_core_remove_address_handler(&dg00x->async_handler);
-
-	dg00x->async_handler.callback_data = NULL;
 }
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 4aefe45d..1275a50 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -58,9 +58,7 @@ struct snd_dg00x {
 	struct fw_address_handler async_handler;
 	u32 msg;
 
-	/* For asynchronous MIDI controls. */
-	struct snd_rawmidi_substream *in_control;
-	struct snd_fw_async_midi_port out_control;
+	/* Console models have additional MIDI ports for control surface. */
 	bool is_console;
 };
 
@@ -68,7 +66,7 @@ struct snd_dg00x {
 
 #define DG00X_OFFSET_STREAMING_STATE	0x0000
 #define DG00X_OFFSET_STREAMING_SET	0x0004
-#define DG00X_OFFSET_MIDI_CTL_ADDR	0x0008
+/* unknown but address in host space	0x0008 */
 /* For LSB of the address		0x000c */
 /* unknown				0x0010 */
 #define DG00X_OFFSET_MESSAGE_ADDR	0x0014
-- 
2.9.3
