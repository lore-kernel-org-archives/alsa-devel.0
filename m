From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] ALSA: fireface: support tx MIDI
	functionality of Fireface UCX
Date: Tue, 22 Jan 2019 22:17:02 +0900
Message-ID: <20190122131705.23213-4-o-takashi@sakamocchi.jp>
References: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F11D2674AC
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:19 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id gn14so11474029plb.10
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:19 -0800 (PST)
In-Reply-To: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
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

Fireface UCX transfers asynchronous transactions for MIDI messages.
One transaction includes quadlet data therefore it can transfer 3
message bytes as maximum. Base address of the destination is
configured by two settings; a register for higher 8 byte of the
address, and a bitflag to option register indicates lower 8byte.

The register for higher address is 0x'ffff'0000'0034. Unfortunately,
firmware v24 includes a bug to ignore registered value for the
destination address and transfers to 0x0001xxxxxxxx always. This
driver doesn't work well if the bug exists, therefore users should
install the latest firmware (v27).

The bitflag is a part of value to be written to option register
(0x'ffff'0000'0014).

lower addr:  bitflag (little endian)
 '0000'0000: 0x00002000
 '0000'0080: 0x00004000
 '0000'0100: 0x00008000
 '0000'0180: 0x00010000

This register includes more options but they are not relevant to
packet streaming or MIDI functionality. This driver don't touch it.

Furthermore, the transaction is sent to address offset incremented
by 4 byte to the offset in previous time. When it reaches base address
plus 0x7c, next offset is the base address.

Content of the transaction includes a prefix byte. Upper 4 bits of
the byte indicates port number, and the rest 4 bits indicate the way
to decode rest of bytes for MIDI message.

Except for system exclusive messages, the rest bits are the same as
status bits of the message without channel bits. For system exclusive
messages, the rest bits are encoded according to included message bytes.
For example:

message: f0 7e 7f 09 01 f7
offset: content (little endian, port 0)
 '0000: 0x04f07e7f
 '0004: 0x070901f7

message: f0 00 00 66 14 20 00 00 00 f7
offset: content (little endian, port 1)
 '0014: 0x14f00000
 '0018: 0x14661420
 '001c: 0x14000000
 '0020: 0x15f70000

message: f0 00 00 66 14 20 00 00 f7
offset: content (little endian, port 0)
 '0078: 0x04f00000
 '007c: 0x04661420
 '0000: 0x070000f7

This commit supports decoding scheme for the above and allows
applications to receive MIDI messages via ALSA rawmidi interface.
The lower 8 bytes of destination address is fixed to 0x'0000'0000,
thus this driver expects userspace applications to configure option
register with bitflag 0x00002000 in advance.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-protocol-latter.c | 43 ++++++++++++++++++++
 sound/firewire/fireface/ff.c                 | 25 +++++-------
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index 64767ba439db..a812ab6feb58 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -264,7 +264,50 @@ static void latter_dump_status(struct snd_ff *ff, struct snd_info_buffer *buffer
 	snd_iprintf(buffer, "Referred clock: %s %d\n", label, rate);
 }
 
+// NOTE: transactions are transferred within 0x00-0x7f in allocated range of
+// address. This seems to be for check of discontinuity in receiver side.
+static void latter_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
+				   __le32 *buf, size_t length)
+{
+	u32 data = le32_to_cpu(*buf);
+	unsigned int index = (data & 0x000000f0) >> 4;
+	u8 byte[3];
+	struct snd_rawmidi_substream *substream;
+	unsigned int len;
+
+	if (index > ff->spec->midi_in_ports)
+		return;
+
+	switch (data & 0x0000000f) {
+	case 0x00000008:
+	case 0x00000009:
+	case 0x0000000a:
+	case 0x0000000b:
+	case 0x0000000e:
+		len = 3;
+		break;
+	case 0x0000000c:
+	case 0x0000000d:
+		len = 2;
+		break;
+	default:
+		len = data & 0x00000003;
+		if (len == 0)
+			len = 3;
+		break;
+	}
+
+	byte[0] = (data & 0x0000ff00) >> 8;
+	byte[1] = (data & 0x00ff0000) >> 16;
+	byte[2] = (data & 0xff000000) >> 24;
+
+	substream = READ_ONCE(ff->tx_midi_substreams[index]);
+	if (substream)
+		snd_rawmidi_receive(substream, byte, len);
+}
+
 const struct snd_ff_protocol snd_ff_protocol_latter = {
+	.handle_midi_msg	= latter_handle_midi_msg,
 	.get_clock		= latter_get_clock,
 	.switch_fetching_mode	= latter_switch_fetching_mode,
 	.begin_session		= latter_begin_session,
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index c09a4875aa86..a2a9fd82f27d 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -32,8 +32,7 @@ static void ff_card_free(struct snd_card *card)
 	struct snd_ff *ff = card->private_data;
 
 	snd_ff_stream_destroy_duplex(ff);
-	if (ff->spec->midi_high_addr > 0)
-		snd_ff_transaction_unregister(ff);
+	snd_ff_transaction_unregister(ff);
 }
 
 static void do_registration(struct work_struct *work)
@@ -51,11 +50,9 @@ static void do_registration(struct work_struct *work)
 	ff->card->private_free = ff_card_free;
 	ff->card->private_data = ff;
 
-	if (ff->spec->midi_high_addr > 0) {
-		err = snd_ff_transaction_register(ff);
-		if (err < 0)
-			goto error;
-	}
+	err = snd_ff_transaction_register(ff);
+	if (err < 0)
+		goto error;
 
 	name_card(ff);
 
@@ -65,11 +62,9 @@ static void do_registration(struct work_struct *work)
 
 	snd_ff_proc_init(ff);
 
-	if (ff->spec->midi_in_ports > 0 || ff->spec->midi_out_ports > 0) {
-		err = snd_ff_create_midi_devices(ff);
-		if (err < 0)
-			goto error;
-	}
+	err = snd_ff_create_midi_devices(ff);
+	if (err < 0)
+		goto error;
 
 	err = snd_ff_create_pcm_devices(ff);
 	if (err < 0)
@@ -124,8 +119,7 @@ static void snd_ff_update(struct fw_unit *unit)
 	if (!ff->registered)
 		snd_fw_schedule_registration(unit, &ff->dwork);
 
-	if (ff->spec->midi_high_addr > 0)
-		snd_ff_transaction_reregister(ff);
+	snd_ff_transaction_reregister(ff);
 
 	if (ff->registered)
 		snd_ff_stream_update_duplex(ff);
@@ -177,7 +171,10 @@ static const struct snd_ff_spec spec_ucx = {
 	.name = "FirefaceUCX",
 	.pcm_capture_channels = {18, 14, 12},
 	.pcm_playback_channels = {18, 14, 12},
+	.midi_in_ports = 2,
 	.protocol = &snd_ff_protocol_latter,
+	.midi_high_addr = 0xffff00000034ull,
+	.midi_addr_range = 0x80,
 };
 
 static const struct ieee1394_device_id snd_ff_id_table[] = {
-- 
2.19.1
