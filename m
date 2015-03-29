From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/11] ALSA: digi00x: improve MIDI
	capture/playback
Date: Mon, 30 Mar 2015 00:05:30 +0900
Message-ID: <1427641531-9047-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 756AD2606D0
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:45 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family are not conformant to IEC 61883-6:2005 or MMA/AMEI
RP-027. In fact, they uses AM824 format data, but data channel includes
port number in its LSB. The MSB is always 0x80, even if the data channel
includes any MIDI messages. As a result, every MIDI conformant data
channel can transfer maximum 2 bytes.

This commit adds own callback functions to handle this quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-protocol.c | 55 +++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c   |  2 ++
 sound/firewire/digi00x/digi00x.h          |  1 +
 3 files changed, 58 insertions(+)

diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
index 40aea36..9104691 100644
--- a/sound/firewire/digi00x/digi00x-protocol.c
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -8,6 +8,61 @@
 
 #include "digi00x.h"
 
+static void fill_midi(struct amdtp_stream *s, __be32 *buffer,
+		      unsigned int frames)
+{
+	unsigned int f, port;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		port = (s->data_block_counter + f) % 4;
+		b = (u8 *)&buffer[s->midi_position];
+
+		/*
+		 * The device allows to transfer MIDI messages by maximum two
+		 * bytes per data channel. But this module transfers one byte
+		 * one time because MIDI data rate is quite lower than IEEE
+		 * 1394 bus data rate.
+		 */
+		if (amdtp_midi_ratelimit_per_packet(s, port) &&
+		    s->midi[port] != NULL &&
+		    snd_rawmidi_transmit(s->midi[port], &b[1], 1) == 1) {
+			amdtp_midi_rate_use_one_byte(s, port);
+			b[3] = 0x01 | (0x10 << port);
+		} else {
+			b[1] = 0;
+			b[3] = 0;
+		}
+		b[0] = 0x80;
+		b[2] = 0;
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static void pull_midi(struct amdtp_stream *s, __be32 *buffer,
+		      unsigned int frames)
+{
+	unsigned int f;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		b = (u8 *)&buffer[s->midi_position];
+
+		if (s->midi[0] && (b[3] > 0))
+			snd_rawmidi_receive(s->midi[0], b + 1, b[3]);
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+/* Use own way to multiplex MIDI messages for data channels. */
+void snd_dg00x_protocol_set_midi_function(struct snd_dg00x *dg00x)
+{
+	dg00x->rx_stream.transfer_midi = fill_midi;
+	dg00x->tx_stream.transfer_midi = pull_midi;
+}
+
 struct workqueue_struct *midi_wq;
 
 static void send_midi_control(struct work_struct *work)
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 5d72264..8220d53 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -196,6 +196,8 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 		dg00x->tx_stream.pcm_positions[c] = c + 1;
 	}
 
+	snd_dg00x_protocol_set_midi_function(dg00x);
+
 	return 0;
 error:
 	release_resources(dg00x);
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index d534f90..b9d072c 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -112,6 +112,7 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPT_IFACE_MODE_COUNT,
 };
 
+void snd_dg00x_protocol_set_midi_function(struct snd_dg00x *dg00x);
 void snd_dg00x_protocol_queue_midi_message(struct snd_dg00x *dg00x);
 int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x);
 void snd_dg00x_protocol_remove_instance(struct snd_dg00x *dg00x);
-- 
2.1.0
