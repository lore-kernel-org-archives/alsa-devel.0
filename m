Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E568C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:24:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B920716
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j1FojbZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6842216F6;
	Tue, 18 Aug 2020 05:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6842216F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721056;
	bh=HeWaY5RgVzO5+EQb2+SUxpzJm5BWVNcEq2hp53iDQmc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j1FojbZoBsnB+S7oOki6s/cRA4SH4QKGpUljJ87wNEgOR9fI0sPKy72ztGUcMawog
	 TGxjOug7uW24lpbLDwlXD8rTO82iO2eN9EPNXIKPiLYJpRsAmVqLb/ApM1sRL4fyJ6
	 7Ejpmf8kGAtAtNoqen46l42e5W9d1DQJFGAdaUZY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD26DF80273;
	Tue, 18 Aug 2020 05:23:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21C9BF80273; Tue, 18 Aug 2020 05:23:21 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E365F80114
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E365F80114
IronPort-SDR: X8r3yf0XCgsg5APMjQVaquo9dtf4pvFvmXHKiztTr0lW7DeNUSuM+LL/ZzficnKsBesOzZo2O5
 TALw+yE6aLsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152242989"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152242989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:13 -0700
IronPort-SDR: dBqri11ZwARXckzMCI9IAK9ShWp/IapE+rA0W6ovd1YbrdwL8AyUCbE5EkLYuHqkC6zgbr+udy
 IXui0HcAJUBQ==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084518"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 00/12] soundwire: intel: add power management support
Date: Mon, 17 Aug 2020 23:29:11 +0800
Message-Id: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

This series adds power management support for Intel soundwire links.

Changes in v2:
- Move "#include <linux/pm_runtime.h>" to the first required patch.
- Fit debug log in single line. 

Bard Liao (1):
  soundwire: intel: reinitialize IP+DSP in .prepare(), but only when
    resuming

Pierre-Louis Bossart (9):
  soundwire: intel: add pm_runtime support
  soundwire: intel: reset pm_runtime status during system resume
  soundwire: intel: fix race condition on system resume
  soundwire: intel: call helper to reset Slave states on resume
  soundwire: intel: pm_runtime idle scheduling
  soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
  soundwire: intel: add CLK_STOP_NOT_ALLOWED support
  soundwire: intel_init: handle power rail dependencies for clock stop
    mode
  soundwire: intel: support clock_stop mode without quirks

Rander Wang (2):
  soundwire: intel: add CLK_STOP_BUS_RESET support
  soundwire: intel: refine runtime pm for SDW_INTEL_CLK_STOP_BUS_RESET

 drivers/soundwire/cadence_master.h |   4 +
 drivers/soundwire/intel.c          | 363 ++++++++++++++++++++++++++++-
 drivers/soundwire/intel.h          |   2 +
 drivers/soundwire/intel_init.c     |  19 +-
 4 files changed, 382 insertions(+), 6 deletions(-)

-- 
2.17.1

