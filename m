From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/8] ALSA: fireface: localize a handler for
	MIDI messages on tx transaction
Date: Tue, 11 Dec 2018 19:17:34 +0900
Message-ID: <20181211101735.13735-8-o-takashi@sakamocchi.jp>
References: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A26D267BA8
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:57 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id u6so6710919plm.8
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:57 -0800 (PST)
In-Reply-To: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Content of asynchronous transaction for MIDI messages differs between
Fireface 400 and 800.

This commit adds a model-specific handler for the transaction and adds
arrangement.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-ff400.c | 38 +++++++++++++++++++++
 sound/firewire/fireface/ff-transaction.c    | 34 +-----------------
 sound/firewire/fireface/ff.h                |  1 +
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-ff400.c b/sound/firewire/fireface/ff-protocol-ff400.c
index b283762e785c..8f34174ee813 100644
--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -105,7 +105,45 @@ static int ff400_switch_fetching_mode(struct snd_ff *ff, bool enable)
 	return err;
 }
 
+static void ff400_handle_midi_msg(struct snd_ff *ff, __le32 *buf, size_t length)
+{
+	int i;
+
+	for (i = 0; i < length / 4; i++) {
+		u32 quad = le32_to_cpu(buf[i]);
+		u8 byte;
+		unsigned int index;
+		struct snd_rawmidi_substream *substream;
+
+		/* Message in first port. */
+		/*
+		 * This value may represent the index of this unit when the same
+		 * units are on the same IEEE 1394 bus. This driver doesn't use
+		 * it.
+		 */
+		index = (quad >> 8) & 0xff;
+		if (index > 0) {
+			substream = READ_ONCE(ff->tx_midi_substreams[0]);
+			if (substream != NULL) {
+				byte = quad & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+
+		/* Message in second port. */
+		index = (quad >> 24) & 0xff;
+		if (index > 0) {
+			substream = READ_ONCE(ff->tx_midi_substreams[1]);
+			if (substream != NULL) {
+				byte = (quad >> 16) & 0xff;
+				snd_rawmidi_receive(substream, &byte, 1);
+			}
+		}
+	}
+}
+
 const struct snd_ff_protocol snd_ff_protocol_ff400 = {
+	.handle_midi_msg	= ff400_handle_midi_msg,
 	.begin_session		= ff400_begin_session,
 	.finish_session		= ff400_finish_session,
 	.switch_fetching_mode	= ff400_switch_fetching_mode,
diff --git a/sound/firewire/fireface/ff-transaction.c b/sound/firewire/fireface/ff-transaction.c
index 1ce4cef6ca35..d8768348067b 100644
--- a/sound/firewire/fireface/ff-transaction.c
+++ b/sound/firewire/fireface/ff-transaction.c
@@ -206,42 +206,10 @@ static void handle_midi_msg(struct fw_card *card, struct fw_request *request,
 {
 	struct snd_ff *ff = callback_data;
 	__le32 *buf = data;
-	u32 quad;
-	u8 byte;
-	unsigned int index;
-	struct snd_rawmidi_substream *substream;
-	int i;
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 
-	for (i = 0; i < length / 4; i++) {
-		quad = le32_to_cpu(buf[i]);
-
-		/* Message in first port. */
-		/*
-		 * This value may represent the index of this unit when the same
-		 * units are on the same IEEE 1394 bus. This driver doesn't use
-		 * it.
-		 */
-		index = (quad >> 8) & 0xff;
-		if (index > 0) {
-			substream = READ_ONCE(ff->tx_midi_substreams[0]);
-			if (substream != NULL) {
-				byte = quad & 0xff;
-				snd_rawmidi_receive(substream, &byte, 1);
-			}
-		}
-
-		/* Message in second port. */
-		index = (quad >> 24) & 0xff;
-		if (index > 0) {
-			substream = READ_ONCE(ff->tx_midi_substreams[1]);
-			if (substream != NULL) {
-				byte = (quad >> 16) & 0xff;
-				snd_rawmidi_receive(substream, &byte, 1);
-			}
-		}
-	}
+	ff->spec->protocol->handle_midi_msg(ff, buf, length);
 }
 
 static int allocate_own_address(struct snd_ff *ff, int i)
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 466304c72d76..178a96cb6e2a 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -108,6 +108,7 @@ enum snd_ff_clock_src {
 };
 
 struct snd_ff_protocol {
+	void (*handle_midi_msg)(struct snd_ff *ff, __le32 *buf, size_t length);
 	int (*begin_session)(struct snd_ff *ff, unsigned int rate);
 	void (*finish_session)(struct snd_ff *ff);
 	int (*switch_fetching_mode)(struct snd_ff *ff, bool enable);
-- 
2.19.1
