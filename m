Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FAEC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 07:53:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752AA61494
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 07:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752AA61494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E13871686;
	Tue,  2 Mar 2021 08:52:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E13871686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614671582;
	bh=V4xv2RDaZhr9iYZ6GgweyeyUC8a2jPHV4H7vZHHdAkg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zr6coU1/mORje9r6DdUla+oPI2d8KChqFi8KNYMTTGsMtjkpRHGtrWJZcc0SOBrbe
	 LCtexihHytV/Xo+k5jY0sT80WvwV94r1ACQSEByn2nSeUcWGDNRzAQp5oyvbtPlMML
	 mbnLYt8xX81q+7wF4MJjEZdIJtyU6wJqLJ7Ep51Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B49AF80269;
	Tue,  2 Mar 2021 08:51:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30FCAF802CA; Tue,  2 Mar 2021 08:51:26 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1842F80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 08:51:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1842F80088
IronPort-SDR: UWr18j04RCkMq1ILEpBKzJuzOocBKQJND+dwwzLBC1UDgkHdc2JSP33F6Gt8c/+2sksdFmHK3/
 NtF4s4eaI6kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186782233"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="186782233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 23:51:12 -0800
IronPort-SDR: Ty2gXSthuG83IcKpD6Fh4A7tEcHjHullYgyy6DLzHkzTUvzN6v57U8Q1hFz1T10rcCPMzRyzKK
 /HmwwQlPXDbA==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="406597576"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 23:51:08 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 1/3] soundwire: add override addr ops
Date: Tue,  2 Mar 2021 15:51:03 +0800
Message-Id: <20210302075105.11515-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
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

From: Vinod Koul <vkoul@kernel.org>

Platform firmware may have incorrect _ADR values causing the driver
probes to fail. Add the override_ops, which when configured will allow
for quirks based on DMI etc to override the addr values.

Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/slave.c     | 8 +++++++-
 include/linux/soundwire/sdw.h | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 180f38bd003b..112b21967c7a 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -95,7 +95,7 @@ static bool find_slave(struct sdw_bus *bus,
 		       struct acpi_device *adev,
 		       struct sdw_slave_id *id)
 {
-	unsigned long long addr;
+	u64 addr;
 	unsigned int link_id;
 	acpi_status status;
 
@@ -108,6 +108,12 @@ static bool find_slave(struct sdw_bus *bus,
 		return false;
 	}
 
+	if (bus->ops->override_adr)
+		addr = bus->ops->override_adr(bus, addr);
+
+	if (!addr)
+		return false;
+
 	/* Extract link id from ADR, Bit 51 to 48 (included) */
 	link_id = SDW_DISCO_LINK_ID(addr);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index d08039d65825..f0a3895e8faf 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -804,6 +804,7 @@ struct sdw_defer {
 /**
  * struct sdw_master_ops - Master driver ops
  * @read_prop: Read Master properties
+ * @override_adr: Override value read from firmware (quirk for buggy firmware)
  * @xfer_msg: Transfer message callback
  * @xfer_msg_defer: Defer version of transfer message callback
  * @reset_page_addr: Reset the SCP page address registers
@@ -813,7 +814,8 @@ struct sdw_defer {
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
-
+	u64 (*override_adr)
+			(struct sdw_bus *bus, u64 addr);
 	enum sdw_command_response (*xfer_msg)
 			(struct sdw_bus *bus, struct sdw_msg *msg);
 	enum sdw_command_response (*xfer_msg_defer)
-- 
2.17.1

