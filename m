Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C110CD5BCF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 04:58:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3BBF60222;
	Tue, 26 May 2026 06:58:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3BBF60222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779771520;
	bh=uoBrR2PzJ54+ODzCwN0pa0qFkl+F7Db8JhE4C3Mt5dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a35ZDUFrd95Uwc7KQtuBJ6PMOSz/afLJBKxrufG+DQ1WA3mYIapqkWPpXXXvER4DC
	 DPhvSxQrs/DL0xErGuwd6jagKZnwM6Mbu95OjzIF3JJNUG7sAZrj9fOgH9Q39H6Jlm
	 tBW1mY0kZSeTRd3eIVsDuiW5YCO4MpZs3F9vBt9k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDE1DF805EB; Tue, 26 May 2026 06:58:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35671F805EF;
	Tue, 26 May 2026 06:58:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1F29F80217; Tue, 26 May 2026 06:58:00 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2D62AF800BD
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 06:57:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D62AF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.a=rsa-sha256 header.s=fm3 header.b=2mMbtvmk;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=MjTcWFjJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD1E014000E5;
	Tue, 26 May 2026 00:57:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 00:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779771475; x=
	1779857875; bh=L1BQNnkrC0gVsBksDZTN7ahZ7v8IXTlMWF1KzH0z4bE=; b=2
	mMbtvmkXKhZSLILfY9fsJK1BJ6BYlnouWjg2R3DsUW53u9hNLFGxRR5ugAVl3dAq
	6aR22S9Q5j+irPnKLPR4anvw8wW0YpbIWZ2VcP7iziGlbyhhYELY+jsN9YvI82pj
	PzwKT2jqwPvvJ8C9peAz8ADM/70Flc+m+FC57inhSPAPftlSRzCORC2w4EIh7Mag
	RZKH2ihnQefUS4hRRhZss2tzNVifBiKhNLPoK/T3el7V6fraD3HV4VSesbmaEnEu
	Qv5C7j+G/hOGd6Q72cxvYaSA+wkJ4ZGAGhVhpoBWZddsaigjOO81PAMT1zTPtTFo
	kjoO/7cdAQexc/AKH8HZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779771475; x=1779857875; bh=L1BQNnkrC0gVsBksDZTN7ahZ7v8IXTlMWF1
	KzH0z4bE=; b=MjTcWFjJ1hm8niQH84g9P/p7g6LZAXxUgz+4BG34irziI2WU9b0
	0jUTgyhAx2NGGnOdwogKRSz4mlDDtXjhWZwDgDXgtzCMZb1UMhEEqb8jwaQ3n0xR
	kAnCcyLnhn/dpgMSiKIG9IxH4oJazGusXsLjf4SgQ2mzkcaBv2opVtFE7lKmDU1t
	ySFJ4aF3Y9RsU90A5zku3zkwMuRA+a3dYKxQwF85pMhlopuWhwzpEyHhgI1Lg9+N
	Blbilqx7d1QPN94Czeq4T6nLcrifDro9x8iUursfx3QOrNcBoCJA21mCh9rhkpc+
	Q9aA2RA42Q2xLgwPTR1HTighTdlPokvkEBQ==
X-ME-Sender: <xms:UygVakPauLPoGYIrry2-qka6ZR8-r_JjRHMd6APDfvvW1bVHeYXcWg>
    <xme:UygVanQNPKs3oNZLNba7vj6z-_do7RBKVq4_MUytKuyxkyIaWF7cUc9EWLoxo-5T3
    riazV9ZpQMx5sJYkpZvPpj2-LtQFYombJyM-pTrpY_MEkWjh5KJddo>
X-ME-Received: 
 <xmr:UygVauD7lup5sMJL-Exm0u63COJ97qKVN6RQQ-BtwAIuq9mqtWPpRQ65mXZSA-l9-0rEZewb8EO2uVM6lqsQd9Zj48yudw>
X-ME-Proxy-Cause: 
 dmFkZTGvEgYLT6xxMi4zK6l9k/yv9n+DddPF63rLdq9QtmpRVhHw6Faes0nKytHLhh+3bL
    hLX9jkXCzpC5VQ4XBt16hLwcQP6uAoehs5+tU8nUH7YzQ6ZnBYPSn7R8YyxtZ19D2oUhK6
    S0yLHcfdPvRcAf1PZslYbOObeDbg8nVqzlwTw3jEibXlTx9aVrHCtKqgI8hi7eTTquozdY
    EKeLA7RunktO1tVryAg+B8M8zhEGdprvWkMjjKttlOVU8bKI4PmfZVddu4b0nKSYueJFBk
    7OYrJmJonO5dNh/yGuGqTigEdRT/nguxpXmqsexdglxJC5ZwooDUp9OQdFLWCeZNfje+Kf
    7ulK6TDAdnxSm5iIs7XpmW1f/xe/0ZNCYvRF+jxm32TmkC8M/2+mDLLrQAsawTLPAVDwaq
    VCIur0nj2Epf15NcUF/13hyr0cSDT/7utUdr+nBsGHS172oilQWfOSHS87wyFSWt5DR1gl
    eSIkY4Pe+VacnljnvZJJ9VwCtokipVuVDehHuoWEnBpHxgktQ9l5/hn/oM0rVn4844v2g6
    D7nlugQ5jX4mnRy93i1g5fwPNN4ydQ+oOh1rRNxnDMxrVGRjnCMXhng9hURWt7oxGratHC
    W/TtOelc5lLiP5JVdUurtlgtxkpB9R/PMLU5XaoygKt83X8g+3XcAfB4YxOQ
X-ME-Proxy: <xmx:UygVaugdqNOhbM2RacvvPowlNKYel4T4kj8sFlds_OyR6NgK1wTrBQ>
    <xmx:UygVavMhnB9a8h6lJe1Ic1UWL4bQCOkV4EcUceFxGFu-KLGMlS6M7w>
    <xmx:UygVan4P2engQ_RjH_5sib_0SNBzUpZVYnDNAWU-ubbctgyvAxtSvg>
    <xmx:UygVal1KRQukyEI3KEzV16-3SlQkTfx5w3WCbA3ANgsExEZgmNYF8g>
    <xmx:UygVaoNymTLNL8rU3Bfs58Rf8LixbeiLkQugpFswrzMP-lGwVyjTd-yx>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 00:57:54 -0400 (EDT)
Date: Tue, 26 May 2026 13:57:51 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: simon@mungewell.org
Cc: Alsa Devel <alsa-devel@alsa-project.org>
Subject: Re: MOTU Firewire driver - Measuring used (or available) Isochronous
 Bandwidth
Message-ID: <20260526045751.GA766404@sakamocchi.jp>
Mail-Followup-To: simon@mungewell.org,
	Alsa Devel <alsa-devel@alsa-project.org>
References: <3d06586868283fb927ae0905accaa25d@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d06586868283fb927ae0905accaa25d@mungewell.org>
Message-ID-Hash: WMR6Q3JGTG3463SRJ7LWRAIBMTK5F4CA
X-Message-ID-Hash: WMR6Q3JGTG3463SRJ7LWRAIBMTK5F4CA
X-MailFrom: o-takashi@sakamocchi.jp
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WMR6Q3JGTG3463SRJ7LWRAIBMTK5F4CA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Mon, May 25, 2026 at 11:42:18AM -0400, simon@mungewell.org wrote:
> I am looking at improving the Linux driver for an old MOTU interface (896
> mk1), as the Windows driver supports disabling the ADAT input/output for the
> purpose of saving bandwidth. I think I have found the appropriate controls,
> but would like to confirm that these do in-fact save bandwidth.
> 
> Q. how can I measure the used (or alternatively available) bandwidth under
> Linux?
> 
> I believe that the different connections should have a peak bandwidth of:
> 
> 4/6 pin - 400Mbps half duplex
> 9 pin - 800Mbps full duplex

In the communication protocol of IEEE 1394, the amount of available
bandwidth is represented in a register on a node (as isochronous resource
manager or root node). For example:

$ firewire-request /dev/fw0 read 0xfffff0000220
result: 00001333

Every time to consume the bandwidth, the requester reduces the value,
thus it is enough to see the difference of the value after starting packet
streaming.

The unit expresses the byte count at S400 speed. If you're interested,
read the computation in Linux sound drivers:
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/iso-resources.c?h=v7.0#n48

I think you are interested in this topic as well:
https://github.com/alsa-project/snd-firewire-ctl-services/issues/215


Regards

Takashi Sakamoto
