Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D08C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 01:24:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E9F2076D
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 01:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GorZ/fcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E9F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 299D2181A;
	Mon, 31 Aug 2020 03:23:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 299D2181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598837045;
	bh=L4CoTQdEXnSYXvZHMlbt4xRnLsxvNk0XwTvpCa5dZ2M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GorZ/fcuAIBih/i9PoXL5lQC8b36fpO7AqCseGhhsOh2+nAjImO5QmLohLuDgtY0+
	 KrqVrfldszpT1t6tXw+J7dQl5yx8qmcyUxL62WXyfAAbUGANi9mj1bu9JZlSoM2BSg
	 9Gm6XstGtAV+A7TBskdyux/sz65YnhXAPIBs5rek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C83F2F802C3;
	Mon, 31 Aug 2020 03:21:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9549AF80278; Mon, 31 Aug 2020 03:21:42 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05623F8012E
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 03:21:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05623F8012E
IronPort-SDR: PzxaYj5cVaxpMnfOS5enzMct5EVmSVg0ODoXpuBDoKGsCpfcOasF2yS0QVgmwWiY+LaEXQYChh
 abr8P0Sz8Ifw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156899771"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="156899771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 18:21:34 -0700
IronPort-SDR: c0Ku5MibqjQ9SDXJS3HHAHkZECjqzsOnDojOkmkmOJfWlXlMLoh93Y2OE6PybBiAGt2qvzIgVd
 yj0v4TE9W+mQ==
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; d="scan'208";a="476529226"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2020 18:21:30 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v3 2/3] soundwire: fix port_ready[] dynamic allocation in
 mipi_disco
Date: Sun, 30 Aug 2020 21:27:41 +0800
Message-Id: <20200830132742.20404-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
References: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
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

The existing code allocates memory for the total number of ports.
This only works if the ports are contiguous, but will break if e.g. a
Devices uses port0, 1, and 14. The port_ready[] array would contain 3
elements, which would lead to an out-of-bounds access. Conversely in
other cases, the wrong port index would be used leading to timeouts on
prepare.

This can be fixed by allocating for the worst-case of 15
ports (DP0..DP14). In addition since the number is now fixed, we can
use an array instead of a dynamic allocation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 18 +-----------------
 drivers/soundwire/slave.c      |  4 ++++
 include/linux/soundwire/sdw.h  |  2 +-
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 4ae62b452b8c..55a9c51c84c1 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -289,7 +289,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	struct sdw_slave_prop *prop = &slave->prop;
 	struct device *dev = &slave->dev;
 	struct fwnode_handle *port;
-	int num_of_ports, nval, i, dp0 = 0;
+	int nval;
 
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
 				 &prop->mipi_revision);
@@ -352,7 +352,6 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			return -ENOMEM;
 
 		sdw_slave_read_dp0(slave, port, prop->dp0_prop);
-		dp0 = 1;
 	}
 
 	/*
@@ -383,21 +382,6 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
 			   prop->sink_ports, "sink");
 
-	/* some ports are bidirectional so check total ports by ORing */
-	nval = prop->source_ports | prop->sink_ports;
-	num_of_ports = hweight32(nval) + dp0; /* add DP0 */
-
-	/* Allocate port_ready based on num_of_ports */
-	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
-					 sizeof(*slave->port_ready),
-					 GFP_KERNEL);
-	if (!slave->port_ready)
-		return -ENOMEM;
-
-	/* Initialize completion */
-	for (i = 0; i < num_of_ports; i++)
-		init_completion(&slave->port_ready[i]);
-
 	return 0;
 }
 EXPORT_SYMBOL(sdw_slave_read_prop);
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 0839445ee07b..a762ee24e6fa 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -25,6 +25,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
 {
 	struct sdw_slave *slave;
 	int ret;
+	int i;
 
 	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
 	if (!slave)
@@ -58,6 +59,9 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	init_completion(&slave->probe_complete);
 	slave->probed = false;
 
+	for (i = 0; i < SDW_MAX_PORTS; i++)
+		init_completion(&slave->port_ready[i]);
+
 	mutex_lock(&bus->bus_lock);
 	list_add_tail(&slave->node, &bus->slaves);
 	mutex_unlock(&bus->bus_lock);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 0aa4c6af7554..63e71645fd13 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -619,7 +619,7 @@ struct sdw_slave {
 	struct dentry *debugfs;
 #endif
 	struct list_head node;
-	struct completion *port_ready;
+	struct completion port_ready[SDW_MAX_PORTS];
 	enum sdw_clk_stop_mode curr_clk_stop_mode;
 	u16 dev_num;
 	u16 dev_num_sticky;
-- 
2.17.1

