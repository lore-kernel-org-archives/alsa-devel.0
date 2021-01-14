Return-Path: <SRS0=k679=GR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF360C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 03:03:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C008236F9
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jan 2021 03:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C008236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B6661680;
	Thu, 14 Jan 2021 04:03:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B6661680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610593431;
	bh=eHyXWYh/dw13YxwVZygs4icW3Ut4lFx5VetsmF29N8w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R5CYHJOFBJb0k5g3+y/i9AmVjvAQNgeC0+SzfeWxd5/fs+71r0ydSENG3Cuz7s143
	 0jiQDR9FNHrJWb9mR6SqhVg475laU3AnVeJEMTLxydYsbcBIdM1D9J/KZtCBpstrGM
	 zk0Argh0DWoFLym0k69M+Wce/gPqD3SvUpdIzfs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95DB0F80249;
	Thu, 14 Jan 2021 04:03:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 122C3F8025E; Thu, 14 Jan 2021 04:02:58 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 533DCF80118
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 04:02:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 533DCF80118
IronPort-SDR: xfkMX9EtqKECZi0X4DH10zmt/U0JC1ft8iN6pJt4hWL4rlygTk+RtCNVpNFIZxlZVxivFvJuvd
 vNVGlo4qGo/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165388936"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; d="scan'208";a="165388936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 19:02:46 -0800
IronPort-SDR: hAwrv6X7KX6ipNg11iCmAaRWauiNhWvyIBFDk9zpNBbic3yVa+WRdaD9KQQRb6WAzzB+qCFxXr
 dfgBbvrlvPuA==
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; d="scan'208";a="382106774"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 19:02:43 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: intel: don't return error when clock stop failed
Date: Thu, 14 Jan 2021 11:02:48 +0800
Message-Id: <20210114030248.9005-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
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

dev->power.runtime_error will be set to the return value of the runtime
suspend callback function, and runtime resume function will return
-EINVAL if dev->power.runtime_error is not 0.

Somehow the codec rarely doesn't return an ACK to the clock prepare
command. If we stop the runtime suspend process and return error, we
will not be able to resume again. Likewise, if the codec lost sync and
did not rejoin, the resume operation will also fail. As a result, the
SoundWire bus can not be used anymore.

This patch suggests to finish the runtime suspend process even if we fail
to stop sdw bus clock. In the case where we do a hardware reset, the codecs
will be reconfigured completely. In the case where we use the regular clock
stop, the codecs keep their state and worst case will fall off the bus and
reattach.

The only drawback is that the power consumption may be higher and
device-initiated interrupts may be lost, but at least audio function can
still work after resume.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 10b60b7b17bb..a2d5cdaa9998 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1673,10 +1673,12 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET ||
 		   !clock_stop_quirks) {
+		bool wake_enable = true;
+
 		ret = sdw_cdns_clock_stop(cdns, true);
 		if (ret < 0) {
 			dev_err(dev, "cannot enable clock stop on suspend\n");
-			return ret;
+			wake_enable = false;
 		}
 
 		ret = sdw_cdns_enable_interrupt(cdns, false);
@@ -1691,7 +1693,7 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 			return ret;
 		}
 
-		intel_shim_wake(sdw, true);
+		intel_shim_wake(sdw, wake_enable);
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.17.1

