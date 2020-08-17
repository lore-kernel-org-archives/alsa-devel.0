Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A6C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:30:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215692054F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iHLABJ7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215692054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E1E21719;
	Tue, 18 Aug 2020 05:29:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E1E21719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721419;
	bh=lJkDK3Cb2nyhSb9RSWPoQ8J6xi83IccIYM+1Vno6TSg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHLABJ7OZyq+q3rCbuDnT/nTdLASQHdvPfAXwHp3BcCSM5cc0sVnzYTDucV5of+px
	 Z+9cOaymnfFLg05lTvOfWLJ9xXk1rk/LK/V2eYnhPBslUvAAMz1hVGUe/AEupE78GI
	 4iJvHDuLCrADE1xl+Z2OC3nlKJ14oECa2Gyko3SQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFF45F80333;
	Tue, 18 Aug 2020 05:24:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A10FEF80322; Tue, 18 Aug 2020 05:23:55 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7258F80307
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7258F80307
IronPort-SDR: yz7oUrORPRqTi4QXlPFoGBzXifzTRSpxH2O6GFamQUxoHCQmPHnwDKplBolQMyfqzaRH5uQxf7
 BVk15UlzT9ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152243051"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152243051"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:51 -0700
IronPort-SDR: 5gxK5uMJyT/dbvPZzsV4y+rb2f3JUG+5YMjCd/4HahUH3FK9W4h9+UMJW46WXLe+LNNgeAKz1u
 ugjvwA1BdUnw==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084675"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:47 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 10/12] soundwire: intel_init: handle power rail
 dependencies for clock stop mode
Date: Mon, 17 Aug 2020 23:29:21 +0800
Message-Id: <20200817152923.3259-11-yung-chuan.liao@linux.intel.com>
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

When none of the clock stop quirks is specified, the Master IP will
assume the context is preserved and will not reset the Bus and restart
enumeration. Due to power rail dependencies, the HDaudio controller
needs to remain powered and prevented from executing its pm_runtime
suspend routine.

This choice of course has a power impact, and this mode should only be
selected when latency requirements are critical or the parent device
can enter D0ix modes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index dd1050743dca..add46d8fc85c 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -73,6 +73,9 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 			pm_runtime_disable(&link->pdev->dev);
 			platform_device_unregister(link->pdev);
 		}
+
+		if (!link->clock_stop_quirks)
+			pm_runtime_put_noidle(link->dev);
 	}
 
 	return 0;
@@ -338,6 +341,16 @@ sdw_intel_startup_controller(struct sdw_intel_ctx *ctx)
 			continue;
 
 		intel_master_startup(link->pdev);
+
+		if (!link->clock_stop_quirks) {
+			/*
+			 * we need to prevent the parent PCI device
+			 * from entering pm_runtime suspend, so that
+			 * power rails to the SoundWire IP are not
+			 * turned off.
+			 */
+			pm_runtime_get_noresume(link->dev);
+		}
 	}
 
 	return 0;
-- 
2.17.1

