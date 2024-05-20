Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE1FC04FFE
	for <alsa-devel@archiver.kernel.org>; Mon, 20 May 2024 13:48:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 887CA820;
	Mon, 20 May 2024 15:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 887CA820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716212920;
	bh=PhZhmPQj8wPJPg41qvten3RwZzl1e+vQG2wGD2LMIYw=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TpiDo500bbPAPW8utDE2+B6INkrC5rGOVbTMGYqZrx0v0qvki4c26mowGPPq8Tsds
	 BquE5jiCwfjgLflOQFzKqEDPM6kl73fnfN6GSBzEyv1DqWMj8jXKDXulXmmbG8L2Rz
	 DaMsSL5oiPfNywIDIuWQ6TUeFg8g0fMgmZdrLbd0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91728F805F0; Mon, 20 May 2024 15:46:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23836F806DA;
	Mon, 20 May 2024 15:46:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2C0DF805B6; Mon, 20 May 2024 14:54:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5F5EF8028B
	for <alsa-devel@alsa-project.org>; Mon, 20 May 2024 14:53:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5F5EF8028B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FuQfmBDa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716209639; x=1747745639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhZhmPQj8wPJPg41qvten3RwZzl1e+vQG2wGD2LMIYw=;
  b=FuQfmBDaG2XPfHK/smCz+1rarn9mCRSdEbXl1T1rLE1r930cW4TP3xN0
   w1Lup5cIrSbbbL3MTaLbvaOHaaomSxNJSdzFBI/X1brfDRQivPYCKMjH5
   oNo7rA45cVVwJ4PPoq8pGL2ccr/NbnpsjiZoRoUVfWT+tyFY53r4Pa+PA
   thWuR/HkPi4tFNf0bgynoNauLp7p17UfVYLbsvDmSyB/8rkl8ShzGkt41
   I5AkQ4sHiIwsUSiW6IT+gy63KvUUdpB5Vr3Q++1EuCYpy73Q+75SvyHFs
   wIH1A3Yy50qxPgEJWVc9+tpHHsezSP6fYGffvJpjYxbHDqdVncq3EQIJd
   Q==;
X-CSE-ConnectionGUID: cyUt92kYTC2FG+TU+Po3Qg==
X-CSE-MsgGUID: FlfzZ6mxQEmmu+jWOxii1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12186652"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000";
   d="scan'208";a="12186652"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 02:31:57 -0700
X-CSE-ConnectionGUID: QskIDXCVR5WhLqW0lWceMQ==
X-CSE-MsgGUID: GCoo0kANQvKKezPGIVwDtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000";
   d="scan'208";a="37237991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 02:31:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s8zN1-00000009GMu-0CCc;
	Mon, 20 May 2024 12:31:51 +0300
Date: Mon, 20 May 2024 12:31:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT
 data
Message-ID: <ZksYhr0mDvMeoZjg@smile.fi.intel.com>
References: <20240518033515.866-1-shenghao-ding@ti.com>
 <ZksYBOk_gHprCd_x@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZksYBOk_gHprCd_x@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID-Hash: ABWNFEXQZUMRT6VCXHJFDBPLJJZTTIS7
X-Message-ID-Hash: ABWNFEXQZUMRT6VCXHJFDBPLJJZTTIS7
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: broonie@kernel.org, i-salazar@ti.com,
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, kevin-lu@ti.com, tiwai@suse.de, baojun.xu@ti.com,
 soyer@irl.hu, Baojun.Xu@fpt.com
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, May 20, 2024 at 12:29:41PM +0300, Andy Shevchenko wrote:
> On Sat, May 18, 2024 at 11:35:15AM +0800, Shenghao Ding wrote:

...

> >  /*
> >   * tas2552.c - ALSA SoC Texas Instruments TAS2552 Mono Audio Amplifier
> >   *
> > - * Copyright (C) 2014 Texas Instruments Incorporated -  https://www.ti.com
> > + * Copyright (C) 2014 - 2024 Texas Instruments Incorporated -
> > + *	https://www.ti.com
> 
> Is it okay to wrap the (c) line? (Just asking.)

In another TI driver the form of

 * Copyright (C) 2014 - 2024 Texas Instruments Incorporated
 * https://www.ti.com

is used, perhaps you should align?

> >   * Author: Dan Murphy <dmurphy@ti.com>
> >   */

-- 
With Best Regards,
Andy Shevchenko


