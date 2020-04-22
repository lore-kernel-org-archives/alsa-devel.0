Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A142DC54FCB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:13:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1262073A
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ViX0IJP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1262073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86AEA169D;
	Wed, 22 Apr 2020 17:12:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86AEA169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587568428;
	bh=+K45y9/74ZS5M1YKspkpEvewACWtZ4Pj89wnR/9jUSo=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ViX0IJP3ZB3WCjEf9T3R5xzJXBzxLkuxpNzPcrOUUOwEhx/hdLBAMKoA2ynBgzqu4
	 3mqO6IuQdHf2x3Jl0brU/8Gjq8dkDIhbGDvm3GLPW6EaqJAQEcxv8Z+VLb/Tylkrt0
	 erClYMQRs3c8MAcNmtxdB0HQ6LN/J57mF6GfGvig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5812F80142;
	Wed, 22 Apr 2020 17:12:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 988BDF801D9; Wed, 22 Apr 2020 17:11:49 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C02DF80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 17:11:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C02DF80108
IronPort-SDR: OIOLGQTL667lxWDeReEnuZ0PUTZC1nB5YY1pYo2Tt8g/2ypCrumPgn5UnnqYzjrdU6lHfWjf9I
 ZiQotxwuqw6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 08:11:39 -0700
IronPort-SDR: oeCQ4LCAzhvpjxqz3npjOIPFf76Fvh/HGvGqdgHJaEdCsMjzv7LwIVvLiqp8iEl90weCViP5nB
 jAqrnQsUR/pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; d="scan'208";a="300944826"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.249.46.244])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2020 08:11:38 -0700
Date: Wed, 22 Apr 2020 17:11:37 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] soundwire: (cosmetic) remove multiple superfluous "else"
 statements
Message-ID: <20200422151136.GA9425@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

No need for an "else" after a "return" statement. Remove multiple such
occurrences.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/bus.c            | 17 ++++++++++-------
 drivers/soundwire/cadence_master.c |  8 ++++++--
 drivers/soundwire/intel_init.c     |  4 +++-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 488c3c9..32de017 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -284,9 +284,10 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	msg->flags = flags;
 	msg->buf = buf;
 
-	if (addr < SDW_REG_NO_PAGE) { /* no paging area */
+	if (addr < SDW_REG_NO_PAGE) /* no paging area */
 		return 0;
-	} else if (addr >= SDW_REG_MAX) { /* illegal addr */
+
+	if (addr >= SDW_REG_MAX) { /* illegal addr */
 		pr_err("SDW: Invalid address %x passed\n", addr);
 		return -EINVAL;
 	}
@@ -306,7 +307,9 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	if (!slave) {
 		pr_err("SDW: No slave for paging addr\n");
 		return -EINVAL;
-	} else if (!slave->prop.paging_support) {
+	}
+
+	if (!slave->prop.paging_support) {
 		dev_err(&slave->dev,
 			"address %x needs paging but no support\n", addr);
 		return -EINVAL;
@@ -375,8 +378,8 @@ static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
 	ret = sdw_transfer(bus, &msg);
 	if (ret < 0)
 		return ret;
-	else
-		return buf;
+
+	return buf;
 }
 
 static int
@@ -471,8 +474,8 @@ int sdw_read(struct sdw_slave *slave, u32 addr)
 	ret = sdw_nread(slave, addr, 1, &buf);
 	if (ret < 0)
 		return ret;
-	else
-		return buf;
+
+	return buf;
 }
 EXPORT_SYMBOL(sdw_read);
 
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index ecd357d1..9ea8753 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -407,7 +407,9 @@ void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 	if (nack) {
 		dev_err_ratelimited(cdns->dev, "Msg NACKed for Slave %d\n", msg->dev_num);
 		return SDW_CMD_FAIL;
-	} else if (no_ack) {
+	}
+
+	if (no_ack) {
 		dev_dbg_ratelimited(cdns->dev, "Msg ignored for Slave %d\n", msg->dev_num);
 		return SDW_CMD_IGNORED;
 	}
@@ -520,7 +522,9 @@ void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 		dev_err_ratelimited(cdns->dev,
 				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
 		return SDW_CMD_FAIL;
-	} else if (no_ack) {
+	}
+
+	if (no_ack) {
 		dev_dbg_ratelimited(cdns->dev,
 				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
 		return SDW_CMD_IGNORED;
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 4b76940..d5d4279 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -86,7 +86,9 @@ static int sdw_intel_cleanup_pdev(struct sdw_intel_ctx *ctx)
 		dev_err(&adev->dev, "Link count %d exceeds max %d\n",
 			count, SDW_MAX_LINKS);
 		return NULL;
-	} else if (!count) {
+	}
+
+	if (!count) {
 		dev_warn(&adev->dev, "No SoundWire links detected\n");
 		return NULL;
 	}
-- 
1.9.3

