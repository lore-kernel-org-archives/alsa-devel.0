Return-Path: <SRS0=REud=KR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE05C04FF3
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 01:35:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38444613F5
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 01:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38444613F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8FD116A3;
	Sat, 22 May 2021 03:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8FD116A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621647357;
	bh=f/nE8+ySeyABv7RyneOLz8z6N7LOrjK02BcXtEA9YcM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=byv1oiH4dSXYA/V6L2uRIwHuO3rG7FPUgrsdNuaTU3UvSiKXs8xOslksc8ClR2cFn
	 EdgHOhDAYPbwfUN2xESnyXNz3fsGHo7GZ+NPeF0MYk8G7iojSSsnI+AZKGUwK5q9Em
	 oN5D02d8KqzMpyk+e7tLC/pJ2R26I5pn1T59T+9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B10CF804AA;
	Sat, 22 May 2021 03:33:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09AA1F802C8; Sat, 22 May 2021 03:33:27 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BE60F80229
 for <alsa-devel@alsa-project.org>; Sat, 22 May 2021 03:33:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BE60F80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Iz5b7FAX"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="FhRn32CL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 824465C025B;
 Fri, 21 May 2021 21:33:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 21 May 2021 21:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=X3Cu6lEuCZJ2y
 ULLlkDaRE3zidiH8ERLDI8koG0w7PA=; b=Iz5b7FAXTqlntRoysfXxhAI2eYKpE
 PXDmu0M2ZSFg7Hfd4Y1y1bMWspTdLQ1uAR+Tw1hh60uAFfYWODtufOT1w7UU6Eq3
 0wu/mrvd9qtYkwhBHs3Rw7u5u5x0hTrDKDP1W35/TprJvxbIuw9F8mWOEJy5eraK
 0QBy6lVJZOoCImFNnf0Tq5uMgtcAbnglYht/UWuyVLfsub1pBk3jSebVuAaomub8
 sxmuif4YyipelOxIfsmWPOZdvQo8jTKJ3OwWDenjY/bM/kV/xW3qK9a5FHgX1jjM
 DXzjIme8Xren7geU7Xwb2sHcMy+wvrDUl1b/uZ4Q+qFVieI5MOYuQaRFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=X3Cu6lEuCZJ2yULLlkDaRE3zidiH8ERLDI8koG0w7PA=; b=FhRn32CL
 tbN2jCchtjlEPP70vgZSRc4ncp++eH6i9w77cBxwqKfA3Wksej8iDfPqjWTzgwuC
 ZMpdl0N2JF2NXN8DMKB4WHV7r6OxhOTovfJVAH51GMAo8+3HBBkA08/b7bB5xL7h
 0y9eML+jU5kz7Mq8JXZsTGzJg7kQ4EZgHE1NGHGt+4hzwGLBU4QUYceDZdRfhJGa
 1l+mXiAeRI9sKs2BVWSsrO2EbQ4rJS0zneWcLxedELzhcw9A6i/of3NOAqXE43Es
 fCNmbqVQ7YgUi4/HqlTqueO9pz+vlYqoFhJHMJM7vriVzmqZ481S/6deCzwYfRUL
 zfGIGZLtN0SHjA==
X-ME-Sender: <xms:V1-oYMww7ZYHsG1tZ6nRc4iocEvGcAxgCoKCN2xprzjTKN9TGC05cw>
 <xme:V1-oYAQr24iw1HpXNfavKs0wT1-rzM51hePZvaxo_p2DjpbIExEoHTCJTXwu3C23W
 --Zn-pRsgoDv9xu-RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejgedggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:V1-oYOVAB0XjNOwJoNMGpxM6-0267Zug-bPq2TPTSJgOPDmeNQApsA>
 <xmx:V1-oYKjLY5YiYuK1CRYewOArwLK1ETFYlLzcCLAx1QTOsyci_eUZyg>
 <xmx:V1-oYOBqmlwymQnmTZ8T0vh1Jq-g9HUBjDaUoE7tYhhOA2h0e6zmdA>
 <xmx:WF-oYJq1oytOqMw-1QKrq5gGS-W5a5y3AwRhWfKz8FJpgYff_SqYXw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 21 May 2021 21:33:10 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 3/6] ALSA: firewire-lib: code refactoring for generation of
 packet descriptors
Date: Sat, 22 May 2021 10:33:00 +0900
Message-Id: <20210522013303.49596-4-o-takashi@sakamocchi.jp>
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

This commit refactors the arguments of helper function to generate the
descriptors of packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index cf4fbbd18756..354512a350b7 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -851,11 +851,11 @@ static unsigned int compute_syt(unsigned int syt_offset, unsigned int cycle,
 	return syt & CIP_SYT_MASK;
 }
 
-static void generate_pkt_descs(struct amdtp_stream *s, struct pkt_desc *descs,
-			       const __be32 *ctx_header, unsigned int packets,
-			       const struct seq_desc *seq_descs,
-			       unsigned int seq_size)
+static void generate_pkt_descs(struct amdtp_stream *s, const __be32 *ctx_header, unsigned int packets)
 {
+	struct pkt_desc *descs = s->pkt_descs;
+	const struct seq_desc *seq_descs = s->ctx_data.rx.seq.descs;
+	const unsigned int seq_size = s->ctx_data.rx.seq.size;
 	unsigned int dbc = s->data_block_counter;
 	unsigned int seq_head = s->ctx_data.rx.seq.head;
 	bool aware_syt = !(s->flags & CIP_UNAWARE_SYT);
@@ -937,8 +937,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
 
 	pool_ideal_seq_descs(s, packets);
 
-	generate_pkt_descs(s, s->pkt_descs, ctx_header, packets, s->ctx_data.rx.seq.descs,
-			   s->ctx_data.rx.seq.size);
+	generate_pkt_descs(s, ctx_header, packets);
 
 	process_ctx_payloads(s, s->pkt_descs, packets);
 
-- 
2.27.0

