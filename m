From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire-lib: split helper function
	to generate CIP header
Date: Fri, 24 May 2019 00:14:37 +0900
Message-ID: <20190523151440.5127-2-o-takashi@sakamocchi.jp>
References: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABC0FF80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 17:14:47 +0200 (CEST)
In-Reply-To: <20190523151440.5127-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is minor code refactoring to split a function to generate CIP
header.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 2d9c764061d1..25985663bb2b 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -477,6 +477,19 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 	return queue_packet(s, s->ctx_data.tx.max_ctx_payload_length);
 }
 
+static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
+				unsigned int syt)
+{
+	cip_header[0] = cpu_to_be32(READ_ONCE(s->source_node_id_field) |
+				(s->data_block_quadlets << CIP_DBS_SHIFT) |
+				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
+				s->data_block_counter);
+	cip_header[1] = cpu_to_be32(CIP_EOH |
+			((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
+			((s->ctx_data.rx.fdf << CIP_FDF_SHIFT) & CIP_FDF_MASK) |
+			(syt & CIP_SYT_MASK));
+}
+
 static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 			     const __be32 *ctx_header, __be32 *buffer,
 			     unsigned int index)
@@ -495,14 +508,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
 
-	buffer[0] = cpu_to_be32(READ_ONCE(s->source_node_id_field) |
-				(s->data_block_quadlets << CIP_DBS_SHIFT) |
-				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
-				s->data_block_counter);
-	buffer[1] = cpu_to_be32(CIP_EOH |
-			((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
-			((s->ctx_data.rx.fdf << CIP_FDF_SHIFT) & CIP_FDF_MASK) |
-			(syt & CIP_SYT_MASK));
+	generate_cip_header(s, buffer, syt);
 
 	if (!(s->flags & CIP_DBC_IS_END_EVENT))
 		s->data_block_counter =
-- 
2.20.1
