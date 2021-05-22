Return-Path: <SRS0=REud=KR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A7C04FF3
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 01:36:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF4F613F4
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 01:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF4F613F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A46716D2;
	Sat, 22 May 2021 03:35:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A46716D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621647368;
	bh=4lqtPJKntEEoHiEt0WRGi/Njm/Q4NAk0D9CBxDqpQQ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSQabBWHCvKQzWqBHETp6PphLj8nO2MNTGbcrFzTK7HLRqt13a/AKrlNmpW75M6yJ
	 o8ViYjmLCGL1Guks6cF0mLmUJSjd6u5fcWa2UdkXRpB0bsl55LGATYEPbdkq5sOiYw
	 tK+uMHczL/g6Pe9jULdD04iGoMcOqi7JCTM64vf4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8517FF804AB;
	Sat, 22 May 2021 03:33:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42DD4F80257; Sat, 22 May 2021 03:33:28 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F46CF80257
 for <alsa-devel@alsa-project.org>; Sat, 22 May 2021 03:33:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F46CF80257
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="rFPzfe6r"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="WIcKOtQ2"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id C87685C024F;
 Fri, 21 May 2021 21:33:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 21 May 2021 21:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=c5jfPQEYgI17v
 h0PEdvC8vVx6rTAzyhbrZqcibr7AxE=; b=rFPzfe6r+jxSbQXtOdE/JRjopduza
 OLO+4FVwOixb3SHCGGMLtwkDzUmXG//GzN3dBVPlhAG/W3gIXNNBaPVK2Q0UIgya
 9JToUrYwgQy8LlCdzT7YKT7LLVbW9nBpeqXrz9GuycHjtCmLUXaQCXMl3v/xEpOC
 iJ+NL+3tkMdQuZGfxykiNOW3eWWRfYl6mC3BjO+Fv76LT8otgUWKkLhlF2j+LQmX
 9IGJCIOYiwd73GqJhpwI1ha6gNxJANrGC2ftzUWPzAVoEhz3MbOvv1ZmWLVLHzOK
 I7FFdMJJ7h648Hg9kaFtg3HSzleGzaMqr5Km0RaVlK3/CgAcPGlREp/PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=c5jfPQEYgI17vh0PEdvC8vVx6rTAzyhbrZqcibr7AxE=; b=WIcKOtQ2
 Eoke9GmI2NHGqYp3DnNHzKlxP+Tk1lxpM6nZMAuHgIFEYOyJhakCCL4XFnSfVnc2
 yhQt46/Rw2gYRBqM6WJVS7iFW1WvkUPF07l9eD3wibjm1szpBhOatlQHQnW+qkvL
 OJK2BiorC0ySxxCOIFv1Az911EK35/zQ+ZbcgSAggkUHJX1+lyE52wOLD+V2Gzrq
 niciWBd5Dj5EChPgL1Lxbhvep97ij76Ftj1cK9UncaAtcj8rTth6qd4/6sd7XjKI
 k1slg2HBbGTVKEGqhhKCzx8qROqCoJihjhBul1RsuHu9tw8I4uoGlUerAAnU27dy
 lHj7wmR4nFEYfg==
X-ME-Sender: <xms:WV-oYIULexHI-jPf0NWSegmWEhT5Z3MhnlBXchrxzAATs3Tjcgqqdg>
 <xme:WV-oYMmBTzqZy3PVTe5_OHXShtYgA6JjgLjhHSM_U_wuyhwPb_2WG1LMtNUk1jSrm
 EsRbo_pmDgPXrJvnrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejgedggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepieetueeuvd
 elfedvteejteeiheeugeelvedvkeeffeffuedutdeifeeukeeutefgnecuffhomhgrihhn
 pehrgidruggrthgrnecukfhppedugedrfedrieehrddujeehnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgr
 mhhotggthhhirdhjph
X-ME-Proxy: <xmx:WV-oYMYwIS0zEwzjEJ3aBTjGY2uNnVFsttUR0aVsDpfrIMTeJC64dQ>
 <xmx:WV-oYHUUX_hgApNzWLlhaNvVITLObJO3FQOsA3yEDLKmWp_qgvQfow>
 <xmx:WV-oYCmY_LozFijuqZobDlYqBIQwjzXplOIKH0eRZXSfm1hd0JfWiQ>
 <xmx:WV-oYJtgfZ3Wi6DEC51A-NuoZREAUCcE8eR5I75iJFa-Wm3uQmFSxQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 21 May 2021 21:33:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 4/6] ALSA: firewire-lib: code refactoring for generation of
 syt sequence
Date: Sat, 22 May 2021 10:33:01 +0900
Message-Id: <20210522013303.49596-5-o-takashi@sakamocchi.jp>
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

This commit dissolves sequence generator in terms of syt offsets for
packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 354512a350b7..77ae75e79a43 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -441,8 +441,30 @@ static unsigned int calculate_syt_offset(unsigned int *last_syt_offset,
 	return syt_offset;
 }
 
+static void pool_ideal_syt_offsets(struct amdtp_stream *s, struct seq_desc *descs,
+				   const unsigned int seq_size, unsigned int seq_tail,
+				   unsigned int count)
+{
+	const enum cip_sfc sfc = s->sfc;
+	unsigned int last = s->ctx_data.rx.last_syt_offset;
+	unsigned int state = s->ctx_data.rx.syt_offset_state;
+	int i;
+
+	for (i = 0; i < count; ++i) {
+		struct seq_desc *desc = descs + seq_tail;
+
+		desc->syt_offset = calculate_syt_offset(&last, &state, sfc);
+
+		seq_tail = (seq_tail + 1) % seq_size;
+	}
+
+	s->ctx_data.rx.last_syt_offset = last;
+	s->ctx_data.rx.syt_offset_state = state;
+}
+
 static void pool_ideal_seq_descs(struct amdtp_stream *s, unsigned int count)
 {
+	struct seq_desc *descs = s->ctx_data.rx.seq.descs;
 	unsigned int seq_tail = s->ctx_data.rx.seq.tail;
 	const unsigned int seq_size = s->ctx_data.rx.seq.size;
 	const unsigned int syt_interval = s->syt_interval;
@@ -450,11 +472,11 @@ static void pool_ideal_seq_descs(struct amdtp_stream *s, unsigned int count)
 	const bool is_blocking = !!(s->flags & CIP_BLOCKING);
 	int i;
 
+	pool_ideal_syt_offsets(s, descs, seq_size, seq_tail, count);
+
 	for (i = 0; i < count; ++i) {
 		struct seq_desc *desc = s->ctx_data.rx.seq.descs + seq_tail;
 
-		desc->syt_offset = calculate_syt_offset(&s->ctx_data.rx.last_syt_offset,
-					&s->ctx_data.rx.syt_offset_state, sfc);
 		desc->data_blocks = calculate_data_blocks(&s->ctx_data.rx.data_block_state,
 				is_blocking, desc->syt_offset == CIP_SYT_NO_INFO,
 				syt_interval, sfc);
-- 
2.27.0

