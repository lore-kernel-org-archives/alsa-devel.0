Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EDC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:28:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A2B207DE
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sFKpjcAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A2B207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 658D81716;
	Tue, 18 Aug 2020 05:27:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 658D81716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721293;
	bh=UOKPgZJ5wX9PUa5Zv/0zLEyRdO7zyyw4x9ppyX8e4ks=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFKpjcAQBTo9ar5uX8csr8fb8L1ltLvcCtYytJSAqeYMGGNK+R5y1IDGCspSYlzt2
	 oZ9nslrXLDh+0Wfkfzt0xV+R2xHS/uW4YdhF28m+XRC44iygmi3llu0YaTFwNkzV0P
	 hBzmxApRg46VaBJ8/EMiE07HXAX1us2HhAB9NYCI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64F09F802E0;
	Tue, 18 Aug 2020 05:23:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8267F802F9; Tue, 18 Aug 2020 05:23:44 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C26B1F802E0
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C26B1F802E0
IronPort-SDR: b5t+o1UGuw6+TjfNWyNz0qfBx3ZOxHEY5xsImxPS75nDWATNX5v3Q7hUC9aQZYKXA7dTxskL7N
 5bYXfPFFAewA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152243026"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152243026"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:36 -0700
IronPort-SDR: Wj4fCak+zrkILfBkFtWXpSOQEg6Dys3Yq7izJOvh5/C8Un9Iq6tVG+Akk1LOSq5rfnA+G8OLt4
 J0oXj+aD9j9A==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084609"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:32 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 06/12] soundwire: intel: pm_runtime idle scheduling
Date: Mon, 17 Aug 2020 23:29:17 +0800
Message-Id: <20200817152923.3259-7-yung-chuan.liao@linux.intel.com>
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

Add quirk and pm_runtime idle scheduling to let the Master suspend if
no Slaves become attached. This can happen when a link is not marked
as disabled and has devices exposed in the DSDT, if the power is
controlled by sideband means or the link includes a pluggable
connector.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 95a1d88a5bfb..3f9015dcb693 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -31,8 +31,9 @@
  * flags reused in each byte, with master0 using the ls-byte, etc.
  */
 
-#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME BIT(0)
-#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME		BIT(0)
+#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP		BIT(1)
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE	BIT(2)
 
 static int md_flags;
 module_param_named(sdw_md_flags, md_flags, int, 0444);
@@ -1422,6 +1423,22 @@ int intel_master_startup(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
+	/*
+	 * The runtime PM status of Slave devices is "Unsupported"
+	 * until they report as ATTACHED. If they don't, e.g. because
+	 * there are no Slave devices populated or if the power-on is
+	 * delayed or dependent on a power switch, the Master will
+	 * remain active and prevent its parent from suspending.
+	 *
+	 * Conditionally force the pm_runtime core to re-evaluate the
+	 * Master status in the absence of any Slave activity. A quirk
+	 * is provided to e.g. deal with Slaves that may be powered on
+	 * with a delay. A more complete solution would require the
+	 * definition of Master properties.
+	 */
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+		pm_runtime_idle(dev);
+
 	return 0;
 
 err_interrupt:
@@ -1561,6 +1578,7 @@ static int intel_resume(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1577,6 +1595,10 @@ static int intel_resume(struct device *dev)
 		pm_runtime_set_active(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_enable(dev);
+
+		link_flags = md_flags >> (bus->link_id * 8);
+		if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
+			pm_runtime_idle(dev);
 	}
 
 	ret = intel_init(sdw);
-- 
2.17.1

