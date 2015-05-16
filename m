From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: firewire-lib: remove restriction for
	non-blocking mode
Date: Sat, 16 May 2015 20:22:45 +0900
Message-ID: <1431775365-25211-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id BB5AC2606E4
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2015 13:22:51 +0200 (CEST)
In-Reply-To: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Former patches allow non-blocking streams to synchronize with timestamp.
This patch removes the restriction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 5892a36..c5bdb62 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -902,7 +902,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 
 	if (s->direction == AMDTP_IN_STREAM)
 		context->callback.sc = in_stream_callback;
-	else if ((s->flags & CIP_BLOCKING) && (s->flags & CIP_SYNC_TO_DEVICE))
+	else if (s->flags & CIP_SYNC_TO_DEVICE)
 		context->callback.sc = slave_stream_callback;
 	else
 		context->callback.sc = out_stream_callback;
-- 
2.1.4
