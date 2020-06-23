Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510EC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F0E20768
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b7/WUSR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F0E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A27C17EF;
	Wed, 24 Jun 2020 07:34:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A27C17EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592976904;
	bh=kVR+J/tUxx71xlMbiuF2O7AmytkaCUNXJyUo0LqkcdY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b7/WUSR2RQWtHTpnevK3hcYSyAZTqzFqIAAoyQpcTZkzV+q83C+bIArP8eIYXhLsR
	 caCaVB75TZKBW+epRAu8BMGZJVOAW2eYSCWzz20qVSPI0i1HRlwZwfpR5M57sW70/0
	 3hSl04dLNmw2KBhjR7tsh6wIE2dbBhqiFqjAwZKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77AA0F802E9;
	Wed, 24 Jun 2020 07:30:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89090F802E8; Wed, 24 Jun 2020 07:30:46 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2993BF80268
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 07:30:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2993BF80268
IronPort-SDR: +o4gTL6iKw6OguEeYCwK4EI0O+LI+Mrd3G4vUkMHrcwBloIRP2w4erho9+LauM8VjWiccUozv2
 /vhpcPQK1aWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124007090"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="124007090"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 22:30:16 -0700
IronPort-SDR: O44QHjD7Jj0ESHuJiFKj1pAFKeLXQVMNtQZpIIw4xWGLEqJW96BGJ4WzFalrV2Neg4mGCWefyS
 Vg97XyNOpRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="452513423"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:30:10 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 4/9] soundwire: intel: introduce helper for link
 synchronization
Date: Wed, 24 Jun 2020 01:35:41 +0800
Message-Id: <20200623173546.21870-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

After arming the synchronization, the SYNCGO field controls the
hardware-based synchronization between links.

Move the programming and wait for clear of SYNCGO to dedicated helper.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6a745602c9cc..0a4fc7f65743 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -512,6 +512,31 @@ static void intel_shim_sync_arm(struct sdw_intel *sdw)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
+static int intel_shim_sync_go_unlocked(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	u32 sync_reg;
+	int ret;
+
+	/* Read SYNC register */
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+
+	/*
+	 * Set SyncGO bit to synchronously trigger a bank switch for
+	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
+	 * the Masters.
+	 */
+	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
+			      SDW_SHIM_SYNC_SYNCGO);
+
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "SyncGO clear failed: %d\n", ret);
+
+	return ret;
+}
+
 /*
  * PDI routines
  */
@@ -763,15 +788,8 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 		ret = 0;
 		goto unlock;
 	}
-	/*
-	 * Set SyncGO bit to synchronously trigger a bank switch for
-	 * all the masters. A write to SYNCGO bit clears CMDSYNC bit for all
-	 * the Masters.
-	 */
-	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
 
-	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-			      SDW_SHIM_SYNC_SYNCGO);
+	ret = intel_shim_sync_go_unlocked(sdw);
 unlock:
 	mutex_unlock(sdw->link_res->shim_lock);
 
-- 
2.17.1

