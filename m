Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D30FCD4F24
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 11:43:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AD26601E4;
	Wed, 13 May 2026 13:42:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AD26601E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778672578;
	bh=0TumWsLZAQaHZLl2KuP1b58CkJOLFENnaAgU0ENBmr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P4fvGm+Bh95/DOZdiV0FQohz4orPBc6quKcgwYj+GpkrvQv07njM50TR3WF5X1I+X
	 ziqh/K0VT0+XG4aiHCaPfb1dLThF3ltEB17Zo0qKArqpMSE/gfoH9j4HwSib/SJv7y
	 gUedoeFIFnXOfJxnTynGwexUN6UZtQKZIQUXPcL8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87E2FF805F4; Wed, 13 May 2026 13:42:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 071D8F805B0;
	Wed, 13 May 2026 13:42:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6073F8049C; Wed, 13 May 2026 13:42:18 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 79C07F80100
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2026 13:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79C07F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.a=rsa-sha256 header.s=fm3 header.b=YvRcLEZG;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=jQQ/cPb5
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 403657A00C1;
	Wed, 13 May 2026 07:42:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 May 2026 07:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778672533; x=
	1778758933; bh=ZmsxX4jWDXZR/pEq/ylGL4TRnL7wvtZrr/GHVbjRvpo=; b=Y
	vRcLEZGSEhrG0e87g5DMzuOZp0PV/hnA4aA7krnBSTDcuQI2jK1L831yf06b3jSA
	yT10QK5IaiSdjbIMl/X8FITiOfUiDSaGZ7pb4bhUSr0JlxjjrFNRnimZBuX9NR76
	hRavtsMzq82b+U2HSY637lis8Bh7ncO6PsQi6HNVccJa4OyhCIR0D/yEhmut1CB9
	pugSbzR+hcK5AujnS8lS8k14fOVH0Gd8JGsbLku8rUnSV+jIUq3UBliV5kuD8mlh
	GHxgthpUvb06sjk7TIjBl3CXylkUixwdTAcapBtaaaPB/E6cvfQQT4HSaiD+vuTM
	aBCHBJ3n+AVfDIibqk87w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778672533; x=1778758933; bh=ZmsxX4jWDXZR/pEq/ylGL4TRnL7wvtZrr/G
	HVbjRvpo=; b=jQQ/cPb55wg21h2PkppPhsSf5dATrTut0TtyZGW53SmQ4RhuSzU
	o0D+/JjVWkYrJKmfT7LvQ3vdUel8RqUdvf0mG5lkohB5pIKOqqQbe3KXwETrFKSe
	ewleMAu3KgsHS2PpeLBTvpYILNahqs6mzTUWrBKMeRvhN0MgkV50/S+MCYNTpUxe
	J5UgQ+hE65cJm/tDdw7TlDSexUErGq4TqiIbvFVbZAJSUZM2QpjYFMB88OHIt/4X
	7HfZse8ceRWwlWHqFWrP+9zKTNwUoOaLtw478O76ZsubOEvDNf0oD6Cfy32p8RTD
	xeYlcBexWVauz/QQXWen6V8Qt2W5rnW5+5A==
X-ME-Sender: <xms:lGMEavQIuzUqVZ3NLd2uK21GxbBu0f7L6uo7CT1t9AP9L7aLkz0Pnw>
    <xme:lGMEatH0SIUghZSKij850p8Btvi_HIG8UZ0v_8KaWQ-m2WcEoQHH6EL9ErJOTY546
    GK163eIv5h6ZaLA2leVMgqdFDvfKMTa_hEgjqRTkVz12Vbbjcv-HRU>
X-ME-Received: 
 <xmr:lGMEankMr0llvAFtprSDzA6qv80SYQYSS--CMl1Q9Z7SJb4vf7YtYvO0qY33ZFh21c5z_o6dpCP2KRDUFy3AOU8mb3Emkw>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeduheegueevte
    euvdekkedvgfffleeiiedvlefhteettdevteetgfffgeejfeelkeenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhesmh
    hunhhgvgifvghllhdrohhrghdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgr
    qdhprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:lGMEag2l3OrjSUbnXJV4JmKa_Cn3dxsoS4TEHdhVJsYCvv8a87e5yg>
    <xmx:lGMEarTqgN4B12P1-zHpN_57pfjEI6dkPlxToBkVacpNeHU-aBZFVQ>
    <xmx:lGMEaqvviy3QE5KBhzrdx4ofXUICwbPf1R3CNvkOyxI4qMERiybZWQ>
    <xmx:lGMEaoYrU0Nk4U22Ksl2pZtmDhmejvYq55vJ2IQgmpGfvWUu9_uHkQ>
    <xmx:lWMEaqTszwUVKd2JP4zp_CkvvNwM51sxNvNbWgh0tvGMxJ7487QjHYQs>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 07:42:11 -0400 (EDT)
Date: Wed, 13 May 2026 20:42:09 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: simon@mungewell.org
Cc: alsa-devel@alsa-project.org
Subject: Re: snd-firewire-ctl-services: Digidesign Digi-002R - missing
 control for 'Optical mode'
Message-ID: <20260513114209.GA352970@sakamocchi.jp>
Mail-Followup-To: simon@mungewell.org, alsa-devel@alsa-project.org
References: <f33030cd26a3f65960481e437788a125@mungewell.org>
 <20260512021958.GA187077@sakamocchi.jp>
 <d10bfa55e085e76f2846c53a550c4d0f@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10bfa55e085e76f2846c53a550c4d0f@mungewell.org>
Message-ID-Hash: IPBELL7ARVGX6FY3M7OLE4XGUDVI677J
X-Message-ID-Hash: IPBELL7ARVGX6FY3M7OLE4XGUDVI677J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPBELL7ARVGX6FY3M7OLE4XGUDVI677J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Tue, May 12, 2026 at 03:08:18PM -0400, simon@mungewell.org wrote:
> On 2026-05-11 22:19, Takashi Sakamoto wrote:
> 
> > Yes. The service program provides no ALSA control element set
> > for this purpose, because Digi 002 differs from Digi 003 in how it
> > selects the source of S/PDIF signals for audio data in IEEE 1394
> > isochronous packets sent to the host system.
> > 
> 
> I experimented some more, and was able to muddle through the Rust code to
> 'move' the control (from 003 protocol) to act on the 002. This showed that
> the 002R does actually support this function.
> 
> I found a couple of things:
> 1). Parameter is not saved unless the Jack server is stopped before making
> the change. I think that this is expected.
> --
> simon@EliteBook:~/snd-firewire-ctl-services.github$ amixer -c 2 cset numid=8
> 'S/PDIF'
> numid=8,iface=MIXER,name='optical-interface'
>   ; type=ENUMERATED,access=rw------,values=1,items=2
>   ; Item #0 'ADAT'
>   ; Item #1 'S/PDIF'
>   : values=1
> simon@EliteBook:~/snd-firewire-ctl-services.github$ amixer -c 2 cget numid=8
> numid=8,iface=MIXER,name='optical-interface'
>   ; type=ENUMERATED,access=rw------,values=1,items=2
>   ; Item #0 'ADAT'
>   ; Item #1 'S/PDIF'
>   : values=1
> --

It is likely that the mode change is just activated when the host system
stops packet streaming. Then these devices shift to 'standby mode', and
you can see the transition in the status indicator if using any console
models.

> 2). With 'loop backs' on the RCA and Optical ports I got all channels in
> 'normal/ADAT' mode, but in the 'S/PDIF' mode the path was re-assigned. I got
> nothing through channels 11..18 (normally ADAT/optical), instead only
> channels 9..10 passed audio - HOWEVER these are going over the optical fibre
> (not co-ax cable), unplug the fibre and this loop-back stops.
> 
> So in summary I think the existing code can be re-jigged to cover both 002
> and 003.
> Simon.

I filed A MR for the required changes. Please test with it:

digi00x: support optical interface mode operation for digi 002 as well as digi 003#214
https://github.com/alsa-project/snd-firewire-ctl-services/pull/214


Thanks

Takashi Sakamoto
