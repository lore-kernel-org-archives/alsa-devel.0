Return-Path: <SRS0=kjsd=JP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49911C433ED
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 14:16:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2AE610E9
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 14:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2AE610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85D601662;
	Sun, 18 Apr 2021 16:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85D601662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618755388;
	bh=lqe7T0lgezeHuHpkmWfNA679zavvVb1MJzIgS7VdYp0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pwzw02oBmgi9FPma0v0nmm0zVBNC3AveGx9WjcrOEITn/WtwqtoXEpekVNWIJjDTc
	 jW3hZ3kghq9IGuaLaUpgG3gYK9SwA5StItjSWk5hXZLeIYE/DaHbrIGSfbsIgt5tbp
	 JJoxHtFcSVq/p3+8T4+g22OTopr4HQyDFkvm2B+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B915F80168;
	Sun, 18 Apr 2021 16:15:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54C63F80253; Sun, 18 Apr 2021 16:15:37 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 673A1F80164
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 16:15:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 673A1F80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="bvPwKAZi"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="JJlgu93l"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2205F5C0728;
 Sun, 18 Apr 2021 10:15:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 18 Apr 2021 10:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=BWnC9nKgv+vwl1MGk89e4mG2jBm
 +w8joVKU7bauHOWo=; b=bvPwKAZisPN3RBC4l5zob8oaxgjEzoehtqv8CyAPkwW
 KIQnftXY4hyEZvCj/wGq/8T/StHT883MG4ocwE5u0g5o1wag1DkeCD0JiycgN7HG
 QUS4zEGOac8wEY3raQdesb1gqQCzIUQZiq3QrpNx3mGTlFPTVzamjAxVc1t5Rd77
 s2upr2Dveb1LdFGYXVMdvLcNhbFYgHdc5+v2cdXPImjonR3rbkUKq6r1/Drr/oD0
 9rxEa8X4n3m11dZM3OxqlzGBetRwBVQaKLHCJrwbkS/iDIISw9ck8N/QGvDuhrQ6
 h1nrpCIUxO9Q76HZWdKuZeVeIariwFI3fOODAO5om8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BWnC9n
 Kgv+vwl1MGk89e4mG2jBm+w8joVKU7bauHOWo=; b=JJlgu93l7cX10BWrNxWz/P
 nZhI7bSplJLI3OvgFECMU1XOklWPQqE8KgaV0DQ3ZFlRD/bBuf2FsCwescUkWxkB
 116SETU/1RI4lxjO35AN/l127gEswI1IMU5Y7s4zDedTRvT85tP2zHiq5X2DhArT
 UZLT0P4mz9Eje5CO5USN94XFf9xAi679FRSIK+xm6BJwVQZtV0IgkaRz2ku8XbtU
 BaeK0Cwu6gvVlNTH5wzTLcl5Kh+wwlCR7sh0+c+vbUyAS8eVla4eh0sgknK/qKh9
 Wn4ATatLhD/PQCzOQFu0MVKr5h/HnAMP8iySGD/pG756+KoNMfbk8nSlT9BZr8Tg
 ==
X-ME-Sender: <xms:AD98YAsZi6uTxnqeax1YdEIcmzuuw-GMmL0umUo4md6_LLdmmnfEzA>
 <xme:AD98YNen0-rMbRGtHTD3BrKAfDi1Uv6vHLXHe3f9P9_ySc2AmrjR_T5tLOmajAk2Z
 TbBJolKrSkGihPR2tY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddttddgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeejgeeifeeuveeufeeigeegjeelvdfgjeegffejgfdv
 keelhefgtdefteejleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppe
 dugedrfedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
 rghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:AD98YLz4fUjJkP5v9hy8ghXXWdbnz6DNbspJkna1fdyxFq6_aLAtew>
 <xmx:AD98YDM8T6X8SQ0GE3gbn_MXvN6R3lhISqSwn9eNHOOf1pbDuO3O7w>
 <xmx:AD98YA84GojYsvSYxaUuD3tpUOazH6mUOSbgOexrBHSvFq-R_X7M6A>
 <xmx:AT98YJJeXvXgHXnQLzM5Hew01U8LGI-Iumdu03WOnyg5D4PETafH_A>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4DCDF1080063;
 Sun, 18 Apr 2021 10:15:27 -0400 (EDT)
Date: Sun, 18 Apr 2021 23:15:24 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3] ALSA: control: Add memory consumption limit to user
 controls
Message-ID: <20210418141524.GA36507@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20210408103149.40357-1-o-takashi@sakamocchi.jp>
 <20210408105025.GB40407@workstation> <s5h1rbl80yy.wl-tiwai@suse.de>
 <20210409022735.GA3776@workstation> <s5h5z0v67wh.wl-tiwai@suse.de>
 <s5hsg3z4ezl.wl-tiwai@suse.de> <20210410082016.GA10316@workstation>
 <s5hblam4jc5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hblam4jc5.wl-tiwai@suse.de>
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

Hi,

Sorry to be late.

On Sat, Apr 10, 2021 at 10:47:22AM +0200, Takashi Iwai wrote:
> On Sat, 10 Apr 2021 10:20:16 +0200,
> Takashi Sakamoto wrote:
> > 
> > On Fri, Apr 09, 2021 at 06:09:02PM +0200, Takashi Iwai wrote:
> > > On Fri, 09 Apr 2021 12:59:10 +0200,
> > > Takashi Iwai wrote:
> > > > 
> > > > On Fri, 09 Apr 2021 04:27:35 +0200,
> > > > Takashi Sakamoto wrote:
> > > > > 
> > > > > 4. Add `max_user_ctl_alloc_size` kobject attribute to the control device
> > > > > 
> > > > > In the patch, a new module parameter 'max_user_ctl_alloc_size' is added.
> > > > > In the item, I use the value of this parameter as initial value per
> > > > > control device. The value per control device can be changed via sysfs
> > > > > node.
> > > > > 
> > > > > The `max_user_ctl_alloc_size` is really the attribute of control device,
> > > > > so I think it acceptable. Additionally, 'curr_user_ctl_alloc_size' is
> > > > > also added so that userspace applications get current status.
> > > > 
> > > > So that's the primary purpose?  Then it makes sense, yeah.
> > > 
> > > You meant something like below, right?
> > 
> > If you were carefully reading my items in the order, you would have
> > realized that the patch includes problem to share attribute group
> > table between several modules...
> 
> Which several modules...?  The control API is mandatory, hence it
> can't be separated from each card core stuff.  So splitting to another
> module makes no sense, as I already replied earlier.
> 
> > Device attribute is one of userspace interface expected to be stable. I'd
> > like to avoid careless changes which our known developer tends to do.
> 
> Sure, it has to be set on stone once after put in the tree.
> However, currently it's just a brain storming phase, and no need to
> grumble for a dreadful future vision.

Oops, I realised to have overlooked your previous post:
https://lore.kernel.org/alsa-devel/s5h5z0v67wh.wl-tiwai@suse.de/

Let me back to it so that we share the premises for the discussion.


Thanks

Takashi Sakamoto
