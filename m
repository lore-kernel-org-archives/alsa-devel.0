Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2658DC43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:21:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A640620874
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dt1LMgKS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLUsH9lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A640620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2358516CD;
	Fri, 18 Sep 2020 14:20:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2358516CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600431678;
	bh=3nOFvYoQg2i/tbVsyKN4KUNrK0x6V03VkCjdm/fkzDE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dt1LMgKSVaUd4dpnnhTtorjDb/IRj28nVksmqnqmPo4tRjqVH2VVIAwFlfmf2WPuo
	 TJ3GFL0WFY9Jc9PMtCuYVlaQzqIwWbEjbB3AewmNbztqr8phCODeA5c5cPqJ7+jET+
	 RfrKOxtgE7OsXwzvif307b6NgnEiX8PwSHyRmFy8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AE0AF8013A;
	Fri, 18 Sep 2020 14:20:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 446F7F800E8; Fri, 18 Sep 2020 14:20:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F248BF800E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 14:20:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F248BF800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wLUsH9lB"
Received: from localhost (unknown [136.185.124.244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 73D972084C;
 Fri, 18 Sep 2020 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600431616;
 bh=3nOFvYoQg2i/tbVsyKN4KUNrK0x6V03VkCjdm/fkzDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wLUsH9lBcu63YQuT42IJublFyh/I0K7AkDzz4cyJVfBhZVJ9SXpNaVyWbl/D+wLP3
 bTDAKVrMcz0DH38fy3CYn4pjaifCDixtqzGYN9BlnARriOevDKPTEQNJYJAs7Xh6Dy
 TcJdQyVOFhV8YuBxEdJZ7ZUz6ewtm1TCoN9g5ToM=
Date: Fri, 18 Sep 2020 17:50:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH v2 0/2] soundwire: use {u32|u16}p_replace_bits
Message-ID: <20200918122012.GT2968@vkoul-mobl>
References: <DM6PR11MB40749F64E911CF7E430C740EFF3F0@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40749F64E911CF7E430C740EFF3F0@DM6PR11MB4074.namprd11.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "Kale,
 Sanyog R" <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 18-09-20, 12:10, Liao, Bard wrote:
> 
> On 9/17/2020 8:01 PM, Vinod Koul wrote:
> > This is v2 of the series to fix usage of FIELD_PREP and use
> > {u32|u16}p_replace_bits.
> >
> > v1 used u32_replace_bits but looks like it might be removed so use the
> > {u32|u16}p_replace_bits() instead. Also this helped to find that one
> > instance in intel driver should have used u16p_replace_bits() so that is
> > fixed too
> >
> > Vinod Koul (2):
> > soundwire: cadence: use u32p_replace_bits
> > soundwire: intel: use {u32|u16}p_replace_bits
> >
> > drivers/soundwire/cadence_master.c | 21 ++++++++++-----------
> > drivers/soundwire/intel.c | 14 +++++++-------
> > 2 files changed, 17 insertions(+), 18 deletions(-)
> 
> Tested it on a Intel platform. So
> 
> Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Thanks Bard, applied now

-- 
~Vinod
