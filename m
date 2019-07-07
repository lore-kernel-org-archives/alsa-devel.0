From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/7] ALSA: firewire-lib: fix initial value of
	data block count for IR context without CIP_DBC_IS_END_EVENT
Date: Sun,  7 Jul 2019 21:07:55 +0900
Message-ID: <20190707120759.16371-4-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D476F801A4
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:11 +0200 (CEST)
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

At present, when CIP_DBC_IS_END_EVENT is not used (i.e. for drivers except
for ALSA fireworks driver), the initial value is used as is for
tracepoints event. However, the engine can detect the value of dbc field
in the payload of first isochronous packet and the value should be assigned
to the event.

This commit fixes the bug.

Fixes: 76864868dbab ("ALSA: firewire-lib: cache next data_block_counter after probing tracepoints event for IR context")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c8d77bb05798..c5daef7872a5 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -654,8 +654,10 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			*dbc = 0;
 	}
 
-	if (err >= 0 && s->flags & CIP_DBC_IS_END_EVENT)
-		s->data_block_counter = *dbc;
+	if (err < 0)
+		return err;
+
+	s->data_block_counter = *dbc;
 
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
 			   index);
-- 
2.20.1
