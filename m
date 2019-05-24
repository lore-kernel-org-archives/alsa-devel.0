From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-lib: fix inverted node IDs
	for amdtp_packet events
Date: Fri, 24 May 2019 18:03:40 +0900
Message-ID: <20190524090342.15619-3-o-takashi@sakamocchi.jp>
References: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E9C9F89630
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 11:03:51 +0200 (CEST)
In-Reply-To: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
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

The amdtp_packet events have inverted node IDs for src/dst. This commit
fixes the bug.

Fixes: 8d3f1fdf5211 ("ALSA: firewire-lib: unify tracing events to 'amdtp_packet' event")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index ab708857979f..5fe0920f04e5 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -35,11 +35,11 @@ TRACE_EVENT(amdtp_packet,
 		__entry->cycle = cycles % CYCLES_PER_SECOND;
 		__entry->channel = s->context->channel;
 		if (s->direction == AMDTP_IN_STREAM) {
-			__entry->src = fw_parent_device(s->unit)->node_id;
-			__entry->dest = fw_parent_device(s->unit)->card->node_id;
-		} else {
 			__entry->src = fw_parent_device(s->unit)->card->node_id;
 			__entry->dest = fw_parent_device(s->unit)->node_id;
+		} else {
+			__entry->src = fw_parent_device(s->unit)->node_id;
+			__entry->dest = fw_parent_device(s->unit)->card->node_id;
 		}
 		if (cip_header) {
 			memcpy(__get_dynamic_array(cip_header), cip_header,
-- 
2.20.1
