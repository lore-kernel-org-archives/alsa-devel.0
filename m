Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528ADC2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:25:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA9E206B6
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FtcAWsBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA9E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AD5F1661;
	Fri, 14 Feb 2020 15:25:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AD5F1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581690350;
	bh=FzflA8Ztsaw7svr4lkN89QlUTtvCxWgfIw3rIFXCYLI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FtcAWsBsdofbTrHrQCeH3a22rAqZMjZ3/OgzV///BWnOSfBL27Pac2GZ+yYnsupTg
	 ST2CyZaFrjzSvBpmY4kp8pi0JaO5ct42/ZdeGv+KF4S97CE6LF7nPYVtON4bj46Bax
	 R9MXa8svEvPLmW627bxm197guwWyszdxBA8gSgF8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97071F800F0;
	Fri, 14 Feb 2020 15:24:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE76FF8014F; Fri, 14 Feb 2020 15:24:57 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F1D9F80138
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 15:24:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F1D9F80138
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 06:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; d="scan'208";a="223029129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga007.jf.intel.com with ESMTP; 14 Feb 2020 06:24:47 -0800
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1j2btg-001MyR-Vd; Fri, 14 Feb 2020 16:24:48 +0200
Date: Fri, 14 Feb 2020 16:24:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Message-ID: <20200214142448.GK10400@smile.fi.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v3 0/9] x86: Easy way of detecting MS
	Surface 3
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Jan 22, 2020 at 01:22:57PM +0200, Andy Shevchenko wrote:
> While working on RTC regression, I noticed that we are using the same DMI check
> over and over in the drivers for MS Surface 3 platform. This series dedicated
> for making it easier in the same way how it's done for Apple machines.


Any comments on this?

> Changelog v3:
> - fixed typo in patch 5 (Jonathan)
> - returned back to if {} else {} condition in ASoC driver (Mark)
> - added Mark's Ack tag
> 
> Changelog v2:
> - removed RTC patches for now (the fix will be independent to this series)
> - added couple more clean ups to arch/x86/kernel/quirks.c
> - redone DMI quirk to use driver_data instead of callback
> - simplified check in soc-acpi-intel-cht-match.c to be oneliner
> - added a new patch to cover rt5645 codec driver
> 
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Jie Yang <yang.jie@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> 
> Andy Shevchenko (9):
>   x86/platform: Rename x86/apple.h -> x86/machine.h
>   x86/quirks: Add missed include to satisfy static checker
>   x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
>   x86/quirks: Join string literals back
>   x86/quirks: Convert DMI matching to use a table
>   x86/quirks: Add a DMI quirk for Microsoft Surface 3
>   platform/x86: surface3_wmi: Switch DMI table match to a test of
>     variable
>   ASoC: rt5645: Switch DMI table match to a test of variable
>   ASoC: Intel: Switch DMI table match to a test of variable
> 
>  arch/x86/kernel/quirks.c                      | 91 +++++++++++++------
>  drivers/platform/x86/surface3-wmi.c           | 16 +---
>  include/linux/platform_data/x86/apple.h       | 14 +--
>  include/linux/platform_data/x86/machine.h     | 20 ++++
>  sound/soc/codecs/rt5645.c                     | 14 ++-
>  .../intel/common/soc-acpi-intel-cht-match.c   | 28 +-----
>  6 files changed, 93 insertions(+), 90 deletions(-)
>  create mode 100644 include/linux/platform_data/x86/machine.h
> 
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
