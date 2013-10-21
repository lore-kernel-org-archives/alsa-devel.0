From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [05/29] ALSA: dice, firewire-lib: add blocking mode
Date: Mon, 21 Oct 2013 21:23:48 +0200
Message-ID: <52657F44.7070203@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Allow AMDTP output streams to use blocking mode.

Use it for DICE devices, because the old DICE-II chip will in some cases
not be able to lock to non-blocking streams (erratum E7).

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/amdtp.c |   54 ++++++++++++++++++++++++++----------------------
 sound/firewire/amdtp.h |    7 +++++-
 sound/firewire/dice.c  |    2 +-
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index ea995af..efb2e29 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -42,9 +42,6 @@ static void pcm_period_tasklet(unsigned long data);
 int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
 			  enum cip_out_flags flags)
 {
-	if (flags != CIP_NONBLOCKING)
-		return -EINVAL;
-
 	s->unit = fw_unit_get(unit);
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
@@ -96,12 +93,20 @@ void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate)
 		return;

 	for (sfc = 0; sfc < ARRAY_SIZE(rate_info); ++sfc)
-		if (rate_info[sfc].rate == rate) {
-			s->sfc = sfc;
-			s->syt_interval = rate_info[sfc].syt_interval;
-			return;
-		}
+		if (rate_info[sfc].rate == rate)
+			goto sfc_found;
 	WARN_ON(1);
+	return;
+
+sfc_found:
+	s->sfc = sfc;
+	s->syt_interval = rate_info[sfc].syt_interval;
+
+	/* default buffering in the device */
+	s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
+	if (s->flags & CIP_BLOCKING)
+		/* additional buffering needed to adjust for no-data packets */
+		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
 }
 EXPORT_SYMBOL(amdtp_out_stream_set_rate);

@@ -110,25 +115,15 @@ EXPORT_SYMBOL(amdtp_out_stream_set_rate);
  * @s: the AMDTP output stream
  *
  * This function must not be called before the stream has been configured
- * with amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_pcm(), and
+ * with amdtp_out_stream_set_rate(), amdtp_out_stream_set_pcm(), and
  * amdtp_out_stream_set_midi().
  */
 unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
 {
-	static const unsigned int max_data_blocks[] = {
-		[CIP_SFC_32000]  =  4,
-		[CIP_SFC_44100]  =  6,
-		[CIP_SFC_48000]  =  6,
-		[CIP_SFC_88200]  = 12,
-		[CIP_SFC_96000]  = 12,
-		[CIP_SFC_176400] = 23,
-		[CIP_SFC_192000] = 24,
-	};
-
 	s->data_block_quadlets = s->pcm_channels;
 	s->data_block_quadlets += DIV_ROUND_UP(s->midi_ports, 8);

-	return 8 + max_data_blocks[s->sfc] * 4 * s->data_block_quadlets;
+	return 8 + s->syt_interval * s->data_block_quadlets * 4;
 }
 EXPORT_SYMBOL(amdtp_out_stream_get_max_payload);

@@ -248,7 +243,7 @@ static unsigned int calculate_syt(struct amdtp_out_stream *s,
 	s->last_syt_offset = syt_offset;

 	if (syt_offset < TICKS_PER_CYCLE) {
-		syt_offset += TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
+		syt_offset += s->transfer_delay;
 		syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
 		syt += syt_offset % TICKS_PER_CYCLE;

@@ -344,8 +339,17 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 		return;
 	index = s->packet_index;

-	data_blocks = calculate_data_blocks(s);
 	syt = calculate_syt(s, cycle);
+	if (!(s->flags & CIP_BLOCKING)) {
+		data_blocks = calculate_data_blocks(s);
+	} else {
+		if (syt != 0xffff) {
+			data_blocks = s->syt_interval;
+		} else {
+			data_blocks = 0;
+			syt = 0xffffff;
+		}
+	}

 	buffer = s->buffer.packets[index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
@@ -455,9 +459,9 @@ static int queue_initial_skip_packets(struct amdtp_out_stream *s)
  * @speed: firewire speed code
  *
  * The stream cannot be started until it has been configured with
- * amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_pcm(), and
- * amdtp_out_stream_set_midi(); and it must be started before any
- * PCM or MIDI device can be started.
+ * amdtp_out_stream_set_rate(), amdtp_out_stream_set_pcm(),
+ * amdtp_out_stream_set_midi(), and amdtp_out_stream_set_format();
+ * and it must be started before any PCM or MIDI device can be started.
  */
 int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
 {
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index f6103d6..fd4ce30 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -11,9 +11,13 @@
  *	sample_rate/8000 samples, with rounding up or down to adjust
  *	for clock skew and left-over fractional samples.  This should
  *	be used if supported by the device.
+ * @CIP_BLOCKING: In blocking mode, each packet contains either zero or
+ *	SYT_INTERVAL samples, with these two types alternating so that
+ *	the overall sample rate comes out right.
  */
 enum cip_out_flags {
-	CIP_NONBLOCKING = 0,
+	CIP_NONBLOCKING	= 0x00,
+	CIP_BLOCKING	= 0x01,
 };

 /**
@@ -51,6 +55,7 @@ struct amdtp_out_stream {
 				 __be32 *buffer, unsigned int frames);

 	unsigned int syt_interval;
+	unsigned int transfer_delay;
 	unsigned int source_node_id_field;
 	struct iso_packets_buffer buffer;

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 02c7b5a..63446f8 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -942,7 +942,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 		goto err_notification_handler;
 	dice->resources.channels_mask = 0x00000000ffffffffuLL;

-	err = amdtp_out_stream_init(&dice->stream, unit, CIP_NONBLOCKING);
+	err = amdtp_out_stream_init(&dice->stream, unit, CIP_BLOCKING);
 	if (err < 0)
 		goto err_resources;


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
