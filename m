Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE6FC3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:14:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF44821473
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nX84de6v";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ0NmxhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF44821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E96F1673;
	Mon, 20 Apr 2020 09:13:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E96F1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587366870;
	bh=xmp2pU3RNE4pr1Ih5vZDQepEAmdemu2mXawUuujDOY8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nX84de6vQyGIFUJ2EIrcJbf+A1oAa7JD6ZOD/HWhTR6MsvEB3mdlHRErxYTed3mzM
	 jesOxD+Sa8TrgJBSOv5V055inUn2kX3OIE6TAYcsD5xuW1bNRL0Mpy4dLp+V16ILnl
	 HYMRvimE1QgKv6Cmew0L0J9qIegSCGPOBdeLRuY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2B1CF8013E;
	Mon, 20 Apr 2020 09:12:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C650BF8021C; Mon, 20 Apr 2020 09:12:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68CC8F8012F
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 09:12:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68CC8F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DZ0NmxhV"
Received: from localhost (unknown [171.61.106.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C8E16206E9;
 Mon, 20 Apr 2020 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587366736;
 bh=xmp2pU3RNE4pr1Ih5vZDQepEAmdemu2mXawUuujDOY8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DZ0NmxhVZhMWlJBq51+bYc9KbAiIhoWZud5Xop9HpuJLReMuFy+FDfO0w54j9he2D
 g80QpRhottoQtlpQ9EOdlte9Xu5yvdHdeAFTOUx33h7RRfFIP6ppq+G3qRBt4XtFyQ
 LALOpWE40Dm9wCvR/rkv2WTPYcnaZzID3sGhvWFQ=
Date: Mon, 20 Apr 2020 12:42:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] soundwire: intel: Make sdw_intel_init static
Message-ID: <20200420071212.GV72691@vkoul-mobl>
References: <20200410115708.27708-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410115708.27708-1-yuehaibing@huawei.com>
Cc: sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On 10-04-20, 19:57, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/soundwire/intel_init.c:193:6: warning:
>  symbol 'sdw_intel_init' was not declared. Should it be static?

Applied, thanks

-- 
~Vinod
