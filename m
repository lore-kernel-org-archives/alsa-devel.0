From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 31/44] bebob/firewire-lib: Add a quirk for discontinuity at
	bus reset
Date: Fri, 21 Mar 2014 20:10:16 +0900
Message-ID: <1395400229-22957-32-git-send-email-o-takashi@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds a flag, which has an effect to skip checking continuity
for first packet. This flag is useful for BeBoB quirk.

Normal BeBoB firmware has a quirk. When receiving bus reset, it transmit
packets with discontinuous value in dbc field.

This causes two situation, one is to abort streaming by firewire-lib as a
result of detecting the discontinuity. Another is to call driver's .update().
These two is generated separately. (The former depends on isochronous stream
and the latter depends on IEEE1394 bus driver.)

When BeBoB driver works with XRUN-recoverable applications, this situation
looks like stream_update_duplex() call following to stream_start_duplex() call
(because applications will call snd_pcm_prepare() immediately).

We shouldn't break connections in stream_update_duplex() or
stream_start_duplex() at bus reset because of this quirk. When breaking
connections, stream_start_duplex() re-establish them, streams immediately
have packets with discontinuity, then firewire-lib generates XRUN,
applications call snd_pcm_prepare() and stream_start_duplex() is called
again, breaking connections, re-establishing connections...(loop)

To avoid this situation, this commit allows BeBoB driver to start streams
during transmitting packets, without breaking connections. The flag is used
for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c              |  8 ++++++--
 sound/firewire/amdtp.h              |  3 +++
 sound/firewire/bebob/bebob.h        |  1 +
 sound/firewire/bebob/bebob_stream.c | 39 ++++++++++++++++++++++++++++++++++---
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 51a13c8..820d790 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -756,7 +756,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 		lost = data_block_counter !=
 		       ((s->data_block_counter + dbc_interval) & 0xff);
 	}
-	if (lost) {
+	if (lost && s->data_block_counter != UINT_MAX) {
 		dev_info(&s->unit->device,
 			 "Detect discontinuity of CIP: %02X %02X\n",
 			 s->data_block_counter, data_block_counter);
@@ -922,7 +922,11 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		goto err_unlock;
 	}
 
-	s->data_block_counter = 0;
+	if (s->direction == AMDTP_IN_STREAM &&
+	    s->flags & CIP_SKIP_INIT_DBC_CHECK)
+		s->data_block_counter = UINT_MAX;
+	else
+		s->data_block_counter = 0;
 	s->data_block_state = initial_state[s->sfc].data_block;
 	s->syt_offset_state = initial_state[s->sfc].syt_offset;
 	s->last_syt_offset = TICKS_PER_CYCLE;
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 5414157..e3ee739 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -27,6 +27,8 @@
  *	corresponds to the end of event in the packet. Out of IEC 61883.
  * @CIP_WRONG_DBS: Only for in-stream. The value of dbs is wrong in in-packets.
  *	The value of data_block_quadlets is used instead of reported value.
+ * @CIP_SKIP_INIT_DBC_CHECK: Only for in-stream. The value of dbc in first
+ *	packet is not continuous from an initial value.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -36,6 +38,7 @@ enum cip_flags {
 	CIP_EMPTY_WITH_TAG0	= 0x08,
 	CIP_DBC_IS_END_EVENT	= 0x10,
 	CIP_WRONG_DBS		= 0x20,
+	CIP_SKIP_INIT_DBC_CHECK	= 0x40,
 };
 
 /**
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 550ccdc..590a49e 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -53,6 +53,7 @@ struct snd_bebob {
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
+	bool connected;
 	struct cmp_connection out_conn;
 	struct amdtp_stream tx_stream;
 	struct cmp_connection in_conn;
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 9375454..f57fdd7 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -308,7 +308,10 @@ check_connection_used_by_others(struct snd_bebob *bebob, struct amdtp_stream *s)
 static int
 make_both_connections(struct snd_bebob *bebob, unsigned int rate)
 {
-	int index, pcm_channels, midi_channels, err;
+	int index, pcm_channels, midi_channels, err = 0;
+
+	if (bebob->connected)
+		goto end;
 
 	/* confirm params for both streams */
 	index = get_formation_index(rate);
@@ -328,8 +331,12 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
 		goto end;
 	err = cmp_connection_establish(&bebob->in_conn,
 			amdtp_stream_get_max_payload(&bebob->rx_stream));
-	if (err < 0)
+	if (err < 0) {
 		cmp_connection_break(&bebob->out_conn);
+		goto end;
+	}
+
+	bebob->connected = true;
 end:
 	return err;
 }
@@ -339,6 +346,8 @@ break_both_connections(struct snd_bebob *bebob)
 {
 	cmp_connection_break(&bebob->in_conn);
 	cmp_connection_break(&bebob->out_conn);
+
+	bebob->connected = false;
 }
 
 static void
@@ -401,6 +410,8 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 		destroy_both_connections(bebob);
 		goto end;
 	}
+	/* See comments in next function */
+	bebob->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
 
 	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
 				AMDTP_OUT_STREAM, CIP_BLOCKING);
@@ -439,7 +450,29 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob,
 	/* need to touch slave stream */
 	slave_flag = (request == slave) || amdtp_stream_running(slave);
 
-	/* packet queueing error */
+	/*
+	 * packet queueing error or detecting discontinuity
+	 *
+	 * Normal BeBoB firmware has a quirk at bus reset to transfers packets
+	 * with discontinuous value in dbc field.
+	 *
+	 * When this driver works with XRUN-recoverable applications, this
+	 * situation looks like stream_update_duplex() call following to
+	 * stream_start_duplex() call (because applications will call
+	 * snd_pcm_prepare() immediately).
+	 *
+	 * If breaking/re-establishing connections here, new streams are also
+	 * involved in bus reset and transfers packets with discontinuity.
+	 * Connections should be handled by a way defined in IEC 61883-1.
+	 *
+	 * But if breaking no connections here, AMDTP packets also has
+	 * discontinuity because isochronous context starts during
+	 * transmitting packets. This is a reason to use SKIP_INIT_DBC_CHECK
+	 * flag.
+	 *
+	 * As a result, when encounter bus reset, some received packets are
+	 * lost and some data already in buffer for out-packet is also lost.
+	 */
 	if (amdtp_streaming_error(master)) {
 		amdtp_stream_stop(master);
 		amdtp_stream_stop(slave);
-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
