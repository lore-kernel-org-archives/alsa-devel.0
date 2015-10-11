From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] firewire-digi00x: add support of
	asynchronous transaction for outgoing MIDI messages to
	physical controls
Date: Sun, 11 Oct 2015 12:30:18 +0900
Message-ID: <1444534219-31718-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 888D52605F4
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 05:30:32 +0200 (CEST)
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

In previous commit, asynchronous transaction for incoming MIDI messages
from physical controls is supported. The physical controls may be
controlled by receiving MIDI messages at a certain address.

This commit supports asynchronous transaction for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-transaction.c | 29 ++++++++++++++++++++++++----
 sound/firewire/digi00x/digi00x.h             |  1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-transaction.c b/sound/firewire/digi00x/digi00x-transaction.c
index 8bf5ed5..554324d 100644
--- a/sound/firewire/digi00x/digi00x-transaction.c
+++ b/sound/firewire/digi00x/digi00x-transaction.c
@@ -9,6 +9,18 @@
 #include <sound/asound.h>
 #include "digi00x.h"
 
+static int fill_midi_message(struct snd_rawmidi_substream *substream, u8 *buf)
+{
+	int bytes;
+
+	buf[0] = 0x80;
+	bytes = snd_rawmidi_transmit_peek(substream, buf + 1, 2);
+	if (bytes >= 0)
+		buf[3] = 0xc0 | bytes;
+
+	return bytes;
+}
+
 static void handle_midi_control(struct snd_dg00x *dg00x, __be32 *buf,
 				unsigned int length)
 {
@@ -102,15 +114,24 @@ int snd_dg00x_transaction_register(struct snd_dg00x *dg00x)
 		return err;
 
 	err = snd_dg00x_transaction_reregister(dg00x);
-	if (err < 0) {
-		fw_core_remove_address_handler(&dg00x->async_handler);
-		dg00x->async_handler.address_callback = NULL;
-	}
+	if (err < 0)
+		goto error;
+
+	err = snd_fw_async_midi_port_init(&dg00x->out_control, dg00x->unit,
+					  DG00X_ADDR_BASE + DG00X_OFFSET_MMC,
+					  4, fill_midi_message);
+	if (err < 0)
+		goto error;
 
 	return err;
+error:
+	fw_core_remove_address_handler(&dg00x->async_handler);
+	dg00x->async_handler.address_callback = NULL;
+	return err;
 }
 
 void snd_dg00x_transaction_unregister(struct snd_dg00x *dg00x)
 {
+	snd_fw_async_midi_port_destroy(&dg00x->out_control);
 	fw_core_remove_address_handler(&dg00x->async_handler);
 }
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 630f6aa..907e739 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -56,6 +56,7 @@ struct snd_dg00x {
 
 	/* For asynchronous MIDI controls. */
 	struct snd_rawmidi_substream *in_control;
+	struct snd_fw_async_midi_port out_control;
 };
 
 #define DG00X_ADDR_BASE		0xffffe0000000ull
-- 
2.1.4
