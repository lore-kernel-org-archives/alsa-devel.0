Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E9FC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:31:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3789D2053B
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UXFNZyRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3789D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B974B16FD;
	Tue, 18 Aug 2020 05:30:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B974B16FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721493;
	bh=OU12N0xIwtKIpxoauzHjLnH9K6qMkiHDZvHrYqaZjKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXFNZyRipOsH3dorPqEDceYsvXr/yh8SXZJEM6e45AC/0ZlUzLG9RV0ZIvlLwFSOS
	 K5EJnK8lraxuO28M1TwrWabMFxnakCVFWav78WcfatCOK8qVXkCGed15KrxLbJIg52
	 6BdsFyCJ889oEYoce0Hn1ulJRyPmLBG+cKUxZxnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B96FF80339;
	Tue, 18 Aug 2020 05:24:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44D94F80337; Tue, 18 Aug 2020 05:24:04 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 580E5F80332
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 580E5F80332
IronPort-SDR: uznjGXK0trAT2rjng4qkvu3ockgNndK/40YhR6qwAcHjANWJZKHyBslafSsL1H2AxbH3qvCA01
 8leTf9IVV+5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152243063"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152243063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:59 -0700
IronPort-SDR: /0Oiq2v7oEO84PBx8dCyDdQi/1XbxcWWPi6v556zk6rS9vG1ZN1eleiwG363IJlo5D8HsdMVSm
 gXzHDtA98TLw==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084704"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:55 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 12/12] soundwire: intel: refine runtime pm for
 SDW_INTEL_CLK_STOP_BUS_RESET
Date: Mon, 17 Aug 2020 23:29:23 +0800
Message-Id: <20200817152923.3259-13-yung-chuan.liao@linux.intel.com>
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

From: Rander Wang <rander.wang@intel.com>

When all the links are suspended, the HDaudio controller may suspend
and the power rails to the SoundWire IP may be disabled, requiring a
complete re-initialization/enumeration on resume. However, if one or
more Masters remained active, the HDaudio controller will remain active
and the power rails will remain enabled. As a result, during the link
resume step we can check if the context was preserved by verifying if
the clock was stopped, and avoid doing a complete bus reset and
re-enumeration.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2899445e2649..dbcbe2708563 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1698,6 +1698,8 @@ static int intel_resume_runtime(struct device *dev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	u32 clock_stop_quirks;
+	bool clock_stop0;
+	int status;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1739,11 +1741,24 @@ static int intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
+		/*
+		 * An exception condition occurs for the CLK_STOP_BUS_RESET
+		 * case if one or more masters remain active. In this condition,
+		 * all the masters are powered on for they are in the same power
+		 * domain. Master can preserve its context for clock stop0, so
+		 * there is no need to clear slave status and reset bus.
+		 */
+		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+
 		/*
 		 * make sure all Slaves are tagged as UNATTACHED and
 		 * provide reason for reinitialization
 		 */
-		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+		if (!clock_stop0) {
+			status = SDW_UNATTACH_REQUEST_MASTER_RESET;
+			sdw_clear_slave_status(bus, status);
+		}
+
 
 		ret = sdw_cdns_enable_interrupt(cdns, true);
 		if (ret < 0) {
@@ -1751,7 +1766,7 @@ static int intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
-		ret = sdw_cdns_clock_restart(cdns, true);
+		ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
 		if (ret < 0) {
 			dev_err(dev, "unable to restart clock during resume\n");
 			return ret;
-- 
2.17.1

