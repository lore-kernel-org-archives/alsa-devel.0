Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B9CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:55:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74B12086D
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WTfElhNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74B12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B8FC1660;
	Wed, 23 Oct 2019 01:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B8FC1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571788552;
	bh=kSiS8sgSN4AHYGX5zTxF5zG/KypWp6VQ/eoF82U34VI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WTfElhNYsl8kcUgC4UzqTnODdO/XszI05JCLlogcwaZMUlHKulRIN/u7vbIVfNObt
	 Ugndf/m/7FvCJiG+QYBHauDciBPxH1xQQK1xsUZPSgernS6nWAXIp17eGzB03HuMM3
	 IOSYPhEnXJdluqMVpTDbK/KUKi4r9sJts2CqUK6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA836F802FB;
	Wed, 23 Oct 2019 01:55:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5747FF800C0; Wed, 23 Oct 2019 01:55:00 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99554F800C0
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 01:54:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99554F800C0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 16:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; d="scan'208";a="196612834"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.20.203])
 by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 16:54:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 18:54:43 -0500
Message-Id: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 0/5] soundwire: intel/cadence: better
	initialization
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

Changes since v2: addressed feedback from Vinod Koul on patch 2&4
Add kernel taint when using debugfs hw_reset (similar to regmap)
Remove useless goto label

Changes since v1: addressed feedback from Vinod Koul
clarified init changes impact Intel and Cadence sides
remove unnecessary intermediate variable
disable interrupts when exit_reset fails, updated error handling
returned -EINVAL on debugfs invalid parameter

Pierre-Louis Bossart (5):
  soundwire: intel/cadence: fix startup sequence
  soundwire: cadence_master: add hw_reset capability in debugfs
  soundwire: intel: add helper for initialization
  soundwire: intel/cadence: add flag for interrupt enable
  soundwire: cadence_master: make clock stop exit configurable on init

 drivers/soundwire/cadence_master.c | 134 +++++++++++++++++++++--------
 drivers/soundwire/cadence_master.h |   5 +-
 drivers/soundwire/intel.c          |  39 ++++++---
 3 files changed, 129 insertions(+), 49 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
