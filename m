From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/17] firewire-lib: Add transfer delay to
	synchronized duplex streams
Date: Sat, 23 Nov 2013 15:07:57 +0900
Message-ID: <1385186884-8259-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id F28742651A0
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:12 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Currently, when duplex streams with synchronization mode, this module just pass
'presentation timestamp' from transmitted packets to out packets. This is
enough to handle actual device but logically it should include 'transfer delay'
and 'processing time'. This means the timestamp in out packet should be at
future.

To be simple, this commit add only 'transfer delay'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index d02ccac..bc21276 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -856,6 +856,15 @@ static void packet_sort(struct sort_table *tbl, unsigned int len)
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
@@ -927,6 +936,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			    (s->flags & CIP_SYNC_TO_DEVICE) &&
 			    s->sync_slave->callbacked) {
 				syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+				add_transfer_delay(s, &syt);
 				handle_out_packet(s->sync_slave, syt);
 			}
 			handle_in_packet(s, tbl[i].payload_size / 4, buffer);
-- 
1.8.3.2
