From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: fix isoc cycle count to
	which rx packet is scheduled
Date: Thu, 29 Aug 2019 23:38:08 +0900
Message-ID: <20190829143808.8131-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AD34F802A1
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 16:38:14 +0200 (CEST)
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

When introducing the list of packet descriptor, for rx packet, the
calculation of scheduled isoc cycle is omitted. This commit fixes the
bug.

Fixes: f4f6ae7b7c1f ("ALSA: firewire-lib: use packet descriptor for IT context")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 1a92855c7647..88270257e896 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -732,7 +732,7 @@ static void generate_ideal_pkt_descs(struct amdtp_stream *s,
 		struct pkt_desc *desc = descs + i;
 		unsigned int index = (s->packet_index + i) % QUEUE_LENGTH;
 
-		desc->cycle = compute_cycle_count(*ctx_header);
+		desc->cycle = compute_it_cycle(*ctx_header);
 		desc->syt = calculate_syt(s, desc->cycle);
 		desc->data_blocks = calculate_data_blocks(s, desc->syt);
 
-- 
2.20.1
