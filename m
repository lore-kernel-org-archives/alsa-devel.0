Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BD0C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Apr 2022 02:35:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65B83190A;
	Wed, 20 Apr 2022 04:34:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65B83190A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650422100;
	bh=de3CW2NHaO3Zlt6dACJu87GE5nxvTHKkn6BThHigbYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gm2biT4RbmadbG4w/MrGsJMmq4Bg6uMge8idq2QWfDtXaPi2V62obHrC3roul1pBH
	 eyFubYutc/EYLoQz3a7LVGl/oWsuFngvGmwSC2Sp7alM0SHnjjxAXQsffnGBcvgpA2
	 pqaUamtKlbPzI9ziub6U7mLWzlZ8+rGDveMierWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68470F80516;
	Wed, 20 Apr 2022 04:33:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16EC1F80511; Wed, 20 Apr 2022 04:33:15 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC468F80254
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 04:33:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC468F80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="RYRNdYA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650421989; x=1681957989;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=de3CW2NHaO3Zlt6dACJu87GE5nxvTHKkn6BThHigbYQ=;
 b=RYRNdYA9VpIYvfeaIcpSC70rsz5n5EMIPXQaj4jODRizroE30RL6DjjF
 cPw9AyPFZTWL419WmL/7NjlvglMV0OVktNTQgICy5XtN035JsSus9aDTj
 HAGsVjm4fh1t6ppVOSfTTb/5Siz/vVAK+kV57dt4W8hXnba44H8Z5Pk7A
 NuR/rUHNhO6emWGhp6ZguCfpz5LuT/tC7MY0/aL4ao1/iI7sdO8Pnz6DJ
 H8uz6SciMbwJJUeh7vD3Pc8GXVEySIYAIANDCoqOD889WRNVEo3S8E8En
 1bdU10VDuO0HM8eYTlbsWn2br7wpZvK0i256XBSLgVA2Y+tYp5RNN3mSw Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263384320"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; d="scan'208";a="263384320"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2022 19:33:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; d="scan'208";a="529554573"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2022 19:33:00 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/3] soundwire: intel: disable WAKEEN in pm_runtime resume
Date: Wed, 20 Apr 2022 10:32:40 +0800
Message-Id: <20220420023241.14335-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
References: <20220420023241.14335-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

When the manager device is pm_runtime resumed, we see a series of
spurious wakes and attempts to resume the same device:

soundwire_intel.link.0: intel_resume_runtime: start
soundwire_intel.link.0: intel_link_power_up: powering up all links
soundwire_intel.link.0: intel_link_power_up: first link up, programming SYNCPRD
soundwire_intel.link.0: intel_shim_wake: WAKEEN disabled for link 0
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume start
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume done
soundwire_intel.link.0: intel_shim_wake: WAKEEN disabled for link 0
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume start
soundwire_intel.link.0: intel_link_process_wakeen_event: pm_request_resume done

This sequence does not break anything but is totally unnecessary.

Currently the wakes are only disabled after the peripheral generates a
wake, e.g. for jack detection.

If the resume is initiated by the host drivers as a result of
userspace actions (play/record typically), we need to disable wake
detection as well. Doing so prevents the spurious wakes and calls to
pm_request_resume().

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 32e5fdb823c4..4b458e5e7336 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1831,6 +1831,9 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		return 0;
 	}
 
+	/* unconditionally disable WAKEEN interrupt */
+	intel_shim_wake(sdw, false);
+
 	link_flags = md_flags >> (bus->link_id * 8);
 	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
 
-- 
2.17.1

