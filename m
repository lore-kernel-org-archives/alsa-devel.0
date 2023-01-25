Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DC5C27C76
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 12:09:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A159982A;
	Wed, 25 Jan 2023 13:08:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A159982A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674648541;
	bh=eLlpCJ1lvC73OSokB6jzy3k8x0DU4G54/zwEJO2ICAo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ZkTPnP7gumBQnYJIMoxh52Vn/iQ9D3NwxULFaJNNcX/bbKLL8jzxY1ADqqhrX4teZ
	 R8vcdaA2/+3Dl43KnyMg+Y4ksXLd9dRl3jMnLrk0gUHFHiN5383vkrAsSICqbaynzV
	 CilkyzjMJxd4mw+ZMamisxH45ilW7L+RGjMXbS/g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03155F80163;
	Wed, 25 Jan 2023 13:08:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C43E0F802E8; Wed, 25 Jan 2023 13:08:08 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CB9CF800FB
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 13:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CB9CF800FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key, unprotected) header.d=sakamocchi.jp
 header.i=@sakamocchi.jp header.a=rsa-sha256 header.s=fm3 header.b=jrhR6Yg0; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=Nh5CSV4q
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 97B6A5C0176;
 Wed, 25 Jan 2023 07:07:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 25 Jan 2023 07:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1674648479; x=1674734879; bh=DF
 Ne9qYghXCug/YdqS/utMFk4bq0M24IOJ8OklWGuG8=; b=jrhR6Yg0brTuTCvdcJ
 F7v0psCXcOqVU1GBBdLGMR9oOEobP2kENS7BHME5pAiitRdUow68419BKzeSLfK3
 SUuD7BDuGVcy6Hg2hxOxhXVfDYXa/Arix3I0d89UP25DtRHpK24Y70wAtDpfFOZ+
 r1kZhoMk/2Ck6ggersrkyCrk9Qomd5gopztUek8hHSyF0zsITUvCIl2861fFOx2X
 reuoDTi1vzFZmomffGcYFE/e0ChskLB3jv9u0fgRVRDWw1hsZ5tca6rFsGOaCrAW
 +fGPmmfJB5NzHHfgfBg7Q+1tHcZC20inWNAJM21guYbqpIgV3L0IorsR/iPcxngp
 UXbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1674648479; x=1674734879; bh=DFNe9qYghXCug/YdqS/utMFk4bq0
 M24IOJ8OklWGuG8=; b=Nh5CSV4qyllDh0XwusdKRvHn+YQ79vFCYShS/UPZ3CcJ
 mXmfuYzswj+in+Zve01+xkMg7joX+xw2V7a8ERFcg9gR1L58eN3+qm++TYFpxvLn
 oDnbQ/Jn+jaAAKXVYBJwEA/pzHlN1ZfwMZb/aK077j7qJ3o7bnqb5qz21wXavgGH
 TavNmMl9y8RD4tKxB/2nFf4lOAvnOf1QDtjwod3YcqpBTInyBxANBsksyXpapMwf
 d1kTDciS48wwBhWLmGaGq9rj12mr7iOEWVLpAbmaZ+vi8TRm2eKQ1WW16tzdYVtk
 iIaKo8DhhUT7Tn9c1YSNKki44U5QH6NvecuLWgX3rw==
X-ME-Sender: <xms:nxvRY-rcUyX_BiD3uRcBpIMHwSMffzEsvNPvIq2Rl_56br6mpnum2A>
 <xme:nxvRY8pn3RhiwgUrDnK64lPIa379hkArHhLAeVl2bji6hHIS23XiPgXNuxFXIsF7T
 GGueZbOv2Ft4jI_z24>
X-ME-Received: <xmr:nxvRYzMFHVOBSPeql0FfMeReTTNhMhGlvbWOp7lw72jfGB35_Nzui16Xjywt8bnACVihTLG3BNjvJdgEp5u6X8EcY7Aov-NHzn6X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
 ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:nxvRY9507r_LbQ3YVXioK4Upgm-h-AjOasZ1mtoC365C9sc74HCKiQ>
 <xmx:nxvRY976cnIVSPwQgx3BBNlZPYHIr-mm0-hvqrxklrVJj4lcv15mRw>
 <xmx:nxvRY9jg5lFDXM7rp8iGq6WeY9Kf3bP5mAuPn9J42XhE1VVXuJvqcA>
 <xmx:nxvRY3mJSYEYdGSmFvXGgbvF9xRDuYDjcdNBLDWCdXJXCWxcsJ-qfA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:07:57 -0500 (EST)
Date: Wed, 25 Jan 2023 21:07:55 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 0/3] firewire: use single object for user space listeners
 to dispatch request to IEC 61883-1 FCP region
Message-ID: <Y9Ebm7Yw9XT06Hx6@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, stefanr@s5r6.in-berlin.de,
 linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20230120090344.296451-1-o-takashi@sakamocchi.jp>
 <873581r76s.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873581r76s.wl-tiwai@suse.de>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de,
 linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

On Mon, Jan 23, 2023 at 09:22:51AM +0100, Takashi Iwai wrote:
> On Fri, 20 Jan 2023 10:03:41 +0100,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > This patch solves long standing issue mentioned by code comment[1] and a
> > commit 281e20323ab7 ("firewire: core: fix use-after-free regression in FCP
> > handler")[2]. This patchset is based on the kernel tree to which another
> > fix is applied[3].
> > 
> > To Iwai-san, I would like to ask you picking them to your local
> > tree, then send them to mainline tree as well as sound patches when
> > the merge window is open for v6.3 kernel, unless any question and
> > objection is posted. (Additionally, I have prepared the other patchset for
> > the subsystem.)
> 
> As those are spontaneous small fixes, now I merged all three patches
> on topic/firewire branch (on top of the for-linus including your
> previous FireWire core fix), merged back to for-next branch for 6.3.

Thanks for your applying.

> But, I have no will to keep doing this in a long term.  I suppose the
> best would be that you'd step up as a maintainer for FireWire
> stack...

Indeed. The next patchset is beyond your courtesy. I posted it to LKML
with my concern. I'm pleased if you follow to it.

* https://lore.kernel.org/lkml/20230125120301.51585-1-o-takashi@sakamocchi.jp/

> thanks,
> 
> Takashi


Thanks

Takashi Sakamoto
