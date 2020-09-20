Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29A1C43464
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:27:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC3720809
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Oa5owpZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC3720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F18851685;
	Mon, 21 Sep 2020 09:26:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F18851685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600673267;
	bh=L7gCoutAqUaMTCKwLWTn3ByUDWnpYqe2xHheEn5zjkA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oa5owpZ+g4Jl2DFCKZOrCjJ50dyinWPh1pk+fmdEiMLU9/Z8n79TVJ2XXh3kUxYNn
	 XyYm2hqo3f6xvF1PMqqYOjolCw0r+5es2q6ZUFsyKtf+5Robghh1fA8tYgAzdVbjMV
	 zlhDeipqsNw2h5LOSvyWmLwfM6Rf4ua12d+j+Auw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94761F8010A;
	Mon, 21 Sep 2020 09:26:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 637AFF8020B; Mon, 21 Sep 2020 09:26:03 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55D05F80161
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 09:25:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55D05F80161
IronPort-SDR: E2Zz1JVo3tbIVrfjlbYBiYlKKlbmuX0W+rfe0ZEmn/eaMs/ZJ1RrJTB7w2jHiSVaxLbrb+r1Nv
 GkLuA9M6P0EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="139824319"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="139824319"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 00:25:50 -0700
IronPort-SDR: +qgGxdqkA9kvl1l8IYmjEqUazUR7QlMFV9H6Bq9BP4aI6sFrew9yzR5xeqfbBa6ryMsKedWiZV
 yauW35r8YXpQ==
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="485325645"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 00:25:46 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/3] soundwire: enable Data Port test modes
Date: Mon, 21 Sep 2020 03:32:05 +0800
Message-Id: <20200920193207.31241-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200920193207.31241-1-yung-chuan.liao@linux.intel.com>
References: <20200920193207.31241-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
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

Test modes are required for all SoundWire IP, and help debug
integration issues. In theory each port can be configured with a
different mode but to simplify this patch only offers separate
configurations for the Master and Slave ports - this covers 99% of the
intended cases during platform integration.

The test mode value is set via platform-specific ways.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c                          | 6 ++++++
 drivers/soundwire/generic_bandwidth_allocation.c | 6 ++++--
 drivers/soundwire/stream.c                       | 3 ++-
 include/linux/soundwire/sdw.h                    | 6 ++++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 340fd1e23e5c..e3fe53f38708 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1099,6 +1099,12 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 	int ret;
 	u8 val = 0;
 
+	if (slave->bus->params.s_data_mode != SDW_PORT_DATA_MODE_NORMAL) {
+		dev_dbg(&slave->dev, "TEST FAIL interrupt %s\n",
+			enable ? "on" : "off");
+		mask |= SDW_DPN_INT_TEST_FAIL;
+	}
+
 	addr = SDW_DPN_INTMASK(port);
 
 	/* Set/Clear port ready interrupt mask */
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 6088775b67a5..058cb9cd8547 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -43,6 +43,7 @@ static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 	int port_bo, sample_int;
 	unsigned int rate, bps, ch = 0;
 	unsigned int slave_total_ch;
+	struct sdw_bus_params *b_params = &m_rt->bus->params;
 
 	port_bo = t_data->block_offset;
 
@@ -66,7 +67,7 @@ static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 			sdw_fill_port_params(&p_rt->port_params,
 					     p_rt->num, bps,
 					     SDW_PORT_FLOW_MODE_ISOCH,
-					     SDW_PORT_DATA_MODE_NORMAL);
+					     b_params->s_data_mode);
 
 			port_bo += bps * ch;
 			slave_total_ch += ch;
@@ -92,6 +93,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 	struct sdw_transport_data t_data = {0};
 	struct sdw_port_runtime *p_rt;
 	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_bus_params *b_params = &bus->params;
 	int sample_int, hstart = 0;
 	unsigned int rate, bps, ch, no_ch;
 
@@ -118,7 +120,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 		sdw_fill_port_params(&p_rt->port_params,
 				     p_rt->num, bps,
 				     SDW_PORT_FLOW_MODE_ISOCH,
-				     SDW_PORT_DATA_MODE_NORMAL);
+				     b_params->m_data_mode);
 
 		/* Check for first entry */
 		if (!(p_rt == list_first_entry(&m_rt->port_list,
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f3219d1fa63b..8608b093abcc 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -443,7 +443,8 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 
 	prep_ch.bank = bus->params.next_bank;
 
-	if (dpn_prop->imp_def_interrupts || !dpn_prop->simple_ch_prep_sm)
+	if (dpn_prop->imp_def_interrupts || !dpn_prop->simple_ch_prep_sm ||
+	    bus->params.s_data_mode != SDW_PORT_DATA_MODE_NORMAL)
 		intr = true;
 
 	/*
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index de9ea2ce2d35..41cc1192f9aa 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -554,6 +554,10 @@ enum sdw_port_prep_ops {
  * @bandwidth: Current bandwidth
  * @col: Active columns
  * @row: Active rows
+ * @s_data_mode: NORMAL, STATIC or PRBS mode for all Slave ports
+ * @m_data_mode: NORMAL, STATIC or PRBS mode for all Master ports. The value
+ * should be the same to detect transmission issues, but can be different to
+ * test the interrupt reports
  */
 struct sdw_bus_params {
 	enum sdw_reg_bank curr_bank;
@@ -563,6 +567,8 @@ struct sdw_bus_params {
 	unsigned int bandwidth;
 	unsigned int col;
 	unsigned int row;
+	int s_data_mode;
+	int m_data_mode;
 };
 
 /**
-- 
2.17.1

