Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A1CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:59:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEDB206C2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h2GF9vsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEDB206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DF43166E;
	Wed, 23 Oct 2019 01:58:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DF43166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571788767;
	bh=F/4EjD803mtLLQRwmZOQJGums5G7Ro+CUDklXR7Yzf4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h2GF9vskiRKu0qNd0eH6J3p0G6auq4dvnj/lrQuECPwGeb11EL2xOum1RuKumkNCW
	 KMJ7xdL596THiAT5ZUQfSHbnBJXTqqkhrRC9An1rstQfytHyDI43nJQ7ny9TZPhgmJ
	 PCAZGAC8mN8wIIGuey63ZdDIoOOibdt1fxQJCQ7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36E73F8063A;
	Wed, 23 Oct 2019 01:55:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2344BF805FD; Wed, 23 Oct 2019 01:55:08 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 989BCF80377
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 01:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 989BCF80377
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 16:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; d="scan'208";a="196612886"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.20.203])
 by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 16:55:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 18:54:48 -0500
Message-Id: <20191022235448.17586-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
References: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 5/5] soundwire: cadence_master: make clock
	stop exit configurable on init
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The use of clock stop is not a requirement, the IP can e.g. be
completely power gated and not detect any wakes while in s2idle/deep
sleep.

For now clock-stop is not supported anyways so the control parameter
is always false. This will be revisited when we add clock stop.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 15 ++++++++-------
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel.c          |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d2c44bfff53a..fed21e2b2277 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -979,7 +979,7 @@ static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
  */
-int sdw_cdns_init(struct sdw_cdns *cdns)
+int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit)
 {
 	struct sdw_bus *bus = &cdns->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -987,12 +987,13 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	int divider;
 	int ret;
 
-	/* Exit clock stop */
-	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
-			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
-	if (ret < 0) {
-		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
-		return ret;
+	if (clock_stop_exit) {
+		ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
+				     CDNS_MCP_CONTROL_CLK_STOP_CLR);
+		if (ret < 0) {
+			dev_err(cdns->dev, "Couldn't exit from clock stop\n");
+			return ret;
+		}
 	}
 
 	/* Set clock divider */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index a106aea6fe53..001457cbe5ad 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -138,7 +138,7 @@ extern struct sdw_master_ops sdw_cdns_master_ops;
 irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
-int sdw_cdns_init(struct sdw_cdns *cdns);
+int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d2fd8bdca55d..99dc61021211 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -909,7 +909,7 @@ static int intel_init(struct sdw_intel *sdw)
 	intel_link_power_up(sdw);
 	intel_shim_init(sdw);
 
-	return sdw_cdns_init(&sdw->cdns);
+	return sdw_cdns_init(&sdw->cdns, false);
 }
 
 /*
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
