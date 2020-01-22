Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE87CC2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:24:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B242465B
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kZtL0zrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B242465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A5F7847;
	Wed, 22 Jan 2020 12:23:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A5F7847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579692249;
	bh=1SNEGAj13zqBV1FdaF9CxhZGmS3H+RTfishMjgh7Lpg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kZtL0zrV28KzTcScO9aLODNGctxeRzDpnvuMXzyLsbW5fX1onFp3YuEUhNR5CnMZd
	 wID2obhc+6NxGUr1HPtmeLxZXJ6dyW74zn4efpRMN7tbTkzNjgyl0FIXEU+X19qXP5
	 T69hxB5qYxvHtkHS1a2/5CZeHnhaIHPaCCxEVxt0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E58F3F800BA;
	Wed, 22 Jan 2020 12:23:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 009E0F8020C; Wed, 22 Jan 2020 12:23:17 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F759F8007E
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 12:23:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F759F8007E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jan 2020 03:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; d="scan'208";a="221209143"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2020 03:23:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 7F6E329B; Wed, 22 Jan 2020 13:23:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Date: Wed, 22 Jan 2020 13:22:57 +0200
Message-Id: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 0/9] x86: Easy way of detecting MS Surface 3
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

While working on RTC regression, I noticed that we are using the same DMI check
over and over in the drivers for MS Surface 3 platform. This series dedicated
for making it easier in the same way how it's done for Apple machines.

Changelog v3:
- fixed typo in patch 5 (Jonathan)
- returned back to if {} else {} condition in ASoC driver (Mark)
- added Mark's Ack tag

Changelog v2:
- removed RTC patches for now (the fix will be independent to this series)
- added couple more clean ups to arch/x86/kernel/quirks.c
- redone DMI quirk to use driver_data instead of callback
- simplified check in soc-acpi-intel-cht-match.c to be oneliner
- added a new patch to cover rt5645 codec driver

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org

Andy Shevchenko (9):
  x86/platform: Rename x86/apple.h -> x86/machine.h
  x86/quirks: Add missed include to satisfy static checker
  x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
  x86/quirks: Join string literals back
  x86/quirks: Convert DMI matching to use a table
  x86/quirks: Add a DMI quirk for Microsoft Surface 3
  platform/x86: surface3_wmi: Switch DMI table match to a test of
    variable
  ASoC: rt5645: Switch DMI table match to a test of variable
  ASoC: Intel: Switch DMI table match to a test of variable

 arch/x86/kernel/quirks.c                      | 91 +++++++++++++------
 drivers/platform/x86/surface3-wmi.c           | 16 +---
 include/linux/platform_data/x86/apple.h       | 14 +--
 include/linux/platform_data/x86/machine.h     | 20 ++++
 sound/soc/codecs/rt5645.c                     | 14 ++-
 .../intel/common/soc-acpi-intel-cht-match.c   | 28 +-----
 6 files changed, 93 insertions(+), 90 deletions(-)
 create mode 100644 include/linux/platform_data/x86/machine.h

-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
