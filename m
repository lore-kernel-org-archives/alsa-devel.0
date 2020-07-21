Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F420BC433E4
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC6820674
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vKosH59B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC6820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9CA0839;
	Wed, 22 Jul 2020 10:32:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9CA0839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595406775;
	bh=RX91LDFItxaQZZGMAXCi+agvPiiOhgeC5kWKeq9YV2E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vKosH59BnF58n3+OLzKFwryWetqe7LRy0bvDtLPa0uX6Sgtnx+QNlMB894HyFkIeF
	 uL8SHfHe2/szJ2SWAhxee2eyoy1Et1CZP1jpysWpBB8+sww2mcwGS5KPn4P7/2PYBZ
	 bknF6WCu0DkkVcIp/zKI0Ygy75SCeghKNT6j8+/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CBB0F80161;
	Wed, 22 Jul 2020 10:32:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 177C0F801F5; Wed, 22 Jul 2020 10:32:04 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04508F80139
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 10:31:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04508F80139
IronPort-SDR: QogXXwSOxSHIk+FGCcmzxSh+yT+IOWF1I4japce9n4I089yP2Bx6oUFAhEcCkvjr6nVTXgAT+K
 GWZ7Zx+msMLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="149457241"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="149457241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 01:31:43 -0700
IronPort-SDR: zMd+VLFpbMOrJmmWr/9BSElL1yk2Edq9WGb8p9IFUybiVaKfRysjU8cvlhfZYv/fzhlv65NTuv
 mVVb800E6W5Q==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="432303114"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 01:31:39 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 00/13] soundwire: intel: add power management support
Date: Wed, 22 Jul 2020 04:37:10 +0800
Message-Id: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

Bard Liao (1):
  soundwire: intel: reinitialize IP+DSP in .prepare(), but only when
    resuming

Pierre-Louis Bossart (10):
  soundwire: intel: Add basic power management support
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
 drivers/soundwire/intel.c          | 448 ++++++++++++++++++++++++++++-
 drivers/soundwire/intel.h          |   2 +
 drivers/soundwire/intel_init.c     |  19 +-
 4 files changed, 465 insertions(+), 8 deletions(-)

-- 
2.17.1

