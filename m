From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire-lib: fix data block counter
	for incoming packet without CIP header
Date: Fri, 24 May 2019 18:03:39 +0900
Message-ID: <20190524090342.15619-2-o-takashi@sakamocchi.jp>
References: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C54B5F8962F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 11:03:50 +0200 (CEST)
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

The value of data block counter is not calculated for incoming packet
without CIP header. This commit fixes the bug.

Fixes: 947b437e1263 ("ALSA: firewire-lib: unify packet handler for IR context")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 791efa5585c2..8a7da86650ea 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -674,6 +674,8 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		cip_header = NULL;
 		data_blocks = payload_length / 4 / s->data_block_quadlets;
 		syt = 0;
+		s->data_block_counter =
+				(s->data_block_counter + data_blocks) & 0xff;
 	}
 
 	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
-- 
2.20.1
