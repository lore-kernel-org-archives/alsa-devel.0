Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB7C38A30
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:58:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CDD2064C
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 03:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qrCpUDx/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="DSLiF70h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CDD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3FC616B5;
	Wed, 22 Apr 2020 05:57:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3FC616B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587527887;
	bh=23BzqynphMFq9fbVMYqMQH112Itx56HxH3+TOWzwEO0=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrCpUDx/1HAKEkvHVPMZ5Yyt+26hto14iKcRTxYjlgs6XRBt75zk5rhhvuzirYktD
	 NkQfoR8tZgES8qIf8Pe6W6tNUe0uNyfp87r55vYc2MTUO7iLDE+ZLeeDU8I3S2NGsZ
	 kh4d86T17PdvBtfmNyCiTXZZOlg6bjdDM/YoasKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC3EDF80108;
	Wed, 22 Apr 2020 05:57:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAFE4F801D9; Wed, 22 Apr 2020 05:57:14 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E1ABF80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 05:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E1ABF80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="DSLiF70h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=j4Ls9wRVE3rzrnjPn4jr+wNKwnnaHQT5dpsn0hB2le4=; b=DSLiF70hGIJpZAwlRs3SpnBt0Q
 QQW8HASY5Qz0V07Y/7tmrphyYJgTvlnPrSaMMgRWY+Pr0MLRUg2pJPI/WBLGnPCPylXkzvVJCooYm
 gVj7FXR/hyeslZqR6HGNJfUdnkDGWSEDfJ4Uz3LBfkSJbxyj4+fcE6//5tDw2z7NITF4=;
Received: from [2a00:1370:8125:3f98:890:f100:d37d:7ada] (helo=home)
 by puleglot.ru with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <puleglot@puleglot.ru>)
 id 1jR6VU-000coH-Ix; Wed, 22 Apr 2020 06:57:04 +0300
Message-ID: <7190177d62f349eea7a5d1056924a63fc4270d43.camel@tsoy.me>
Subject: Re: [PATCH] ALSA: usb-audio: Apply async workaround for Scarlett
 2i4 2nd gen
From: Alexander Tsoy <alexander@tsoy.me>
To: Takashi Iwai <tiwai@suse.de>
Date: Wed, 22 Apr 2020 06:57:03 +0300
In-Reply-To: <s5hpnc01vq5.wl-tiwai@suse.de>
References: <20200421190908.462860-1-alexander@tsoy.me>
 <s5hpnc01vq5.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

В Вт, 21/04/2020 в 21:31 +0200, Takashi Iwai пишет:
> On Tue, 21 Apr 2020 21:09:08 +0200,
> Alexander Tsoy wrote:
> > Due to rounding error driver sometimes incorrectly calculate next
> > packet
> > size, which results in audible clicks on devices with synchronous
> > playback
> > endpoints. For example on a high speed bus and a sample rate 44.1
> > kHz it
> > loses one sample every ~40.9 seconds. Fortunately playback
> > interface on
> > Scarlett 2i4 2nd gen has a working explicit feedback endpoint, so
> > we can
> > switch playback data endpoint to asynchronous mode as a workaround.
> > 
> > Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
> 
> Applied now, thanks.
> 
> I wonder, though, whether we can correct the rounding error in the
> driver code, too.

I'm not sure if it's possible with currently used Q16.16 arithmetic.

