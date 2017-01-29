From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/19] firewire-lib: enable
	CIP_DBC_IS_END_EVENT for both directions of stream
Date: Sun, 29 Jan 2017 12:54:05 +0900
Message-ID: <20170129035417.2095-8-o-takashi@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 621DD266A56
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 04:54:26 +0100 (CET)
In-Reply-To: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
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

Commit c8bdf49b9935("ALSA: fireworks/firewire-lib: Add a quirk for the
meaning of dbc") adds CIP_DBC_IS_END_EVENT flag just for tx packets.
However, MOTU FireWire series has this quirk for rx packets.

This commit allows both directions with the flag.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 8 +++++++-
 sound/firewire/amdtp-stream.h | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 65c5ed7..f9d12f4 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -426,6 +426,10 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 	data_blocks = calculate_data_blocks(s, syt);
 	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
 
+	if (s->flags & CIP_DBC_IS_END_EVENT)
+		s->data_block_counter =
+				(s->data_block_counter + data_blocks) & 0xff;
+
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
@@ -435,7 +439,9 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 				((s->fdf << CIP_FDF_SHIFT) & CIP_FDF_MASK) |
 				(syt & CIP_SYT_MASK));
 
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+	if (!(s->flags & CIP_DBC_IS_END_EVENT))
+		s->data_block_counter =
+				(s->data_block_counter + data_blocks) & 0xff;
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 
 	trace_out_packet(s, cycle, buffer, payload_length, index);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 679053d..d2a3163 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -18,8 +18,8 @@
  *	SYT_INTERVAL samples, with these two types alternating so that
  *	the overall sample rate comes out right.
  * @CIP_EMPTY_WITH_TAG0: Only for in-stream. Empty in-packets have TAG0.
- * @CIP_DBC_IS_END_EVENT: Only for in-stream. The value of dbc in an in-packet
- *	corresponds to the end of event in the packet. Out of IEC 61883.
+ * @CIP_DBC_IS_END_EVENT: The value of dbc in an packet corresponds to the end
+ * of event in the packet. Out of IEC 61883.
  * @CIP_WRONG_DBS: Only for in-stream. The value of dbs is wrong in in-packets.
  *	The value of data_block_quadlets is used instead of reported value.
  * @CIP_SKIP_DBC_ZERO_CHECK: Only for in-stream.  Packets with zero in dbc is
-- 
2.9.3
