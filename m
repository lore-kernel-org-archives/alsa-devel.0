Return-Path: <SRS0=EA+P=KI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2512C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 12:59:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DF561421
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 12:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DF561421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7489917F1;
	Thu, 13 May 2021 14:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7489917F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620910768;
	bh=Qi+7qitwrGA0eF+Q7b0ugban0JcWnAjG6SVxQu4gRuw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fjmoXa+zumOoIvvePB4pJRQTeNAAR5yRb86P6+laONSY5iAi0ydhQdMGmhnjUXIw3
	 Sc5jY4vc/InBNuttEXaTI4fybVcwOS4YtJoEUXuF/nlnI7UHfEIQICf5yuSltVSfBO
	 SUm+Tj8HUZctEHdlxHSs+3pB4oPxvyazX69YS9pQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10B04F80475;
	Thu, 13 May 2021 14:57:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2CA1F80425; Thu, 13 May 2021 14:57:10 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83A97F801D5
 for <alsa-devel@alsa-project.org>; Thu, 13 May 2021 14:57:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83A97F801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="VUzEvmq3"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="j+kyhSXt"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id B2B305C0131;
 Thu, 13 May 2021 08:57:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Thu, 13 May 2021 08:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=1bWNkO+xtTgO+
 nBeqiO1bNG/Jcme/8RK9i++sOTt6cs=; b=VUzEvmq3TtL8Ys91DYbAWrSJdDayl
 unGtLnDmZSFviMcI490XEL+lGUzpBZLiP3gjJZsf6j1xjXFPwObErv7dRkkPe0Q9
 y4YvJT/AoAcytQq8fkyRgySlYRZQSez3/GCoX6XUZGSUJ8fbhru/ULpR5NKi//m8
 jJwSf5Kxe5dspO6XzhKHUCO4CDUiP2m08q82wMUIzTGUdfhl41y+aV0l1e1HmrXn
 JTSZKAFA65nmoqzk6WmUHq+sawf2KFXkGPGebqYf3pBtz1c5jdSuH5ZmY4hZDYqL
 BWktOzcIusHcpUJ+SOBWu1NV1ShpLbhzk//SVtKaMXb7XW0BLwffv/3cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=1bWNkO+xtTgO+nBeqiO1bNG/Jcme/8RK9i++sOTt6cs=; b=j+kyhSXt
 SpgjyhFJSJ0FDXhqAOd/1Aw++6hJeouzqeNFzmqTIK7HxqXjN3btx2BmJb84WzgC
 cUlwgj6JQ6z/cIK07csOaX9++TOk+SOv2AI1r2wrcDTaOhqSj1lDtd1vrVpja3Yn
 3IDgm8EwSW7h6jey5sJc1nKBSxbzrNguJJOMpHV6PA6by40WR24WiNZf2UWMGmhy
 FTuppwGaYYSinX/trTg+5tPJDhlqDJYBXea7y8u3Stn7JJBDg+iTDpc17uf6fbXL
 b6G1dzD/CDifsFanroMsmVlsoEhrohY8ktsipKLZsSK04j0Cap7gfbSnyfeXu1w0
 nHZKTxwbqchXog==
X-ME-Sender: <xms:HiKdYDpgi0WkbMlf8-TMYUgQ65VWeH-kzO_4nAGUxl6Fd9_tn0SEjw>
 <xme:HiKdYNowOh6UFNhIoxM0og75Dkki_eAyaEr_fRsq0t08ME64iK0Uyrs9RhizTziD0
 LSeyEgyCVBeIa0e_Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:HiKdYAMBAzNQujBEN1Q0IW13IyWW_eUg8Q56v7cIqBsPJPvUIc_W6w>
 <xmx:HiKdYG6M1zidkUxj8syyiGcufpzSrIg8ZxLjTJ-eHxFfNLyNX_e0KA>
 <xmx:HiKdYC5jnfGOb0hOyUBXRJ49BcsQwdgC22QbLmJcp313QE5RaFArlQ>
 <xmx:HiKdYIR3Pu2r7kR47Z9F7VPR3ltJp-BvY4i8FJVo3JgpzQ5cWnVEpg>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 13 May 2021 08:57:01 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 3/5] ALSA: firewire-lib: fix check for the size of isochronous
 packet payload
Date: Thu, 13 May 2021 21:56:50 +0900
Message-Id: <20210513125652.110249-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210513125652.110249-1-o-takashi@sakamocchi.jp>
References: <20210513125652.110249-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, stable@vger.kernel.org
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

The check for size of isochronous packet payload just cares of the size of
IR context payload without the size of CIP header.

Cc: <stable@vger.kernel.org>
Fixes: f11453c7cc01 ("ALSA: firewire-lib: use 16 bytes IR context header to separate CIP header")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 4e2f2bb7879f..b53971bf4b90 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -633,18 +633,24 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			       unsigned int *syt, unsigned int index)
 {
 	const __be32 *cip_header;
+	unsigned int cip_header_size;
 	int err;
 
 	*payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
-	if (*payload_length > s->ctx_data.tx.ctx_header_size +
-					s->ctx_data.tx.max_ctx_payload_length) {
+
+	if (!(s->flags & CIP_NO_HEADER))
+		cip_header_size = 8;
+	else
+		cip_header_size = 0;
+
+	if (*payload_length > cip_header_size + s->ctx_data.tx.max_ctx_payload_length) {
 		dev_err(&s->unit->device,
 			"Detect jumbo payload: %04x %04x\n",
-			*payload_length, s->ctx_data.tx.max_ctx_payload_length);
+			*payload_length, cip_header_size + s->ctx_data.tx.max_ctx_payload_length);
 		return -EIO;
 	}
 
-	if (!(s->flags & CIP_NO_HEADER)) {
+	if (cip_header_size > 0) {
 		cip_header = ctx_header + 2;
 		err = check_cip_header(s, cip_header, *payload_length,
 				       data_blocks, data_block_counter, syt);
-- 
2.27.0

