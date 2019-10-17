Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF08FA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E4621835
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UYLpTNhJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GF/1T4eI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVhE8Wat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E4621835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BAE716C5;
	Thu, 17 Oct 2019 18:02:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BAE716C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571328215;
	bh=+cwrrIqGukudvrCxMgJc/yOtMJi0uR3c4MhrpAGQAgU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYLpTNhJbCc0nFaVfqrjfmeTCvb6VC6p50HCPb0vok96nFnRe5Ma2Q8CsN4L3cKA5
	 MIXI5I8bscw9XeGqWC+zeZW6C47zEjEN9VBnTqZQv738Ncp7ZFWoRXNPgEPtRqt920
	 6OK4j9xdN4INz1Wg/vCAcg8T7wNhJ8NnW+coaD94=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EC04F80715;
	Thu, 17 Oct 2019 17:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6B0AF80639; Thu, 17 Oct 2019 17:54:53 +0200 (CEST)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F70BF80322
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 17:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F70BF80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="GF/1T4eI"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="oVhE8Wat"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 7FBE44D1;
 Thu, 17 Oct 2019 11:54:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 17 Oct 2019 11:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=ivZeOBemg61Qv
 gUJXUNEHOpl71FSS14DdP40ArSmwCo=; b=GF/1T4eIyDvkO+TsQCy2AgdVPElW7
 puw1232uWoHRUzbsm/Q2DaXfi2kxnhsSJTK4PCwHy1s8B92IVifSOQ+XY1A97ven
 3RoGQPCHUvb9ig8PvHCc3zc72cPCUGSOIIeWsvUC0AanPteTcGnETkdMDqKfMGPQ
 zPuTZLz3zmzsHAiaeMGSPphXSFBNUOSOJm1MM7988mSfyMxJ3SPP5q4Ge+OBasU0
 /dKFu2OL2Zc0IUo0sQiol3b3aQEre6TJlT9+Hiz732WA7ynxCXFh04KGld5B5kWJ
 A/2EFbJxWK/VpENvzTSzgLnr5TyR8pz1dKRMuGPY4YtmsuSeyfDYb7UTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ivZeOBemg61QvgUJXUNEHOpl71FSS14DdP40ArSmwCo=; b=oVhE8Wat
 oxMTxUts1lA8dQW6s8Il9FBYo4gw9s7B1rGmq4sq5qy1l7jYNaw/y7art6p/Mg7m
 ZtIkuu4j7YGFAD2OXztFWTD54p/TyAjsV3oe6qahTHelsu96lpgP2izNylI/y3te
 pvj2kQytQiBu1EN7xiREvefpEgM9Bl9+sP/WTr/Q/zMd5YcCWrHc7KxRzJ/0dAv7
 3bSThXZmNeCKES2yLVTmDdftPch7sxSTu1IZnF1Hmb1oJZm86FdT15tsHq0AP3q0
 qQpOzT/U+ygJe6eXQ3Bpg9C9pTqbV9hVa5/NV5ey3CXZD9jXCLMGLvRvWLJByIPE
 CrZkvUb5w/OtIA==
X-ME-Sender: <xms:xI6oXUj9dqYXbPC8eLuF_zRIeA3e1otraVDFq_Rgt27KaTcV4nqT6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdelgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucfkphepudegrdefrdejhedrudekudenuc
 frrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhi
 rdhjphenucevlhhushhtvghrufhiiigvpeej
X-ME-Proxy: <xmx:xI6oXZYHefdX3Av9Gxe10GSkQ9KWwC4oYy2klh1qU3DVYA8lQ9kA-w>
 <xmx:xI6oXQiQXHBZkCAFtRBNYENbRn3c1CtUU02iiIAU7qUWU-CEJt40yw>
 <xmx:xI6oXTaYZT9lWxMqgBy6IHh3yYw2y3-TbiR-dJDD_pc5XYn-1_BH8w>
 <xmx:xY6oXZvRoGyevTwjxko98KIIIWMq3UuuvIZYS-6UybNrJ0HU4osHrg>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp
 [14.3.75.181])
 by mail.messagingengine.com (Postfix) with ESMTPA id AB1AB80063;
 Thu, 17 Oct 2019 11:54:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Date: Fri, 18 Oct 2019 00:54:22 +0900
Message-Id: <20191017155424.885-11-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017155424.885-1-o-takashi@sakamocchi.jp>
References: <20191017155424.885-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH 10/12] ALSA: firewire-lib: schedule hardware
	IRQ according to the size of PCM period
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

ALSA IEC 61883-1/6 packet streaming engine controls 1394 OHCI controller
to generate hardware IRQ for fixed number of isochronous packets (=16)
since its first commit.

This commit allow the engine to generate it for variable period according
to the number of event to handle. For outgoing stream, internal
calculator is used to check the accumulated events. For incoming stream,
the number of data block in the packet of stream is used to check the
accumulated events. When it's unavailable, fixed number of packet
roughly calculated in advance is used instead of event counting.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 70 +++++++++++++++++++++++++++--------
 sound/firewire/amdtp-stream.h |  3 ++
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 1f38729c8e74..fd7c3e4d5374 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -52,9 +52,6 @@
 #define CIP_FMT_AM		0x10
 #define AMDTP_FDF_NO_DATA	0xff
 
-/* TODO: make these configurable */
-#define INTERRUPT_INTERVAL	16
-
 // For iso header, tstamp and 2 CIP header.
 #define IR_CTX_HEADER_SIZE_CIP		16
 // For iso header and tstamp.
@@ -435,11 +432,12 @@ static void pcm_period_tasklet(unsigned long data)
 		snd_pcm_period_elapsed(pcm);
 }
 
-static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params)
+static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params,
+			bool sched_irq)
 {
 	int err;
 
-	params->interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
+	params->interrupt = sched_irq;
 	params->tag = s->tag;
 	params->sy = 0;
 
@@ -457,21 +455,21 @@ static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params)
 }
 
 static inline int queue_out_packet(struct amdtp_stream *s,
-				   struct fw_iso_packet *params)
+				   struct fw_iso_packet *params, bool sched_irq)
 {
 	params->skip =
 		!!(params->header_length == 0 && params->payload_length == 0);
-	return queue_packet(s, params);
+	return queue_packet(s, params, sched_irq);
 }
 
 static inline int queue_in_packet(struct amdtp_stream *s,
-				  struct fw_iso_packet *params)
+				  struct fw_iso_packet *params, bool sched_irq)
 {
 	// Queue one packet for IR context.
 	params->header_length = s->ctx_data.tx.ctx_header_size;
 	params->payload_length = s->ctx_data.tx.max_ctx_payload_length;
 	params->skip = false;
-	return queue_packet(s, params);
+	return queue_packet(s, params, sched_irq);
 }
 
 static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
@@ -779,6 +777,8 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 {
 	struct amdtp_stream *s = private_data;
 	const __be32 *ctx_header = header;
+	unsigned int events_per_period = s->events_per_period;
+	unsigned int event_count = s->event_count;
 	unsigned int packets;
 	int i;
 
@@ -799,6 +799,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			struct fw_iso_packet params;
 			__be32 header[IT_PKT_HEADER_SIZE_CIP / sizeof(__be32)];
 		} template = { {0}, {0} };
+		bool sched_irq = false;
 
 		if (s->ctx_data.rx.syt_override < 0)
 			syt = desc->syt;
@@ -809,12 +810,20 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				    desc->data_blocks, desc->data_block_counter,
 				    syt, i);
 
-		if (queue_out_packet(s, &template.params) < 0) {
+		event_count += desc->data_blocks;
+		if (event_count >= events_per_period) {
+			event_count -= events_per_period;
+			sched_irq = true;
+		}
+
+		if (queue_out_packet(s, &template.params, sched_irq) < 0) {
 			cancel_stream(s);
 			return;
 		}
 	}
 
+	s->event_count = event_count;
+
 	fw_iso_context_queue_flush(s->context);
 }
 
@@ -823,8 +832,10 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			       void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int packets;
 	__be32 *ctx_header = header;
+	unsigned int events_per_period = s->events_per_period;
+	unsigned int event_count = s->event_count;
+	unsigned int packets;
 	int i;
 	int err;
 
@@ -845,14 +856,29 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	}
 
 	for (i = 0; i < packets; ++i) {
+		const struct pkt_desc *desc = s->pkt_descs + i;
 		struct fw_iso_packet params = {0};
+		bool sched_irq = false;
+
+		if (err >= 0) {
+			event_count += desc->data_blocks;
+			if (event_count >= events_per_period) {
+				event_count -= events_per_period;
+				sched_irq = true;
+			}
+		} else {
+			sched_irq =
+				!((s->packet_index + 1) % s->idle_irq_interval);
+		}
 
-		if (queue_in_packet(s, &params) < 0) {
+		if (queue_in_packet(s, &params, sched_irq) < 0) {
 			cancel_stream(s);
 			return;
 		}
 	}
 
+	s->event_count = event_count;
+
 	fw_iso_context_queue_flush(s->context);
 }
 
@@ -913,6 +939,7 @@ static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed,
 		[CIP_SFC_176400] = {  0,   67 },
 	};
 	unsigned int events_per_buffer = d->events_per_buffer;
+	unsigned int events_per_period = d->events_per_period;
 	unsigned int ctx_header_size;
 	unsigned int max_ctx_payload_size;
 	enum dma_data_direction dir;
@@ -958,11 +985,21 @@ static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed,
 			max_ctx_payload_size -= IT_PKT_HEADER_SIZE_CIP;
 	}
 
+	// This is a case that AMDTP streams in domain run just for MIDI
+	// substream. Use the number of events equivalent to 10 msec as
+	// interval of hardware IRQ.
+	if (events_per_period == 0)
+		events_per_period = amdtp_rate_table[s->sfc] / 100;
 	if (events_per_buffer == 0)
-		events_per_buffer = INTERRUPT_INTERVAL * 3;
+		events_per_buffer = events_per_period * 3;
 
+	s->idle_irq_interval =
+			DIV_ROUND_UP(CYCLES_PER_SECOND * events_per_period,
+				     amdtp_rate_table[s->sfc]);
 	s->queue_size = DIV_ROUND_UP(CYCLES_PER_SECOND * events_per_buffer,
 				     amdtp_rate_table[s->sfc]);
+	s->events_per_period = events_per_period;
+	s->event_count = 0;
 
 	err = iso_packets_buffer_init(&s->buffer, s->unit, s->queue_size,
 				      max_ctx_payload_size, dir);
@@ -1002,12 +1039,15 @@ static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed,
 	s->packet_index = 0;
 	do {
 		struct fw_iso_packet params;
+		bool sched_irq;
+
+		sched_irq = !((s->packet_index + 1) % s->idle_irq_interval);
 		if (s->direction == AMDTP_IN_STREAM) {
-			err = queue_in_packet(s, &params);
+			err = queue_in_packet(s, &params, sched_irq);
 		} else {
 			params.header_length = 0;
 			params.payload_length = 0;
-			err = queue_out_packet(s, &params);
+			err = queue_out_packet(s, &params, sched_irq);
 		}
 		if (err < 0)
 			goto err_pkt_descs;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 8d541727e437..344818e936df 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -145,6 +145,9 @@ struct amdtp_stream {
 			int syt_override;
 		} rx;
 	} ctx_data;
+	unsigned int event_count;
+	unsigned int events_per_period;
+	unsigned int idle_irq_interval;
 
 	/* For CIP headers. */
 	unsigned int source_node_id_field;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
