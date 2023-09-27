Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E04AE77360
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:08:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3C5CED8;
	Sat, 30 Sep 2023 10:07:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3C5CED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061314;
	bh=7I5cFt6U19O3US9boaZ22e0oiRQxApKw5hEyWITbzLg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CF9chqI3uYszc5Si0e0zIIIJ8v+QAdLeOJ6Wky724LXV86bmkkayDph6aEteVBK7m
	 /UcXzXJL69YFm/tdUVVLSmNS0kK14Nqqrvpq6/ncR5Ebwd+zRHk7yj/04fWRQDdAgZ
	 7hQM1mgon6R60j+UAFvPOJkrtyTCLzkgFfdrOK7I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78234F80609; Sat, 30 Sep 2023 10:06:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6435EF80609;
	Sat, 30 Sep 2023 10:06:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52934F8016A; Wed, 27 Sep 2023 12:20:15 +0200 (CEST)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by alsa1.perex.cz (Postfix) with ESMTP id 17BCBF80130
	for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2023 12:20:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17BCBF80130
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1978106:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256);
 Wed, 27 Sep 2023 18:19:49 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 27 Sep
 2023 18:19:48 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 27 Sep 2023 18:19:48 +0800
Date: Wed, 27 Sep 2023 18:19:48 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Allen Lin
	<allen_lin@richtek.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <20230927101948.GA27975@linuxcarl2.richtek.com>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
 <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
 <20230927094637.GA25905@linuxcarl2.richtek.com>
 <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-MailFrom: prvs=1631658C43=cy_huang@richtek.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: DUR72UBGQPUOAK3GPKKTPGNRYZS7XZFN
X-Message-ID-Hash: DUR72UBGQPUOAK3GPKKTPGNRYZS7XZFN
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:06:34 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DUR72UBGQPUOAK3GPKKTPGNRYZS7XZFN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Sep 27, 2023 at 11:59:31AM +0200, Mark Brown wrote:
> On Wed, Sep 27, 2023 at 05:46:37PM +0800, ChiYuan Huang wrote:
> > On Wed, Sep 27, 2023 at 11:13:22AM +0200, Mark Brown wrote:
> 
> > > Is this something that's going to be changing dynamically at runtime or
> > > should this be a device property that's set either by firmware or when
> > > we're doing the TDM setup?  This sounds like something I'd expect to be
> > > fixed by the board design.
> 
> > I may think one case if ASoC platform support multiple data source outputs
> > that share the same bck/lcrk on different data pin. If it can be dynamically
> > adjusted for the scenarios, this will keep the flexibility for the differet
> > platform design.
> 
> Sure, but is that actually a practical design - or if someone is doing
> this shouldn't it be joined up with the TDM configuration since with
> just the control it'd only be possible to switch the pins but not change
> the TDM layout?  I'm not sure that this control works as a standalone
> thing.

I think if two data source input for different scenarios, then the data source
switch will become practical. For the standalone usage, keep a device property
to decide this may be enough. But consider the future application, to keep this
in general mixer control is still usable to meet the complex design.
