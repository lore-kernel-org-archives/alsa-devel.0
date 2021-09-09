Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C0AC433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 11:52:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B84761AFC
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 11:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B84761AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04ADF16A9;
	Thu,  9 Sep 2021 13:51:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04ADF16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631188331;
	bh=7g7VFpPQn5V3ZUik6UpjDE8iJY3WAIaFuDLTsNOoHTg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ILrbiOH0/PwuuWEMK8SJ6qYj5BLPpURMsBc9bp8zdL8RkRPmg5AQDEPe1PtKJcjfC
	 ZHa9Y5WyLqcp2eL0gaNrmUQKMO3C9RttPZbom8TsB3o8pqMmAFlMBAXdkajrqpUedt
	 r1I1s/Czr6jPe0NwDjwaq55FzKnqgNQB5cBXUBRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E530F804EC;
	Thu,  9 Sep 2021 13:50:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53DDCF802A9; Thu,  9 Sep 2021 13:50:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 005FAF802A9
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 13:50:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 005FAF802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QUz3gWMJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14FD36127B;
 Thu,  9 Sep 2021 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631188223;
 bh=7g7VFpPQn5V3ZUik6UpjDE8iJY3WAIaFuDLTsNOoHTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QUz3gWMJfpGYF/0/TobKFSBSekj4/aANTEnjxe/pVpN3lIAGldxyx2K90TB/BeThc
 toUeNL513gyzVoDxlUJyfm/wqHIEgdS95aCppt34c+L1oHflDb4CBdJkxqE8d1lYq0
 41cn5vDJ4EVijca+kfejjGUtDgajH5Ze6cw/mXcsWsE7vUZuRwR+ZRRMqB7WJbyZL7
 tdervGA65jGyJl45bZWoxhM2EuGsLHtijawjEuYdRTmD1nPu5oJe33it4dgdaCFs6V
 aNLAQs6bF42oS017leOS2xm2QDFshiOe88z7ucKHuFomEC8GndwQmX6YN5I+FYcMUh
 9oEHaefFJcL6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 177/219] soundwire: intel: fix potential race
 condition during power down
Date: Thu,  9 Sep 2021 07:45:53 -0400
Message-Id: <20210909114635.143983-177-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114635.143983-1-sashal@kernel.org>
References: <20210909114635.143983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
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

[ Upstream commit ea6942dad4b2a7e1735aa0f10f3d0b04b847750f ]

The power down sequence sets the link_up flag as false outside of the
mutex_lock. This is potentially unsafe.

In additional the flow in that sequence can be improved by first
testing if the link was powered, setting the link_up flag as false and
proceeding with the power down. In case the CPA bits cannot be
cleared, we only flag an error since we cannot deal with interrupts
any longer.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20210818024954.16873-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fd95f94630b1..c03d51ad40bf 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -537,12 +537,14 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 
 	mutex_lock(sdw->link_res->shim_lock);
 
-	intel_shim_master_ip_to_glue(sdw);
-
 	if (!(*shim_mask & BIT(link_id)))
 		dev_err(sdw->cdns.dev,
 			"%s: Unbalanced power-up/down calls\n", __func__);
 
+	sdw->cdns.link_up = false;
+
+	intel_shim_master_ip_to_glue(sdw);
+
 	*shim_mask &= ~BIT(link_id);
 
 	if (!*shim_mask) {
@@ -559,18 +561,19 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 		link_control &=  spa_mask;
 
 		ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev, "%s: could not power down link\n", __func__);
+
+			/*
+			 * we leave the sdw->cdns.link_up flag as false since we've disabled
+			 * the link at this point and cannot handle interrupts any longer.
+			 */
+		}
 	}
 
 	mutex_unlock(sdw->link_res->shim_lock);
 
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "%s: could not power down link\n", __func__);
-
-		return ret;
-	}
-
-	sdw->cdns.link_up = false;
-	return 0;
+	return ret;
 }
 
 static void intel_shim_sync_arm(struct sdw_intel *sdw)
-- 
2.30.2

