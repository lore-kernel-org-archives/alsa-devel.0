From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/17] ALSA: oxfw: copy handlers of
	asynchronous transaction for MIDI capture
Date: Sun,  6 Dec 2015 13:18:20 +0900
Message-ID: <1449375505-2704-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B7D672651F0
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit copies some functions of asynchronous transactions for MIDI
capture, to merge scs1x module. The features of payload in asynchronous
transaction are:

 * System exclusive messages for SCS.1 are encoded without ID data. In
   this encoding scheme, 4 bits in LSB are available. The bits are squashed
   in payload byte. Thus, one payload byte transfers two MIDI messages.
 * The first byte of payload byte means:
  * 0x00: depending on second payload byte
   * 0xf9: including escaped system exclusive messages for SCS.1, up to
     3 byte (= 6 MIDI messages)
   * the others: including MIDI 1.0 messages
  * the others: including escaped system exclusive messages for SCS.1, up
    to 64 bytes

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 83 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 4a2a7ff..4060bf0 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -11,18 +11,99 @@
 
 #define HSS1394_ADDRESS			0xc007dedadadaULL
 #define HSS1394_MAX_PACKET_SIZE		64
+#define HSS1394_TAG_USER_DATA		0x00
 #define HSS1394_TAG_CHANGE_ADDRESS	0xf1
 
 struct fw_scs1x {
 	struct fw_address_handler hss_handler;
+	u8 input_escape_count;
+	struct snd_rawmidi_substream *input;
 };
 
+static const u8 sysex_escape_prefix[] = {
+	0xf0,			/* SysEx begin */
+	0x00, 0x01, 0x60,	/* Stanton DJ */
+	0x48, 0x53, 0x53,	/* "HSS" */
+};
+
+static void midi_input_escaped_byte(struct snd_rawmidi_substream *stream,
+				    u8 byte)
+{
+	u8 nibbles[2];
+
+	nibbles[0] = byte >> 4;
+	nibbles[1] = byte & 0x0f;
+	snd_rawmidi_receive(stream, nibbles, 2);
+}
+
+static void midi_input_byte(struct fw_scs1x *scs,
+			    struct snd_rawmidi_substream *stream, u8 byte)
+{
+	const u8 eox = 0xf7;
+
+	if (scs->input_escape_count > 0) {
+		midi_input_escaped_byte(stream, byte);
+		scs->input_escape_count--;
+		if (scs->input_escape_count == 0)
+			snd_rawmidi_receive(stream, &eox, sizeof(eox));
+	} else if (byte == 0xf9) {
+		snd_rawmidi_receive(stream, sysex_escape_prefix,
+				    ARRAY_SIZE(sysex_escape_prefix));
+		midi_input_escaped_byte(stream, 0x00);
+		midi_input_escaped_byte(stream, 0xf9);
+		scs->input_escape_count = 3;
+	} else {
+		snd_rawmidi_receive(stream, &byte, 1);
+	}
+}
+
+static void midi_input_packet(struct fw_scs1x *scs,
+			      struct snd_rawmidi_substream *stream,
+			      const u8 *data, unsigned int bytes)
+{
+	unsigned int i;
+	const u8 eox = 0xf7;
+
+	if (data[0] == HSS1394_TAG_USER_DATA) {
+		for (i = 1; i < bytes; ++i)
+			midi_input_byte(scs, stream, data[i]);
+	} else {
+		snd_rawmidi_receive(stream, sysex_escape_prefix,
+				    ARRAY_SIZE(sysex_escape_prefix));
+		for (i = 0; i < bytes; ++i)
+			midi_input_escaped_byte(stream, data[i]);
+		snd_rawmidi_receive(stream, &eox, sizeof(eox));
+	}
+}
+
 static void handle_hss(struct fw_card *card, struct fw_request *request,
 		       int tcode, int destination, int source, int generation,
 		       unsigned long long offset, void *data, size_t length,
 		       void *callback_data)
 {
-	fw_send_response(card, request, RCODE_COMPLETE);
+	struct fw_scs1x *scs = callback_data;
+	struct snd_rawmidi_substream *stream;
+	int rcode;
+
+	if (offset != scs->hss_handler.offset) {
+		rcode = RCODE_ADDRESS_ERROR;
+		goto end;
+	}
+	if (tcode != TCODE_WRITE_QUADLET_REQUEST &&
+	    tcode != TCODE_WRITE_BLOCK_REQUEST) {
+		rcode = RCODE_TYPE_ERROR;
+		goto end;
+	}
+
+	if (length >= 1) {
+		stream = ACCESS_ONCE(scs->input);
+		if (stream)
+			midi_input_packet(scs, stream, data, length);
+	}
+
+	rcode = RCODE_COMPLETE;
+end:
+	fw_send_response(card, request, rcode);
 }
 
 static int register_address(struct snd_oxfw *oxfw)
-- 
2.5.0
