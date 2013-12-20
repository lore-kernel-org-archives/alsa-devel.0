From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/38] firewire-lib: Add transfer delay to synchronized duplex
	streams
Date: Fri, 20 Dec 2013 22:14:01 +0900
Message-ID: <1387545269-3875-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, when duplex streams with synchronization mode, this module just pass
'presentation timestamp' from in-packets to out-packets. This is enough to
handle actual device but logically the timestamp should include
'transfer delay' and 'processing time'. This means the timestamp in out-packet
should be at future.

To be simple, this commit add only 'transfer delay'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index b17ec9b..00d4485 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -785,6 +785,15 @@ static void packet_sort(struct sort_table *tbl, unsigned int len)
 	} while (i < len);
 }
 
+static inline void add_transfer_delay(struct amdtp_stream *s, unsigned int *syt)
+{
+	if (*syt != CIP_SYT_NO_INFO) {
+		*syt += (s->transfer_delay / TICKS_PER_CYCLE) << 12;
+		*syt += s->transfer_delay % TICKS_PER_CYCLE;
+		*syt &= CIP_SYT_MASK;
+	}
+}
+
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 				size_t header_length, void *header,
 				void *private_data)
@@ -856,6 +865,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			    (s->flags & CIP_SYNC_TO_DEVICE) &&
 			    s->sync_slave->callbacked) {
 				syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+				add_transfer_delay(s, &syt);
 				handle_out_packet(s->sync_slave, syt);
 			}
 			handle_in_packet(s, tbl[i].payload_size / 4, buffer);
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
