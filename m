Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD3C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:19:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E550B20786
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IlfpGr+y";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Y5MnP4fg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4BaerRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E550B20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4231E1679;
	Wed, 17 Jun 2020 15:18:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4231E1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592399947;
	bh=usgGx4x7ECVCrSMo6I+8My/0ZJj30fPhV3sns+T54dY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlfpGr+yGmy/FmSZP/89TfubDzDpCMQ3CISwwNtDTjZRERAM5qRwK71HUb4KdTgKu
	 YcEqZlPccMctAvfgO8yNd2jkSkTzedhZrHK5DATxINAXPtB9ft8lJqa+IXw03dDgmI
	 h4nYeLfO+/aIg+DOwm38HVeRuc+CYQUSVJS/fPTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B38CF801EB;
	Wed, 17 Jun 2020 15:17:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49D7CF801ED; Wed, 17 Jun 2020 15:17:55 +0200 (CEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CFADF80116
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 15:17:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CFADF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Y5MnP4fg"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="l4BaerRH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id C96645C00CF;
 Wed, 17 Jun 2020 09:17:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 17 Jun 2020 09:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=j/qZV78V2pDA5PdPaaEBiPjJ+Gv
 R0JqOc1OJAmqboQ0=; b=Y5MnP4fgKXlADNgqvCEJP/xGnzFmI2ImiJ7JXDme1ix
 2Zn2Q032//bDXG7GE0fpiFDUkRmcQsHzguPc7mYLIPYhPmJjftPC0Og2krm3pwUI
 bktO0FH8KLL7cGbc6zffRh2cvs9d4vNYx6RZo5MDyu3Mc+gAU1xIEpiotM0E5P5O
 +rudkHcac7m7du1BpFB9EWRL3UxanuAGKjbV4TVusAcj/u1m4wa3e2Y2Ny8SQNxd
 Ynot+XRGS/pAhcfA0nuPNEyxj4Yh4+fSvSwU/sZcr6T24fGkxDz5abEyvnP8i/w2
 JGKMuC2ituYecObXP0RGVQtz1CcZEA1GQjKaMEGngzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=j/qZV7
 8V2pDA5PdPaaEBiPjJ+GvR0JqOc1OJAmqboQ0=; b=l4BaerRH9VPepC1mTxC9LG
 aGQcB/8QwV2Wmf9b+a79MZ5NZmPm46eJci+tRYnTs4JRzr/KpjPy3J5UvnWkvtUc
 lgP2TY6BY3uaNoRc2tLAlCUB+piICk3OOvr1yc313WRST7RddjMPjSPKWEGOddYg
 xjeRjbmiRo+NWGjsRdI1ksDj4VN4FlcNejLmewuXRIIqgjDJKssPo0+2craWCjkd
 WPb47s3nITDT2XQs4Zb8fYdxP6+3LfXAzX13HXjk+elRzEL6R+t2fIa8rKS3ZDiH
 ziJMXPc1UoMWLVKRgpvCWWfPqCqejJP3LvLBIhleH7SVwZsxUZjAB9Knd0MTT3QA
 ==
X-ME-Sender: <xms:_RfqXjAeiKXkuuFxzcroQ-cdWw3ML4Tq4P5mPgDLSZiisjKoDbETMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddgieefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpefggfeiheekuefhheduueeileetffevgeeuieekfeeg
 fefgtedvveetgfdtgeeuudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnh
 gvlhdrohhrghenucfkphepudektddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihii
 vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
 hotggthhhirdhjph
X-ME-Proxy: <xmx:_RfqXpgWSoK3SuDYkqAC5hS609YIfj2etX8M1GwADWLp_IlZPWa3Cw>
 <xmx:_RfqXumGWKVO2cESCmc4uH6tBmc0uWAytl1zw-tfnG3wHoyRiFJugQ>
 <xmx:_RfqXlwzlqHNKOF-Xk03rnwnD0N8jwczr2C0TwFW12VdFMZU3VBYVw>
 <xmx:_RfqXvcejJq4NgWExfgTNR1DOskSxs60o9d_XgO2sAdk7S5akrra6Q>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5BB2B3061CCB;
 Wed, 17 Jun 2020 09:17:48 -0400 (EDT)
Date: Wed, 17 Jun 2020 22:17:46 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Move ownership for repositories in Github related to
 gobject-introspection
Message-ID: <20200617131746.GA274842@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20200617080114.GA265611@workstation>
 <26bcc126-6688-5996-b6ad-3288bd2facd8@perex.cz>
 <20200617125716.GA273906@workstation>
 <350b8bbe-afed-294f-a96a-0caf99ecb567@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350b8bbe-afed-294f-a96a-0caf99ecb567@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
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

On Wed, Jun 17, 2020 at 03:07:02PM +0200, Jaroslav Kysela wrote:
> > Thanks for your approval. Just now I transferred below four repositories
> > from my account to alsa-project account:
> > 
> >   * https://github.com/alsa-project/alsa-gobject-rs
> >   * https://github.com/alsa-project/libhinawa
> >   * https://github.com/alsa-project/libhinawa-docs
> >   * https://github.com/alsa-project/hinawa-rs
> > 
> > Fortunately I can select the 'gobject-introspection' team as destination
> > of the transferring, but I'm grant for read-only access. Would I request
> > you to grant my account Admin (or Writeable) right?
> > 
> > And you made 'Hinawa' team and put libhinawa/hinawa-rs repositories into
> > it. But in my preference they're in 'gobject-introspection' team as well
> > as alsa-gobject repositories.
> 
> I created new 'Hinawa' team and changed the priviledges for all new repos
> appropriately.
> 
> If something is wrong, let me know.

The half of libhinawa is an application of ALSA hwdep interface to
implement user/kernel interaction described in 'include/uapi/sound/firewire.h'[1].
(The rest is an application of Linux FireWire stack.)

Furthermore, in a point of application of gobject-introspection and
abstraction to a kind of ioctl requests, libhinawa and alsa-gobject has
similar design. For me, it's convenient to put them into the same
'gobject-introspection' team without adding the specific team.

Would I request you to put all of them under 'gobject-introspection'
team, again?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/firewire.h

Thanks

Takashi Sakamoto
