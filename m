From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/7] ALSA: firewire-lib: fix different data
	block counter between probed event and transferred
	isochronous packet
Date: Sun,  7 Jul 2019 21:07:56 +0900
Message-ID: <20190707120759.16371-5-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABEFDF800E6
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:12 +0200 (CEST)
In-Reply-To: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
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

For IT context, tracepoints event is probed after calculating next data
block counter. This brings difference of data block counter between
the probed event and actual isochronous packet.

This commit fixes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c5daef7872a5..24cc8ce51e01 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -510,13 +510,13 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 		cip_header = NULL;
 	}
 
+	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
+			   index);
+
 	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
 	}
-
-	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
-			   index);
 }
 
 static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
-- 
2.20.1
