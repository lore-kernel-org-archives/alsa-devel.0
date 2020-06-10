Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0EBC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:30:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D3D2072E
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dFbHOoyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D3D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tratt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC13415E4;
	Wed, 10 Jun 2020 18:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC13415E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591806620;
	bh=cSZ4B0/wzri9+XNq4E7Zfyk7jKn5EsIkbTV2WmOCekM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFbHOoyHtmk9pRd4ZwigXb8REqg22EM2OKXrqCzmIXLCGHRu9mLAICOJKujZYmRPJ
	 zUgu/K15c1W4a2Lzb/ZeBT238+GKxVOUivERkJFUV+qbGiiYGvhgyQ+ja1eOWrGtiv
	 AsA5qb5ncPF5Pk4KCPluhuDXPaVkhSnzYUemk/h0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B5F1F801F7;
	Wed, 10 Jun 2020 18:29:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20CAFF8021C; Wed, 10 Jun 2020 18:29:21 +0200 (CEST)
Received: from echo.tratt.net (echo.default.edsfctgx.uk0.bigv.io [46.43.3.208])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D398DF80088
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 18:29:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D398DF80088
Received: by echo.tratt.net (Postfix, from userid 1000)
 id E896D65EC; Wed, 10 Jun 2020 17:29:13 +0100 (BST)
Date: Wed, 10 Jun 2020 17:29:12 +0100
From: Laurence Tratt <laurie@tratt.net>
To: Alexander Tsoy <alexander@tsoy.me>
Subject: Re: Clock sync problem?
Message-ID: <20200610162912.ltwyjc4tpxsst3rf@overdrive.tratt.net>
User-Agent: mutt
References: <20200607133959.kmljpqdwefuio3mk@overdrive.tratt.net>
 <s5hk10i58io.wl-tiwai@suse.de>
 <14f91307-c121-a9f8-4045-1319ee0ca49e@bollie.de>
 <s5htuzl4r4f.wl-tiwai@suse.de>
 <d74af0e9a3074c3c9104cac7407185c825378de5.camel@tsoy.me>
 <20200610074409.aknnhrzzu3ulfa4e@overdrive.tratt.net>
 <325c117faed8514693f0f82d00961efa09fc1b00.camel@tsoy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <325c117faed8514693f0f82d00961efa09fc1b00.camel@tsoy.me>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Thomas Ebeling <penguins@bollie.de>
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

On Wed, Jun 10, 2020 at 04:49:14PM +0300, Alexander Tsoy wrote:

Hello Alexander,

> Thanks! So SSL 2+ is indeed currently needs implicit feedback quirk.
> The question is why it didn't help in your case.

It didn't work because I was an idiot and used the wrong manufacturer ID.
When I fixed that typo, the drift disappeared. Patch attached!

[It's reasonable to assume that this will also work for the SSL2, but I
don't know its ID: it might use the same ID as the SSL2+ or perhaps its
0x0001. Unfortunately I suspect we'll have to wait until one is observed in
the wild to know.]


Laurie


diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8a05dcb134..abf726c49f 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -367,6 +367,7 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ifnum = 0;
 		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
+	case USB_ID(0x31e9, 0x0002): /* Solid State Logic SSL2+ */
 		ep = 0x81;
 		ifnum = 2;
 		goto add_sync_ep_from_ifnum;
