Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E59E95A61
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Oct 2023 11:30:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0F3982B;
	Sat,  7 Oct 2023 13:29:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0F3982B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696678205;
	bh=lrF/Dt4nJqR/ko3PJBiwi43YujEb8+25i/z1Vehz2vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fCzVftFNVfBJqYFwh1QpgrTcf9PJG1d2Z7TZDIGO2mRwRDlos+1AFFwUFaR2Kc+rO
	 /2kh/fSLA60Uvcc6l+u3EBBthmexMGBOvC+3drkGIw6oVZx1HstYRboNG0RvwaqyHw
	 Q5pA/xIyx5XuAcUe2Xv9sfh+QxyGzHwhlc6cil8w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 692A6F80549; Sat,  7 Oct 2023 13:28:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C6736F8047D;
	Sat,  7 Oct 2023 13:28:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4C0AF8047D; Sat,  7 Oct 2023 13:28:38 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44014F801EB
	for <alsa-devel@alsa-project.org>; Sat,  7 Oct 2023 13:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44014F801EB
Received: by m.b4.vu (Postfix, from userid 1000)
	id DDE15604F298; Sat,  7 Oct 2023 21:58:22 +1030 (ACDT)
Date: Sat, 7 Oct 2023 21:58:22 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: scarlett2: Add Focusrite Clarett+ 2Pre and 4Pre
 support
Message-ID: <ZSFA1mXhyLJjSOWH@m.b4.vu>
References: <ZRL7qjC3tYQllT3H@m.b4.vu>
 <87wmw0w32k.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmw0w32k.wl-tiwai@suse.de>
Message-ID-Hash: G3Q72EDZWRBIM47PSYZSHN7U4ZHUXVZT
X-Message-ID-Hash: G3Q72EDZWRBIM47PSYZSHN7U4ZHUXVZT
X-MailFrom: g@b4.vu
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G3Q72EDZWRBIM47PSYZSHN7U4ZHUXVZT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Oct 06, 2023 at 10:46:43AM +0200, Takashi Iwai wrote:
> On Tue, 26 Sep 2023 17:41:30 +0200,
> Geoffrey D. Bennett wrote:
> > 
> > The Focusrite Clarett+ series uses the same protocol as the Scarlett
> > Gen 2 and Gen 3 series. This patch adds support for the Clarett+ 2Pre
> > and Clarett+ 4Pre similarly to the existing 8Pre support by adding
> > appropriate entries to the scarlett2 driver.
> > 
> > The Clarett 2Pre USB and 4Pre USB presumably use the same protocol as
> > well, so support for them can easily be added if someone can test.
> > 
> > Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
> 
> Thanks, applied now.

Thanks! Shortly after you sent this email I got confirmation that the
Clarett USB 2Pre and 4Pre also use the same protocol, so will send
through another patch shortly adding those PIDs.
