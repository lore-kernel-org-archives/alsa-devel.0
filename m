From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 29/49] fireworks/firewire-lib: Add a quirk of data blocks for
	MIDI in out-stream
Date: Fri, 25 Apr 2014 22:45:10 +0900
Message-ID: <1398433530-13136-30-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Fireworks has a quirk to ignore MIDI messages in data blocks more than 8.
This commit adds a flag for this quirk and codes to skip 8 or more data
blocks to transfer MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      | 5 ++++-
 sound/firewire/amdtp.h                      | 3 +++
 sound/firewire/fireworks/fireworks_stream.c | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 5e13b3f..28ee3d8 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -78,6 +78,8 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->callbacked = false;
 	s->sync_slave = NULL;
 
+	s->rx_blocks_for_midi = UINT_MAX;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -472,7 +474,8 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 		b = (u8 *)&buffer[s->midi_position];
 
 		port = (s->data_block_counter + f) % 8;
-		if ((s->midi[port] == NULL) ||
+		if ((f >= s->rx_blocks_for_midi) ||
+		    (s->midi[port] == NULL) ||
 		    (snd_rawmidi_transmit(s->midi[port], b + 1, 1) <= 0))
 			b[0] = 0x80;
 		else
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 42c75c9..fb5934c 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -125,6 +125,9 @@ struct amdtp_stream {
 	/* quirk: fixed interval of dbc between previos/current packets. */
 	unsigned int tx_dbc_interval;
 
+	/* quirk: the first count of data blocks in an rx packet for MIDI */
+	unsigned int rx_blocks_for_midi;
+
 	bool callbacked;
 	wait_queue_head_t callback_wait;
 	struct amdtp_stream *sync_slave;
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 3a3f203..f9d836f 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -212,6 +212,11 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 		destroy_stream(efw, &efw->tx_stream);
 		goto end;
 	}
+	/*
+	 * Fireworks ignores MIDI messages in more than first 8 data
+	 * blocks of an received AMDTP packet.
+	 */
+	efw->rx_stream.rx_blocks_for_midi = 8;
 
 	/* set IEC61883 compliant mode (actually not fully compliant...) */
 	err = snd_efw_command_set_tx_mode(efw, SND_EFW_TRANSPORT_MODE_IEC61883);
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
