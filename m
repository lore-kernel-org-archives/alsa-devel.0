From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: firewire-lib: remove restriction for non-blocking
	mode
Date: Fri, 22 May 2015 23:00:54 +0900
Message-ID: <1432303254-4192-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
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
index 5c0e3ce..bed8e10 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -913,7 +913,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 
 	if (s->direction == AMDTP_IN_STREAM)
 		context->callback.sc = in_stream_callback;
-	else if ((s->flags & CIP_BLOCKING) && (s->flags & CIP_SYNC_TO_DEVICE))
+	else if (s->flags & CIP_SYNC_TO_DEVICE)
 		context->callback.sc = slave_stream_callback;
 	else
 		context->callback.sc = out_stream_callback;
-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
