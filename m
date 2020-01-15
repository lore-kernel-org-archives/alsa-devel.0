Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A67C33CB1
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:15:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B587C2465A
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LlIpOvuH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="nJrBNygK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B587C2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F308317A0;
	Wed, 15 Jan 2020 16:14:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F308317A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579101301;
	bh=Gh4fwSFbiajwKHjwqxSJWVp8P7PsbYcTaGUtKBMHKs4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LlIpOvuH7IljnPCqUaB+uQChUouMmTPzjatobaFfrgRuu792Q7UI1m5a+NfCYtHg5
	 WE6P46m4VjtYs+spAcVG875jXjIX3oId92+5mO68qq3BbSgTe9oBK8fGPIzD7vFZF8
	 nuIFBDNnCyUTJVffLy7aiyMU45hIpx0Sj9/tU5MQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54BFBF8014B;
	Wed, 15 Jan 2020 16:14:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 091E3F801EB; Wed, 15 Jan 2020 16:14:08 +0100 (CET)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87BC3F800CC
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 16:14:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87BC3F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="nJrBNygK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fjbxaCXo0+i4IqBXF9ryB1CZI1WAC+SKFV7I2kwwJxA=; b=nJrBNygKWxtrdKw+XQ+M9o/SlY
 w+8x6BHzUPj1LiUsvXvv8OKNvQBRA1PymdqBaNlyHrCzqFOyJ6zIyd0kI99SLIyg5a37n6Ly29qqB
 4f23gyK8k1nNJCjZ9xWYJoaKXMDj++c1eYsqMf+ojsMJK1xhUQfV2AzeD71zIqDwnnQs=;
Received: from [2a00:1370:8125:8203:1dce:4cab:baac:10ca]
 (helo=home.puleglot.ru)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1irkMq-0005LV-Cb; Wed, 15 Jan 2020 18:14:00 +0300
From: Alexander Tsoy <alexander@tsoy.me>
To: alsa-devel@alsa-project.org
Date: Wed, 15 Jan 2020 18:13:58 +0300
Message-Id: <20200115151358.56672-1-alexander@tsoy.me>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: add implicit fb quirk for
	MOTU M Series
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This fixes crackling sound during playback.

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---

MOTU is known for reusing Product IDs for different devices or different
generations of the device (e.g. MicroBook I/II/IIc shares a single Product
ID). This patch was only tested with M4 audio interface, but the same
Product ID is also used by M2. Hope it will work for M2 as well.

 sound/usb/pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index a11c8150af58..4f1c00615d94 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -348,6 +348,10 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ep = 0x84;
 		ifnum = 0;
 		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
+		ep = 0x81;
+		ifnum = 2;
+		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x0582, 0x01d8): /* BOSS Katana */
 		/* BOSS Katana amplifiers do not need quirks */
 		return 0;
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
