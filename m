Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD1C4361B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 05:40:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E23B207A0
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 05:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E23B207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D14C17B0;
	Tue, 15 Dec 2020 06:39:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D14C17B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608010829;
	bh=WSUhMO+a5KTzKt8C61JBxK7/Z4tIaEqtG2wZ2OlyBRc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=czu/Q2D/xrZ1rWPTEUCvkm9iTZQeSqdHAkxpsq1kQCequp/m6dJ87ncR0YPgsHRKO
	 07Ibg/9aUDW4R0hrxRFsL8ShJBAG5F66TprpboSmF3wmbQ7bipJEIehAAHU5aTcjAY
	 xDuHbNlpQG/m/0BaVbWhxR5rhAvnX2RoPUM9FZ0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B4CF80259;
	Tue, 15 Dec 2020 06:39:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26A0AF80278; Tue, 15 Dec 2020 06:39:36 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0082CF8014B
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 06:39:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0082CF8014B
IronPort-SDR: kpgWb7Dtey+61u75cqTHDAzDLv7rZNyB3JUDjzLNs8rH1kRjYv5tBnJDoXFnMi2P2ZdOG9G1di
 NJhFWJsS3cBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="236414220"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="236414220"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 21:39:28 -0800
IronPort-SDR: 4TiTHIGGizS4EfteCBGtwHqfimnBShbEe7TvrWXhsyWwr8G4fD9fxYS10KFOtbE8Z3BSHsGfFk
 Rr0ddENLdt/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="341384666"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga006.jf.intel.com with ESMTP; 14 Dec 2020 21:39:25 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] Enable DMA mode on Intel Keem Bay platform
Date: Tue, 15 Dec 2020 13:33:05 +0800
Message-Id: <20201215053307.24128-1-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, lars@metafoo.de, tiwai@suse.com,
 jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

v1: Initial patch version, to enable DMA mode on Intel Keembay platform.

Michael Sit Wei Hong (2):
  dt-bindings: sound: intel, keembay-i2s: Add info for device to use DMA
  ASoC: Intel: KMB: Enable DMA transfer mode

 .../bindings/sound/intel,keembay-i2s.yaml     |  14 ++
 sound/soc/intel/Kconfig                       |   2 +
 sound/soc/intel/keembay/kmb_platform.c        | 157 ++++++++++++++++--
 sound/soc/intel/keembay/kmb_platform.h        |   9 +
 4 files changed, 167 insertions(+), 15 deletions(-)

-- 
2.17.1

