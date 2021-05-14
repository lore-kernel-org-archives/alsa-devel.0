Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA76C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:57:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCFF613DF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 08:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCFF613DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E53917A8;
	Fri, 14 May 2021 10:56:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E53917A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620982633;
	bh=t3fn906uW0x3mdeRqeXkU2BAWVGUnVb45BUi9beKtz4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C8pBptoNm2dYrGp/Ue5ND7wOy38wra8drpkQG0I2NUAtqTCgKQqIdiOML5dJlgEl+
	 3c+IZ6PQsq9vX3pe9PDaha5BvmWCWuEnMrRtqBVH0+wmFWpX//DFV2/UpuyV3m70vH
	 0aIBuLWEBvA+Z0ZwdM9M0DD5b04lCqrNQBJ5O4VY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10214F80430;
	Fri, 14 May 2021 10:54:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1635FF80425; Fri, 14 May 2021 10:54:54 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1657FF8026B
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 10:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1657FF8026B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="PNqYM2Tu"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="lzHHXagn"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 0913E5C0068;
 Fri, 14 May 2021 04:54:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 14 May 2021 04:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=Wf5rma3SMUvAD
 alJhseJNErXEEXoqx0IQmaLa6jcejk=; b=PNqYM2TumGLMc4FaY1NiqrZJtRjPV
 AVxPTJ6tJXLcnFNJm7UJNwv3A6cpHFPAHxCySqTjWVCC9Bh3pEu8Hhj9WgxOyX14
 2PpC4asteBOPc20fTAHOd3B8kizM5dIlh67mZkhLOfn60hWVJhNsjsqp/LVTLA0E
 wnpy2QOvayUxKqDinM9XPzrGre9qFcqpgikPX9bATLd1rbkIOUvvIUYovdkdygf0
 uyPqJjWUxqpaJW5EZxKrJ1w1EZVgx9C8uogpcq0I/Mz7ay0+E1c+1ttlq/O5Bf0Z
 KVeIVdvMzWVSRhVpzlS8RW7e0IycHr9bnzHx7bK6xiENAMqbn9lISXxqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=Wf5rma3SMUvADalJhseJNErXEEXoqx0IQmaLa6jcejk=; b=lzHHXagn
 CorGvOmbJ8TVUg5PUfJ8dxP0F/LMhh5/+UKAVKErodn/DfaU4dd48nDOb1lAhtzm
 37SWJ7FlanSrZYK3OqyaLGLrZS+1ErQUyee2wxqFlHztk/kMvFBbupLr9XZDuYaw
 kKyR7VRbEBk2lHonVxCOV2PqpT0hLJ1u52zoSVQ8nXkl3aXwa2InQADkp8YvDDkL
 WWGETi6UOYujov2TuWUq3UenAU+Y6PQMCKek1EikDWSPwWI5nY4wVkVgLiR9CV77
 cwHo+1yuhzRX+dHj8r+fYpNWoH6SLxLNrs8s4GjNw9Qyd/KoMtR+a1uJJqLc9gwE
 QgqoWqfKn10wbA==
X-ME-Sender: <xms:1DqeYOzT0ZVA-9SYh7XPCLjtjKGI39KZ-m0OsHJFsmQLPkhzY4cirQ>
 <xme:1DqeYKRfQ5wLyvN44Otsvf1zWmATz2LGqjgVHmA62crRktqVsTMBFGbgJfl3s7CPu
 MYA_M1bPrMZiRw2bmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehhedgudefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
 rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
 ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucfkphepudeg
 rdefrdeihedrudejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:1DqeYAVpLWsY91AsbFkjwvgVQCWSauv5fQBZUCvTeN9sefdDX3TDLQ>
 <xmx:1DqeYEihL9oBMt5Rmq50AFSTfwG8F1CDuip9oU87kKjNaa87KnpMMw>
 <xmx:1DqeYAAg0gs9JYqEma7tb5FPDOLkwMU_YA4SbifsXPMtnHba4k0slA>
 <xmx:1TqeYLrBGnY2c5qUrtDdj4ONv3t-Pjv-OTnXu_skGZhuXKHdEEVw5w>
Received: from workstation.flets-east.jp (ae065175.dynamic.ppp.asahi-net.or.jp
 [14.3.65.175]) by mail.messagingengine.com (Postfix) with ESMTPA;
 Fri, 14 May 2021 04:54:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Subject: [PATCH 3/7] ALSA: oxfw: add explicit device entry for Loud
 Technologies Mackie Onyx Sattelite
Date: Fri, 14 May 2021 17:54:31 +0900
Message-Id: <20210514085435.92807-4-o-takashi@sakamocchi.jp>
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

Loud Technologies Mackie Onyx Satellite is identified as the model with
OXFW970 ASIC.

This commit adds explicit entry for the model.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 21b30ca355c9..b1596b1fecfd 100644
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
@@ -339,14 +338,13 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 	OXFW_DEV_ENTRY(VENDOR_BEHRINGER, 0x00fc22, NULL),
 	// Loud Technologies, Tapco Link.FireWire 4x6.
 	OXFW_DEV_ENTRY(VENDOR_LOUD, 0x000460, NULL),
-	/*
-	 * Any Mackie(Loud) models (name string/model id):
-	 *  Onyx-i series (former models):	0x081216
-	 *  Mackie Onyx Satellite:		0x00200f
-	 *  d.4 pro:				Unknown
-	 *  U.420:				Unknown
-	 *  U.420d:				Unknown
-	 */
+	// Loud Technologies, Mackie Onyx Satellite.
+	OXFW_DEV_ENTRY(VENDOR_LOUD, MODEL_SATELLITE, NULL),
+	// Any Mackie(Loud) models (name string/model id):
+	//  Onyx-i series (former models):	0x081216
+	//  d.4 pro:				Unknown
+	//  U.420:				Unknown
+	//  U.420d:				Unknown
 	{
 		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
 				  IEEE1394_MATCH_SPECIFIER_ID |
-- 
2.27.0

