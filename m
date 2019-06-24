From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] Revert "ALSA: firewire-lib: fix inverted
	node IDs for amdtp_packet events"
Date: Mon, 24 Jun 2019 18:20:15 +0900
Message-ID: <20190624092015.8290-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7BC9F8071F
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 11:20:22 +0200 (CEST)
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

This reverts commit e703965a129cdd72ff74e248f8fbf0d617844527.

When creating this patch, I compared the value of src field to the
value of first byte of cip_header field (SID) in tracing event.
But in this test I used a device which has a quirk to transfer
isochronous packet with invalid SID. The original change is valid.

Fixes: e703965a129c ("ALSA: firewire-lib: fix inverted node IDs for amdtp_packet events")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 5fe0920f04e5..ab708857979f 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -35,11 +35,11 @@ TRACE_EVENT(amdtp_packet,
 		__entry->cycle = cycles % CYCLES_PER_SECOND;
 		__entry->channel = s->context->channel;
 		if (s->direction == AMDTP_IN_STREAM) {
-			__entry->src = fw_parent_device(s->unit)->card->node_id;
-			__entry->dest = fw_parent_device(s->unit)->node_id;
-		} else {
 			__entry->src = fw_parent_device(s->unit)->node_id;
 			__entry->dest = fw_parent_device(s->unit)->card->node_id;
+		} else {
+			__entry->src = fw_parent_device(s->unit)->card->node_id;
+			__entry->dest = fw_parent_device(s->unit)->node_id;
 		}
 		if (cip_header) {
 			memcpy(__get_dynamic_array(cip_header), cip_header,
-- 
2.20.1
