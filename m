Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C085C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 26 May 2022 12:59:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7DB416F9;
	Thu, 26 May 2022 14:58:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7DB416F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653569953;
	bh=teJiEKYqzpxSBTTseMEZIwFcLX9bcRVmUtQT+C/QVnA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=klMFCS/biUdm5NLj1cfMjNhasRIEPd7eeghy+UR8gR52K6aWCxQUeRRGSjIibigCZ
	 8aQQAMwQlXS/Q5na9PnL6AY8TgNnyVw7EM2NleMsO667jIbUCRS5aaNtwNNLibVKl8
	 cIx6/yTnXd2jiafzthSODLcvEdAHaV+9oRhBlhj4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7744CF80137;
	Thu, 26 May 2022 14:58:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BAC8F8007E; Thu, 26 May 2022 14:58:21 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 783CCF8007E
 for <alsa-devel@alsa-project.org>; Thu, 26 May 2022 14:58:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 783CCF8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="WvVyMwea"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="M6fkbFwe"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4E20F5C01B9;
 Thu, 26 May 2022 08:58:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 26 May 2022 08:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1653569893; x=1653656293; bh=q0
 cFLsP9rZBibGeX4KuUoRhQ1SR4hsgOzwzShkXgS3g=; b=WvVyMwea3dzwylXgR0
 Ul89RUIBWJ0DOYRSHdWZFktXC3z4UkpZyKqej4cIQC8xoPcPUnUAu1a/Y41W8DAx
 z+ZV5Rd6BHR6anm/TjhceYzBZXhDrG+P9metjE4Bn+I77/dZ4H0piHzcyNaDYycZ
 q5LXL1FIXIqcSpPD9VY/uJzT3LYxYVJP0OALlGG6l4nfVK1gQLz99PjhrkTK8k9Z
 RA/7cXD4uNwq6yNWpNwwPrefq2xGQgsjgxjf9Rx9FviKlm2YSq8gfzO78xkYz6nI
 QZ9zkcZXkDqX2aMK67Wuuax6yPAi92WW0fJn34sj6wwdMTRZOieOljvyD+eq1T+x
 moXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1653569893; x=1653656293; bh=q0cFLsP9rZBibGeX4KuUoRhQ1SR4
 hsgOzwzShkXgS3g=; b=M6fkbFwe8SGHEG9CVyKRMEhtv3I59br2LWYwFabRL+tr
 9h3XbXfJtRCdAL2jIcqjBlbacJciqw1b/joNDgbhj6m4vMxS8nFAB1vMPrIKK7Dv
 qAvWX8KuFXCjYSQoxXpLAWvhSTd0UtOGSOs0PCaksiJGRWf7ZZp8S3aq3v+co4e/
 8usaqlin7DOx/xFL3/q4I2kyWVj3VQjnZZY8FiGasFoIGa5y+g0f9esbB2WLwWGP
 +klc7GIXBam/z49KW6uvU3JbKSJ0rTr73tqXZ35RytnWzu2FTi2qQNfec0ZVUnlq
 66GP0hrc4K0Gk/uM38B+6Ds7/7jhUZHz7/ypcInQzA==
X-ME-Sender: <xms:ZHmPYucbCNR4KYQOqgcSxqQ8V-aiHF9kMjONNwEzNzZJDdqjlkWvsg>
 <xme:ZHmPYoOHb-PC-vChFqeg1I4l2uJHr5rcPYTgi2DpIGtdGHzEnq6MRutnabmzcKYau
 OrWT7G0awx1A0ulXxg>
X-ME-Received: <xmr:ZHmPYvi8YIhOc2aOh51qgkkuZexwojPiP_unu0gklsyfjg-bur9koqRqggH1VdpmmCXz6Wv1VLEKgJgbqU08IN3X2Q3dkksV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeejgdehjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeduheegueevteeuvdekkedvgfffleeiiedvlefhteet
 tdevteetgfffgeejfeelkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
 ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZHmPYr-xeoQJE2XVpXPFMTV6mGEMjPzOf-1JA_k6JuXZCgz7vB29MA>
 <xmx:ZHmPYqsMR14KgnoKDF2jH2awJf25DDl6hYh7BtzlyGlfVv-mj-7PRg>
 <xmx:ZHmPYiGjLHIWLWVDyWzyr2ToSSwJn6_WyYCCTbBLm_Xvo2o148F9uw>
 <xmx:ZXmPYvWVKLVj1qpbHny0cM2coVhhFvabqFq_CkPzSJ-uP48Oj_4mkA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 May 2022 08:58:11 -0400 (EDT)
Date: Thu, 26 May 2022 21:58:08 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Request for setup of new repositories
Message-ID: <Yo95YGyUSSBOipM2@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>
References: <7d90c47a-ce1a-d9d7-ba8a-e794f20487cb@perex.cz>
 <YmfZxmfv5dfgdYG1@workstation> <YmtNgqfFREYKZM6t@workstation>
 <YnO4A43EUdnG0b7n@workstation>
 <14235475-bd6b-4b86-61f4-8c2aa7f95838@perex.cz>
 <b6e986d0-b594-4543-ae63-e08e88ad3418@www.fastmail.com>
 <YozAmQFZ3LhqQoZN@workstation>
 <afd7c233-39c5-b73f-75c7-728a8abbd434@perex.cz>
 <Yo2JcNT9rQ0xw0+Q@workstation>
 <ef0ab4a6-ed6e-51e5-ffd8-397aa3e289ab@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0ab4a6-ed6e-51e5-ffd8-397aa3e289ab@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>
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

On Wed, May 25, 2022 at 08:37:37AM +0200, Jaroslav Kysela wrote:
> On 25. 05. 22 3:42, Takashi Sakamoto wrote:
> > Thanks for the suggestion. Indeed, we can choose the way to put
> > documentation to specific branch in the repository. I've already
> > investigated the way then had complexed feeling.
> > 
> > ...To be honest, I'd like to avoid it, as much as possible, in a point
> > of the essential concept in source control management. The branching
> > idea forces to put several histories disconnected each other into one
> > repository. It's surely available technically, however I feel sort of
> > awkward somehow.
> > 
> > (I think I'm enough conservative when using tools. I feel something
> > shooting myself in the foot when doing it. It perhaps comes from my
> > experience under UNIX-like environment...)
> > 
> > The separated common repository for documents had room for integration of
> > documentation. For example, I can put library documentations as well as
> > overview page for included software such like Rust crates. It's flexible
> > and logical in a view of top level of software stack.
> 
> It's fine for me. The gobject-introspection-docs is created now.

Great. I pushed some documents except for index page:

 * https://github.com/alsa-project/gobject-introspection-docs

Later I'd like to use Jekyll backend of github pages[1]. Would I ask you
to grant my privilege in the repository so that I can add configuration
for it? I think the same privilege set in libhinawa-docs is enough.

Additionally, please archive below old documentation repositories? I've
already configure them to publish redirect pages. I hear that github
pages service still publish pages for archived repositories.

 * https://github.com/alsa-project/libhinawa-docs/
 * https://github.com/alsa-project/libhitaki-doc/
 * https://github.com/alsa-project/alsa-gobject-docs/

And it's helpful to change page URL in 'About' section of right pane.
(I think it's good to remove it for convenience.)

 * https://github.com/alsa-project/libhinawa/

Today I release new releases for libhinawa and libhitaki. Thanks for
your help.

 * https://github.com/alsa-project/libhitaki/releases/tag/v0.1.0
 * https://github.com/alsa-project/libhinawa/releases/tag/2.5.0

[1] https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll
[2] https://github.com/alsa-project/libhinawa-docs/


Regards

Takashi Sakamoto
