Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D85C432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:12:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1D3215F1
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y/3ZDc6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1D3215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA1F415E4;
	Mon,  2 Dec 2019 08:11:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA1F415E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575270745;
	bh=xXUJTG94YpnWjGBKJQT6tJG1kWzlczcCHi/tb/STZcU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y/3ZDc6KRQZdVTX+dhxhZ2jh2nfxDc0OUC7iHSEyY9SEf1ZgBGT56fOjVSK8pbobf
	 AsSjUTkKR/BLR2haZoUzRYhEDCQsl3M+EzWGBzoVeGEVLuO3o8rCbp3boWHXVr0dFC
	 gJuzGhuwocRIZGElP8ZdOr+6TT1WoupqFnmzcJFU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44042F801D9;
	Mon,  2 Dec 2019 08:11:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9666F80214; Mon,  2 Dec 2019 08:11:32 +0100 (CET)
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8182F800F0
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 08:11:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8182F800F0
Received: from b4.vu (localhost.localdomain [127.0.0.1])
 by b4.vu (8.13.8/8.13.8) with ESMTP id xB27BMoN020244;
 Mon, 2 Dec 2019 17:41:22 +1030
Received: (from g@localhost) by b4.vu (8.13.8/8.13.8/Submit) id xB27BLEk020243;
 Mon, 2 Dec 2019 17:41:21 +1030
Date: Mon, 2 Dec 2019 17:41:21 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191202071121.GA20154@b4.vu>
References: <20191111054133.GA1817@b4.vu>
 <861b90c8-8878-c3be-bc8e-769a3638cc14@gmail.com>
 <s5hsgmh5i3x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5hsgmh5i3x.wl-tiwai@suse.de>
User-Agent: Mutt/1.4.2.2i
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: Fix Scarlett 6i6 Gen 2
	port data
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

Hi Takashi,

On Thu, Nov 21, 2019 at 05:06:42PM +0100, Takashi Iwai wrote:
> On Thu, 21 Nov 2019 09:52:10 +0100,
> Markus Schroetter wrote:
> > 
> > > The s6i6_gen2_info.ports[] array had the Mixer and PCM port type
> > > entries in the wrong place. Use designators to explicitly specify the
> > > array elements being set.
> > >
> > > Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
> > > Signed-off-by: Geoffrey D. Bennett <g at b4.vu <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> > > Reported-by: Jonas Berlin <kernel at xkr47.space <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> > > Tested-by: Alex Fellows <alex.fellows at gmail.com <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> > Tested-by: Markus Schroetter <project.m.schroetter@gmail.com>
> 
> Oh this wasn't taken yet.  Now merged for 5.5.

Thanks, I see it appeared in 5.4.1. Is it too late to get the commit
message fixed for 5.5? It's missing the Reported-by line above:

Reported-by: Jonas Berlin <kernel@xkr47.space>

Thanks,
Geoffrey.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
