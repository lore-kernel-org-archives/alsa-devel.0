Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8014C433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601862076E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ito0aq6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601862076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87BAA1760;
	Tue, 18 Aug 2020 16:36:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87BAA1760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597761426;
	bh=IGbMowwoJnqHeHWISULeSDOwh/Tg4ybiFZLqHqLcFT4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ito0aq6Ad+JxVsjRX0zRlnFTAFjgPvEseafBCQ0dfii+0NA8y1zFLaWyuqbo+nGwC
	 xy5T6Pd+L3gefyCp65rEv7iUOUpoXen/sndynSO5O/15O94BVqm4gzI2xRXckVcfu+
	 FChCNEt8D2j9nklSwQpV/UIX3SMt03WZO2oiHTT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F18CF802A1;
	Tue, 18 Aug 2020 16:35:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F024CF8029A; Tue, 18 Aug 2020 16:35:28 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F971F800D3
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 16:35:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F971F800D3
IronPort-SDR: hb8CWfLkbuKKZNGR+8fIsv0l0Ki8Tp2yZtJyvWfGaSvAHcBQTewIupthtLcUO+jVwZLmpeAkUn
 SJjkik8IfkcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154885433"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="154885433"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 07:35:16 -0700
IronPort-SDR: WyHsuadT6jVo+CUsor5B5qJYHT8X3rCEZB3gty/TmdwcpcbIeFrAaYs5I8fkMhfRY6pUTbtpf+
 61chcvHzMSSQ==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="471830291"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 07:35:12 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 01/11] soundwire: intel: disable shim wake on suspend
Date: Tue, 18 Aug 2020 10:41:10 +0800
Message-Id: <20200818024120.20721-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
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

If we enabled the clock stop mode and suspend, we need to disable the
shim wake. We do so only if the parent is pm_runtime active due to
power rail dependencies.

GitHub issue: https://github.com/thesofproject/linux/issues/1678
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index dbcbe2708563..fe9b92fd48db 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1532,6 +1532,7 @@ static int intel_suspend(struct device *dev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	u32 clock_stop_quirks;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1543,6 +1544,23 @@ static int intel_suspend(struct device *dev)
 	if (pm_runtime_suspended(dev)) {
 		dev_dbg(dev, "%s: pm_runtime status: suspended\n", __func__);
 
+		clock_stop_quirks = sdw->link_res->clock_stop_quirks;
+
+		if ((clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET ||
+		     !clock_stop_quirks) &&
+		    !pm_runtime_suspended(dev->parent)) {
+
+			/*
+			 * if we've enabled clock stop, and the parent
+			 * is still active, disable shim wake. The
+			 * SHIM registers are not accessible if the
+			 * parent is already pm_runtime suspended so
+			 * it's too late to change that configuration
+			 */
+
+			intel_shim_wake(sdw, false);
+		}
+
 		return 0;
 	}
 
-- 
2.17.1

