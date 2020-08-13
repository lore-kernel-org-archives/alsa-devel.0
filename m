Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E80BC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:01:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2DE20829
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MPO+jtpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2DE20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D0EE1616;
	Thu, 13 Aug 2020 18:00:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D0EE1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597334488;
	bh=f3/gj5O99eCJcdga6v2S0Uqo5JeSV/yyj/3oJZTvOBA=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPO+jtpOW8FJtqxLKPa55eJYupgl3g2KcqQreK3M2w4xP8Toi1G7K6Tm9WIk3VSf2
	 YGL4g9SzQk4UBSVBEe89WFgDQ42YwGaw8r/9bOMwfjSEOIf3rsCdjPftNxuirqTKxz
	 gh7OShWM+5wUJFGaw6grq30vDY6NaTR8BHx3DpmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E0CAF8014C;
	Thu, 13 Aug 2020 18:00:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59EC4F8015B; Thu, 13 Aug 2020 18:00:37 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16DC5F800D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 18:00:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16DC5F800D3
IronPort-SDR: Ej0lu/+GpD4WF8BMgQxbpL3C+WRFQxQotyfH9Q7KDL53tFvcLHjwuais6R1r/xh3A6MpGF195o
 wofYtfcGxY9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239084723"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; d="scan'208";a="239084723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 09:00:25 -0700
IronPort-SDR: 5ZGgw6Bewj8yi2nrXQYw5m0dQIam5v1ArBu7YpiccKnRcTnEWXZJIAK+MeIthBfRmwftg/te/M
 lSDf3bjIJfKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; d="scan'208";a="495902736"
Received: from srincon-mobl.ger.corp.intel.com ([10.249.44.242])
 by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2020 09:00:18 -0700
Message-ID: <7f6f652f36d8654560f038326f841624ffeb649a.camel@linux.intel.com>
Subject: Re: [PATCH v4 00/13] ASoC: Intel: Catpt - Lynx and Wildcat point
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Date: Thu, 13 Aug 2020 17:00:10 +0100
In-Reply-To: <20200812205753.29115-1-cezary.rojewski@intel.com>
References: <20200812205753.29115-1-cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: andriy.shevchenko@intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, ppapierkowski@habana.ai, marcin.barlik@intel.com,
 zwisler@google.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 filip.proborszcz@intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, michal.wasko@intel.com, tiwai@suse.com,
 krzysztof.hejmowski@intel.com, cujomalainey@chromium.org,
 vamshi.krishna.gopal@intel.com
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

On Wed, 2020-08-12 at 22:57 +0200, Cezary Rojewski wrote:
> Implement support for Lynxpoint and Wildcat Point AudioDSP. Catpt
> 
> solution deprecates existing sound/soc/intel/haswell which is removed
> in
> 
> the following series. This cover-letter is followed by 'Developer's
> deep
> 
> dive' message schedding light on catpt's key concepts and areas
> 
> addressed.

Whilst I applaud removing the old driver I do NOT support adding yet
*another* Intel audio DSP driver. Our goal is to remove DSP drivers and
unify under one codebase (and this was discussed in Lyon last year at
the audio Miniconf).

Please take all these good improvements and add them into the SOF
driver.

Please also remember that we are adding an IPC abstraction layer into
the SOF driver so it can cope with multiple IPC versions. You are most
welcome to help in this effort.

Thanks

Liam





