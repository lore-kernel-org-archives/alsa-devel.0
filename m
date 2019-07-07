From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/7] ALSA: firewire-lib/fireface: fix initial
	value of data block counter for IR context with CIP_NO_HEADER
Date: Sun,  7 Jul 2019 21:07:54 +0900
Message-ID: <20190707120759.16371-3-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB4C2F80212
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:09 +0200 (CEST)
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

For IR context, ALSA IEC 61883-1/6 engine uses initial value of data
block counter as UINT_MAX, to detect first isochronous packet in the
middle of packet streaming.

At present, when CIP_NO_HEADER is used (i.e. for ALSA fireface driver),
the initial value is used for tracepoints event. 0x00 should be
for the event when the initial value is UINT_MAX because isochronous
packets with CIP_NO_HEADER option has no field for data block count.

This commit fixes the bug.

Fixes: 76864868dbab ("ALSA: firewire-lib: cache next data_block_counter after probing tracepoints event for IR context")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 6c9f4d026505..c8d77bb05798 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -646,8 +646,12 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 		err = 0;
 		*data_blocks = *payload_length / sizeof(__be32) /
 			       s->data_block_quadlets;
-		*dbc = s->data_block_counter;
 		*syt = 0;
+
+		if (s->data_block_counter != UINT_MAX)
+			*dbc = s->data_block_counter;
+		else
+			*dbc = 0;
 	}
 
 	if (err >= 0 && s->flags & CIP_DBC_IS_END_EVENT)
-- 
2.20.1
