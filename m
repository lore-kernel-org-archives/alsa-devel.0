Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED655CD3430
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 01:53:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EE6CAEA;
	Tue, 19 Sep 2023 03:52:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EE6CAEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695088393;
	bh=4zCbIXTTo22S+epszTnLGeWY7F3niiZ31jQ1w744zPI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hAZAG60i3ZXnJPqDwAJsSj8a6FkBvflU3AdUyf9gbtozJKaok0C7Pzup2E70YhwpT
	 sgOumK/YWfBtKOtwH/kTO74yCtY07HUGBt8r1FNUby9XPh/c8ivdjdaQiuZOOYFKu2
	 wc7fdLzf4Y1DOkrDDNNyv3q5F7qvOC2KJJjcldUE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68191F80563; Tue, 19 Sep 2023 03:51:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 87D46F80551;
	Tue, 19 Sep 2023 03:51:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49D3FF8047D; Tue, 19 Sep 2023 03:51:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 85183F800F4
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 03:51:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85183F800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ds6eFPzl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695088276; x=1726624276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4zCbIXTTo22S+epszTnLGeWY7F3niiZ31jQ1w744zPI=;
  b=ds6eFPzlcFuDLwbXhzUNd1u9+aDjXJFh+xmGM64gadpraVmr7Eu9f01u
   dVS6VkDjzFGfvWX/GQZUdAI0xg5C2Jt15d4wpd488JMswyajDdFDY21I6
   5tqMeJWPZE8wuEZ3uwDyUtRtsUisPa9W3M1Tgz/QCwLfY7WsSykKccHGf
   MFNTcUiPccx8iA/1bYbf10zcUet5Cv8qxeDjS8f6LAD+o9xNTXtD713jv
   T87QzeZYtZEy+TxV7R91X309h+uABHSu64ilNt0stqkJvqkNK73fXchTb
   oCysNYCSyNT0dzZySgBYdT4HgOBIdS8h0flbYOpBEOPuilNwyBvAHN4/c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377136202"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000";
   d="scan'208";a="377136202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 18:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811545614"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000";
   d="scan'208";a="811545614"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 18:50:57 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com,
	peter.ujfalusi@linux.intel.com
Subject: [PATCH 0/2] ASoC: intel: Add CS42L43 sdw machine driver support
Date: Tue, 19 Sep 2023 10:00:09 +0800
Message-Id: <20230919020011.1896041-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IXJ3RYPPMPLNNZ2BNARWHW42IOII6TDD
X-Message-ID-Hash: IXJ3RYPPMPLNNZ2BNARWHW42IOII6TDD
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IXJ3RYPPMPLNNZ2BNARWHW42IOII6TDD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add cs42l43 codec support to sof_sdw machine driver.

Bard Liao (1):
  ASoC: intel: sof_sdw: Add CS42L43 CODEC support

Chao Song (1):
  ASoC: Intel: soc-acpi-intel-mtl-match: add acpi match table for
    cdb35l56-eight-c

 sound/soc/intel/boards/Kconfig                |   4 +
 sound/soc/intel/boards/Makefile               |   3 +-
 sound/soc/intel/boards/sof_sdw.c              |  27 ++++
 sound/soc/intel/boards/sof_sdw_common.h       |  13 ++
 sound/soc/intel/boards/sof_sdw_cs42l43.c      | 145 ++++++++++++++++++
 .../intel/common/soc-acpi-intel-mtl-match.c   |  78 ++++++++++
 6 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/boards/sof_sdw_cs42l43.c

-- 
2.25.1

