Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A4AC47DD9
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:52:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDD862BF7;
	Wed, 27 Mar 2024 13:51:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDD862BF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711543921;
	bh=PJI3yotieIXJ09NShbI7HjyU5QvebwSEl7+j6u6cYxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=COUDWZZJwgiXsUIAB/oe6x14wQDEKdd0YSOCXNEwG+uRyw7YGrawL2hKHgXcNUDVA
	 q0+/wdKci2pl+hPUA8iXIiGItpMwgQWNDEbUC/chAxdnosCFM/eakmjFb3bXvX1ZuR
	 9x7kZvpd+5Lkf98o5MzOBv9W7tnHaMiiHnG5WdaE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B90F0F801EB; Wed, 27 Mar 2024 13:51:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 706A4F805AA;
	Wed, 27 Mar 2024 13:51:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45BCCF8025F; Wed, 27 Mar 2024 13:51:21 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B973F80093
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 13:51:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B973F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZnnxwCQM
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 04195CE25FC;
	Wed, 27 Mar 2024 12:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C136DC433C7;
	Wed, 27 Mar 2024 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711543866;
	bh=PJI3yotieIXJ09NShbI7HjyU5QvebwSEl7+j6u6cYxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnnxwCQM9WZlqK7t9UoomyEa9q8AnftIYTNv8fiHa+8/T4aM3cXvM2vd6BkUk5zVV
	 Sr99YbyU61VTxJp9JVqpViEytsuR3AX5zbf9J32KfcwXtQJvdphEb0q0wUaVckTqcf
	 nZAnkHQJPaDDzq5nYT0togqvNS0TMjbLpo9LQWOJMV/+hm0HE/9+wuXdZD96sTjKfq
	 ICp1Wf3Fp4fvIsH9E+hsnnIyG/feNzSKoEplNfSao8YTnrVi6Y6jWuGbGpLQTt2AAC
	 iQGeIz2Ph3AdDTBaNvubV3Bmti0htwXRQHKr5JxCj2v42ZDThlN9GhVKdkK01clW6M
	 7bhQ02ASe9cVg==
Date: Wed, 27 Mar 2024 18:21:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 0/7] Soundwire: clean up sysfs group creation
Message-ID: <ZgQWNjZ9EfhU5A9X@matsya>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <ZbpFTyW9UCZdCs_v@matsya>
 <2024032742-armless-cage-7c6c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032742-armless-cage-7c6c@gregkh>
Message-ID-Hash: REFYGXX4XM5AFYHOFROL35DFW5RELTPT
X-Message-ID-Hash: REFYGXX4XM5AFYHOFROL35DFW5RELTPT
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/REFYGXX4XM5AFYHOFROL35DFW5RELTPT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 27-03-24, 09:13, Greg Kroah-Hartman wrote:
> On Wed, Jan 31, 2024 at 06:34:15PM +0530, Vinod Koul wrote:
> > On 30-01-24, 10:46, Greg Kroah-Hartman wrote:
> > > Note, this is a redone version of a very old series I wrote back in
> > > 2022:
> > > 	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
> > > but everyone has forgotten about it now, and I've reworked it, so I'm
> > > considering it a "new" version, and not v2.
> > > 
> > > Here's a series that adds the functionality to the driver core to hide
> > > entire attribute groups, in a much saner way than we have attempted in
> > > the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
> > > this patch.  I'll also be taking this into my driver-core branch and
> > > creating a stable tag for anyone else to pull from to get it into their
> > > trees, as I think it will want to be in many for this development cycle.
> > > 
> > > After the driver core change, there's cleanups to the soundwire core for
> > > how the attribute groups are created, to remove the "manual" creation of
> > > them, and allow the driver core to create them correctly, as needed,
> > > when needed, which makes things much smaller for the soundwire code to
> > > manage.
> > 
> > The series lgtm, having the core handle these would be good. I will wait
> > couple of days for people to test this and give a t-b and apply.
> > I hope it is okay if patch1 goes thru sdw tree?
> 
> patch 1 is now in Linus's tree, so the remaining ones can go through the
> your tree now if you want.  Or I can resend them if needed, just let me
> know.

Great, I was about to ask about this. If there is no conflicts I can
pick this series (looking at folks for giving me a t-b)

-- 
~Vinod
