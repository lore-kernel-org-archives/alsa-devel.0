Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E84BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:35:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82342083E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tXTN33N3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/HD9M5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82342083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4129616B0;
	Mon, 22 Jun 2020 07:34:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4129616B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592804145;
	bh=E3RXzVUV2XgnYSHsFHYQBv8Wt4U72vQ9giqYbfrpai0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tXTN33N3E7C6T25Y2jmrybvwnKSR0p2ELOwkpyxnzDjKnpWabeSGqfe1DZCMugp7v
	 3bFQKpm1zlkUBqcV/gNbjmuJ+KOQwM+ddJci4xMN8u/vpv3I5SphfpOLYwHwEKOl0A
	 lmA2elr1tuq++7R0IswLrs1CMWZCTLtTYNYFtMUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AF4BF80246;
	Mon, 22 Jun 2020 07:34:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83B47F801DB; Mon, 22 Jun 2020 07:34:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF660F8015A
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 07:34:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF660F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="r/HD9M5I"
Received: from localhost (unknown [171.61.66.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 78482253E9;
 Mon, 22 Jun 2020 05:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592804085;
 bh=E3RXzVUV2XgnYSHsFHYQBv8Wt4U72vQ9giqYbfrpai0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r/HD9M5IHBDvlCPkxSg/s2VSNOE1JY8phHpLiQuVHwgWBzZoQoUtBSXI3GI3aDom8
 BvKAkZVhh8j3nyl8NaWYDQbyj5CawS5c8DZrURjEv8rOmpmJBNMpidK4+TiSzf3d06
 t+qsGvgVMCmzwvP4CuJzG34SpxPyZy5+4GaswZjw=
Date: Mon, 22 Jun 2020 11:04:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/3] ALSA: compress: document the compress gapless audio
 state machine
Message-ID: <20200622053441.GE2324254@vkoul-mobl>
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-3-vkoul@kernel.org>
 <5c878ccf-43dd-4e13-aa6b-a6cb1e82af72@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c878ccf-43dd-4e13-aa6b-a6cb1e82af72@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>
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

On 19-06-20, 09:27, Pierre-Louis Bossart wrote:
> 
> > +For Gapless, we move from running state to partial drain and back, along
> > +with setting of meta_data and signalling for next track ::
> > +
> > +
> > +                                        +----------+
> > +                compr_drain_notify()    |          |
> > +              +------------------------>|  RUNNING |
> > +              |                         |          |
> > +              |                         +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_next_track()
> > +              |                              |
> > +              |                              V
> > +              |                         +----------+
> > +              |                         |          |
> > +              |                         |NEXT_TRACK|
> > +              |                         |          |
> > +              |                         +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_partial_drain()
> > +              |                              |
> > +              |                              V
> > +              |                         +----------+
> > +              |                         |          |
> > +              +------------------------ | PARTIAL_ |
> > +                                        |  DRAIN   |
> > +                                        +----------+
> 
> May I suggest having a single state machine, not a big one and an additional
> partial one. It would help explain why in one case compr_drain_notify()
> triggers a transition to RUNNING while in the other one it goes to SETUP.
> 
> I realize it's more complicated to edit but it'd be easier on
> reviewers/users.

Ell adding stop and transitions would really make it complicated and
gapless is a bit different handling and it looks cleaner this way IMO,
so lets stick to this. Feel free to create one if you are up for it.

-- 
~Vinod
