From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/20] ALSA: firewire-lib: add list of packet
	descriptor
Date: Mon, 22 Jul 2019 12:36:58 +0900
Message-ID: <20190722033710.28107-9-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D08CF803F4
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:29 +0200 (CEST)
In-Reply-To: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
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

In current implementation of ALSA IEC 61883-1/6 packet streaming engine,
16 packets are handled in one interrupt of isochronous context of OHCI
1394.

Overall packet processing runs for each. However, this is not better in
a point to split the processing into several parts.

This commit is an attempt to add intermediate representation for
parameters required for the parts.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 15 ++++++++++++---
 sound/firewire/amdtp-stream.h |  9 +++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index c8543cdb3c8c..2bea15151d4a 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -936,6 +936,13 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	else
 		s->tag = TAG_CIP;
 
+	s->pkt_descs = kcalloc(INTERRUPT_INTERVAL, sizeof(*s->pkt_descs),
+			       GFP_KERNEL);
+	if (!s->pkt_descs) {
+		err = -ENOMEM;
+		goto err_context;
+	}
+
 	s->packet_index = 0;
 	do {
 		struct fw_iso_packet params;
@@ -947,7 +954,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 			err = queue_out_packet(s, &params);
 		}
 		if (err < 0)
-			goto err_context;
+			goto err_pkt_descs;
 	} while (s->packet_index > 0);
 
 	/* NOTE: TAG1 matches CIP. This just affects in stream. */
@@ -958,12 +965,13 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->callbacked = false;
 	err = fw_iso_context_start(s->context, -1, 0, tag);
 	if (err < 0)
-		goto err_context;
+		goto err_pkt_descs;
 
 	mutex_unlock(&s->mutex);
 
 	return 0;
-
+err_pkt_descs:
+	kfree(s->pkt_descs);
 err_context:
 	fw_iso_context_destroy(s->context);
 	s->context = ERR_PTR(-1);
@@ -1059,6 +1067,7 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 	fw_iso_context_destroy(s->context);
 	s->context = ERR_PTR(-1);
 	iso_packets_buffer_destroy(&s->buffer, s->unit);
+	kfree(s->pkt_descs);
 
 	s->callbacked = false;
 
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 5996cc60f166..73c492c9a5d5 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -94,6 +94,14 @@ enum amdtp_stream_direction {
 	AMDTP_IN_STREAM
 };
 
+struct pkt_desc {
+	u32 cycle;
+	u32 syt;
+	unsigned int data_blocks;
+	unsigned int data_block_counter;
+	__be32 *ctx_payload;
+};
+
 struct amdtp_stream;
 typedef unsigned int (*amdtp_stream_process_data_blocks_t)(
 						struct amdtp_stream *s,
@@ -110,6 +118,7 @@ struct amdtp_stream {
 	struct fw_iso_context *context;
 	struct iso_packets_buffer buffer;
 	int packet_index;
+	struct pkt_desc *pkt_descs;
 	int tag;
 	union {
 		struct {
-- 
2.20.1
