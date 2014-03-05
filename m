From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/39] firewire-lib: Add transfer delay to
	synchronized duplex streams
Date: Wed,  5 Mar 2014 19:47:58 +0900
Message-ID: <1394016507-15761-11-git-send-email-o-takashi@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 85D762650FF
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 11:48:57 +0100 (CET)
In-Reply-To: <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Currently, in duplex streams with synchronization mode, this module just pass
'presentation timestamp' from in-packets to out-packets. This is enough to
handle actual device but logically the timestamp should include
'transfer delay' and 'processing time'. This means the timestamp in out-packet
should be at future.

To be simple, this commit add only 'transfer delay'.
---
 sound/firewire/amdtp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index d3cf7bf..9383392 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -774,6 +774,15 @@ static void packet_sort(struct sort_table *tbl, unsigned int len)
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
@@ -846,6 +855,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			    (s->flags & CIP_SYNC_TO_DEVICE) &&
 			    s->sync_slave->callbacked) {
 				syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+				add_transfer_delay(s, &syt);
 				handle_out_packet(s->sync_slave, syt);
 			}
 			handle_in_packet(s, tbl[i].payload_size / 4, buffer);
-- 
1.8.3.2
