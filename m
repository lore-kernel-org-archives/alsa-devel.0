Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4FAC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:37:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6412220702
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nkiHu38s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="KN3FUgW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6412220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDEBA1684;
	Tue,  7 Jul 2020 12:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDEBA1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594118273;
	bh=D0ssH4e3eiJBNljyOc756aE8nfEHm9AzQ21hHdhSmjA=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nkiHu38sPE/8nuH5lQcWnd5f/PPBeilS2BdP5UQrvf454+JGxZJyfucuxFbHrQY2m
	 geIK3t2VTCH8EWJmHjo/bcoLBUotKp6D08JQnE5+zXa2S06BtKq23y20g5iA6RdUJY
	 Y6KGKsUJBF58jVAr3EdVnnzvcVsy5WvrlVj9ShX4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB5BDF802DF;
	Tue,  7 Jul 2020 12:34:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B412F802E8; Tue,  7 Jul 2020 12:34:27 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D25EAF800D0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:34:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D25EAF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="KN3FUgW6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0tYA2OGdalzXxQL21KHhAIsJJCzeGY/ZyL063pnitF8=; b=KN3FUgW6QQIjULY+ZifqTEGJss
 q79dtrjyz/KeIFkaPOZ/9Kx/f2W9JuFRiKIaHKa0muGYoKKNj1DBZwTsLDA5PepEQqPK4BK4BeU9A
 KdLS9ECKdLaak2OHwJjxbYcVBosjgi4Y+9buxIwiwgXDOLpYNAdmNDA8miCDXxMwZTRI=;
Received: from [10.8.10.223] (helo=work)
 by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93.0.4) (envelope-from <puleglot@puleglot.ru>)
 id 1jskvY-000ePh-Ai; Tue, 07 Jul 2020 13:34:16 +0300
Message-ID: <c233f32650a48c92a6c984db9da1f5c231df27a7.camel@tsoy.me>
Subject: Re: Ignored USB-audio implicit feedback in kernel 5.8rc3
From: Alexander Tsoy <alexander@tsoy.me>
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
Date: Tue, 07 Jul 2020 13:34:15 +0300
In-Reply-To: <5bd5efb4-66f0-955c-783e-57aff997028a@ivitera.com>
References: <5be78c36-bca0-da9c-43ec-2e2a538948a8@ivitera.com>
 <51a129ba-d74f-bfe3-933c-4805bc87804a@ivitera.com>
 <5bd5efb4-66f0-955c-783e-57aff997028a@ivitera.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

В Чт, 02/07/2020 в 13:28 +0200, Pavel Hofman пишет:
> Dne 29. 06. 20 v 17:08 Pavel Hofman napsal(a):
> > Dne 29. 06. 20 v 13:28 Pavel Hofman napsal(a):
> > > Audio analyzer RTX6001 (XMOS-based) is using implicit feedback,
> > > yet the
> > > feedback is not used by the latest kernel 5.8 rc3 (i.e. already
> > > with the
> > > latest implicit-feedback patches).
> > > 
> > > Two analyzers on two different PCs are getting clicks in duplex-
> > > mode
> > > loobpack, one every 10 secs, the other one every 50 secs.
> > > 
> 
> I am very sure the problem is identical to that for MOTU M2/4, Solid
> State Logic SSL2+, Fractal Audio Axe-Fx III etc.
> https://github.com/torvalds/linux/commit/e7585db1b0b5b4e4eb1967bb1472df308f7ffcbf
> . I will try the simple quirk, IMO it will work OK. BTW if I
> understand
> correctly all these devices use the XMOS.
> 
> However, I would like to ask, why a quirk for these devices is
> required.
> The comment explanation in this interesting patch
> https://lore.kernel.org/patchwork/patch/1174179/ talks about the same
> EP
> numbers, but in the different direction. 0x01 EP OUT + 0x81 EP IN
> implicit feedback data. All the devices mentioned above have this
> numbering, just the EP IN is in a different interface than the EP
> OUT.
> But please are there actually any duplex implicit feedback devices
> having EP OUT and implicit-feedback EP IN  in the same interface? The
> explicit feedback EP IN is clear, they are in the same interface. E-
> MU
> 0404 USB has EP OUT + EP IN explicit feedback in interface 1,
> together,
> EP IN implicit feedback data in interface 2. My other soundcards,
> adaptive OUT and async IN again each in a different interface (though
> there is no feedback to solve).
> 
> Please is the requirement that EP OUT + EP IN implicit feedback data
> must be in the same interface really necessary? If such a requirement
> was dropped, IMO many devices could be removed from the existing
> set_sync_ep_implicit_fb_quirk and many devices would work out of the
> box, as they require no other quirk (unlike the MOTUs, but that's a
> different issue).

USB Audio Class specs are pretty clear about it: only one isochronous
endpoint is allowed per interface. And it can be accompanied by the
*explicit* feedback endpoint.

I have patches that implement autodetection of implicit feedback, but I
need to clean them up and be careful not to break Scarlett 18i8/18i20
3rd Gen (these devices have 3 altsettings per interface and probably
require some additional sample rates filtering, so that each sample
rate uniquely match one single altsetting).

