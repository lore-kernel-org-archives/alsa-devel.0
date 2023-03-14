Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA8C61DA4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Mar 2023 01:45:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC0B51488;
	Tue, 14 Mar 2023 02:44:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC0B51488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678758311;
	bh=GNGs5CqhpeSutHJ3ZnJS8u0595Z/RX0QA49udnu9oCc=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=obTS+UkYnq70XYHDYA091gnFXCVNhWTHqiA3Y32HLRxMPUyFouyZLe/tgKtG7NGce
	 3KoZiHt7murg9MPDtxUvxdzC7YpjPH3bXSBO6MbREKS3o5Hgmiks+yXIKQJDtgcaQP
	 kEHHurnsQoCT/Tv9w5ueF21JznqrdRaIyVV/B3Aw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5AA4F805A8;
	Tue, 14 Mar 2023 02:41:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B33D3F80570; Tue, 14 Mar 2023 02:41:35 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 571A5F80553
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2023 02:41:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 571A5F80553
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kmQwVrV5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758091; x=1710294091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNGs5CqhpeSutHJ3ZnJS8u0595Z/RX0QA49udnu9oCc=;
  b=kmQwVrV5yrwj6WoqsmIX9MnbTekXVelx960+MNWe8nDjigNEjKsqW9Pr
   g8lpJDOolEun/VkQd0WXzrLsjnNrHkaFG+BF7ei9EkskkzmUvBEu6vWzR
   SNku/CnL8iTaHDkNMK3UbBjhkAyoX/L9QzWWlz2moj7E/FemMir8M0bdS
   FxJQfIdHFoprQluI6iGDOQWY4+rpj1Mul4I75L25XVWcv6LxBEMvygvED
   dgxzcLpZI67cLtlblotHodwm9hpRO6YryHgFlAJ0zTHsFMFIFJKIGzk8s
   Mmh2K/dluJzkMqzoIS0kvAHvu4RmOeFfbAwPWEsKwJNk3zr63BeKRxRGm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949282"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="316949282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327485"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400";
   d="scan'208";a="711327485"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2023 18:41:24 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 10/16] soundwire: intel: move bank switch routine to common
 intel_bus_common.c
Date: Tue, 14 Mar 2023 09:54:04 +0800
Message-Id: <20230314015410.487311-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KUIEP2TKEQKTULU2LYGEZPSLATREYDD4
X-Message-ID-Hash: KUIEP2TKEQKTULU2LYGEZPSLATREYDD4
X-MailFrom: yung-chuan.liao@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KUIEP2TKEQKTULU2LYGEZPSLATREYDD4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No functionality change, just moving the routines to a common file so
that they can be used for new hardware.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c            | 49 ----------------------------
 drivers/soundwire/intel.h            |  4 +++
 drivers/soundwire/intel_bus_common.c | 49 ++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1131ecb4b5e7..046c67a2a39b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -682,55 +682,6 @@ static int intel_free_stream(struct sdw_intel *sdw,
 	return 0;
 }
 
-/*
- * bank switch routines
- */
-
-static int intel_pre_bank_switch(struct sdw_intel *sdw)
-{
-	struct sdw_cdns *cdns = &sdw->cdns;
-	struct sdw_bus *bus = &cdns->bus;
-
-	/* Write to register only for multi-link */
-	if (!bus->multi_link)
-		return 0;
-
-	sdw_intel_sync_arm(sdw);
-
-	return 0;
-}
-
-static int intel_post_bank_switch(struct sdw_intel *sdw)
-{
-	struct sdw_cdns *cdns = &sdw->cdns;
-	struct sdw_bus *bus = &cdns->bus;
-	int ret = 0;
-
-	/* Write to register only for multi-link */
-	if (!bus->multi_link)
-		return 0;
-
-	mutex_lock(sdw->link_res->shim_lock);
-
-	/*
-	 * post_bank_switch() ops is called from the bus in loop for
-	 * all the Masters in the steam with the expectation that
-	 * we trigger the bankswitch for the only first Master in the list
-	 * and do nothing for the other Masters
-	 *
-	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
-	 */
-	if (sdw_intel_sync_check_cmdsync_unlocked(sdw))
-		ret = sdw_intel_sync_go_unlocked(sdw);
-
-	mutex_unlock(sdw->link_res->shim_lock);
-
-	if (ret < 0)
-		dev_err(sdw->cdns.dev, "Post bank switch failed: %d\n", ret);
-
-	return ret;
-}
-
 /*
  * DAI routines
  */
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 7a69cf755954..09d479f2c77b 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -201,4 +201,8 @@ void intel_check_clock_stop(struct sdw_intel *sdw);
 int intel_start_bus_after_clock_stop(struct sdw_intel *sdw);
 int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop);
 
+/* common bank switch routines */
+int intel_pre_bank_switch(struct sdw_intel *sdw);
+int intel_post_bank_switch(struct sdw_intel *sdw);
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index 9a06ab58018b..f180e3bea989 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -208,3 +208,52 @@ int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 
 	return 0;
 }
+
+/*
+ * bank switch routines
+ */
+
+int intel_pre_bank_switch(struct sdw_intel *sdw)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+
+	/* Write to register only for multi-link */
+	if (!bus->multi_link)
+		return 0;
+
+	sdw_intel_sync_arm(sdw);
+
+	return 0;
+}
+
+int intel_post_bank_switch(struct sdw_intel *sdw)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+	int ret = 0;
+
+	/* Write to register only for multi-link */
+	if (!bus->multi_link)
+		return 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/*
+	 * post_bank_switch() ops is called from the bus in loop for
+	 * all the Masters in the steam with the expectation that
+	 * we trigger the bankswitch for the only first Master in the list
+	 * and do nothing for the other Masters
+	 *
+	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
+	 */
+	if (sdw_intel_sync_check_cmdsync_unlocked(sdw))
+		ret = sdw_intel_sync_go_unlocked(sdw);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "Post bank switch failed: %d\n", ret);
+
+	return ret;
+}
-- 
2.25.1

