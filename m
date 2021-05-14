Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C0C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:57:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0CF613DF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0CF613DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3457B1799;
	Fri, 14 May 2021 10:56:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3457B1799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620982646;
	bh=Scs6hNqc7vCIq5u6xNEyY9chW8xRM13WV2TiSaXzSFc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FezxKmISG4yF7t5IfrUlcVi4dS2s7pOJ5OexJer0dCYEzwaJqJS4G6Rd5WwkpG92f
	 kdYzupdqtEIKl0ekyNy07oQRTEA2TOD3JrIl1hSJZOPXrt+dmxgj8HS7AwTE+TXwq7
	 z+Y7uTQ/x5dBabv6tX1vIc851EmI2v/+7jsSlXHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE724F8049C;
	Fri, 14 May 2021 10:54:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EC3CF80430; Fri, 14 May 2021 10:54:54 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1641CF800BF
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 10:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1641CF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="z12EBTOe"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="B7+p1u4h"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id AC18F5C016C;
 Fri, 14 May 2021 04:54:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 14 May 2021 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=VMa8zmtT0qib8
 pZrc9gTED7LWQoqSfhkNYxLRgHzitY=; b=z12EBTOeK/1v+izzk0vSYh5lZobJ3
 x5ZIve1uc8oOm+HaK/zg61d0S87waihFe9EZBhp5KwQmLMrfaA89hXskNilYzOGJ
 GckHsVxgcnjcod+ajqA+3nlBFGFK9W6LEUUJMVcZzlcTn4VF5wjC37SN2o7/dx8h
 A2gNknXlf2aVVWdnxxNQy+y8u1UP+9ClFc3eSRcKgcfRIDoYiptaG7DtDNy0Ytia
 ilYHGlSIDmA++8U19lqVT8hw432AAJP2aoUVaqjU5HkfLo8LRSHJXnnA5jlpDxG1
 YMfsE9FcRnZer+cY0nAYNEnQJmTs2dqfOe2sGuthZsJkSUsKmhMnBEQ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=VMa8zmtT0qib8pZrc9gTED7LWQoqSfhkNYxLRgHzitY=; b=B7+p1u4h
 7UKCJRR7TBtQpv/BPtzkNzXuJcHdtT1Yj0CIofhijSsp/rAiT7XLst16c/LnalGn
 g2RvdmAyjBx+o3D6Vomtq4QktHBwT6X7WGvpr61mVQ0ZOwP9Ch6/4jrrazZtUmUa
 Hu0clDnt4qW6NvtcsK9Q3/N6b9O/CJtHqnJ1oaJIpOiyFe8l+4CNXuu6iLkl+NDv
 zLQXR6rFy262GxnBd8WBkjSXh/t2yjXOwW6YcEwA1AhdUgVrz0p57dOuzeceO8Vx
 lNTv35gLzLvE0vn7SJ+fLwXIX2idzUFb27bnqoomyXAWcZqReZde887zh2ZsXow4
 UaZDPaXW7PcCXg==
X-ME-Sender: <xms:0jqeYP_vhNvhQ3wsondze81-PQIcLK9Ng3-6HEsQgJg0oNDRDW0bxQ>
 <xme:0jqeYLtlQ5BvCtW69zHv6dSw7HGIULdeab8CtkLQZkiDszAi6kSU3dqkfE8k074cr
 dpDtwwqOUjw4BsaLGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgudefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudeg
 rdefrdeihedrudejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:0jqeYNCq3ONy0qfazU9WmEkJ2pWrIHL0vCSZAwjJ6S8tWu-MqGWt-Q>
 <xmx:0jqeYLcGD2PApDNB0CzrFIeXLqFd1wOr6lN9phgxyH7mAUEtul6s8w>
 <xmx:0jqeYEMKZsxT0f2A7d6DgVQUmEeLctlsrjXvKHD85GVq-HrtrFfihQ>
 <xmx:0zqeYOVR5nUc0OD9EiE-bpUrFJzUjbmM81AyFfYpJ7wpC5dMA8ooNg>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 14 May 2021 04:54:41 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 2/7] ALSA: oxfw: add device entry for Loud Technologies Tapco
 Link.FireWire 4x6
Date: Fri, 14 May 2021 17:54:30 +0900
Message-Id: <20210514085435.92807-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210514085435.92807-1-o-takashi@sakamocchi.jp>
References: <20210514085435.92807-1-o-takashi@sakamocchi.jp>
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

Loud Technologies Tapco Link.FireWire 4x6 is identified as the model
with OXFW970 ASIC.

This commit adds explicit entry for the model.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index f01c8bfd71cc..21b30ca355c9 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -47,7 +47,6 @@ static bool detect_loud_models(struct fw_unit *unit)
 		"Onyx 1640i",
 		"d.Pro",
 		"Mackie Onyx Satellite",
-		"Tapco LINK.firewire 4x6",
 		"U.420"};
 	char model[32];
 	int err;
@@ -338,11 +337,12 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 	OXFW_DEV_ENTRY(VENDOR_LACIE, 0x00f970, &lacie_speakers),
 	// Behringer,F-Control Audio 202.
 	OXFW_DEV_ENTRY(VENDOR_BEHRINGER, 0x00fc22, NULL),
+	// Loud Technologies, Tapco Link.FireWire 4x6.
+	OXFW_DEV_ENTRY(VENDOR_LOUD, 0x000460, NULL),
 	/*
 	 * Any Mackie(Loud) models (name string/model id):
 	 *  Onyx-i series (former models):	0x081216
 	 *  Mackie Onyx Satellite:		0x00200f
-	 *  Tapco LINK.firewire 4x6:		0x000460
 	 *  d.4 pro:				Unknown
 	 *  U.420:				Unknown
 	 *  U.420d:				Unknown
-- 
2.27.0

