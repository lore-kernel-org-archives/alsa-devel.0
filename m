Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D1C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:48:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14976100A
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14976100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5701816DD;
	Tue, 18 May 2021 10:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5701816DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621327710;
	bh=8ayjLbVWf3C8BGPZC60BiLFPymypO7X5DbaciqOP0y4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cgdQ7M5f551x2dN6g/e/RmFGv3if2GPsSfoVNSqbkzzxtLVM9MEedB7zK3ZgR0stA
	 RHH0Uzhn6VRveaBDZwcmGE70QcW8FW4aD70IV2LIMJJkfv958ouJIF3xM/WIPiHTW/
	 xLynea+0NCZwfnlqbdkycH/UvMWixcEmxIWm6x24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EB42F80475;
	Tue, 18 May 2021 10:46:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C0F6F80272; Tue, 18 May 2021 10:46:13 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71E1AF80272
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 10:46:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71E1AF80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="yMvkX64I"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="H45e/KsZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id A8F625C00A4;
 Tue, 18 May 2021 04:46:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 18 May 2021 04:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=yy4KErEXtjHja
 I46tRlfO8xAp9Q7omE53IZRt+oG4NI=; b=yMvkX64I/5qqw131lUsutIuYNmb57
 ZHWu6tmq0jfdHHOIc43HkZeBE3qLV9wmUlMThaOwVCcuxsblER/Kg5auyKmZBCvb
 8cOZi8lq77Re/bITEQe/TpzL0h5T4yYjgy8jKj2Y33IJu5oJWDS5SbeH+HyI9siD
 HVdMBYwTgp+MJzXgyXt4W0UG1uCcbQGrOgwNyhP9JazH74XbMkM1vGH+3NzHbupR
 HFLonQsUAYqcTR1oOJS6moNvDyVo7iTewkhkS2Idqo8qhT56xmhFaWIWG+uhQFSq
 4wt4PGeqZ540AJsD8IrHoRrY2XdnBSFUXc9xT9sPa+c/p2in5Bsi278ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=yy4KErEXtjHjaI46tRlfO8xAp9Q7omE53IZRt+oG4NI=; b=H45e/KsZ
 MW3l57CrSCyDRITbGFZ7YDH8EqjoKWcDQE9DQl6OzuRx0zI9iFRp8HYHL65Q6D66
 NcN3bYMDpvKaNSSArMpujBdrCHmYZ5WMQ5dDbcIX/1a+jWBHWQGKjIYdREoWg8ot
 4u1FYvboMns5zeIpcIPeWO2zxPJu51CZ5yYTHMBuCdF/Z+bb4b2nEfR3fhIj826h
 snQT2ELhQ2wA0nDFhza34iloHdc9AkWV6MPg4VSeRsDHjmE660PFmL+ti2Mu2OdV
 kp4QBWTmwJ2A0+eHdQaPdHZDU1h5XUY4LqH9SHkQEHEyi0+8fb9hoqqykwXxBhgj
 +JhEs2qk0bZKDg==
X-ME-Sender: <xms:z36jYFs_5ZKbRtykYthzFncEncrHpISsTU8eAUO_lgDIVMEqVp7ddQ>
 <xme:z36jYOfXYRxl717LYf1KVV3YbC6i_qifa2tHFRxttcpeqQpmLjgsdb8PlKW3138JW
 xrV9i9GOFwrwG7d7cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgtdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
 etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:z36jYIzP9k_VvZLwEzegx0LzWsRyIJsX0_W91UPnOX56Tz8bYFuBQA>
 <xmx:z36jYMOSgczhA6Ey8pPz_sdFI8ANw6R5yVUDBa2MENlYyC6Ukq8z9A>
 <xmx:z36jYF9zDh9w_9s5lQJC1at03fCbp-cYNCOJOFW9ygdT0XUPDanktg>
 <xmx:z36jYCHSQbU2QGIug5fY5qXO3AoTC204GRK2LFfZ0kEKbhoHojKFHw>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Tue, 18 May 2021 04:46:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH v4 04/11] ALSA: oxfw: code refactoring to detect mackie models
Date: Tue, 18 May 2021 17:45:50 +0900
Message-Id: <20210518084557.102681-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518084557.102681-1-o-takashi@sakamocchi.jp>
References: <20210518084557.102681-1-o-takashi@sakamocchi.jp>
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

This commit changes condition statement to call mackie models detection
just for the device entry. Additionally, comment is added for Onyx 1640i.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 7be999c61730..2af72951ebf8 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -245,7 +245,7 @@ static int oxfw_probe(struct fw_unit *unit,
 {
 	struct snd_oxfw *oxfw;
 
-	if (entry->vendor_id == VENDOR_LOUD && !detect_loud_models(unit))
+	if (entry->vendor_id == VENDOR_LOUD && entry->model_id == 0 && !detect_loud_models(unit))
 		return -ENODEV;
 
 	/* Allocate this independent of sound card instance. */
@@ -341,6 +341,7 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 	/*
 	 * Any Mackie(Loud) models (name string/model id):
 	 *  Onyx-i series (former models):	0x081216
+	 *  Onyx 1640i:				0x001640
 	 *  Mackie Onyx Satellite:		0x00200f
 	 *  Tapco LINK.firewire 4x6:		0x000460
 	 *  d.2 pro/d.4 pro (built-in card):	Unknown
@@ -352,6 +353,7 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 				  IEEE1394_MATCH_SPECIFIER_ID |
 				  IEEE1394_MATCH_VERSION,
 		.vendor_id	= VENDOR_LOUD,
+		.model_id	= 0,
 		.specifier_id	= SPECIFIER_1394TA,
 		.version	= VERSION_AVC,
 	},
-- 
2.27.0

