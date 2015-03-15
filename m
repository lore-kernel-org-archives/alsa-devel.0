From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/11] digi00x: improve MIDI capture/playback
Date: Mon, 16 Mar 2015 01:01:08 +0900
Message-ID: <1426435269-17059-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 38ADA260881
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 17:01:21 +0100 (CET)
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

Digi 002/003 family are not conformant to IEC 61883-6:2005 or MMA/AMEI
RP-027. In fact, they uses AM824 format data, but data channel includes
port number in its LSB. The MSB is always 0x80, even if the data channel
includes any MIDI messages. As a result, every MIDI conformant data
channel can transfer maximum 2 bytes.

This commit adds own callback functions to handle this quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-protocol.c | 48 +++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c   |  3 ++
 sound/firewire/digi00x/digi00x.h          |  4 +++
 3 files changed, 55 insertions(+)

diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
index 3e5b3bec..4dd373d 100644
--- a/sound/firewire/digi00x/digi00x-protocol.c
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -8,6 +8,54 @@
 
 #include "digi00x.h"
 
+void snd_dg00x_protocol_fill_midi(struct amdtp_stream *s,
+				  __be32 *buffer, unsigned int frames)
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
+void snd_dg00x_protocol_pull_midi(struct amdtp_stream *s,
+				  __be32 *buffer, unsigned int frames)
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
 struct workqueue_struct *midi_wq;
 
 static void send_midi_control(struct work_struct *work)
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 92eb86d..410b971 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -204,6 +204,9 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 	dg00x->rx_stream.midi_position = 0;
 	dg00x->tx_stream.midi_position = 0;
 
+	dg00x->rx_stream.transfer_midi = snd_dg00x_protocol_fill_midi;
+	dg00x->tx_stream.transfer_midi = snd_dg00x_protocol_pull_midi;
+
 	return 0;
 error:
 	release_resources(dg00x);
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 20b178f..a658f44 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -84,6 +84,10 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPTICAL_MODE_SPDIF,
 };
 
+void snd_dg00x_protocol_fill_midi(struct amdtp_stream *s,
+				  __be32 *buffer, unsigned int frames);
+void snd_dg00x_protocol_pull_midi(struct amdtp_stream *s,
+				  __be32 *buffer, unsigned int frames);
 void snd_dg00x_protocol_queue_midi_message(struct snd_dg00x *dg00x);
 int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x);
 void snd_dg00x_protocol_remove_instance(struct snd_dg00x *dg00x);
-- 
2.1.0
