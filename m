Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CADC46CCD
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Dec 2023 23:37:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E06DDF5;
	Fri, 22 Dec 2023 00:37:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E06DDF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703201871;
	bh=QKRGEb6ntQbbWETEGc52fYWEw4HYQa9uwTHsTB26UVw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bzBVhd7v5rdwgaTXSzZ+Xdp2f9pgE2rWVkAN/bZf774EzgULNSzNE0AS20oaFU7Ep
	 PzD0143p+3MB7sf5uZJo7vTjfspebuGqSe39KkYQDcJC2V1JZzxdkLbvaFwimtpRyR
	 WgHLNKsRyxxY34JjhURjLeSDH7iOqQsVJF6AMpOc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3F44F8057B; Fri, 22 Dec 2023 00:37:18 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B2E9F800D2;
	Fri, 22 Dec 2023 00:37:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6948F8016E; Fri, 22 Dec 2023 00:37:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CBBC0F800D2
	for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2023 00:36:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBBC0F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fjdGkDuD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703201816; x=1734737816;
  h=date:from:to:cc:subject:message-id;
  bh=QKRGEb6ntQbbWETEGc52fYWEw4HYQa9uwTHsTB26UVw=;
  b=fjdGkDuDDEaA4j8+zRvlTpuXgRJcGFaJiqHptnG20XFHREp6or874ogz
   /ipDgbEmIRAMTMZqY+dssPzpIILZKFpAVZcCnzj/2SfPzdWVm4OdLvlXD
   uNVUgHIGfnRlE2eg/P6KmSEz3KqH4bcelpmWV5cgfKf8y3op2BSNdTAx1
   o3Hx9yxUfET0LSVWs1agIDwyiu5TD5oIvlvXC3ApLCo5JzDz7WU6tl0Xw
   5uuY4frKmCgYALznmGThItuJD9oPSLjzQiGfsODPNjf5ZdVlsXEVswyIK
   0wFXu/bpz7yXS4/brqsWdOj+GxeAOnmEWhYNhfTaapW60v4mf6uCcWwmN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3296492"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600";
   d="scan'208";a="3296492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 15:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895268140"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600";
   d="scan'208";a="895268140"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2023 15:36:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGSaG-0008ro-0B;
	Thu, 21 Dec 2023 23:36:23 +0000
Date: Fri, 22 Dec 2023 07:35:36 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 alsa-devel@alsa-project.org, netdev@vger.kernel.org,
 patches@opensource.cirrus.com
Subject: [linux-next:pending-fixes] BUILD REGRESSION
 c6eb02b33bd24f8f4a60947b539db4871ef914cd
Message-ID: <202312220731.p0jrL7zG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Message-ID-Hash: LAD5MGYGTPLX6IXHBMCNXJG6A47QUEYC
X-Message-ID-Hash: LAD5MGYGTPLX6IXHBMCNXJG6A47QUEYC
X-MailFrom: lkp@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LAD5MGYGTPLX6IXHBMCNXJG6A47QUEYC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: c6eb02b33bd24f8f4a60947b539db4871ef914cd  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202312211413.1NkzZWqi-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

sound/pci/hda/cs35l41_hda_property.c:238: undefined reference to `spi_setup'

Unverified Error/Warning (likely false positive, please contact us if interested):

net/core/stream.c:82:13-14: WARNING opportunity for min()

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-051-20231010
    `-- sound-pci-hda-cs35l41_hda_property.c:undefined-reference-to-spi_setup
clang_recent_errors
`-- x86_64-randconfig-102-20231221
    `-- net-core-stream.c:WARNING-opportunity-for-min()

elapsed time: 1457m

configs tested: 2
configs skipped: 0

tested configs:
x86_64                            allnoconfig   gcc  
x86_64                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
