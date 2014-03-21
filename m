From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/44] firewire-lib: Restrict calling
	flush_context_completion() when context exists
Date: Fri, 21 Mar 2014 20:09:54 +0900
Message-ID: <1395400229-22957-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently, drivers can bring XRUN state for PCM substreams when error to
queue packets or detecting discontinuity of packet. The application may try to
recover this state by calling snd_pcm_prepare().

Depending on each driver, .prepare() includes restart streaming. Then there
is a state that PCM substreams are running but isochronous contexts are
stopped. In this case, when .pointer() is called, it refers to error pointer.

This commit is for a prevention of this bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index d2042d9..a216729 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -973,7 +973,7 @@ EXPORT_SYMBOL(amdtp_stream_start);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
 {
 	/* this optimization is allowed to be racy */
-	if (s->pointer_flush)
+	if (s->pointer_flush && amdtp_stream_running(s))
 		fw_iso_context_flush_completions(s->context);
 	else
 		s->pointer_flush = true;
-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
