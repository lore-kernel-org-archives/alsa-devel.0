From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/15] ALSA: firewire-lib: add support
	arbitrary value for fmt/fdf fields in CIP header
Date: Sat, 19 Sep 2015 11:21:53 +0900
Message-ID: <1442629322-15457-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5A02604D6
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:14 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some vendor specific protocol uses its own value for fmt/fdf fields in
CIP header.

This commit support to set arbitrary values for the fields.

In IEC 61883-6, NO-DATA code is defined for FDF field. A packet with this
code includes no data even if it includes some data blocks. This commit
still leaves a condition to handle this special packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 31 +++++++++++++++++++++++--------
 sound/firewire/amdtp.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 5a3a452..b251f4b 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -59,8 +59,8 @@
  * Audio and Music transfer protocol specific parameters
  * only "Clock-based rate control mode" is supported
  */
-#define CIP_FMT_AM		(0x10 << CIP_FMT_SHIFT)
-#define AMDTP_FDF_AM824		(0 << (CIP_FDF_SHIFT + 3))
+#define CIP_FMT_AM		0x10
+#define AMDTP_FDF_AM824		0x00
 #define AMDTP_FDF_NO_DATA	0xff
 
 /* TODO: make these configurable */
@@ -94,6 +94,8 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->callbacked = false;
 	s->sync_slave = NULL;
 
+	s->fmt = CIP_FMT_AM;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -225,6 +227,8 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s,
 	s->data_block_quadlets = s->pcm_channels + midi_channels;
 	s->midi_ports = midi_ports;
 
+	s->fdf = AMDTP_FDF_AM824 | s->sfc;
+
 	/*
 	 * In IEC 61883-6, one data block represents one event. In ALSA, one
 	 * event equals to one PCM frame. But Dice has a quirk at higher
@@ -691,8 +695,10 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				s->data_block_counter);
-	buffer[1] = cpu_to_be32(CIP_EOH | CIP_FMT_AM | AMDTP_FDF_AM824 |
-				(s->sfc << CIP_FDF_SHIFT) | syt);
+	buffer[1] = cpu_to_be32(CIP_EOH |
+				((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
+				((s->fdf << CIP_FDF_SHIFT) & CIP_FDF_MASK) |
+				(syt & CIP_SYT_MASK));
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
@@ -732,6 +738,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int *data_blocks, unsigned int syt)
 {
 	u32 cip_header[2];
+	unsigned int fmt, fdf;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
@@ -745,8 +752,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	 * For convenience, also check FMT field is AM824 or not.
 	 */
 	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
-	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH) ||
-	    ((cip_header[1] & CIP_FMT_MASK) != CIP_FMT_AM)) {
+	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH)) {
 		dev_info_ratelimited(&s->unit->device,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
@@ -755,10 +761,19 @@ static int handle_in_packet(struct amdtp_stream *s,
 		goto end;
 	}
 
+	/* Check valid protocol or not. */
+	fmt = (cip_header[1] & CIP_FMT_MASK) >> CIP_FMT_SHIFT;
+	if (fmt != s->fmt) {
+		dev_err(&s->unit->device,
+			"Detect unexpected protocol: %08x %08x\n",
+			cip_header[0], cip_header[1]);
+		return -EIO;
+	}
+
 	/* Calculate data blocks */
+	fdf = (cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SHIFT;
 	if (payload_quadlets < 3 ||
-	    ((cip_header[1] & CIP_FDF_MASK) ==
-				(AMDTP_FDF_NO_DATA << CIP_FDF_SHIFT))) {
+	    (fmt == CIP_FMT_AM && fdf == AMDTP_FDF_NO_DATA)) {
 		*data_blocks = 0;
 	} else {
 		data_block_quadlets =
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 6522925..883bb1a 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -128,6 +128,8 @@ struct amdtp_stream {
 	unsigned int source_node_id_field;
 	unsigned int data_block_quadlets;
 	unsigned int data_block_counter;
+	unsigned int fmt;
+	unsigned int fdf;
 	/* quirk: fixed interval of dbc between previos/current packets. */
 	unsigned int tx_dbc_interval;
 	/* quirk: indicate the value of dbc field in a first packet. */
-- 
2.1.4
