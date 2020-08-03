Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:16:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727CA2065E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tPFB8ch2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727CA2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98EE911C;
	Mon,  3 Aug 2020 10:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98EE911C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596442615;
	bh=ZDCEqAWu0KDLEEdI38az63rJuIY8TdhT9DCQlt0fzAU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tPFB8ch2AxFtE+ITZTGaQBi9zEIdmqaoqCzNjOCWTEy7pTCY1JNwoCUKOUFJWBLGc
	 s28HLAqk/qiMo4gxPuFSHVPCSczFWUb9wp3ZPbiFUBDGTghz09eI8OvYYZI5Hg/myu
	 0PkJN5gpNR0LsDwj7ippj1VM2dvAEfq1ZYD/bS10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33008F80148;
	Mon,  3 Aug 2020 10:16:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43B6EF80218; Mon,  3 Aug 2020 10:16:03 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5DE5F80148
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 10:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5DE5F80148
IronPort-SDR: iGGVFHOruth2nm6al98y5R7fFbdXlo2t4xEgh7fMVEpyXGCtTuR34vomaY5vcggTm0+TneKHaI
 Wc6xkwv3qhVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149862300"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; d="scan'208";a="149862300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 01:15:53 -0700
IronPort-SDR: 4lqu+AEIANGtQ9xZ5kBw2ftLxIPwdIklY+f0QZ0LXzkHaOaNwvLBS1nMUi773pN94Fr2wao5Ug
 meu68jSIe1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; d="scan'208";a="436124374"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga004.jf.intel.com with ESMTP; 03 Aug 2020 01:15:50 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@intel.com>)
 id 1k2VdO-005tEJ-8O; Mon, 03 Aug 2020 11:15:50 +0300
Date: Mon, 3 Aug 2020 11:15:50 +0300
From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To: "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH 3/3] ASoC: codec: tlv3204: Moving GPIO reset and add ADC
 reset
Message-ID: <20200803081550.GV3703480@smile.fi.intel.com>
References: <20200729073256.24028-1-michael.wei.hong.sit@intel.com>
 <20200729073256.24028-4-michael.wei.hong.sit@intel.com>
 <e97b37d1-548e-6ede-4015-563d4f67f5e6@ti.com>
 <BYAPR11MB30468CC46295BBA5BEF0FB0C9D710@BYAPR11MB3046.namprd11.prod.outlook.com>
 <20200730123353.GC5055@sirena.org.uk>
 <BYAPR11MB3046A6AB5E7E1A2E2795DD329D4D0@BYAPR11MB3046.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3046A6AB5E7E1A2E2795DD329D4D0@BYAPR11MB3046.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 "a-estrada@ti.com" <a-estrada@ti.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "zakkaye@ti.com" <zakkaye@ti.com>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "Sia, Jee Heng" <jee.heng.sia@intel.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>
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

On Mon, Aug 03, 2020 at 04:54:06AM +0300, Sit, Michael Wei Hong wrote:
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Thursday, 30 July, 2020 8:34 PM
> > On Thu, Jul 30, 2020 at 05:46:20AM +0000, Sit, Michael Wei Hong wrote:
> > From: Alsa-devel <alsa-devel-bounces@alsa-project.org> On Behalf Of Sit,
> > Michael Wei Hong
> > Sent: Thursday, 30 July, 2020 1:46 PM
> > From: Dan Murphy <dmurphy@ti.com>
> > Sent: Wednesday, 29 July, 2020 8:31 PM
> > On 7/29/20 2:32 AM, Michael Sit Wei Hong wrote:

> This code patch is created based on the kernel version 5.8-rc4.
> The register reading and writing are copied from the function aic32x4_component_probe.

Side note. When formatting the patch series, add --base to the `git
format-patch`, so it will add it to cover letter.

-- 
With Best Regards,
Andy Shevchenko


