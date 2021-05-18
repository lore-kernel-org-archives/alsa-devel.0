Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE79AC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:46:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E676135F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E676135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4650167F;
	Tue, 18 May 2021 04:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4650167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621305968;
	bh=ecXGP7UvcqAeddWVujTRhp5wXlYTu+1U5pTQO+kYzP0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/GubORB5qn/pGr9TPR7ijXoAgNaGFPL+s+ezqAGt5evvBvqMmEJH9YZ9oG1+MzQt
	 qcRl9VmAnKInVvt1vwsw3aRJ6c5hGcvB6HMNeCrdehAkfm2Kz4gRWADol8PbJV5+tB
	 +BYu4869KaXFBgayF2lsE8jFZZjrcZd10L6CyeN4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19BA5F802C8;
	Tue, 18 May 2021 04:43:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11BBFF804A9; Tue, 18 May 2021 04:43:52 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9ADBF8027D
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 04:43:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9ADBF8027D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="N1WUG84U"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="oRXoSO8r"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 11FBB5C00A2;
 Mon, 17 May 2021 22:43:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 17 May 2021 22:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=70ipNRkwOuqh7
 Y/8xTJRyXNS0tI5YWloNgWLpub/Vho=; b=N1WUG84USa8gyywrrCmP5R3qhEZ/C
 5er5AUdye4zTU3L/0GQuoK0Wx5xLLb3gC0mE50xpt6rWbmr2vIAHb9sH+Pr0PC7b
 sI7ZiCGE/A/tMno9Lm4wdkP7p6EmK7L6Ntj/FTL8gGqT4YxLffZiGXUoA0ucSPw6
 HNNh6ATMXkrJLCC7Ecu5TaKIxpGEIhRe2vOXRl/sYzwqcRRXBAr4+HFrAmUrYpQ6
 q8hvTWa62c6gjhtRKMupnl65dcwmiYV+Lu97RPQGh9WmXAzHUgBTtk43Y1/yIsdL
 kJZKB0xAl/p26wS40nUOGtroqa3cM4bmG54uirnkavszIbIvS/NXMcC8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=70ipNRkwOuqh7Y/8xTJRyXNS0tI5YWloNgWLpub/Vho=; b=oRXoSO8r
 pUHOOfF4zFpqm7RsfbLId1AojFtl2yL9poKZB4I3uMNs2d73kXXiDthr60t01JWs
 CIYyG3sHmL1zzUXdtlTBCWRjx7zEENRKchVyeE0nKw8NT6l9/BJdbCe28LpukIl0
 AysBe1FnZ2JWi7s1UnLYbDgtDVAq5CZ8a4yoxBzhYfdq5S01YOXo+1L6QsKB1tyv
 OO0HkyhQxLRETpm0/IxNYIM7oxyz7oTaeylwoyCiDUyTW6xH0lm43l9jOkOxvL+5
 4TRJapM0ISS7VjQx0KdtsuFNbNkyB0hdNrVsonoxvnm2FW7yGWOaP7IDnbqVq7rq
 5ISl7plUJCQeNw==
X-ME-Sender: <xms:2ymjYJ0rG2TywryvhXoam0tVKeWxffk-7g5amxT5lq5fEAaXM7cPUw>
 <xme:2ymjYAG8cqtjb9KIkIIf90z1Et_3nr3u9xzoL44TfyCwSjSYej0shuwfAUPt1y9iK
 fRgSFoPpaYAkg9kf_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:2ymjYJ5KDzsgeQwHN0lC20Fc_IKezel9fdIfa4KTJlmc6cjXLopnww>
 <xmx:2ymjYG0lGPX7aGd8XjRsXuO2GyAmcXgxokrGDtDXDcYnRHTJm6HoUQ>
 <xmx:2ymjYMGhp0_ZGsdIp9rZX7uuR993AhZQFMOTSOfP3ArwWvm69Raq-Q>
 <xmx:3CmjYHPdcy-bYGTPQdDlFkkwiiuFyyRCR_dGp0ps9E4_0wPP6uapbQ>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Mon, 17 May 2021 22:43:38 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 06/11] ALSA: oxfw: add explicit device entry for Loud
 Technologies Mackie Onyx Sattelite
Date: Tue, 18 May 2021 11:43:21 +0900
Message-Id: <20210518024326.67576-7-o-takashi@sakamocchi.jp>
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

Loud Technologies Mackie Onyx Satellite is identified as the model with
OXFW970 ASIC.

This commit adds explicit entry for the model.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 998f0da6fd5b..e851149c5280 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -46,7 +46,6 @@ static bool detect_loud_models(struct fw_unit *unit)
 		"Onyx-i",
 		"Onyx 1640i",
 		"d.Pro",
-		"Mackie Onyx Satellite",
 		"U.420"};
 	char model[32];
 	int err;
@@ -339,15 +338,14 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 	OXFW_DEV_ENTRY(VENDOR_BEHRINGER, 0x00fc22, NULL),
 	// Loud Technologies, Tapco Link.FireWire 4x6.
 	OXFW_DEV_ENTRY(VENDOR_LOUD, 0x000460, NULL),
-	/*
-	 * Any Mackie(Loud) models (name string/model id):
-	 *  Onyx-i series (former models):	0x081216
-	 *  Onyx 1640i:				0x001640
-	 *  Mackie Onyx Satellite:		0x00200f
-	 *  d.2 pro/d.4 pro (built-in card):	Unknown
-	 *  U.420:				Unknown
-	 *  U.420d:				Unknown
-	 */
+	// Loud Technologies, Mackie Onyx Satellite.
+	OXFW_DEV_ENTRY(VENDOR_LOUD, MODEL_SATELLITE, NULL),
+	// Any Mackie(Loud) models (name string/model id):
+	//  Onyx-i series (former models):	0x081216
+	//  Onyx 1640i:				0x001640
+	//  d.2 pro/d.4 pro (built-in card):	Unknown
+	//  U.420:				Unknown
+	//  U.420d:				Unknown
 	{
 		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
 				  IEEE1394_MATCH_SPECIFIER_ID |
-- 
2.27.0

