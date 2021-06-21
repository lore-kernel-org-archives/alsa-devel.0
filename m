Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB3AC4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:12:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249A56100B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249A56100B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B82701660;
	Mon, 21 Jun 2021 20:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B82701660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299175;
	bh=WqQ6pXK+BFyXZEVHYpB+27XWUHVs7abhBKg8jXqk6Gg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BKPDVlkK+VavT5NJL//dwb/GIdtwh97yuCNA/fpq+XmvlIEOtO7adHuSVSGObVhGc
	 zm+Sb95YFICxXy+LYAddDcqcY+lBkeEJjwwTT3POHq3AcRNExi58TnAGXOGRnP9D6l
	 iyrxN10GlfUFE8AwO7o7tS8O7AyvtoePlGRcfvKI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6064F80506;
	Mon, 21 Jun 2021 20:09:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 345F6F804FC; Mon, 21 Jun 2021 20:09:34 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A729BF804E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A729BF804E7
Received: by m.b4.vu (Postfix, from userid 1000)
 id 3476361E287D; Tue, 22 Jun 2021 03:39:29 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:29 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/31] ALSA: usb-audio: scarlett2: Reformat
 scarlett2_config_items[]
Message-ID: <512d14eeb3571a266810c954d0f83140a3af7afc.1624294591.git.g@b4.vu>
References: <cover.1624294591.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624294591.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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

Use designated initializers and merge lines in preparation for more
configuration items coming soon.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 40 +++++++++------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index c401b7d56408..4a36181e61ab 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -523,40 +523,20 @@ struct scarlett2_config {
 
 static const struct scarlett2_config
 		scarlett2_config_items[SCARLETT2_CONFIG_COUNT] = {
-	/* Dim/Mute Buttons */
-	{
-		.offset = 0x31,
-		.size = 1,
-		.activate = 2
-	},
+	[SCARLETT2_CONFIG_DIM_MUTE] = {
+		.offset = 0x31, .size = 1, .activate = 2 },
 
-	/* Line Out Volume */
-	{
-		.offset = 0x34,
-		.size = 2,
-		.activate = 1
-	},
+	[SCARLETT2_CONFIG_LINE_OUT_VOLUME] = {
+		.offset = 0x34, .size = 2, .activate = 1 },
 
-	/* SW/HW Volume Switch */
-	{
-		.offset = 0x66,
-		.size = 1,
-		.activate = 3
-	},
+	[SCARLETT2_CONFIG_SW_HW_SWITCH] = {
+		.offset = 0x66, .size = 1, .activate = 3 },
 
-	/* Level Switch */
-	{
-		.offset = 0x7c,
-		.size = 1,
-		.activate = 7
-	},
+	[SCARLETT2_CONFIG_LEVEL_SWITCH] = {
+		.offset = 0x7c, .size = 1, .activate = 7 },
 
-	/* Pad Switch */
-	{
-		.offset = 0x84,
-		.size = 1,
-		.activate = 8
-	}
+	[SCARLETT2_CONFIG_PAD_SWITCH] = {
+		.offset = 0x84, .size = 1, .activate = 8 },
 };
 
 /* proprietary request/response format */
-- 
2.31.1

