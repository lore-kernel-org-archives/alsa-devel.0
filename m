Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CA4C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:22:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DC2606A5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DC2606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02F8B1766;
	Mon, 21 Jun 2021 20:21:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02F8B1766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299719;
	bh=UItnPYGUolNuGmYbIDxBXVsFgRh61lrWm3cGWmYIdTQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fBWQPCwY1VtPOzMklwP6lS574pvtncXYsa1bzY5KhyBSxD+JEESGir+lJaCmck9oq
	 ZdjThzPj67QYjo75nUSJqTkQZ5cVL0Aak1D4dGwYziJ28ejdWC89VAtApRrw0QblqK
	 verwQ+8SVgfh/9qciP52yrFPnxkYdoyOrmXZwTjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42159F805EF;
	Mon, 21 Jun 2021 20:10:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71030F805E3; Mon, 21 Jun 2021 20:10:24 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDF4FF805BB
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:10:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDF4FF805BB
Received: by m.b4.vu (Postfix, from userid 1000)
 id 789D861E5F02; Tue, 22 Jun 2021 03:40:13 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:40:13 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/31] ALSA: usb-audio: scarlett2: Update get_config to do
 endian conversion
Message-ID: <0d62f5e413be817b89ce7e7fbd18758cfc0306b8.1624294591.git.g@b4.vu>
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

For configuration items with a size of 16, scarlett2_usb_get_config()
was filling *buf with little-endian data. Update it to convert to CPU
endian. This function is not currently used so affects nothing yet;
will be used by the upcoming talkback feature.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index dc5fd045b2dc..8fd850f6aa6e 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1170,7 +1170,13 @@ static int scarlett2_usb_get_config(
 	/* For byte-sized parameters, retrieve directly into buf */
 	if (config_item->size >= 8) {
 		size = config_item->size / 8 * count;
-		return scarlett2_usb_get(mixer, config_item->offset, buf, size);
+		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
+		if (err < 0)
+			return err;
+		if (size == 2)
+			for (i = 0; i < count; i++, (u16 *)buf++)
+				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
+		return 0;
 	}
 
 	/* For bit-sized parameters, retrieve into value */
-- 
2.31.1

