Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41495C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:50:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E186B206D7
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="prGSEPCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E186B206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tratt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67B421691;
	Tue, 16 Jun 2020 09:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67B421691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592293857;
	bh=1vzoz3y37Zkrh3RaOWmpw8E1d80b8koKdoCiey0P3ig=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=prGSEPCbLF3jZXNaRAtkWhiWZ3KW5Tbs7l9WyUtPsBpX5vkoQWLbMzx64j1FjfQhs
	 NR5Q0fS8I6bIN1kYDLv0WCgdsAkkqtWv5DEfSTm/Kl6LPQOuiavVhrpIJsIGzksR8n
	 FW1h0nCFzinrO36lrFC00ZpPL5SsSMh4Y19qjLT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AE23F80217;
	Tue, 16 Jun 2020 09:50:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0ED1F8022B; Tue, 16 Jun 2020 09:50:03 +0200 (CEST)
Received: from echo.tratt.net (echo.default.edsfctgx.uk0.bigv.io [46.43.3.208])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94DDBF800EF
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 09:49:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94DDBF800EF
Received: by echo.tratt.net (Postfix, from userid 1000)
 id 74B266604; Tue, 16 Jun 2020 08:49:55 +0100 (BST)
Date: Tue, 16 Jun 2020 08:49:54 +0100
From: Laurence Tratt <laurie@tratt.net>
To: alsa-devel@alsa-project.org
Subject: [PATCH] Add implicit feedback quirk for SSL2.
Message-ID: <20200616074954.dtoqjlqh7nbmgqli@overdrive.tratt.net>
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

As expected, this requires the same quirk as the SSL2+ in order for the
clock to sync. This was suggested by, and tested on an SSL2, by Dmitry.

Suggested-by: Dmitry <dpavlushko@gmail.com>
Signed-off-by: Laurence Tratt <laurie@tratt.net>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git sound/usb/pcm.c sound/usb/pcm.c
index 84c0ae4319..dc1608bdf6 100644
--- sound/usb/pcm.c
+++ sound/usb/pcm.c
@@ -367,6 +367,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ifnum = 0;
 		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
+	case USB_ID(0x31e9, 0x0001): /* Solid State Logic SSL2 */
 	case USB_ID(0x31e9, 0x0002): /* Solid State Logic SSL2+ */
 		ep = 0x81;
 		ifnum = 2;
-- 
2.27.0

