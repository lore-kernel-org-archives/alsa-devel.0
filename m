Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C20C43461
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:44:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351021973
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="doN1ZypK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351021973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0806F1719;
	Wed,  9 Sep 2020 03:43:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0806F1719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599615853;
	bh=P+ySu6bO8+7aoL8YTj5ItQhSoZj/2oLg9zoq2TA2e2M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=doN1ZypKWolhflbdXPgAntr8upqrfYDsdMNlOG6rkBKcCm2544dJkoKa5+u09Ovri
	 DAFboXZEkUffphszwRMm2Wx/D9CH9Gf0eXfsixzKKqmx6afGhuB0UGYI/sAJb+rFQh
	 yhtq/25XXEVQA5mQ2hKrrkZLRFTIiAL5v2YibLNU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B784F802FE;
	Wed,  9 Sep 2020 03:39:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7FB8F802F7; Wed,  9 Sep 2020 03:39:31 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED4FDF802DF
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 03:39:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED4FDF802DF
IronPort-SDR: oPnc8C9LLTQunOqw1/GTsXfdD01uwRrFZ4a5r5zKa3qI+7hkscJcKKRvzZBzybAWHks/umhV03
 WbO5OTrASxNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222458474"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="222458474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 18:39:28 -0700
IronPort-SDR: bUrXS8YdK4dT8w2redZuhe1b8ZGPc5iTH3WV6ecsIgccWJpnDaxG+g+oAwVFSpfhEQQeY3YXNb
 UaTqReYlxtFQ==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; d="scan'208";a="449018128"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2020 18:39:24 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 6/7] soundwire: bus: export broadcast read/write capability
 for tests
Date: Tue,  8 Sep 2020 21:45:20 +0800
Message-Id: <20200908134521.6781-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
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

Provide prototype and export symbol to enable tests. The bus lock is
handled externally to avoid conflicts e.g. between kernel-generated
traffic and test traffic.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 56 +++++++++++++++++++++++++++++++++++------
 drivers/soundwire/bus.h |  4 +++
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 09185e5cfd70..02574b4bb179 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -255,6 +255,21 @@ static int sdw_reset_page(struct sdw_bus *bus, u16 dev_num)
 	return ret;
 }
 
+static int sdw_transfer_unlocked(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	int ret;
+
+	ret = do_transfer(bus, msg);
+	if (ret != 0 && ret != -ENODATA)
+		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
+			msg->dev_num, ret);
+
+	if (msg->page)
+		sdw_reset_page(bus, msg->dev_num);
+
+	return ret;
+}
+
 /**
  * sdw_transfer() - Synchronous transfer message to a SDW Slave device
  * @bus: SDW bus
@@ -266,13 +281,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
 
 	mutex_lock(&bus->msg_lock);
 
-	ret = do_transfer(bus, msg);
-	if (ret != 0 && ret != -ENODATA)
-		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
-			msg->dev_num, ret);
-
-	if (msg->page)
-		sdw_reset_page(bus, msg->dev_num);
+	ret = sdw_transfer_unlocked(bus, msg);
 
 	mutex_unlock(&bus->msg_lock);
 
@@ -428,6 +437,39 @@ sdw_bwrite_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value)
 	return sdw_transfer(bus, &msg);
 }
 
+int sdw_bread_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr)
+{
+	struct sdw_msg msg;
+	u8 buf;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
+			   SDW_MSG_FLAG_READ, &buf);
+	if (ret)
+		return ret;
+
+	ret = sdw_transfer_unlocked(bus, &msg);
+	if (ret < 0)
+		return ret;
+
+	return buf;
+}
+EXPORT_SYMBOL(sdw_bread_no_pm_unlocked);
+
+int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, NULL, addr, 1, dev_num,
+			   SDW_MSG_FLAG_WRITE, &value);
+	if (ret)
+		return ret;
+
+	return sdw_transfer_unlocked(bus, &msg);
+}
+EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
+
 static int
 sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 {
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 82484f741168..c53345fbc4c7 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -168,6 +168,10 @@ sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 	return sdw_write(slave, addr, tmp);
 }
 
+/* broadcast read/write for tests */
+int sdw_bread_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr);
+int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 value);
+
 /*
  * At the moment we only track Master-initiated hw_reset.
  * Additional fields can be added as needed
-- 
2.17.1

