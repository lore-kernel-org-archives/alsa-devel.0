Return-Path: <SRS0=GNy4=BY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20854C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 11:09:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDE02078D
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pbxToG2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDE02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CC6F166F;
	Fri, 14 Aug 2020 13:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CC6F166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597403379;
	bh=7CSKCCqQ709+gPRD7j47BM4Pxdm3Bd8xWVNkysHObbU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pbxToG2bl3LE4mLFgq+EuQBtcH9HFH4yjNMt5qhfY8T+D+RWuj+qg30SCsBEu/BNk
	 A1N/xgZo0D0OXx2T0w8rdZdLFjVd/6xboSreWyATiDYLB8rXopP/gCtr0lU00MpRas
	 REz2H5zoNsfO+dkC6POfl1ylwG82qAC6eT4VhC80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09CAAF80245;
	Fri, 14 Aug 2020 13:08:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5714F80247; Fri, 14 Aug 2020 13:08:27 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B243F800D3
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2020 13:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B243F800D3
IronPort-SDR: I44Y3cBPrO5cSYofMRdBWmoztiIGJlmcIai9bsZHPcZSWaAuKB2EUbAqBohwgTa2eC/vb7h/3e
 zEQ9Uy9NgrFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="142229988"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; d="scan'208";a="142229988"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 04:08:13 -0700
IronPort-SDR: 3z9XMhjtuie34GKt6M2+xFCpANpAacs8df7P6eMDN0O/TiilgvNqKkzm4SOdiQRZ/9h5a/xXv2
 /RTRWXQkFLjg==
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; d="scan'208";a="470555463"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 04:08:09 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH] soundwire: SDCA: detect sdca_cascade interrupt
Date: Fri, 14 Aug 2020 07:14:21 +0800
Message-Id: <20200813231421.26252-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
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

The SoundWire 1.2 specification defines an "SDCA cascade" bit which
handles a logical OR of all SDCA interrupt sources (up to 30 defined).

Due to limitations of the addressing space, this bit is located in the
SDW_DP0_INT register when DP0 is used, or alternatively in the
DP0_SDCA_Support_INTSTAT register when DP0 is not used.

To allow for both cases to be handled, this bit will be checked in the
main device-level interrupt handling code. This will result in the
register being read twice if DP0 is enabled, but it's not clear how to
optimize this case. It's also more logical to deal with this interrupt
at the device than the port level, this bit is really not DP0 specific
and its location in the DP0_INTSTAT bit is only due to the lack of
free space in SCP_INTSTAT_1.

The SDCA_Cascade bit cannot be masked or cleared, so the interrupt
handling only forwards the detection to the Slave driver, which will
deal with reading the relevant SDCA status bits and clearing them. The
bus driver only signals the detection.

The communication with the Slave driver is based on the same interrupt
callback, with only an extension to provide the status of the
sdca_cascade bit.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 14 ++++++++++++++
 include/linux/soundwire/sdw.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e6e0fb9a81b4..17c697f5ad78 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1361,6 +1361,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	int port_num, stat, ret, count = 0;
 	unsigned long port;
 	bool slave_notify = false;
+	bool sdca_cascade = false;
 	u8 buf, buf2[2], _buf, _buf2[2];
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
@@ -1388,6 +1389,18 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		goto io_err;
 	}
 
+	if (slave->prop.is_sdca) {
+		ret = sdw_read(slave, SDW_DP0_INT);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+				"SDW_DP0_INT read failed:%d\n", ret);
+			goto io_err;
+		}
+		sdca_cascade = ret & SDW_DP0_SDCA_CASCADE;
+		if (sdca_cascade)
+			slave_notify = true;
+	}
+
 	do {
 		/*
 		 * Check parity, bus clash and Slave (impl defined)
@@ -1453,6 +1466,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		/* Update the Slave driver */
 		if (slave_notify && slave->ops &&
 		    slave->ops->interrupt_callback) {
+			slave_intr.sdca_cascade = sdca_cascade;
 			slave_intr.control_port = clear;
 			memcpy(slave_intr.port, &port_status,
 			       sizeof(slave_intr.port));
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..a51494646a2c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -355,6 +355,7 @@ struct sdw_dpn_prop {
  * @dp0_prop: Data Port 0 properties
  * @src_dpn_prop: Source Data Port N properties
  * @sink_dpn_prop: Sink Data Port N properties
+ * @is_sdca: the Slave supports the SDCA specification
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -376,6 +377,7 @@ struct sdw_slave_prop {
 	struct sdw_dp0_prop *dp0_prop;
 	struct sdw_dpn_prop *src_dpn_prop;
 	struct sdw_dpn_prop *sink_dpn_prop;
+	bool is_sdca;
 };
 
 /**
@@ -465,10 +467,12 @@ struct sdw_slave_id {
 
 /**
  * struct sdw_slave_intr_status - Slave interrupt status
+ * @sdca_cascade: set if the Slave device reports an SDCA interrupt
  * @control_port: control port status
  * @port: data port status
  */
 struct sdw_slave_intr_status {
+	bool sdca_cascade;
 	u8 control_port;
 	u8 port[15];
 };
-- 
2.17.1

