Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB13CC433C1
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 09:17:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0582C61A1A
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 09:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0582C61A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 830A7165D;
	Fri, 26 Mar 2021 10:16:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 830A7165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616750248;
	bh=vNYnOm7y7Kt1dAzlr/nJsJg2bWbCC1/A9yB5tP6h+Sw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GAu3U/51uqizEtmSBEvXz8L1ci7AkjINn2R/7ZcOAP9Utr2jBZAGbw/67NKc0FFL1
	 ubWkgOn/LxFmHHHvsxwj2O2b8u1zW9jJcwOUd3RXQYOt8K765MpAiIoh8ZqYpcUEGG
	 XCj4vths3a9KHR3FpqUVG6iEHbASV8vyTz7CpxjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18B3BF8032B;
	Fri, 26 Mar 2021 10:15:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A9F4F800D0; Fri, 26 Mar 2021 10:15:45 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9ACAF801D5
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 10:15:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9ACAF801D5
IronPort-SDR: Ya1qnMb+6hsLYEOmoBZw+6xrNNWtllwF7GcWP/evpBEKnuGsjft9TVLtcxLboVhdPjn+4jEhmL
 ZBGLeUT1u7Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="276249429"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; d="scan'208";a="276249429"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 02:15:33 -0700
IronPort-SDR: RF5j6OdW2lolHQ5vDF/92d3zBfcEV2xiffnyqc6SlcHhSoFO9Os8VizvW+SjZ1r9PETWRco5YM
 aE1fsPvIx7zw==
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; d="scan'208";a="416463117"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 02:15:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [RESEND PATCH 02/11] soundwire: bus: test read status
Date: Fri, 26 Mar 2021 17:15:05 +0800
Message-Id: <20210326091514.20751-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
References: <20210326091514.20751-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
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

In the existing code we may read a negative error value but still mask
it and write it back.

Make sure all reads are tested and errors not propagated further.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 04eb879de145..1c01cc192cbd 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -875,8 +875,12 @@ static int sdw_slave_clk_stop_prepare(struct sdw_slave *slave,
 		if (wake_en)
 			val |= SDW_SCP_SYSTEMCTRL_WAKE_UP_EN;
 	} else {
-		val = sdw_read_no_pm(slave, SDW_SCP_SYSTEMCTRL);
-
+		ret = sdw_read_no_pm(slave, SDW_SCP_SYSTEMCTRL);
+		if (ret < 0) {
+			dev_err(&slave->dev, "SDW_SCP_SYSTEMCTRL read failed:%d\n", ret);
+			return ret;
+		}
+		val = ret;
 		val &= ~(SDW_SCP_SYSTEMCTRL_CLK_STP_PREP);
 	}
 
@@ -895,8 +899,12 @@ static int sdw_bus_wait_for_clk_prep_deprep(struct sdw_bus *bus, u16 dev_num)
 	int val;
 
 	do {
-		val = sdw_bread_no_pm(bus, dev_num, SDW_SCP_STAT) &
-			SDW_SCP_STAT_CLK_STP_NF;
+		val = sdw_bread_no_pm(bus, dev_num, SDW_SCP_STAT);
+		if (val < 0) {
+			dev_err(bus->dev, "SDW_SCP_STAT bread failed:%d\n", val);
+			return val;
+		}
+		val &= SDW_SCP_STAT_CLK_STP_NF;
 		if (!val) {
 			dev_info(bus->dev, "clock stop prep/de-prep done slave:%d",
 				 dev_num);
-- 
2.17.1

