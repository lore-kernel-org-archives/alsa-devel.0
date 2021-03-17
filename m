Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0014C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 20:43:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D3964F33
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D3964F33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF2AF16B9;
	Wed, 17 Mar 2021 21:42:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF2AF16B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616013828;
	bh=4Z/s1L0ujXp2Cf7EmgtzqnZdhCI7caHJcygH4Jzcpmg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNvLMxMPoQ8ZW8gd1au4DNYN0cRnL3uWNGa/qT+pVxl29lTTW9NmU6QAlePl1B9mY
	 Rl8r3idjRECOxTYYVDZwiFJRhLqIAF7WvB0Ell15yHfuOMH5CL1Hj92wL+hjVPZB75
	 eCvnisruV8PSIwnbvaX6DqjmqUySGYquIzzNxwFY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42FFEF801F7;
	Wed, 17 Mar 2021 21:42:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74992F8021C; Wed, 17 Mar 2021 21:42:56 +0100 (CET)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09FBEF80124
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 21:42:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09FBEF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="ld5DyQF+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=wSTffLxRvbfWNiwQavgHvVZJbejq7y1KUbBR2HBcwJs=; b=ld5DyQF+1/bh/cItmNZ3cdq8Kb
 653hzvRn2JLN72BXCkJyr40IsnfRW0UBpZ6hV3z22c69dyhbGLMfcJFT1Eg49ucejtjHx5+W6P6ze
 RCmrHdar7lx3x/P3oPWLdKvNNY1liLrv0nqepyueQyyUMD1hATKch1MNGChz5W74bTbTYzquU5A7P
 k4oKwY+pu0MuHD4hQMZI4+Mw/9z37f8PF8AaqhBmllWB9cu6Xtab8MaOdGC1Yr+LlMgnAs+ZJx+Ry
 155JE7wqJq4R+mwbgrcUqfXCSfl3FYUGc8vUdKmzZOGpWpHHHqruagMmJ4uSa/DyVFkmXb/SeH4Nd
 TRDEiApA==;
Received: from [2601:1c0:6280:3f0::9757]
 by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMcwu-001gdl-Dn; Wed, 17 Mar 2021 20:39:30 +0000
Subject: Re: [PATCH] ALSA: asihpi: fix comment syntax in file headers
To: Aditya Srivastava <yashsri421@gmail.com>, alsa-devel@alsa-project.org
References: <20210317202144.20290-1-yashsri421@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <608b4400-dfda-9702-ae3a-b1bc9aca6da6@infradead.org>
Date: Wed, 17 Mar 2021 13:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317202144.20290-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: lukas.bulwahn@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 tiwai@suse.com, linux-kernel@vger.kernel.org
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

On 3/17/21 1:21 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are files in sound/pci/asihpi which follow this syntax in their file
> headers, i.e. start with '/**' like comments, which causes unexpected
> warnings from kernel-doc.
> 
> E.g., running scripts/kernel-doc -none on sound/pci/asihpi/hpidspcd.h
> causes this warning:
> "warning: Cannot understand
>  on line 4 - I thought it was a doc line"
> 
> Provide a simple fix by replacing the kernel-doc like comment syntax with
> general format, i.e. "/*", to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210312
> 
>  sound/pci/asihpi/hpicmn.h   | 2 +-
>  sound/pci/asihpi/hpidspcd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
> index de3bedd29d94..8ec656cf8848 100644
> --- a/sound/pci/asihpi/hpicmn.h
> +++ b/sound/pci/asihpi/hpicmn.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>  
>      AudioScience HPI driver
>      Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
> diff --git a/sound/pci/asihpi/hpidspcd.h b/sound/pci/asihpi/hpidspcd.h
> index a01e8c6092bd..9f1468ed7096 100644
> --- a/sound/pci/asihpi/hpidspcd.h
> +++ b/sound/pci/asihpi/hpidspcd.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /***********************************************************************/
> -/**
> +/*
>  
>      AudioScience HPI driver
>      Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
> 


-- 
~Randy

