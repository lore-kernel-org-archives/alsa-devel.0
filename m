From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/7] ALSA: firewire-lib: code refactoring for
	error path of parser for CIP header
Date: Sun,  7 Jul 2019 21:07:57 +0900
Message-ID: <20190707120759.16371-6-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F7B3F80228
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:14 +0200 (CEST)
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

When a parser for CIP header returns -EAGAIN, no extra care is needed
to probe tracepoints event.

This commit adds code refactoring for the error path.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 24cc8ce51e01..8c4564a560f6 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -635,12 +635,8 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 		cip_header = ctx_header + 2;
 		err = check_cip_header(s, cip_header, *payload_length,
 				       data_blocks, dbc, syt);
-		if (err < 0) {
-			if (err != -EAGAIN)
-				return err;
-
-			*data_blocks = 0;
-		}
+		if (err < 0)
+			return err;
 	} else {
 		cip_header = NULL;
 		err = 0;
@@ -654,9 +650,6 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			*dbc = 0;
 	}
 
-	if (err < 0)
-		return err;
-
 	s->data_block_counter = *dbc;
 
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
-- 
2.20.1
