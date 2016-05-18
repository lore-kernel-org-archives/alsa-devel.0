From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: change a member of event
	structure to suppress sparse wanings to bool type
Date: Wed, 18 May 2016 22:27:43 +0900
Message-ID: <1463578063-16685-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8F52604BE
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 15:27:49 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Commit a9c4284bf5a9 ("ALSA: firewire-lib: add context information to
tracepoints") adds new members to tracepoint events of this module, to
represent context information. One of the members is bool type and
this causes sparse warnings.

16:1: warning: expression using sizeof bool
60:1: warning: expression using sizeof bool
16:1: warning: odd constant _Bool cast (ffffffffffffffff becomes 1)
60:1: warning: odd constant _Bool cast (ffffffffffffffff becomes 1)

This commit suppresses the warnings, by changing type of the member
to 'unsigned int'. Additionally, this commit applies '!!' idiom to
get 0/1 from 'in_interrupt()'.

Fixes: a9c4284bf5a9 ("ALSA: firewire-lib: add context information to tracepoints")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 1622579..9c04faf 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -26,7 +26,7 @@ TRACE_EVENT(in_packet,
 		__field(u32, cip_header1)
 		__field(unsigned int, payload_quadlets)
 		__field(unsigned int, packet_index)
-		__field(bool, irq)
+		__field(unsigned int, irq)
 		__field(unsigned int, index)
 	),
 	TP_fast_assign(
@@ -39,7 +39,7 @@ TRACE_EVENT(in_packet,
 		__entry->cip_header1 = cip_header[1];
 		__entry->payload_quadlets = payload_quadlets;
 		__entry->packet_index = s->packet_index;
-		__entry->irq = in_interrupt();
+		__entry->irq = !!in_interrupt();
 		__entry->index = index;
 	),
 	TP_printk(
@@ -70,7 +70,7 @@ TRACE_EVENT(out_packet,
 		__field(u32, cip_header1)
 		__field(unsigned int, payload_quadlets)
 		__field(unsigned int, packet_index)
-		__field(bool, irq)
+		__field(unsigned int, irq)
 		__field(unsigned int, index)
 	),
 	TP_fast_assign(
@@ -83,7 +83,7 @@ TRACE_EVENT(out_packet,
 		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
 		__entry->payload_quadlets = payload_length / 4;
 		__entry->packet_index = s->packet_index;
-		__entry->irq = in_interrupt();
+		__entry->irq = !!in_interrupt();
 		__entry->index = index;
 	),
 	TP_printk(
-- 
2.7.4
