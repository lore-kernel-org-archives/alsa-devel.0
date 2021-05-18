Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F74C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:48:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8F661369
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8F661369
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9F4982B;
	Tue, 18 May 2021 04:47:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9F4982B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621306103;
	bh=JRc9DCV+kQP/aiXtI8kxufsQcMSHGQ/1I6BvPqvRyZw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FqyFbBa7RzuKBIsN9sxn5Q/sVWvj3A8/7cHBTy4YMwZGQStUAHNTyOzoG+bf4/CFM
	 QuzRdpVQXeIXpvT0pVl//pNYqBKSUy9mun2bprJV5NeFFj9KgNKoHiFDmLnGKu045B
	 qzJg+l3ppf4HH7OZRMmCPCodMco8liwwkQ9TpAOs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C58EF804E6;
	Tue, 18 May 2021 04:44:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8381EF804B1; Tue, 18 May 2021 04:43:59 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7E3CF8012C
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 04:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7E3CF8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="ayIWyCz0"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="tXQqrDRw"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 1A6AD5C0196;
 Mon, 17 May 2021 22:43:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 17 May 2021 22:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=/X4Km5+fh5lH7
 8+KdttWjo7bnQ89V8nq9Swu+W9VfJg=; b=ayIWyCz0QvNrdO6tgm4yA6L5LJwlS
 ggsLcvYGXOoZQLgkAbyZADYeTkOes6ZMhokaX0k4zot2jd2QMN975qPPMe8d3QJA
 LU9CNHe2JzEm6vVV5cnPFxOiTwi09gIQ/DC2sNP87ikQJAHCvhLgRPzAigg2Zg3U
 j09fXmx7ioyXuWOL6s0B08ar+502VcbbdrhyQZy6+gh3rNzzLN5altVRE9gK+62p
 6lCAkhMztWxwqo3zUXEWoONzelDghnffSl2fSgVFZSZr907PaU7HRnxpDJ7Mc+7O
 Y8Njdl0OgpTfIgamGfmVAp6ElhjLPsUQkdTA80bmyzWO8rU0Nhw4sqb0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=/X4Km5+fh5lH78+KdttWjo7bnQ89V8nq9Swu+W9VfJg=; b=tXQqrDRw
 pWbK0UXafedD4lOKXeHzi85QpC9bqtvk0UaG3YNSo0HKAZxlpJa8DmZOz82XcpVM
 0JDVUXDUx+F/u0S96b2x1D0OjjdNz45QJUV7VvBe1uX5ZgxWM8Qoy54ROR3IalzD
 J57R0wfDVQ9mHfZqYAz7IGbqVJO344KYlY4rBNvrySr0nd9Xa22hNgJfxdfOsV05
 d3SxhH3QvN69V+EoFhtt8C2ZktGZps9ek+k60Mde/XdbmQMxVQ92gZj2swH3q3sv
 nswD4M44uiZ6C3ykPpCHd4ry6UcbzNV1FsqVgkr0WHmc1ffLv+AeDjAxh9jAF0T3
 xEl2zjoElTMTXQ==
X-ME-Sender: <xms:3ymjYFaehn7xWiDpVHFMEbIF9gTRzjZw5t1nOtPAKQKyNHaxp_u8Mg>
 <xme:3ymjYMbK0KSWVKIEdCqaG2wsCeSH6NLPxY5DhopguOugynrtndsu2VIRiOeTBRbuQ
 3eBTkPinsjDH54XTbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:4CmjYH-S_FxSKGrvTFr5LjbYS8qtEgs_SUBdYAS1IPH3WlypPERWcA>
 <xmx:4CmjYDrmH_dQydxk5EO-1Zo-qCEst3kUlGlPa8c0pJxfKxexG9PfFw>
 <xmx:4CmjYArnKKdT_h3shYZL8QcF0RrJ5UuBGM0lugLVpW-M7Nb2BxnvhQ>
 <xmx:4CmjYHTgMxFco4bMZGy9V5Qjr8hFVZpbwGyHXItG1XkFtpCh4tevJQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Mon, 17 May 2021 22:43:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 09/11] ALSA: firewire-lib: code refactoring for jumbo
 payload quirk
Date: Tue, 18 May 2021 11:43:24 +0900
Message-Id: <20210518024326.67576-10-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518024326.67576-1-o-takashi@sakamocchi.jp>
References: <20210518024326.67576-1-o-takashi@sakamocchi.jp>
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

A new macro is added to describe the maximum number of cycles to accept
cycle skip by jumbo payload quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 094c9b2d772f..ba70c8b51907 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -64,6 +64,11 @@
 #define IT_PKT_HEADER_SIZE_CIP		8 // For 2 CIP header.
 #define IT_PKT_HEADER_SIZE_NO_CIP	0 // Nothing.
 
+// The initial firmware of OXFW970 can postpone transmission of packet during finishing
+// asynchronous transaction. This module accepts 5 cycles to skip as maximum to avoid buffer
+// overrun. Actual device can skip more, then this module stops the packet streaming.
+#define IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES	5
+
 static void pcm_period_work(struct work_struct *work);
 
 /**
@@ -316,7 +321,7 @@ unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 	unsigned int cip_header_size = 0;
 
 	if (s->flags & CIP_JUMBO_PAYLOAD)
-		multiplier = 5;
+		multiplier = IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES;
 	if (!(s->flags & CIP_NO_HEADER))
 		cip_header_size = sizeof(__be32) * 2;
 
-- 
2.27.0

