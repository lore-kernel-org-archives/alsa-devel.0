Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D8AC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 03:04:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16272068F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="veqP3u9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16272068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AEC117DD;
	Wed,  2 Sep 2020 05:03:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AEC117DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599015862;
	bh=LdyoNAOTCDidOr7mS9T0/s6JrwJYfjjmv9qWpjknaYY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=veqP3u9Zwhrk+qqaLEvWhlE0f6ornRAZSLKQxknI460s3T4lYnO+LjTkCrSwrt/HW
	 HsDFw99HFszxcRk/o3/5iSdHzANznmiAefA2gbQk4ipLCEpd088bFlUjfuElj7cWDW
	 g2SigSocc06Eh0dYHcj2MY3fZ3YdpttWZYYirkYk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97096F802E7;
	Wed,  2 Sep 2020 05:00:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 224EEF802DB; Wed,  2 Sep 2020 05:00:03 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1273F80212
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 04:59:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1273F80212
IronPort-SDR: QcIsnmFKE4hRrl2gzFg/fCcrzXmmdoJj5TJSd+NqTCtF78K0004mGXfR/vrIw10mquHDJfW1os
 1k7JZPpAIQ4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="156570751"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="156570751"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 19:59:56 -0700
IronPort-SDR: XirWR19BgRgDyggOkar4n1daIoDsUOv7aFYdJG5Jzxq+WnAx3xsbO4v9VhEf/o9GiLpTXo2/c2
 e7uVauAjV/VA==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; d="scan'208";a="283588086"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 19:59:52 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 04/10] soundwire: intel: add missing support for all clock
 stop modes
Date: Tue,  1 Sep 2020 23:05:50 +0800
Message-Id: <20200901150556.19432-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
References: <20200901150556.19432-1-yung-chuan.liao@linux.intel.com>
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

Deal with the BUS_RESET case, which is the default. The only change is
to add support for the exit sequence using the syncArm/syncGo mode for
the exit reset sequence.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 49 +++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 259e3da98e42..8634d33c388c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1868,11 +1868,6 @@ static int intel_resume_runtime(struct device *dev)
 
 		if (!clock_stop0) {
 
-			/*
-			 * Re-initialize the IP since it was powered-off
-			 */
-			sdw_cdns_init(&sdw->cdns);
-
 			/*
 			 * make sure all Slaves are tagged as UNATTACHED and
 			 * provide reason for reinitialization
@@ -1880,13 +1875,31 @@ static int intel_resume_runtime(struct device *dev)
 
 			status = SDW_UNATTACH_REQUEST_MASTER_RESET;
 			sdw_clear_slave_status(bus, status);
-		}
 
+			ret = sdw_cdns_enable_interrupt(cdns, true);
+			if (ret < 0) {
+				dev_err(dev, "cannot enable interrupts during resume\n");
+				return ret;
+			}
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
-			return ret;
+			/*
+			 * follow recommended programming flows to avoid
+			 * timeouts when gsync is enabled
+			 */
+			if (multi_link)
+				intel_shim_sync_arm(sdw);
+
+			/*
+			 * Re-initialize the IP since it was powered-off
+			 */
+			sdw_cdns_init(&sdw->cdns);
+
+		} else {
+			ret = sdw_cdns_enable_interrupt(cdns, true);
+			if (ret < 0) {
+				dev_err(dev, "cannot enable interrupts during resume\n");
+				return ret;
+			}
 		}
 
 		ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
@@ -1894,6 +1907,22 @@ static int intel_resume_runtime(struct device *dev)
 			dev_err(dev, "unable to restart clock during resume\n");
 			return ret;
 		}
+
+		if (!clock_stop0) {
+			ret = sdw_cdns_exit_reset(cdns);
+			if (ret < 0) {
+				dev_err(dev, "unable to exit bus reset sequence during resume\n");
+				return ret;
+			}
+
+			if (multi_link) {
+				ret = intel_shim_sync_go(sdw);
+				if (ret < 0) {
+					dev_err(sdw->cdns.dev, "sync go failed during resume\n");
+					return ret;
+				}
+			}
+		}
 	} else if (!clock_stop_quirks) {
 		ret = intel_init(sdw);
 		if (ret) {
-- 
2.17.1

