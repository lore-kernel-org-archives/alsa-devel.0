From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 35/49] bebob/firewire-lib: Add a quirk for discontinuity at
	bus reset
Date: Fri, 25 Apr 2014 22:45:16 +0900
Message-ID: <1398433530-13136-36-git-send-email-o-takashi@sakamocchi.jp>
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

Normal BeBoB firmware has a quirk. When receiving bus reset, it transmits
packets with discontinuous value in dbc field.

This causes two situation, one is to abort streaming by firewire-lib as a
result of detecting the discontinuity. Another is to call driver's .update()
because of bus reset. These two is generated independently. (The former
depends on isochronous stream and the latter depends on IEEE1394 bus driver.)

When BeBoB driver works with XRUN-recoverable applications, this situation
looks like stream_start_duplex() call followed by stream_update_duplex() call
because applications will call snd_pcm_prepare() immediately at XRUN.

To update connections and streams at first, this commit use completion. When
queueing error occurs, stream_start_duplex() is forced to wait maximum
1000msec. During this, when .update() is called, the completion is waken and
stream_start_duplex() is processed without breaking connections.

At bus reset, stream_start_duplex() shouldn't break/establish connections and
stream_update_duplex() should update connections because a caller of
fw_iso_resources_allocate() is responsible for calling
fw_iso_resources_update() on bus reset.

This commit also adds a flag, which has an effect to skip checking continuity
for first packet. This flag is useful for BeBoB quirk to start handling packets
during streaming.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c              |  9 +++++--
 sound/firewire/amdtp.h              |  3 +++
 sound/firewire/bebob/bebob.h        |  4 +++
 sound/firewire/bebob/bebob_stream.c | 52 ++++++++++++++++++++++++++++++++-----
 4 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 28ee3d8..690c608 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -665,7 +665,8 @@ static void handle_in_packet(struct amdtp_stream *s,
 
 	/* Check data block counter continuity */
 	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
-	if ((s->flags & CIP_SKIP_DBC_ZERO_CHECK) && data_block_counter == 0) {
+	if (((s->flags & CIP_SKIP_DBC_ZERO_CHECK) && data_block_counter == 0) ||
+	    (s->data_block_counter == UINT_MAX)) {
 		lost = false;
 	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
@@ -850,7 +851,11 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
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
index fb5934c..c79f058 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -25,6 +25,8 @@
  *	The value of data_block_quadlets is used instead of reported value.
  * @SKIP_DBC_ZERO_CHECK: Only for in-stream.  Packets with zero in dbc is
  *	skipped for detecting discontinuity.
+ * @CIP_SKIP_INIT_DBC_CHECK: Only for in-stream. The value of dbc in first
+ *	packet is not continuous from an initial value.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -34,6 +36,7 @@ enum cip_flags {
 	CIP_DBC_IS_END_EVENT	= 0x08,
 	CIP_WRONG_DBS		= 0x10,
 	CIP_SKIP_DBC_ZERO_CHECK	= 0x20,
+	CIP_SKIP_INIT_DBC_CHECK	= 0x40,
 };
 
 /**
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index a195c16..031ca78 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -53,6 +53,10 @@ struct snd_bebob {
 	unsigned int midi_input_ports;
 	unsigned int midi_output_ports;
 
+	/* for bus reset quirk */
+	struct completion bus_reset;
+	bool connected;
+
 	struct amdtp_stream *master;
 	struct amdtp_stream tx_stream;
 	struct amdtp_stream rx_stream;
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index c868c17..46b056c 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -9,6 +9,7 @@
 #include "./bebob.h"
 
 #define CALLBACK_TIMEOUT	1000
+#define FW_ISO_RESOURCE_DELAY	1000
 
 /*
  * NOTE;
@@ -325,7 +326,10 @@ check_connection_used_by_others(struct snd_bebob *bebob, struct amdtp_stream *s)
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
@@ -345,8 +349,12 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
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
@@ -356,6 +364,8 @@ break_both_connections(struct snd_bebob *bebob)
 {
 	cmp_connection_break(&bebob->in_conn);
 	cmp_connection_break(&bebob->out_conn);
+
+	bebob->connected = false;
 }
 
 static void
@@ -415,6 +425,9 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 		destroy_both_connections(bebob);
 		goto end;
 	}
+	/* See comments in next function */
+	init_completion(&bebob->bus_reset);
+	bebob->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
 
 	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
 				AMDTP_OUT_STREAM, CIP_BLOCKING);
@@ -433,8 +446,25 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, int rate)
 	atomic_t *slave_substreams;
 	enum cip_flags sync_mode;
 	unsigned int curr_rate;
+	bool updated = false;
 	int err = 0;
 
+	/*
+	 * Normal BeBoB firmware has a quirk at bus reset to transmits packets
+	 * with discontinuous value in dbc field.
+	 *
+	 * This 'struct completion' is used to call .update() at first to update
+	 * connections/streams. Next following codes handle streaming error.
+	 */
+	if (amdtp_streaming_error(&bebob->tx_stream)) {
+		if (completion_done(&bebob->bus_reset))
+			reinit_completion(&bebob->bus_reset);
+
+		updated = (wait_for_completion_interruptible_timeout(
+				&bebob->bus_reset,
+				msecs_to_jiffies(FW_ISO_RESOURCE_DELAY)) > 0);
+	}
+
 	mutex_lock(&bebob->mutex);
 
 	/* Need no substreams */
@@ -463,13 +493,19 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, int rate)
 	if (err < 0)
 		goto end;
 
-	/* packet queueing error */
-	if (amdtp_streaming_error(master)) {
+	/*
+	 * packet queueing error or detecting discontinuity
+	 *
+	 * At bus reset, connections should not be broken here. So streams need
+	 * to be re-started. This is a reason to use SKIP_INIT_DBC_CHECK flag.
+	 */
+	if (amdtp_streaming_error(master))
 		amdtp_stream_stop(master);
-		amdtp_stream_stop(slave);
-	}
 	if (amdtp_streaming_error(slave))
 		amdtp_stream_stop(slave);
+	if (!updated &&
+	    !amdtp_stream_running(master) && !amdtp_stream_running(slave))
+		break_both_connections(bebob);
 
 	/* stop streams if rate is different */
 	err = snd_bebob_stream_get_rate(bebob, &curr_rate);
@@ -599,6 +635,10 @@ void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
 		amdtp_stream_update(&bebob->tx_stream);
 	}
 
+	/* wake up stream_start_duplex() */
+	if (!completion_done(&bebob->bus_reset))
+		complete_all(&bebob->bus_reset);
+
 	mutex_unlock(&bebob->mutex);
 }
 
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
