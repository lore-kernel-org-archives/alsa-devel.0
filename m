Return-Path: <SRS0=Dw+a=JH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F305C433ED
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Apr 2021 08:21:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46142611AE
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Apr 2021 08:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46142611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2409C10E;
	Sat, 10 Apr 2021 10:20:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2409C10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618042882;
	bh=zAaJjbzQ842pmvvgwjFKRW1oLnNzcuGyn0iCkxB53vs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vOBKozvCpgAuegSvrraE65yjPRnNH/e1RwIYxbxoL/85ybfsDoXkJfszeZ1qzW3D/
	 Samte7OicFUDwyrv/P93KFQNmqN0y6ZwBpHBPa31IDXyCvWanlXV3TzMC9nqJoIrAO
	 VZTZd4EgCn/16Fpj/iauHDR0obRYXbwtOXYqCde8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6363F800EE;
	Sat, 10 Apr 2021 10:20:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D827F8020B; Sat, 10 Apr 2021 10:20:29 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EE6BF800EE
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 10:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EE6BF800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="cboawYfb"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="QiBGwwWx"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 75D905C0103;
 Sat, 10 Apr 2021 04:20:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sat, 10 Apr 2021 04:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=W83yGO2rkerVfs/mJE87JSRciPc
 FT745ZrHS2wcIP34=; b=cboawYfbtR53on/R1iHUTG5X7Z5TnEvRbcboiUFRiqz
 r12D0yMu+yeE6PaG8YSxsvRvaY9CiIxXQESUmolHaYIRQ5oJ0fz1FC67287VQOqn
 FoHY7TUPZAKssiFh4xoAK5We20X2Zh/XHRYaiMHDvem3FUXVFLmLIpLV4SIHCv4P
 xfEktFk5HAXUX2uY+43/eXiPh8JEo9/lXMUe/P0u6Sah5J5Ub7eQt06BpbogiTKT
 M37drGSoQvehnxlfgSgaGgQcnhprTuCuTrR5v3XAsBjWl1FgNQgLTHaI96TfSXB7
 w77ticWEPFO/SFpn1gZVSW8kbacMGWM0QGzxdbqOF6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W83yGO
 2rkerVfs/mJE87JSRciPcFT745ZrHS2wcIP34=; b=QiBGwwWxkntZ0wzA24Wpyi
 hRujgMImzmfLpSORC4KdAHLXfs7H9TGFU+JygD8SS1AO+LelCx5MBypoMSbVW+p3
 RjLKNTDulCNki1PJMnn9XDVuMsX1v8XXIEjGQsc1mm4lbqoswUw72GXFYFxCQWG3
 J15UNrRNHhQsij/t7HbIqHG0142DXYE+UFUGfrEdNTgxc6CcmVxyaePXCWpgzffI
 LRKHGrCGc6eO5KsmMTx/vglOAk/wlRhcF6qbScnmy3L0hDohAJibZfsNUBk7vkLp
 hPTr0zPezNdrky23a/4z6s3PUIckoc/NTpAaPR72P4BaWNLXtNPkj1KWAqOYIcuw
 ==
X-ME-Sender: <xms:xF9xYEaCKt5S9aD6RnV6NY0Zf-7T9cvlq2mHgBd6Unfa0qWy2LVDrA>
 <xme:xF9xYPZ3ot1Uk6xzkaWgghwhL9V9ig1KAE3xOYP1g_r2ug1P5otDyzO6Imy-iiPMr
 xUOeEuXnjHcJJuUE_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekfedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
 tddtgeetjeekvdefgeefhfenucfkphepudegrdefrdeihedrudejheenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
 rghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xF9xYO9vHDiEMpJzn-7A5flj3P6Ksmf0YmnknUkw8XxYGQ2-iMHGbg>
 <xmx:xF9xYOrO4ye8FA9D8jUqmZgm1mgcYh0gAx6wXyOjJKXjMIBNO4jZSw>
 <xmx:xF9xYPoZ4Y-kk35w4RE29njc1OjC9pmQR28GQpzG9pbaSMZhb4ttDA>
 <xmx:xV9xYJFzxQoI6u88scF4PDbKHfJZuu2qJqOtgZQN_AkrCqsVSuzx5Q>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6A4CF24005E;
 Sat, 10 Apr 2021 04:20:19 -0400 (EDT)
Date: Sat, 10 Apr 2021 17:20:16 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3] ALSA: control: Add memory consumption limit to user
 controls
Message-ID: <20210410082016.GA10316@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20210408103149.40357-1-o-takashi@sakamocchi.jp>
 <20210408105025.GB40407@workstation> <s5h1rbl80yy.wl-tiwai@suse.de>
 <20210409022735.GA3776@workstation> <s5h5z0v67wh.wl-tiwai@suse.de>
 <s5hsg3z4ezl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsg3z4ezl.wl-tiwai@suse.de>
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

On Fri, Apr 09, 2021 at 06:09:02PM +0200, Takashi Iwai wrote:
> On Fri, 09 Apr 2021 12:59:10 +0200,
> Takashi Iwai wrote:
> > 
> > On Fri, 09 Apr 2021 04:27:35 +0200,
> > Takashi Sakamoto wrote:
> > > 
> > > 4. Add `max_user_ctl_alloc_size` kobject attribute to the control device
> > > 
> > > In the patch, a new module parameter 'max_user_ctl_alloc_size' is added.
> > > In the item, I use the value of this parameter as initial value per
> > > control device. The value per control device can be changed via sysfs
> > > node.
> > > 
> > > The `max_user_ctl_alloc_size` is really the attribute of control device,
> > > so I think it acceptable. Additionally, 'curr_user_ctl_alloc_size' is
> > > also added so that userspace applications get current status.
> > 
> > So that's the primary purpose?  Then it makes sense, yeah.
> 
> You meant something like below, right?

If you were carefully reading my items in the order, you would have
realized that the patch includes problem to share attribute group
table between several modules...

Device attribute is one of userspace interface expected to be stable. I'd
like to avoid careless changes which our known developer tends to do.


Thanks

Takashi Sakamoto
