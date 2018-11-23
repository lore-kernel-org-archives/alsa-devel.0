From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: firewire-tascam: pick up data of
	state from tx isochronous pakcets
Date: Fri, 23 Nov 2018 13:13:03 +0900
Message-ID: <20181123041307.22980-2-o-takashi@sakamocchi.jp>
References: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DB04926786E
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 05:13:33 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id c72so2754312pfc.6
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 20:13:33 -0800 (PST)
In-Reply-To: <20181123041307.22980-1-o-takashi@sakamocchi.jp>
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
Cc: sbahling@suse.com, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Units of TASCAM FireWire series multiplex PCM frames and state of
control surface into the same tx isochronous packets. One isochronous
packet includes a part of the state in a quadlet data. An image of the
state consists of 64 quadlet data.

This commit demultiplexes the state from tx isochronous packets.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/firewire.h        |  2 ++
 sound/firewire/tascam/amdtp-tascam.c | 17 ++++++++++++++++-
 sound/firewire/tascam/tascam.h       |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/firewire.h b/include/uapi/sound/firewire.h
index f0a547d86679..b9bc4bb1756b 100644
--- a/include/uapi/sound/firewire.h
+++ b/include/uapi/sound/firewire.h
@@ -88,4 +88,6 @@ struct snd_firewire_get_info {
  * Returns -EBUSY if the driver is already streaming.
  */
 
+#define SNDRV_FIREWIRE_TASCAM_STATE_COUNT	64
+
 #endif /* _UAPI_SOUND_FIREWIRE_H_INCLUDED */
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index ab482423c165..516cb931fd5e 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -117,6 +117,21 @@ int amdtp_tscm_add_pcm_hw_constraints(struct amdtp_stream *s,
 	return amdtp_stream_add_pcm_hw_constraints(s, runtime);
 }
 
+static void read_status_messages(struct amdtp_stream *s,
+				 __be32 *buffer, unsigned int data_blocks)
+{
+	struct snd_tscm *tscm = container_of(s, struct snd_tscm, tx_stream);
+	int i;
+
+	for (i = 0; i < data_blocks; i++) {
+		unsigned int index;
+
+		index = be32_to_cpu(buffer[0]) % SNDRV_FIREWIRE_TASCAM_STATE_COUNT;
+		tscm->state[index] = buffer[s->data_block_quadlets - 1];
+		buffer += s->data_block_quadlets;
+	}
+}
+
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
@@ -128,7 +143,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 	if (data_blocks > 0 && pcm)
 		read_pcm_s32(s, pcm, buffer, data_blocks);
 
-	/* A place holder for control messages. */
+	read_status_messages(s, buffer, data_blocks);
 
 	return data_blocks;
 }
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index a5bd167eb5d9..c710496a99cf 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -89,6 +89,9 @@ struct snd_tscm {
 
 	/* For MIDI message outgoing transactions. */
 	struct snd_fw_async_midi_port out_ports[TSCM_MIDI_OUT_PORT_MAX];
+
+	// A cache of status information in tx isoc packets.
+	__be32 state[SNDRV_FIREWIRE_TASCAM_STATE_COUNT];
 };
 
 #define TSCM_ADDR_BASE			0xffff00000000ull
-- 
2.19.1
