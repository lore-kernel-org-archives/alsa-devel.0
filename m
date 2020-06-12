Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FAC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B179320801
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WTi4PuPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B179320801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tratt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A6741675;
	Fri, 12 Jun 2020 13:18:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A6741675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591960749;
	bh=BzIsKWxCrWi3C8ILcDGQjORvGXyRtog1riCL0CPgeIk=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WTi4PuPa24MluCF8i8JRwbz5zQWj//E5hlj13Rx0uDpQjhpys038kWz+buLYbVVfC
	 5cHm5xI4if96HrWCbxnb6PAWUu6zNGlD7xylRhzY15e2WfOA5IHj4FlK1gw501w4F/
	 3NqH/fwMRn03W7E+Fw44yX84vBvCzw8WQYB9eqzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7B72F800CC;
	Fri, 12 Jun 2020 13:18:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63E84F800CC; Fri, 12 Jun 2020 13:18:17 +0200 (CEST)
Received: from echo.tratt.net (echo.default.edsfctgx.uk0.bigv.io [46.43.3.208])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A223F800CC
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 13:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A223F800CC
Received: by echo.tratt.net (Postfix, from userid 1000)
 id 27B0A65EC; Fri, 12 Jun 2020 12:18:09 +0100 (BST)
Date: Fri, 12 Jun 2020 12:18:07 +0100
From: Laurence Tratt <laurie@tratt.net>
To: alsa-devel@alsa-project.org
Subject: [PATCH] Add implicit feedback quirk for SSL2+.
Message-ID: <20200612111807.dgnig6rwhmsl2bod@overdrive.tratt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This uses the same quirk as the Motu M2 and M4 to ensure the driver uses the
audio interface's clock. Tested on an SSL2+.

Signed-off-by: Laurence Tratt <laurie@tratt.net>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git sound/usb/pcm.c sound/usb/pcm.c
index 8a05dcb13..84c0ae431 100644
--- sound/usb/pcm.c
+++ sound/usb/pcm.c
@@ -367,6 +367,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ifnum = 0;
 		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
+	case USB_ID(0x31e9, 0x0002): /* Solid State Logic SSL2+ */
 		ep = 0x81;
 		ifnum = 2;
 		goto add_sync_ep_from_ifnum;
-- 
2.27.0

