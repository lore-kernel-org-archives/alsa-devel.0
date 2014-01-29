From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/52] firewire-lib: Add transfer delay to synchronized duplex
	streams
Date: Wed, 29 Jan 2014 22:44:17 +0900
Message-ID: <1391003099-7109-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, in duplex streams with synchronization mode, this module just pass
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
index 9d1c47f..881d610 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -784,6 +784,15 @@ static void packet_sort(struct sort_table *tbl, unsigned int len)
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
@@ -855,6 +864,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
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
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
