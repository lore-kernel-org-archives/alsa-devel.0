From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/6] firewire-digi00x: add support of
	asynchronous transaction for incoming MIDI messages from
	physical controls
Date: Sun, 11 Oct 2015 12:30:17 +0900
Message-ID: <1444534219-31718-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A63292605F1
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 05:30:30 +0200 (CEST)
In-Reply-To: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 00x series has two types of model; rack and console. The console
models have physical controls. The model can transmit control messages.
These control messages are transferred by asynchronous transactions to
registered address.

This commit supports the asynchronous transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-transaction.c | 41 ++++++++++++++++++++++++++--
 sound/firewire/digi00x/digi00x.h             |  3 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-transaction.c b/sound/firewire/digi00x/digi00x-transaction.c
index 4937290..8bf5ed5 100644
--- a/sound/firewire/digi00x/digi00x-transaction.c
+++ b/sound/firewire/digi00x/digi00x-transaction.c
@@ -9,6 +9,28 @@
 #include <sound/asound.h>
 #include "digi00x.h"
 
+static void handle_midi_control(struct snd_dg00x *dg00x, __be32 *buf,
+				unsigned int length)
+{
+	struct snd_rawmidi_substream *substream;
+	unsigned int i;
+	unsigned int len;
+	u8 *b;
+
+	substream = ACCESS_ONCE(dg00x->in_control);
+	if (substream == NULL)
+		return;
+
+	length /= 4;
+
+	for (i = 0; i < length; i++) {
+		b = (u8 *)&buf[i];
+		len = b[3] & 0xf;
+		if (len > 0)
+			snd_rawmidi_receive(dg00x->in_control, b + 1, len);
+	}
+}
+
 static void handle_unknown_message(struct snd_dg00x *dg00x,
 				   unsigned long long offset, __be32 *buf)
 {
@@ -31,6 +53,8 @@ static void handle_message(struct fw_card *card, struct fw_request *request,
 
 	if (offset == dg00x->async_handler.offset)
 		handle_unknown_message(dg00x, offset, buf);
+	else if (offset == dg00x->async_handler.offset + 4)
+		handle_midi_control(dg00x, buf, length);
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
@@ -39,14 +63,25 @@ int snd_dg00x_transaction_reregister(struct snd_dg00x *dg00x)
 {
 	struct fw_device *device = fw_parent_device(dg00x->unit);
 	__be32 data[2];
+	int err;
 
 	/* Unknown. 4bytes. */
 	data[0] = cpu_to_be32((device->card->node_id << 16) |
 			      (dg00x->async_handler.offset >> 32));
 	data[1] = cpu_to_be32(dg00x->async_handler.offset);
+	err = snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
+				 &data, sizeof(data), 0);
+	if (err < 0)
+		return err;
+
+	/* Asynchronous transactions for MIDI control message. */
+	data[0] = cpu_to_be32((device->card->node_id << 16) |
+			      (dg00x->async_handler.offset >> 32));
+	data[1] = cpu_to_be32(dg00x->async_handler.offset + 4);
 	return snd_fw_transaction(dg00x->unit, TCODE_WRITE_BLOCK_REQUEST,
-				   DG00X_ADDR_BASE + DG00X_OFFSET_MESSAGE_ADDR,
-				   &data, sizeof(data), 0);
+				  DG00X_ADDR_BASE + DG00X_OFFSET_MIDI_CTL_ADDR,
+				  &data, sizeof(data), 0);
 }
 
 int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
@@ -57,7 +92,7 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 	};
 	int err;
 
-	dg00x->async_handler.length = 4;
+	dg00x->async_handler.length = 12;
 	dg00x->async_handler.address_callback = handle_message;
 	dg00x->async_handler.callback_data = dg00x;
 
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 89494d0..630f6aa 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -53,6 +53,9 @@ struct snd_dg00x {
 	/* For asynchronous messages. */
 	struct fw_address_handler async_handler;
 	u32 msg;
+
+	/* For asynchronous MIDI controls. */
+	struct snd_rawmidi_substream *in_control;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
-- 
2.1.4
