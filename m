From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] ALSA: firewire-lib: use clear name for
	variable of CIP header
Date: Wed, 22 May 2019 23:17:03 +0900
Message-ID: <20190522141708.29159-2-o-takashi@sakamocchi.jp>
References: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A662F8962C
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:15 +0200 (CEST)
In-Reply-To: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
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

This commit is to distinguish variable of CIP header from variable of
isochronous context header.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f43943fd962d..020edf2b1726 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -286,15 +286,15 @@ EXPORT_SYMBOL(amdtp_stream_set_parameters);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 {
 	unsigned int multiplier = 1;
-	unsigned int header_size = 0;
+	unsigned int cip_header_size = 0;
 
 	if (s->flags & CIP_JUMBO_PAYLOAD)
 		multiplier = 5;
 	if (!(s->flags & CIP_NO_HEADER))
-		header_size = 8;
+		cip_header_size = sizeof(__be32) * 2;
 
-	return header_size +
-		s->syt_interval * s->data_block_quadlets * 4 * multiplier;
+	return cip_header_size +
+		s->syt_interval * s->data_block_quadlets * sizeof(__be32) * multiplier;
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
-- 
2.20.1
