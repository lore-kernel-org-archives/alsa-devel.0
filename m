Return-Path: <SRS0=REud=KR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FAC04FF3
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 01:36:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8AE610A8
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 01:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8AE610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B58F216CD;
	Sat, 22 May 2021 03:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B58F216CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621647398;
	bh=TR0cErReRtApcHkyAKlcCdq18dXUl25mpM+aydXckCM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1ju9AiH3vyAXnAzw/+FousPW1u9D5MKvviuITVbmDWgM19MeaVWi6lNZNe0aaRvw
	 baMoEth6Ta+oYkh+BjTDk8HhdU1CoNifnZ9jIGPXuYhRAiqLSWTQVJ/aCzTHCWw/Hw
	 FrB/wsP+nEs+y/arBkiXYNnhLWQZoEkUlxHx8NUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F58F804B2;
	Sat, 22 May 2021 03:33:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B8D2F80229; Sat, 22 May 2021 03:33:29 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23884F80272
 for <alsa-devel@alsa-project.org>; Sat, 22 May 2021 03:33:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23884F80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="FilX2mAW"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kPVGbcOV"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5C80A5C0136;
 Fri, 21 May 2021 21:33:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Fri, 21 May 2021 21:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=jatAEoUb4MRny
 R8XSwqqEWDxkjc5gyrlNYOQnlbSxRQ=; b=FilX2mAWvrgxRW92amKWmXG0Q/grW
 1Pk2JHgZQEhP3ew41Cp3AhKDxALI/L32fvv0SCO2ZaNZHxCUupwx+i9l1WhdRhYZ
 g28e7tr3YZtYruV8elsW+bfMto1h5sw9LSa7XyUOnbGZsoC03coNOiTH9NT0NwMm
 jz5TqgibpFMgn/72GF5OJc4/z0NC+hyjq4IHN2eqmk7HcO0oi4ITLmWt/Y015jth
 tgn9Haj69/bpRJTY5Fx7WlPgmc0jykAIeG9UhRHovb3n06hAne2dJM3FcP+MsqpN
 NpF0rdhU5sui4xx1619o3p+Gl9tTqvkB65WKwC7AHbmQ2kMM4AcdcpYFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=jatAEoUb4MRnyR8XSwqqEWDxkjc5gyrlNYOQnlbSxRQ=; b=kPVGbcOV
 0b6XzT0lyTfcO/lrwlFe5Fsw6pGWTML3usWKcx9ycRh4x2iKz5+PK5X+4vSV4C8y
 A+fGuHAYbELIPBUaEXor+nKQEs3LVN6ATmxnv/ozYucsNUFwqj8w60KsIwRTDkMe
 DgomeAL2ydQoFlN8DRl+1bjbJKri3HLybVvZD46bXcfwFVRxe3vwd1jgCcj3M0DV
 7qdlocnl4OGx2iE5xD9z3A+9qXwmyeP4GBWP4hZ62fW59t4m/JwXVclXIKogEF8D
 rwkNlYs1XzLhC7fJfLytqDbBibo47aG+vPkrjWll/hVtfc0xKqDezG//paMtBsRd
 IZPi7sZMepTZew==
X-ME-Sender: <xms:XF-oYLwjs51XlkzB8fF70D6CweVZOtuuDA3RL8FRbh9ZSZBnD5RXEA>
 <xme:XF-oYDQ7p1gyUOsTJtBzEQWIRDEiSyZA2Slk1H0CJNz8_GI2JooInranmRSuUoymg
 0jpF13UidZaOxGu0O4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejgedggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:XF-oYFVFtaF1XTDmHhHebr0DxnRuH0IW0tKw-Ev9MkK_pDmYewaAJg>
 <xmx:XF-oYFhPuJv7n3R-32Vb8KS5atMstyIUmdMPgRABFjQ0gjvofH4kyQ>
 <xmx:XF-oYNCcJpaFRO-g5SNmnfQrFu4nLEfV8D7ZnLDGhxoUdcVRoGEjyg>
 <xmx:XF-oYArYA2fRDJyLqtYhu_-4w_dAVj3_tVJcxCYcl0VSM-6C3y8r6g>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 21 May 2021 21:33:15 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 6/6] ALSA: firewire-lib: code refactoring for transfer delay
Date: Sat, 22 May 2021 10:33:03 +0900
Message-Id: <20210522013303.49596-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210522013303.49596-1-o-takashi@sakamocchi.jp>
References: <20210522013303.49596-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In later commit, transfer delay is used in both IR and IT contexts. This
commit refactors regardless of transfer delay.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 24 ++++++++----------------
 sound/firewire/amdtp-stream.h |  7 +++----
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 26209513199a..6dceb8cd6e0c 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -294,17 +294,11 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s, unsigned int rate,
 	s->syt_interval = amdtp_syt_intervals[sfc];
 
 	// default buffering in the device.
-	if (s->direction == AMDTP_OUT_STREAM) {
-		s->ctx_data.rx.transfer_delay =
-					TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
-
-		if (s->flags & CIP_BLOCKING) {
-			// additional buffering needed to adjust for no-data
-			// packets.
-			s->ctx_data.rx.transfer_delay +=
-				TICKS_PER_SECOND * s->syt_interval / rate;
-		}
-	}
+	s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
+
+	// additional buffering needed to adjust for no-data packets.
+	if (s->flags & CIP_BLOCKING)
+		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
 
 	return 0;
 }
@@ -897,12 +891,10 @@ static void generate_pkt_descs(struct amdtp_stream *s, const __be32 *ctx_header,
 
 		desc->cycle = compute_ohci_it_cycle(*ctx_header, s->queue_size);
 
-		if (aware_syt && seq->syt_offset != CIP_SYT_NO_INFO) {
-			desc->syt = compute_syt(seq->syt_offset, desc->cycle,
-						s->ctx_data.rx.transfer_delay);
-		} else {
+		if (aware_syt && seq->syt_offset != CIP_SYT_NO_INFO)
+			desc->syt = compute_syt(seq->syt_offset, desc->cycle, s->transfer_delay);
+		else
 			desc->syt = CIP_SYT_NO_INFO;
-		}
 
 		desc->data_blocks = seq->data_blocks;
 
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index fc653fe95405..467d5021624b 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -140,15 +140,13 @@ struct amdtp_stream {
 			unsigned int dbc_interval;
 		} tx;
 		struct {
-			// To calculate CIP data blocks and tstamp.
-			unsigned int transfer_delay;
-
 			// To generate CIP header.
 			unsigned int fdf;
 
 			// To generate constant hardware IRQ.
 			unsigned int event_count;
 
+			// To calculate CIP data blocks and tstamp.
 			struct {
 				struct seq_desc *descs;
 				unsigned int size;
@@ -169,7 +167,8 @@ struct amdtp_stream {
 	unsigned int sph;
 	unsigned int fmt;
 
-	/* Internal flags. */
+	// Internal flags.
+	unsigned int transfer_delay;
 	enum cip_sfc sfc;
 	unsigned int syt_interval;
 
-- 
2.27.0

