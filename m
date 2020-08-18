Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE564C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:42:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E061207DA
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t7Tnbw5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E061207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1ACC1769;
	Tue, 18 Aug 2020 16:41:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1ACC1769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597761769;
	bh=VEWeXHW45HNwfkOyH+/Rn+5R5PisIwmeFWq1ozqm8BA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t7Tnbw5x9xolUogTXTItn+b+ENziqCePDhT4jd8DObDWwxvGhFx0M+B4oGafxKOdV
	 G/BF0/g6VXL5grrINm3B8+RT1E0SbFpGQryARo24w9HX9c/eTV6nmAAFB27kmJBHlR
	 z++/ccOp77zzNgJU3CELn0vHd5hrOFj0j5qYwPSQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E8B1F8032A;
	Tue, 18 Aug 2020 16:36:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43BDCF80323; Tue, 18 Aug 2020 16:36:02 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A1DDF80322
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 16:35:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A1DDF80322
IronPort-SDR: 7uc6dLRZDJq0pYxWYoCjLAR3vWaAQCw/+nc1JRvY4cUG1skWUmcI9Wumfx5DEtTdAKYetsLmmt
 3BzQ8A8xgF8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219223608"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="219223608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 07:35:58 -0700
IronPort-SDR: pYASlFNwMd+E6GmvVY2K0hPj6X6RBKwWRPIgbELDlzpSI8BP2Gv2bFjzeOhMIX99aZ3keJVKEq
 bIv23cQ8RUSw==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; d="scan'208";a="471830800"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 07:35:54 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 11/11] soundwire: intel: don't manage link power individually
Date: Tue, 18 Aug 2020 10:41:20 +0800
Message-Id: <20200818024120.20721-12-yung-chuan.liao@linux.intel.com>
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

Each link has separate power controls, but experimental results show
we need to use an all-or-none approach to the link power management.

This change has marginal power impacts, the DSP needs to be powered
anyways before SoundWire links can be powered, and even when powered a
link can be in clock-stopped mode.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 70 +++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b82d02af3c4f..154aa7c0561a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -63,7 +63,9 @@ MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off
 #define SDW_SHIM_WAKESTS		0x192
 
 #define SDW_SHIM_LCTL_SPA		BIT(0)
+#define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
 #define SDW_SHIM_LCTL_CPA		BIT(8)
+#define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
 
 #define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
@@ -295,8 +297,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	u32 *shim_mask = sdw->link_res->shim_mask;
 	struct sdw_bus *bus = &sdw->cdns.bus;
 	struct sdw_master_prop *prop = &bus->prop;
-	int spa_mask, cpa_mask;
-	int link_control;
+	u32 spa_mask, cpa_mask;
+	u32 link_control;
 	int ret = 0;
 	u32 syncprd;
 	u32 sync_reg;
@@ -319,6 +321,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
 
 	if (!*shim_mask) {
+		dev_dbg(sdw->cdns.dev, "%s: powering up all links\n", __func__);
+
 		/* we first need to program the SyncPRD/CPU registers */
 		dev_dbg(sdw->cdns.dev,
 			"%s: first link up, programming SYNCPRD\n", __func__);
@@ -331,21 +335,24 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 		/* Set SyncCPU bit */
 		sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
 		intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
-	}
 
-	/* Link power up sequence */
-	link_control = intel_readl(shim, SDW_SHIM_LCTL);
-	spa_mask = (SDW_SHIM_LCTL_SPA << link_id);
-	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
-	link_control |=  spa_mask;
+		/* Link power up sequence */
+		link_control = intel_readl(shim, SDW_SHIM_LCTL);
 
-	ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "Failed to power up link: %d\n", ret);
-		goto out;
-	}
+		/* only power-up enabled links */
+		spa_mask = sdw->link_res->link_mask <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_SPA_MASK);
+		cpa_mask = sdw->link_res->link_mask <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_CPA_MASK);
+
+		link_control |=  spa_mask;
+
+		ret = intel_set_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev, "Failed to power up link: %d\n", ret);
+			goto out;
+		}
 
-	if (!*shim_mask) {
 		/* SyncCPU will change once link is active */
 		ret = intel_wait_bit(shim, SDW_SHIM_SYNC,
 				     SDW_SHIM_SYNC_SYNCCPU, 0);
@@ -483,7 +490,7 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 
 static int intel_link_power_down(struct sdw_intel *sdw)
 {
-	int link_control, spa_mask, cpa_mask;
+	u32 link_control, spa_mask, cpa_mask;
 	unsigned int link_id = sdw->instance;
 	void __iomem *shim = sdw->link_res->shim;
 	u32 *shim_mask = sdw->link_res->shim_mask;
@@ -493,24 +500,39 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 
 	intel_shim_master_ip_to_glue(sdw);
 
-	/* Link power down sequence */
-	link_control = intel_readl(shim, SDW_SHIM_LCTL);
-	spa_mask = ~(SDW_SHIM_LCTL_SPA << link_id);
-	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
-	link_control &=  spa_mask;
-
-	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
-
 	if (!(*shim_mask & BIT(link_id)))
 		dev_err(sdw->cdns.dev,
 			"%s: Unbalanced power-up/down calls\n", __func__);
 
 	*shim_mask &= ~BIT(link_id);
 
+	if (!*shim_mask) {
+
+		dev_dbg(sdw->cdns.dev, "%s: powering down all links\n", __func__);
+
+		/* Link power down sequence */
+		link_control = intel_readl(shim, SDW_SHIM_LCTL);
+
+		/* only power-down enabled links */
+		spa_mask = (~sdw->link_res->link_mask) <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_SPA_MASK);
+		cpa_mask = sdw->link_res->link_mask <<
+			SDW_REG_SHIFT(SDW_SHIM_LCTL_CPA_MASK);
+
+		link_control &=  spa_mask;
+
+		ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	}
+
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+
 	mutex_unlock(sdw->link_res->shim_lock);
 
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "%s: could not power down link\n", __func__);
+
 		return ret;
+	}
 
 	sdw->cdns.link_up = false;
 	return 0;
-- 
2.17.1

