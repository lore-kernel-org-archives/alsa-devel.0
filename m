From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] firewire-lib: add callback function for
	payload
Date: Wed, 17 Jul 2013 20:50:46 +0900
Message-ID: <1374061848-5851-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 824E22654A1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 13:51:04 +0200 (CEST)
In-Reply-To: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: robert.chamier@googlemail.com, damien@zamaudio.com, linux1394-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, sakamocchi <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

From: sakamocchi <o-takashi@sakamocchi.jp>

This commit allows each driver to register its callback function to handle
payload. The registered callback is called for each packet so the frequency is
8,000 times per second.

Inner the callback function, each driver can modify information in header,
fill data blocks with PCM samples and MIDI messages.

I note that each driver must return the number of handled PCM frames. Then
snd-firewire-lib process pcm buffer correctly.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amdtp.c |   30 +++++++++++++-----------------
 amdtp.h |   11 ++++++++++-
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/amdtp.c b/amdtp.c
index 19b8a81..e3e055d 100644
--- a/amdtp.c
+++ b/amdtp.c
@@ -110,8 +110,8 @@ EXPORT_SYMBOL(amdtp_out_stream_set_rate);
  * @s: the AMDTP output stream
  *
  * This function must not be called before the stream has been configured
- * with amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_pcm(), and
- * amdtp_out_stream_set_midi().
+ * with amdtp_out_stream_set_hw_params(),
+ * amdtp_out_stream_set_data_block_quadlets().
  */
 unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
 {
@@ -332,7 +332,7 @@ static void amdtp_fill_midi(struct amdtp_out_stream *s,
 static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
-	unsigned int index, data_blocks, syt, ptr;
+	unsigned int index, data_blocks, syt, pcm_frames, ptr;
 	struct snd_pcm_substream *pcm;
 	struct fw_iso_packet packet;
 	int err;
@@ -350,15 +350,9 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 				s->data_block_counter);
 	buffer[1] = cpu_to_be32(CIP_EOH | CIP_FMT_AM | AMDTP_FDF_AM824 |
 				(s->sfc << AMDTP_FDF_SFC_SHIFT) | syt);
-	buffer += 2;
 
 	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm)
-		s->transfer_samples(s, pcm, buffer, data_blocks);
-	else
-		amdtp_fill_pcm_silence(s, buffer, data_blocks);
-	if (s->midi_ports)
-		amdtp_fill_midi(s, buffer, data_blocks);
+	pcm_frames = s->payload_cb(s, pcm, buffer, data_blocks);
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
@@ -382,13 +376,13 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 		index = 0;
 	s->packet_index = index;
 
-	if (pcm) {
-		ptr = s->pcm_buffer_pointer + data_blocks;
+	if (pcm_frames > 0) {
+		ptr = s->pcm_buffer_pointer + pcm_frames;
 		if (ptr >= pcm->runtime->buffer_size)
 			ptr -= pcm->runtime->buffer_size;
 		ACCESS_ONCE(s->pcm_buffer_pointer) = ptr;
 
-		s->pcm_period_pointer += data_blocks;
+		s->pcm_period_pointer += pcm_frames;
 		if (s->pcm_period_pointer >= pcm->runtime->period_size) {
 			s->pcm_period_pointer -= pcm->runtime->period_size;
 			s->pointer_flush = false;
@@ -450,13 +444,14 @@ static int queue_initial_skip_packets(struct amdtp_out_stream *s)
  * @s: the AMDTP output stream to start
  * @channel: the isochronous channel on the bus
  * @speed: firewire speed code
+ * @payload_cb: the function to handle the content of payload
  *
  * The stream cannot be started until it has been configured with
- * amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_pcm(), and
- * amdtp_out_stream_set_midi(); and it must be started before any
- * PCM or MIDI device can be started.
+ * amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_data_block_quadlets()
+ * and it must be started before any PCM or MIDI device can be started.
  */
-int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
+int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed,
+			   amdtp_payload_cb_t payload_cb)
 {
 	static const struct {
 		unsigned int data_block;
@@ -510,6 +505,7 @@ int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
 	if (err < 0)
 		goto err_context;
 
+	s->payload_cb = payload_cb;
 	err = fw_iso_context_start(s->context, -1, 0, 0);
 	if (err < 0)
 		goto err_context;
diff --git a/amdtp.h b/amdtp.h
index 977205b..8172ce9 100644
--- a/amdtp.h
+++ b/amdtp.h
@@ -35,6 +35,12 @@ enum cip_sfc {
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
+struct amdtp_out_stream;
+
+typedef unsigned int (*amdtp_payload_cb_t)(struct amdtp_out_stream *s,
+					   struct snd_pcm_substream *pcm,
+					   __be32 *buffer,
+					   unsigned int data_blocks);
 
 struct amdtp_out_stream {
 	struct fw_unit *unit;
@@ -44,6 +50,8 @@ struct amdtp_out_stream {
 
 	enum cip_sfc sfc;
 	unsigned int data_block_quadlets;
+	amdtp_payload_cb_t payload_cb;
+
 	unsigned int pcm_channels;
 	unsigned int midi_ports;
 	void (*transfer_samples)(struct amdtp_out_stream *s,
@@ -77,7 +85,8 @@ void amdtp_out_stream_destroy(struct amdtp_out_stream *s);
 void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate);
 unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s);
 
-int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed);
+int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed,
+			   amdtp_payload_cb_t payload_cb);
 void amdtp_out_stream_update(struct amdtp_out_stream *s);
 void amdtp_out_stream_stop(struct amdtp_out_stream *s);
 
-- 
1.7.10.4
