From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 27/37] ALSA: firewire-lib: add support for
	source packet header field in CIP header
Date: Sat, 11 Jul 2015 23:12:38 +0900
Message-ID: <1436623968-10780-28-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 798262605B1
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:06 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In IEC 61883-1, CIP headers have a SPH field. When a packet has 1 in the
SPH field, the packet has a source packet headers. A source packet header
consists of 32 bit field (= 1 quadlet) and it transfers timestamp, which
is the same value as the lower 25 bits of the IEEE 1394 CYCLE_TIMER
register and the rest is zero.

This commit just supports source packet header field because IEC 61883-1
includes ambiguity the position of this header and the number. Each
protocol layer can have actual implementation according its requirements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 8 ++++++--
 sound/firewire/amdtp-stream.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c7fbdd3..58f6ae0 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -34,6 +34,8 @@
 #define CIP_SID_MASK		0x3f000000
 #define CIP_DBS_MASK		0x00ff0000
 #define CIP_DBS_SHIFT		16
+#define CIP_SPH_MASK		0x00000400
+#define CIP_SPH_SHIFT		10
 #define CIP_DBC_MASK		0x000000ff
 #define CIP_FMT_SHIFT		24
 #define CIP_FMT_MASK		0x3f000000
@@ -414,6 +416,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
+				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
 				s->data_block_counter);
 	buffer[1] = cpu_to_be32(CIP_EOH |
 				((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
@@ -440,7 +443,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int *data_blocks)
 {
 	u32 cip_header[2];
-	unsigned int fmt, fdf, syt;
+	unsigned int sph, fmt, fdf, syt;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
@@ -461,8 +464,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	}
 
 	/* Check valid protocol or not. */
+	sph = (cip_header[0] & CIP_SPH_MASK) >> CIP_SPH_SHIFT;
 	fmt = (cip_header[1] & CIP_FMT_MASK) >> CIP_FMT_SHIFT;
-	if (fmt != s->fmt) {
+	if (sph != s->sph || fmt != s->fmt) {
 		dev_err(&s->unit->device,
 			"Detect unexpected protocol: %08x %08x\n",
 			cip_header[0], cip_header[1]);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index d2354f0..aa5d04d 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -107,6 +107,7 @@ struct amdtp_stream {
 	unsigned int source_node_id_field;
 	unsigned int data_block_quadlets;
 	unsigned int data_block_counter;
+	unsigned int sph;
 	unsigned int fmt;
 	unsigned int fdf;
 	/* quirk: fixed interval of dbc between previos/current packets. */
-- 
2.1.4
