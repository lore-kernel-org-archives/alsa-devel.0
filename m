Return-Path: <SRS0=bp7U=KK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54126C433B4
	for <alsa-devel@archiver.kernel.org>; Sat, 15 May 2021 07:14:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2113613CA
	for <alsa-devel@archiver.kernel.org>; Sat, 15 May 2021 07:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2113613CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C78C173B;
	Sat, 15 May 2021 09:14:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C78C173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621062890;
	bh=dExvVoTGLf7U1Y9k+Y0xTSfVZ05c68Ggl5QdIFAnYRc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SgJPe+Cixb820kSyxryumhLzrf/7ptovTL3C0TEF4Yyrx9IyeVYIOiAdJAWMnvMjW
	 HdkOMvakmaBCmPHH0ud4+8q3wyvxLp5bQNQODfLOC27fS4U+0ukyV8YeyPiTpdhOHB
	 /go+7dC2GCI5FCNJV/8TcYfrzWiURejQKcnCy88M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C704DF804BD;
	Sat, 15 May 2021 09:11:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD04EF804AB; Sat, 15 May 2021 09:11:33 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35FACF802D2
 for <alsa-devel@alsa-project.org>; Sat, 15 May 2021 09:11:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35FACF802D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="rSYwig5u"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="vrkV8jJk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 758555C011D;
 Sat, 15 May 2021 03:11:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sat, 15 May 2021 03:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=Y7Op8L2qKUKtq
 pgpfwBcp5vvU/wt/qoca6pUELYbLoY=; b=rSYwig5u49+OU8KdsZKc/hlExv5Gd
 AaqrC5VJjo23nWTdiShOf1NSjYs7/c90WVisnbQRtrgofaNrK1fEW+X0zClerj43
 j19mZkXP8TGk5qiycuhVE1SllJHJqYNjdb7ym6qnOGoHu0BjiojQT0Chj2tV3M27
 PbAqKAPqRuXfCobrUKxmvV99/KXk3Fh+e7EYsaGNBd0ft8xj5g7OhW1NasIpKXEo
 KNCsvmj4kgxYoti3li7GF+UeO/APVfB4J3JxtSCD+PxGR5vycopRdJP2JfgRtFbA
 aEGlPkHk0ATVBpbKLIV80p4Nkmkva0KNEmOofYxE25UKNmnrkpHkOc8sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=Y7Op8L2qKUKtqpgpfwBcp5vvU/wt/qoca6pUELYbLoY=; b=vrkV8jJk
 L1iauG7M79tiAU0yG6Kr1arfiShRRaClz1hjC2pGEhS7+zLTdjhLZEprxCQq8rCz
 JlpYxnhIcBBxxkl0arfsNghhTtpESy21+iiyWwkjHw0ZZuZNmiThAuACKLKdeBCC
 Yc8x2ig2HT+migWmPGeNKHykIM1fHzHzlOmRD+seXbLDPsSxDVyrLplbtRyf7eLp
 OJFFoZh2Ajxns7MOioJZdkZ5fJkpMJC56bEpIN1V1ye/Pz+dFCkoIR2y5/mSwPV1
 K/rbr6/GiW10fJfKnCOsnX74BEJlTI9rYZ9PkyJqQwsyen/kBe2T8+09rR0RzpPS
 tqqmgEYrnpw+lA==
X-ME-Sender: <xms:HXSfYPhlAsjnCzIEIaq322aaNeIT2qMHZ7U9u52PhgS1JPttVoBFJA>
 <xme:HXSfYMBWOKmhLTSpVhg4LvdMVErBIVTdxTwhnWEdiXQKR7R2r18DEKfR7-aU94TLd
 S18Pw8AP6xVnlkVj9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehledguddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:HXSfYPHHTRtq4mHuOAUyj79yyYu0mSoxBznW9qOzTSSZmN8KcqwW5A>
 <xmx:HXSfYMQT0BYNeGhd-QOWCQBddyuzP9a55947jdgUHdMfTNhSSUoqEg>
 <xmx:HXSfYMxGThVzqoH9Nfqn1401hWU7pNmEdXcwP0VaPG8F3TchKrdiTw>
 <xmx:HXSfYCaSV5GTwGiueMslrC53YyoQ7zZSwUObczNOsNyfIQ9w69QyFA>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Sat, 15 May 2021 03:11:24 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v2 06/10] ALSA: oxfw: add comment for the type of ASICs
Date: Sat, 15 May 2021 16:11:08 +0900
Message-Id: <20210515071112.101535-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210515071112.101535-1-o-takashi@sakamocchi.jp>
References: <20210515071112.101535-1-o-takashi@sakamocchi.jp>
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

ALSA OXFW supports two types of ASICS; OXFW970 and OXFW971. The former
is known to have a quirk we call 'jumbo payload' that some isochronous
cycles are skipped to transfer isochronous packets during handling
asynchronous transaction. The quirk seems to correspond to firmware
initially delivered by Oxford Semiconductor since the quirk is not
confirmed for Mackie Onyx Satellite in which the revised firmware is
available. The quirk is not confirmed in the latter.

This commit adds code comment to describe the quirk.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index e851149c5280..9a9c84bc811a 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -332,14 +332,30 @@ static const struct compat_info lacie_speakers = {
 }
 
 static const struct ieee1394_device_id oxfw_id_table[] = {
+	//
+	// OXFW970 devices:
+	// Initial firmware has a quirk to postpone isoc packet transmission during finishing async
+	// transaction. As a result, several isochronous cycles are skipped to transfer the packets
+	// and the audio data frames which should have been transferred during the cycles are put
+	// into packet at the first isoc cycle after the postpone. Furthermore, the value of SYT
+	// field in CIP header is not reliable as synchronization timing,
+	//
 	OXFW_DEV_ENTRY(VENDOR_GRIFFIN, 0x00f970, &griffin_firewave),
 	OXFW_DEV_ENTRY(VENDOR_LACIE, 0x00f970, &lacie_speakers),
-	// Behringer,F-Control Audio 202.
+	// Behringer,F-Control Audio 202. The value of SYT field is not reliable at all.
 	OXFW_DEV_ENTRY(VENDOR_BEHRINGER, 0x00fc22, NULL),
-	// Loud Technologies, Tapco Link.FireWire 4x6.
+	// Loud Technologies, Tapco Link.FireWire 4x6. The value of SYT field is always 0xffff.
 	OXFW_DEV_ENTRY(VENDOR_LOUD, 0x000460, NULL),
-	// Loud Technologies, Mackie Onyx Satellite.
+	// Loud Technologies, Mackie Onyx Satellite. Although revised version of firmware is
+	// installed to avoid the postpone, the value of SYT field is always 0xffff.
 	OXFW_DEV_ENTRY(VENDOR_LOUD, MODEL_SATELLITE, NULL),
+	// Miglia HarmonyAudio. Not yet identified.
+
+	//
+	// OXFW971 devices:
+	// The value of SYT field in CIP header is enough reliable. Both of blocking and non-blocking
+	// transmission methods are available.
+	//
 	// Any Mackie(Loud) models (name string/model id):
 	//  Onyx-i series (former models):	0x081216
 	//  Onyx 1640i:				0x001640
-- 
2.27.0

