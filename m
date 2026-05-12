Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13006CD4846
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2026 02:20:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A02F601F2;
	Tue, 12 May 2026 04:20:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A02F601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778552446;
	bh=UxBwcawcLSRcKSp5fGL9a5cfdsXzVyCvTP6Kb3lXkyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PmJ3sKR7iF0fH8F2lUWcvdPOiAS56PJ/EbhEOfXuUGZGtjriju0Ij6pxTTlGKdphT
	 myv7ZSLqGU0PU3SY+WM5KoTTLrnGKrVGAg77wfVzQfdD8P+DnrBiYfTDRUh+OkDkX/
	 bN42vIj30iC65Ev8gNmxpb9ZYPJGeEuRiaRulRis=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D400F805F0; Tue, 12 May 2026 04:20:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C986F805F1;
	Tue, 12 May 2026 04:20:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6980CF804CC; Tue, 12 May 2026 04:20:07 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 95D8FF8001F
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2026 04:20:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95D8FF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.a=rsa-sha256 header.s=fm3 header.b=GOhyXY7f;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=Lz9D8t6E
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0563BEC013B;
	Mon, 11 May 2026 22:20:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 22:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778552402; x=
	1778638802; bh=7XTzcDFnaJshscetbH3KahYyFyjALcxgGB6sSMWtaSI=; b=G
	OhyXY7fPLU02BaIgeqPJmWlqeUsHW/i8IcR/qxwEM4pASwBcy1ZugvC295OQtGdv
	fsnYN4GQyR/8OKFJc0nCpCpzRObmIlFjC4lOn5oFnLytfzTWHNhbwc+QVceQBC85
	zprgXMRk1HsQnqT6qtoCZa+rNsAN+4h2HMBpVUkzFN5ptsQEJIBCee+X3rBx78Bp
	go9OilWY15QoLM0NhTtglEmEG2+GcXl+Fcp68lpvjY7T1nY3n8hOqxifr0YRrWmt
	RuIX8oFUrGnSwgWRPGH3mxJSVtQ36Het/k1Nj4QquBlbWxUL6hf2FmKHTkhRlQpN
	bIeVNVNEnxXpVl2EFTwJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778552402; x=1778638802; bh=7XTzcDFnaJshscetbH3KahYyFyjALcxgGB6
	sSMWtaSI=; b=Lz9D8t6EydlMuVQpW8YKCnCTHGiTrkMN0NzJelVNf2FYeWehRhx
	KQhg7p98dogQS1HHO4MzYPMS+Gm1bpbonN4sQlwi5v3mLiWzViWwCG67W9TtpFoC
	7WcSMWJX3wBXh/AdK+mhryniat5vGlcucw7QnXEkBauJwzJOheL3Ahn6TKK4Esj3
	38tQfRGXYSDWHA95H3OtV1vWbtl2yQ8SBL9PIWDNHgsQ9lUcwYU9ffIWjEoHzL1k
	aymtGrhowQNn2tb4Kp37KH3g2h3igV6sPgPuVoqwFeIYmyikz+SEOynIDyki6pRz
	M69gEzITpNSiG/j95Gg77VzA6QDAuYfEMPA==
X-ME-Sender: <xms:UY4Cai8TxorGD0a8ldiHBRVwCbpsBc4aX1-DoPDAa5FIrZjsDErmJQ>
    <xme:UY4CavBRkT5n03jAOwIw1pu1pGfL_RJZxAGaYJNrqgbPNeDcWBcqboiXiASWX_Bly
    fKJ_b_Qu1Dnd1DtiAe4keK8q8y9eklNOYmXyd_d1PsavtYIohHNbA>
X-ME-Received: 
 <xmr:UY4CaqyMvOvHL1eXERKVyPaguhbJbEjBLW91k0Mi0mHHjH1VFNknee1M6jnS3pBmgdOWwc0MOTya4VMe7OalqREkXCOHTg>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhfduke
    ffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhesmh
    hunhhgvgifvghllhdrohhrghdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgr
    qdhprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:UY4CasQMznQUtK4bh79XpyZ2bzvPw-3o6mm4lWp6kDnXpr5hqqYXeg>
    <xmx:UY4Cap99LMyp-APDdG-xxdhtMvZfOEqTd8i11rAHGCxbR-4O6fy5og>
    <xmx:UY4CarqfPMC0hLwTrVWlPb3E_1ga6TiRm6dpokDDKR4w4vgh0iHXhw>
    <xmx:UY4Caumbj8YYkoj1riOze932ubXIJs81kU9y2x4NJSAyfUDg7a8Lsw>
    <xmx:Uo4Caq-6JC8yf91qeBXRedzMoaQ80wwz97m-R0szWUn0nu__UCCBMozM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 22:20:00 -0400 (EDT)
Date: Tue, 12 May 2026 11:19:58 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: simon@mungewell.org
Cc: alsa-devel@alsa-project.org
Subject: Re: snd-firewire-ctl-services: Digidesign Digi-002R - missing
 control for 'Optical mode'
Message-ID: <20260512021958.GA187077@sakamocchi.jp>
Mail-Followup-To: simon@mungewell.org, alsa-devel@alsa-project.org
References: <f33030cd26a3f65960481e437788a125@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33030cd26a3f65960481e437788a125@mungewell.org>
Message-ID-Hash: NGBYLNSC52RJ3BI4VXCERRBIXAFZ4UWI
X-Message-ID-Hash: NGBYLNSC52RJ3BI4VXCERRBIXAFZ4UWI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NGBYLNSC52RJ3BI4VXCERRBIXAFZ4UWI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Mon, May 11, 2026 at 06:14:19PM -0400, simon@mungewell.org wrote:
> I have noticed that 'snd-firewire-ctl-services' does not provide a control
> for switching the mode of the Optical connections, which can be either ADAT
> or S/PDIF. The Windows/Mac drivers let the user select the mode.
> 
> It is mentioned in the kernel source, but seemingly not exposed to the user:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/firewire/digi00x/digi00x-proc.c?h=v7.1-rc3#n34
> 
> Note, when 'Optical S/PDIF' is selected, the 'RCA S/PDIF' connectors are
> disabled.
> 
> I have the 002-Rack interface, and can assist with testing,
> Simon.

Yes. The service program provides no ALSA control element set
for this purpose, because Digi 002 differs from Digi 003 in how it
selects the source of S/PDIF signals for audio data in IEEE 1394
isochronous packets sent to the host system.

In my understanding, when the Digi 002 detects S/PDIF signals at the
optical input port, it automatically uses those signals for the packet
and ignores the S/PDIF signals in the coaxial input port. In contrast,
the Digi 003 allows the system software to select either the optical or
coaxial input as the source of S/PDIF signals when both are available.

However, I may have misunderstood the hardware behavior. Please let me
know if you observe any behavior that differs from my understanding
above.


Thanks

Takashi Sakamoto
