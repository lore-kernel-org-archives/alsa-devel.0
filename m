Return-Path: <SRS0=uvJZ=6W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CBC38A2A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 04:39:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12BC206D3
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 04:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AoHMeQR8";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="o/uX4rCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HemZSLRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12BC206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C6F8182E;
	Fri,  8 May 2020 06:39:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C6F8182E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588912794;
	bh=uy+QmMCXupCXBHwl03Ot8Ta+v7XJXuSe9eNtQy/Jd4Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AoHMeQR8fVc53TqGdJIQMm1SqUhAYkovJTTonXI3Rt4OxKAt2y/mYdL35+55JqShF
	 Qu35+CsarYCSnNinst/fBvZW8CB9MRezQOWxzCSzQTCp7WTIhrnEjvDXWGX3JdsFXM
	 vwkUebEzU5StJNYS2VW4mPPk6JDPLe41EZlE8dZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FA94F8025F;
	Fri,  8 May 2020 06:37:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E6B2F8029A; Fri,  8 May 2020 06:36:58 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94F01F80253
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2020 06:36:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94F01F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="o/uX4rCg"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="HemZSLRr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 94E24A8C;
 Fri,  8 May 2020 00:36:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 08 May 2020 00:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=9R7cJOKi8dae+
 r/XcKWIyPQYqP72o494vgDkCg/h0uc=; b=o/uX4rCgAFc4opIM+5j6qv+u30feN
 AvaWfj+OSWx5Yq7m9lTXdCxgUhivT9gspcrBfJ+ixv25S4Up+d9VwT0yODEYHA1P
 XiqRd2Sabzyw7p68Cb6xXGXBidq8854S40QJWWRuWDdoHVVNWDReffIA1nbXrrK7
 ro9eMBuLuDWoN60Zx0jDLIt1kA1PXmMtCRNCWM1RhS55f5Zn6hBVwO1iEqwIhTBf
 KF4C3dDYnqwXCZ8ez0PdSdx6pKtn3MCzC1Y7Yx7Q0b6Rt+2QOF0ApCGRazlf6F8d
 Ld/56c+M9TZAWeKfF1ZFzxhLhPtDhcAG5thHjlCOEMA6Q2qEvC2hrNqIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=9R7cJOKi8dae+r/XcKWIyPQYqP72o494vgDkCg/h0uc=; b=HemZSLRr
 9a/1/j16vWS6UWRj+9oVMc8kix0hj2CYltyscn9UMUZ08MjX8Kd+v3ftIItl3nQ+
 nH449Ge3k3VVv0fZvpBzXjNNKnP2LoeFINVFAajh6kAY4fXUyjp/yaM5Zqojfm8y
 KXhR133WaMQPdFKzLK89XcRaOFwV3OHyy1l+/vBDsCXMzBVyHKjipbNNcjd8ikj1
 F+iUgMQMzO4HBHcTf9RtykbkZaXLvn5VkFcDylj6WdtgkdFocnT6ObAwRS7sZQ1O
 LgxCAzWLYAJA0Z3zoVj//I6CK6x0hsc+g7Q+apSVpyNqYy33VxmQA9C/q/hMdmsv
 QkUI0BM7kJWCmg==
X-ME-Sender: <xms:3OG0XmRXoi_2srJi6YisCcRyrXchzXaqf-2hyrTHCUhg39Fn_2fQWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkedugdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffeekte
 fgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudektddr
 vdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:3OG0XtYUnICzQL6Om2-0Iv2ClPI8z6IvtJygoOEL6wr8nqm9E7RFuw>
 <xmx:3OG0Xn4INy2LqWZdAPJmgK0T5BOIJDzks0sd0ltQnJHboH9BBkpoUg>
 <xmx:3OG0Xod4SZCZkP7zWtMR8Pq3JsDp5-dvO_yBZefuDUr14LEvOo8GhA>
 <xmx:3OG0XkDzY-d9XuYkUL1UE7Y7DYp_2-GYaz4O4Uuo7ANZvKZJOO2K2g>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3D5EC3280068;
 Fri,  8 May 2020 00:36:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: clemens@ladisch.de,
	tiwai@suse.de
Subject: [PATCH 05/10] ALSA: firewire-lib: code refactoring for syt computation
Date: Fri,  8 May 2020 13:36:30 +0900
Message-Id: <20200508043635.349339-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200508043635.349339-1-o-takashi@sakamocchi.jp>
References: <20200508043635.349339-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

In current implementation for outgoing AMDTP packet, the value of syt
field in CIP header is computed when calculating syt offset. For
future extension, it's convenient to split the computation and
calculation.

This commit splits them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 36 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 6130c240ff33..1605ea4301ce 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -383,10 +383,9 @@ static unsigned int calculate_data_blocks(struct amdtp_stream *s,
 	return data_blocks;
 }
 
-static unsigned int calculate_syt(struct amdtp_stream *s,
-				  unsigned int cycle)
+static unsigned int calculate_syt_offset(struct amdtp_stream *s)
 {
-	unsigned int syt_offset, phase, index, syt;
+	unsigned int syt_offset, phase, index;
 
 	if (s->ctx_data.rx.last_syt_offset < TICKS_PER_CYCLE) {
 		if (!cip_sfc_is_base_44100(s->sfc))
@@ -416,15 +415,10 @@ static unsigned int calculate_syt(struct amdtp_stream *s,
 		syt_offset = s->ctx_data.rx.last_syt_offset - TICKS_PER_CYCLE;
 	s->ctx_data.rx.last_syt_offset = syt_offset;
 
-	if (syt_offset < TICKS_PER_CYCLE) {
-		syt_offset += s->ctx_data.rx.transfer_delay;
-		syt = (cycle + syt_offset / TICKS_PER_CYCLE) << 12;
-		syt += syt_offset % TICKS_PER_CYCLE;
+	if (syt_offset >= TICKS_PER_CYCLE)
+		syt_offset = CIP_SYT_NO_INFO;
 
-		return syt & CIP_SYT_MASK;
-	} else {
-		return CIP_SYT_NO_INFO;
-	}
+	return syt_offset;
 }
 
 static void update_pcm_pointers(struct amdtp_stream *s,
@@ -740,6 +734,17 @@ static int generate_device_pkt_descs(struct amdtp_stream *s,
 	return 0;
 }
 
+static unsigned int compute_syt(unsigned int syt_offset, unsigned int cycle,
+				unsigned int transfer_delay)
+{
+	unsigned int syt;
+
+	syt_offset += transfer_delay;
+	syt = ((cycle + syt_offset / TICKS_PER_CYCLE) << 12) |
+	      (syt_offset % TICKS_PER_CYCLE);
+	return syt & CIP_SYT_MASK;
+}
+
 static void generate_ideal_pkt_descs(struct amdtp_stream *s,
 				     struct pkt_desc *descs,
 				     const __be32 *ctx_header,
@@ -751,9 +756,16 @@ static void generate_ideal_pkt_descs(struct amdtp_stream *s,
 	for (i = 0; i < packets; ++i) {
 		struct pkt_desc *desc = descs + i;
 		unsigned int index = (s->packet_index + i) % s->queue_size;
+		unsigned int syt_offset;
 
 		desc->cycle = compute_it_cycle(*ctx_header, s->queue_size);
-		desc->syt = calculate_syt(s, desc->cycle);
+		syt_offset = calculate_syt_offset(s);
+		if (syt_offset != CIP_SYT_NO_INFO) {
+			desc->syt = compute_syt(syt_offset, desc->cycle,
+						s->ctx_data.rx.transfer_delay);
+		} else {
+			desc->syt = syt_offset;
+		}
 		desc->data_blocks = calculate_data_blocks(s, desc->syt);
 
 		if (s->flags & CIP_DBC_IS_END_EVENT)
-- 
2.25.1

