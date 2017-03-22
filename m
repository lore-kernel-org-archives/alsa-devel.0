From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/18] ALSA: firewire-lib: add support for
	source packet header field in CIP header
Date: Wed, 22 Mar 2017 21:30:16 +0900
Message-ID: <20170322123028.24148-7-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C2E652673BF
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:42 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

In IEC 61883-1, CIP headers can have a SPH field. When a packet has 1 in
SPH field of its CIP header, the packet has a source packet headers. A
source packet header consists of 32 bit field (= 1 quadlet) and it
transfers time stamp, which is the same value as the lower 25 bits of the
IEEE 1394 CYCLE_TIMER register and the rest is zero.

This commit just supports source packet header field because IEC 61883-1
includes ambiguity the position of this header and its count. Each
protocol layer is allowed to have actual implementation according its
requirements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 8 ++++++--
 sound/firewire/amdtp-stream.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 371cf97..65c5ed7 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -37,6 +37,8 @@
 #define CIP_SID_MASK		0x3f000000
 #define CIP_DBS_MASK		0x00ff0000
 #define CIP_DBS_SHIFT		16
+#define CIP_SPH_MASK		0x00000400
+#define CIP_SPH_SHIFT		10
 #define CIP_DBC_MASK		0x000000ff
 #define CIP_FMT_SHIFT		24
 #define CIP_FMT_MASK		0x3f000000
@@ -426,6 +428,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
+				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
 				s->data_block_counter);
 	buffer[1] = cpu_to_be32(CIP_EOH |
 				((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
@@ -454,7 +457,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 {
 	__be32 *buffer;
 	u32 cip_header[2];
-	unsigned int fmt, fdf, syt;
+	unsigned int sph, fmt, fdf, syt;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
@@ -482,8 +485,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	}
 
 	/* Check valid protocol or not. */
+	sph = (cip_header[0] & CIP_SPH_MASK) >> CIP_SPH_SHIFT;
 	fmt = (cip_header[1] & CIP_FMT_MASK) >> CIP_FMT_SHIFT;
-	if (fmt != s->fmt) {
+	if (sph != s->sph || fmt != s->fmt) {
 		dev_info_ratelimited(&s->unit->device,
 				     "Detect unexpected protocol: %08x %08x\n",
 				     cip_header[0], cip_header[1]);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index edf5646..679053d 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -106,6 +106,7 @@ struct amdtp_stream {
 	unsigned int source_node_id_field;
 	unsigned int data_block_quadlets;
 	unsigned int data_block_counter;
+	unsigned int sph;
 	unsigned int fmt;
 	unsigned int fdf;
 	/* quirk: fixed interval of dbc between previos/current packets. */
-- 
2.9.3
