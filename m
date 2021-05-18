Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF315C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:46:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DF06008E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 02:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DF06008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D46A1690;
	Tue, 18 May 2021 04:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D46A1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621306002;
	bh=K2QTJ7PWAmZz2pe8j3TlXJ5eUB6PUhhTPsN4IKE+lro=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EONbg1q++t98FI7C3WpkHTFrnrPpxVkkwnL4d9NtmBTKtQgiLKyV8xdjHtdo7I7yG
	 svfmXx9L3Y1TJigByCXWye9pSKM7sjBo3tjmkiXxqK3Z8QA3eYtJDGKXcMoakfeKuV
	 sSNndxCH0hb8HP65rP4/rs1ps/iw9FLPlcY5HMoQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C21B9F804AF;
	Tue, 18 May 2021 04:44:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 702B2F8014C; Tue, 18 May 2021 04:43:53 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1EB6F80229
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 04:43:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1EB6F80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="MW7Q8mEZ"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="cI/6GmI1"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 0321C5C0136;
 Mon, 17 May 2021 22:43:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 17 May 2021 22:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=z2h4iAd5kIIH1
 zEvRUhiZCQqxbScmElaaiMxsPYF/Pc=; b=MW7Q8mEZfLCF0pLIZzPBjepKUPr81
 YS3pdav6o7sWb9XhR713aXQW/e1cSXm8GDF0M5m978CDMrKebWTTnZvnX0lfjbIb
 /26soZIsBpXS4ulmCl5JQ+yAj94j2+03AWs3pJdSEiWeo4nq7KcmHmPDHZiWzn+t
 bkqbrUaU9dSUYB4rk5CufKyL9/40rg34jQGaUAN+1p8Z05ygPGVdtTtsrbwnuxcB
 JmYVSJnouKk0Wnojn0schZlvTjsNtRbLNPUzQQJFOCfognLUq2UXhLJK0fP+yF9L
 OQJKzTVKoa8rTsvUdqjnMr7zq9QTNXn+Jj5ikC0zUWnIPrr+wTwhWFnjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=z2h4iAd5kIIH1zEvRUhiZCQqxbScmElaaiMxsPYF/Pc=; b=cI/6GmI1
 4S7X35A6P/mVE/CK4CNM+EjgQq+1SOd0iJrnwJkntCH5PFbTOhuUang1BHZJO8lS
 q2PvArlMqk13ssMSPqXHlYg2n5SR9vxYRa3dK4sDiM5dn4hL8KSPrRtOmMRQOWe1
 rWujVXNXvsRIDSs/XpglVh2XkYSVUNjeBlPJ+iw8z29VSJCONH6XTcQ1UBN/Y1L/
 VFTj31kS238Fjp80+DruEmKjH1OrVmKRA0QdVSXKvh9WWSq8DntquGS9DF2/pWyU
 NYmApJyfmfLGBNB4dsPWwkvOLtUy3CrQhEsWQAU5ZjxLQ9z7pjY+ph1Bqv+dmRKy
 2z8L7Hi0M0FZFA==
X-ME-Sender: <xms:1ymjYH4jUdL0xYI64WyqmC-HI-4sp84k4owXXt4GQJOUDShA-JyqgQ>
 <xme:1ymjYM5sjbYIvQ0tlEN6Eq65q8UIs385XgST_I7SYrGRpBS2LFzcuuexXDZ8K06mB
 8d-yiEtvV7kdrwY5Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:1ymjYOe_QLMtypDxsIu66a0wyI9z0Ce86nWYTOWrEBN69REd72FXMQ>
 <xmx:1ymjYIKr0v44Et-V5vCR0GjaEh813p0nJ5ZT-m02sGE4udfvh3uxNA>
 <xmx:1ymjYLKW5dmUsm4kgh34C75CuHuQy3u7s71D46A8FfkycsrJ5-70MA>
 <xmx:1ymjYNxSObDQ2jZD9_dtSXCBt0AkpeAukuorLzOpjqpOyp0-xSGvRA>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Mon, 17 May 2021 22:43:34 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v3 03/11] ALSA: oxfw: code refactoring for existent device
 entry with specifier_id and version
Date: Tue, 18 May 2021 11:43:18 +0900
Message-Id: <20210518024326.67576-4-o-takashi@sakamocchi.jp>
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

All of the devices known to be based on OXFW ASICs have the same layout
of configuration ROM, in which unit directory includes vendor, model,
specifier_id and version immediate values. Especially, the pair of
specifier_id and version is fixed to represent AV/C general protocol.

This commit refactors device entries to fulfil with these 4 elements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 82 ++++++++++++--------------------------
 1 file changed, 25 insertions(+), 57 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 5490637d278a..7be999c61730 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -320,36 +320,24 @@ static const struct compat_info lacie_speakers = {
 	.model_name = "FireWire Speakers",
 };
 
+#define OXFW_DEV_ENTRY(vendor, model, data) \
+{ \
+	.match_flags  = IEEE1394_MATCH_VENDOR_ID | \
+			IEEE1394_MATCH_MODEL_ID | \
+			IEEE1394_MATCH_SPECIFIER_ID | \
+			IEEE1394_MATCH_VERSION, \
+	.vendor_id    = vendor, \
+	.model_id     = model, \
+	.specifier_id = SPECIFIER_1394TA, \
+	.version      = VERSION_AVC, \
+	.driver_data  = (kernel_ulong_t)data, \
+}
+
 static const struct ieee1394_device_id oxfw_id_table[] = {
-	{
-		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
-				IEEE1394_MATCH_MODEL_ID |
-				IEEE1394_MATCH_SPECIFIER_ID |
-				IEEE1394_MATCH_VERSION,
-		.vendor_id    = VENDOR_GRIFFIN,
-		.model_id     = 0x00f970,
-		.specifier_id = SPECIFIER_1394TA,
-		.version      = VERSION_AVC,
-		.driver_data  = (kernel_ulong_t)&griffin_firewave,
-	},
-	{
-		.match_flags  = IEEE1394_MATCH_VENDOR_ID |
-				IEEE1394_MATCH_MODEL_ID |
-				IEEE1394_MATCH_SPECIFIER_ID |
-				IEEE1394_MATCH_VERSION,
-		.vendor_id    = VENDOR_LACIE,
-		.model_id     = 0x00f970,
-		.specifier_id = SPECIFIER_1394TA,
-		.version      = VERSION_AVC,
-		.driver_data  = (kernel_ulong_t)&lacie_speakers,
-	},
-	/* Behringer,F-Control Audio 202 */
-	{
-		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_MODEL_ID,
-		.vendor_id	= VENDOR_BEHRINGER,
-		.model_id	= 0x00fc22,
-	},
+	OXFW_DEV_ENTRY(VENDOR_GRIFFIN, 0x00f970, &griffin_firewave),
+	OXFW_DEV_ENTRY(VENDOR_LACIE, 0x00f970, &lacie_speakers),
+	// Behringer,F-Control Audio 202.
+	OXFW_DEV_ENTRY(VENDOR_BEHRINGER, 0x00fc22, NULL),
 	/*
 	 * Any Mackie(Loud) models (name string/model id):
 	 *  Onyx-i series (former models):	0x081216
@@ -367,34 +355,14 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.specifier_id	= SPECIFIER_1394TA,
 		.version	= VERSION_AVC,
 	},
-	/* TASCAM, FireOne */
-	{
-		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_MODEL_ID,
-		.vendor_id	= VENDOR_TASCAM,
-		.model_id	= 0x800007,
-	},
-	/* Stanton, Stanton Controllers & Systems 1 Mixer (SCS.1m) */
-	{
-		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_MODEL_ID,
-		.vendor_id	= OUI_STANTON,
-		.model_id	= 0x001000,
-	},
-	/* Stanton, Stanton Controllers & Systems 1 Deck (SCS.1d) */
-	{
-		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_MODEL_ID,
-		.vendor_id	= OUI_STANTON,
-		.model_id	= 0x002000,
-	},
-	// APOGEE, duet FireWire
-	{
-		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
-				  IEEE1394_MATCH_MODEL_ID,
-		.vendor_id	= OUI_APOGEE,
-		.model_id	= 0x01dddd,
-	},
+	// TASCAM, FireOne.
+	OXFW_DEV_ENTRY(VENDOR_TASCAM, 0x800007, NULL),
+	// Stanton, Stanton Controllers & Systems 1 Mixer (SCS.1m).
+	OXFW_DEV_ENTRY(OUI_STANTON, 0x001000, NULL),
+	// Stanton, Stanton Controllers & Systems 1 Deck (SCS.1d).
+	OXFW_DEV_ENTRY(OUI_STANTON, 0x002000, NULL),
+	// APOGEE, duet FireWire.
+	OXFW_DEV_ENTRY(OUI_APOGEE, 0x01dddd, NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
2.27.0

