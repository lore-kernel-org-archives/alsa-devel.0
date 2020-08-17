Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76197C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:30:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24A3207DE
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BYYBC6KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A3207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C46B1726;
	Tue, 18 Aug 2020 05:29:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C46B1726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721398;
	bh=dbMz36uvgxZ3NEgtz+yQMBT5SO/ec3+4Nz+rLX86uqk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BYYBC6KKoWcLYiVyurqejbctx+Ajf2H6+NfPpsuUsV9umOC6itYsRouKLtRKgFaYC
	 Kd6LjG7L5XyUCPNFv9x7NZtNZedxzaYNrIZ2vaoRQugnEKqmAE1Ctx3lVuK4p0RAgZ
	 PkyJrKHtgSApu57xbKRGQTJCc8VgQyPJdvcUd/bk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87A10F80329;
	Tue, 18 Aug 2020 05:23:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37EA3F80307; Tue, 18 Aug 2020 05:23:52 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E294F802FB
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E294F802FB
IronPort-SDR: nc5eT6bHhYbc8r/AONp4Y9hfttcaHqR1Ru2UJX8OHkzeXQ/c1FR/PjENdtpiF6K3l74TgY3cyS
 d0qV+3cDAo3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152243046"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152243046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:47 -0700
IronPort-SDR: xDqN1dgdDYDwVq+SeaUu259O1Kh52s9XmxAfAgtveXmBMi9SJcGrjrt3kAgQcxET5VTi57MJ8x
 Q0vGgDM+YHtA==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084662"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:44 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 09/12] soundwire: intel: add CLK_STOP_NOT_ALLOWED support
Date: Mon, 17 Aug 2020 23:29:20 +0800
Message-Id: <20200817152923.3259-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In case the clock needs to keep running, we need to prevent the Master
from entering pm_runtime suspend.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ad476e9e4d25..95b14c034ea7 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1367,6 +1367,7 @@ int intel_master_startup(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	int link_flags;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1423,6 +1424,20 @@ int intel_master_startup(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
+	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_NOT_ALLOWED) {
+		/*
+		 * To keep the clock running we need to prevent
+		 * pm_runtime suspend from happening by increasing the
+		 * reference count.
+		 * This quirk is specified by the parent PCI device in
+		 * case of specific latency requirements. It will have
+		 * no effect if pm_runtime is disabled by the user via
+		 * a module parameter for testing purposes.
+		 */
+		pm_runtime_get_noresume(dev);
+	}
+
 	/*
 	 * The runtime PM status of Slave devices is "Unsupported"
 	 * until they report as ATTACHED. If they don't, e.g. because
@@ -1454,6 +1469,11 @@ static int intel_master_remove(struct platform_device *pdev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 
+	/*
+	 * Since pm_runtime is already disabled, we don't decrease
+	 * the refcount when the clock_stop_quirk is
+	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
+	 */
 	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(cdns, false);
-- 
2.17.1

