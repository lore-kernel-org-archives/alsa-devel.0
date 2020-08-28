Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD059C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:21:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A69208C9
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N/tUpK/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A69208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98B7C187C;
	Fri, 28 Aug 2020 16:21:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98B7C187C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598624511;
	bh=PkMf63A54wSl+AcjUbWllnALDzR/QLt7uLaIIbIinZc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/tUpK/k65sU1/ygo8mCP7ke09rMAuNNAg39D4XPHi2Zsn1en6iYG03OPp/Rqk/aJ
	 i3Fvzb85goRc5iKG0mmiNGoacvSRVW+BetDtic4BPkYgyW6PHcVL004S/+NVB0RXRJ
	 s6SOhJCCFrRGqpjIP3zTvDaaFmChN9Mi4z3baVdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26DD5F80143;
	Fri, 28 Aug 2020 16:21:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84AACF8016F; Fri, 28 Aug 2020 16:20:59 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13645F80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 16:20:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13645F80118
IronPort-SDR: AKgzz0cdPH9fA6K2VbgiHNvNVfBNzRgC3p8Jtxz+MvIcBXb4zr5XfKYyzh03UCnVZnUBJOGAVF
 Q5snn/iG6vxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136731457"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; d="scan'208";a="136731457"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2020 07:20:42 -0700
IronPort-SDR: R+b/Q25oLvb4+oq7SsZuIAlHR2bxxrSjfvdm2LP4cc7PdMlHBmiFz8TaCmBJQYMnjhPoI+tpe4
 eZDj0a0WT6ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; d="scan'208";a="329964529"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 28 Aug 2020 07:20:41 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kBfF9-00C8Tm-6x; Fri, 28 Aug 2020 17:20:39 +0300
Date: Fri, 28 Aug 2020 17:20:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: core: Replace dma_request_slave_channel() with
 dma_request_chan()
Message-ID: <20200828142039.GT1891694@smile.fi.intel.com>
References: <20200828140057.4198-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828140057.4198-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Fri, Aug 28, 2020 at 05:00:57PM +0300, Andy Shevchenko wrote:
> Drivers should use dma_request_chan() instead of dma_request_slave_channel().
> 
> dma_request_slave_channel() is a simple wrapper for dma_request_chan() eating
> up the error code for channel request failure and makes deferred probing
> impossible.

It's not fully correct change.

-- 
With Best Regards,
Andy Shevchenko


