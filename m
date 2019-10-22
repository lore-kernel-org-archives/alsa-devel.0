Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C43CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:59:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84000206C2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 23:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QFbqjIJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84000206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBC9C167E;
	Wed, 23 Oct 2019 01:58:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBC9C167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571788751;
	bh=e6y1elyzF5gp8JZxnQ/SAbO2ZakZUXz4csXwQJ8KiYg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFbqjIJmHqx2ptW22LlrVqYgOA4KZ+Rjc6PICoqkpzKxr3pBd9UCYYaAecX2qiS+v
	 CH51GxR3Dk/DLE3D441DUUKfp5wioMm7qKFzYv24kFsxsO3pGKlrLLPZTPY489mQvk
	 e3iK+EbBCmnXLt78KrIlf1KMpl68CZdZo9wYs/Co=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12B99F80638;
	Wed, 23 Oct 2019 01:55:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 539D0F805FA; Wed, 23 Oct 2019 01:55:07 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68A7AF8026A
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 01:55:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68A7AF8026A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 16:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; d="scan'208";a="196612870"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.20.203])
 by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 16:55:01 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 22 Oct 2019 18:54:47 -0500
Message-Id: <20191022235448.17586-5-pierre-louis.bossart@linux.intel.com>
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
Subject: [alsa-devel] [PATCH v3 4/5] soundwire: intel/cadence: add flag for
	interrupt enable
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

Prepare for future PM support and fix error handling by disabling
interrupts as needed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 18 ++++++++++++------
 drivers/soundwire/cadence_master.h |  2 +-
 drivers/soundwire/intel.c          | 13 +++++++------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 7476e867468d..d2c44bfff53a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -815,14 +815,17 @@ EXPORT_SYMBOL(sdw_cdns_exit_reset);
  * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
  * @cdns: Cadence instance
  */
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
 {
-	u32 mask;
+	u32 slave_intmask0 = 0;
+	u32 slave_intmask1 = 0;
+	u32 mask = 0;
+
+	if (!state)
+		goto update_masks;
 
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
-		    CDNS_MCP_SLAVE_INTMASK0_MASK);
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
-		    CDNS_MCP_SLAVE_INTMASK1_MASK);
+	slave_intmask0 = CDNS_MCP_SLAVE_INTMASK0_MASK;
+	slave_intmask1 = CDNS_MCP_SLAVE_INTMASK1_MASK;
 
 	/* enable detection of all slave state changes */
 	mask = CDNS_MCP_INT_SLAVE_MASK;
@@ -845,6 +848,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 	if (interrupt_mask) /* parameter override */
 		mask = interrupt_mask;
 
+update_masks:
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
 	/* commit changes */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 6199e71edeab..a106aea6fe53 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -142,7 +142,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
 int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
-int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
+int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state);
 
 #ifdef CONFIG_DEBUG_FS
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 891cd08e6037..d2fd8bdca55d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -945,7 +945,7 @@ static int intel_probe(struct platform_device *pdev)
 	ret = sdw_add_bus_master(&sdw->cdns.bus);
 	if (ret) {
 		dev_err(&pdev->dev, "sdw_add_bus_master fail: %d\n", ret);
-		goto err_master_reg;
+		return ret;
 	}
 
 	if (sdw->cdns.bus.prop.hw_disabled) {
@@ -976,7 +976,7 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_init;
 	}
 
-	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
+	ret = sdw_cdns_enable_interrupt(&sdw->cdns, true);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
 		goto err_init;
@@ -985,7 +985,7 @@ static int intel_probe(struct platform_device *pdev)
 	ret = sdw_cdns_exit_reset(&sdw->cdns);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
-		goto err_init;
+		goto err_interrupt;
 	}
 
 	/* Register DAIs */
@@ -993,18 +993,18 @@ static int intel_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(sdw->cdns.dev, "DAI registration failed: %d\n", ret);
 		snd_soc_unregister_component(sdw->cdns.dev);
-		goto err_dai;
+		goto err_interrupt;
 	}
 
 	intel_debugfs_init(sdw);
 
 	return 0;
 
-err_dai:
+err_interrupt:
+	sdw_cdns_enable_interrupt(&sdw->cdns, false);
 	free_irq(sdw->res->irq, sdw);
 err_init:
 	sdw_delete_bus_master(&sdw->cdns.bus);
-err_master_reg:
 	return ret;
 }
 
@@ -1016,6 +1016,7 @@ static int intel_remove(struct platform_device *pdev)
 
 	if (!sdw->cdns.bus.prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
+		sdw_cdns_enable_interrupt(&sdw->cdns, false);
 		free_irq(sdw->res->irq, sdw);
 		snd_soc_unregister_component(sdw->cdns.dev);
 	}
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
