From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] ALSA: fireface: support rx MIDI
	functionality for Fireface UCX
Date: Tue, 22 Jan 2019 22:17:05 +0900
Message-ID: <20190122131705.23213-7-o-takashi@sakamocchi.jp>
References: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C55B72674AC
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:25 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id y126so11771995pfb.4
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:25 -0800 (PST)
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

In latter model of Fireface series, asynchronous transaction includes
a prefix byte to indicate the way to decode included MIDI bytes.

Upper 4 bits of the prefix byte indicates port number, and the rest 4
bits indicate the way to decode rest of bytes for MIDI messages.

Basically the rest bits indicates the number of bytes for MIDI message.
However, if the last byte of each MIDi message is included, the rest
bits are 0xf. For example:

message: f0 00 00 66 14 20 00 00 f7
offset: content (big endian, port 0)
 '0030: 0x02f00000
 '0030: 0x03006614
 '0030: 0x03200000
 '0030: 0x0ff70000

This commit supports encoding scheme for the above and allows
applications to transfer MIDI messages via ALSA rawmidi interface.
An unused member (running_status) is reused to keep state of
transmission of system exclusive messages.

For your information, this is a dump of config rom.

$ sudo ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'bmc': False,
                'chip_ID': 13225063715,
                'cmc': False,
                'cyc_clk_acc': 0,
                'imc': False,
                'isc': True,
                'max_rec': 512,
                'name': '1394',
                'node_vendor_ID': 2613},
  'root-directory': [ [ 'NODE_CAPABILITIES',
                        { 'addressing': {'64': True, 'fix': True, 'prv': False},
                          'misc': {'int': False, 'ms': False, 'spt': True},
                          'state': { 'atn': False,
                                     'ded': False,
                                     'drq': True,
                                     'elo': False,
                                     'init': False,
                                     'lst': True,
                                     'off': False},
                          'testing': {'bas': False, 'ext': False}}],
                      ['VENDOR', 2613],
                      ['DESCRIPTOR', 'RME!'],
                      ['EUI_64', 2873037108442403],
                      [ 'UNIT',
                        [ ['SPECIFIER_ID', 2613],
                          ['VERSION', 4],
                          ['MODEL', 1054720],
                          ['DESCRIPTOR', 'Fireface UCX']]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff-midi.c            |  2 +-
 sound/firewire/fireface/ff-protocol-latter.c | 96 ++++++++++++++++++++
 sound/firewire/fireface/ff.c                 |  1 +
 sound/firewire/fireface/ff.h                 |  2 +-
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/fireface/ff-midi.c b/sound/firewire/fireface/ff-midi.c
index 6a49611ee462..5b44e1c4569a 100644
--- a/sound/firewire/fireface/ff-midi.c
+++ b/sound/firewire/fireface/ff-midi.c
@@ -19,7 +19,7 @@ static int midi_playback_open(struct snd_rawmidi_substream *substream)
 	struct snd_ff *ff = substream->rmidi->private_data;
 
 	/* Initialize internal status. */
-	ff->running_status[substream->number] = 0;
+	ff->on_sysex[substream->number] = 0;
 	ff->rx_midi_error[substream->number] = false;
 
 	WRITE_ONCE(ff->rx_midi_substreams[substream->number], substream);
diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index a812ab6feb58..817af4447349 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -306,8 +306,104 @@ static void latter_handle_midi_msg(struct snd_ff *ff, unsigned int offset,
 		snd_rawmidi_receive(substream, byte, len);
 }
 
+/*
+ * When return minus value, given argument is not MIDI status.
+ * When return 0, given argument is a beginning of system exclusive.
+ * When return the others, given argument is MIDI data.
+ */
+static inline int calculate_message_bytes(u8 status)
+{
+	switch (status) {
+	case 0xf6:	/* Tune request. */
+	case 0xf8:	/* Timing clock. */
+	case 0xfa:	/* Start. */
+	case 0xfb:	/* Continue. */
+	case 0xfc:	/* Stop. */
+	case 0xfe:	/* Active sensing. */
+	case 0xff:	/* System reset. */
+		return 1;
+	case 0xf1:	/* MIDI time code quarter frame. */
+	case 0xf3:	/* Song select. */
+		return 2;
+	case 0xf2:	/* Song position pointer. */
+		return 3;
+	case 0xf0:	/* Exclusive. */
+		return 0;
+	case 0xf7:	/* End of exclusive. */
+		break;
+	case 0xf4:	/* Undefined. */
+	case 0xf5:	/* Undefined. */
+	case 0xf9:	/* Undefined. */
+	case 0xfd:	/* Undefined. */
+		break;
+	default:
+		switch (status & 0xf0) {
+		case 0x80:	/* Note on. */
+		case 0x90:	/* Note off. */
+		case 0xa0:	/* Polyphonic key pressure. */
+		case 0xb0:	/* Control change and Mode change. */
+		case 0xe0:	/* Pitch bend change. */
+			return 3;
+		case 0xc0:	/* Program change. */
+		case 0xd0:	/* Channel pressure. */
+			return 2;
+		default:
+		break;
+		}
+	break;
+	}
+
+	return -EINVAL;
+}
+
+static int latter_fill_midi_msg(struct snd_ff *ff,
+				struct snd_rawmidi_substream *substream,
+				unsigned int port)
+{
+	u32 data = {0};
+	u8 *buf = (u8 *)&data;
+	int consumed;
+
+	buf[0] = port << 4;
+	consumed = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
+	if (consumed <= 0)
+		return consumed;
+
+	if (!ff->on_sysex[port]) {
+		if (buf[1] != 0xf0) {
+			if (consumed < calculate_message_bytes(buf[1]))
+				return 0;
+		} else {
+			// The beginning of exclusives.
+			ff->on_sysex[port] = true;
+		}
+
+		buf[0] |= consumed;
+	} else {
+		if (buf[1] != 0xf7) {
+			if (buf[2] == 0xf7 || buf[3] == 0xf7) {
+				// Transfer end code at next time.
+				consumed -= 1;
+			}
+
+			buf[0] |= consumed;
+		} else {
+			// The end of exclusives.
+			ff->on_sysex[port] = false;
+			consumed = 1;
+			buf[0] |= 0x0f;
+		}
+	}
+
+	ff->msg_buf[port][0] = cpu_to_le32(data);
+	ff->rx_bytes[port] = consumed;
+
+	return 1;
+}
+
 const struct snd_ff_protocol snd_ff_protocol_latter = {
 	.handle_midi_msg	= latter_handle_midi_msg,
+	.fill_midi_msg		= latter_fill_midi_msg,
 	.get_clock		= latter_get_clock,
 	.switch_fetching_mode	= latter_switch_fetching_mode,
 	.begin_session		= latter_begin_session,
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 675c6ab556eb..a9611157f4c8 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -174,6 +174,7 @@ static const struct snd_ff_spec spec_ucx = {
 	.pcm_capture_channels = {18, 14, 12},
 	.pcm_playback_channels = {18, 14, 12},
 	.midi_in_ports = 2,
+	.midi_out_ports = 2,
 	.protocol = &snd_ff_protocol_latter,
 	.midi_high_addr = 0xffff00000034ull,
 	.midi_addr_range = 0x80,
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index e52ad11803e0..ed8fea0ff5e1 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -75,7 +75,7 @@ struct snd_ff {
 
 	/* TO handle MIDI rx. */
 	struct snd_rawmidi_substream *rx_midi_substreams[SND_FF_OUT_MIDI_PORTS];
-	u8 running_status[SND_FF_OUT_MIDI_PORTS];
+	bool on_sysex[SND_FF_OUT_MIDI_PORTS];
 	__le32 msg_buf[SND_FF_OUT_MIDI_PORTS][SND_FF_MAXIMIM_MIDI_QUADS];
 	struct work_struct rx_midi_work[SND_FF_OUT_MIDI_PORTS];
 	struct fw_transaction transactions[SND_FF_OUT_MIDI_PORTS];
-- 
2.19.1
