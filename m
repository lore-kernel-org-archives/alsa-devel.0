Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00AC64E8A
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 08:42:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F6620C56
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 08:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F6620C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90D761831;
	Thu,  3 Dec 2020 09:41:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90D761831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606984922;
	bh=9b5gRKVIpQaDd9NV46v+at1S43lxlZ+M0XAkIK8u0SA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izQn5qXDEpNbkPPT+3/k6JcE976A9WhR0BiHETkev1tTWjhboblumIebWR2En1hXj
	 p5OBX+v6QSnP6sbW2023HJl0A4gryLZgWcl1jYNHw6RGM9m8qkPOvGsLLbeCksbYka
	 Npcys8gUK4rm7FSshI1a2rt9FqCkReJEt+VHRDr4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24CCAF804D6;
	Thu,  3 Dec 2020 09:39:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BD8CF804D6; Thu,  3 Dec 2020 09:39:38 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AD71F804C3
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 09:39:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AD71F804C3
IronPort-SDR: yx5hz4KSmU5FOvMolXFNzl4oG5lkjT3PnZHZ67avseN0WDmqgw6BDjXOIAkIhWYqcYeCvDiVvp
 9KoUmutiRWXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="237276587"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; d="scan'208";a="237276587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2020 00:39:33 -0800
IronPort-SDR: rBjdkOtomujh1t7lNvGjfvsvFaOz6+w4KmQe/nmODU603xjTIs2esKjYrmCokxxPjwE/TU9SK8
 M9s4PknU+aLw==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; d="scan'208";a="481881009"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2020 00:39:29 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 4/7] soundwire/regmap: use _no_pm functions in
 regmap_read/write
Date: Thu,  3 Dec 2020 04:46:42 +0800
Message-Id: <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
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

sdw_update_slave_status will be invoked when a codec is attached,
and the codec driver will initialize the codec with regmap functions
while the codec device is pm_runtime suspended.

regmap routines currently rely on regular SoundWire IO functions,
which will call pm_runtime_get_sync()/put_autosuspend.

This causes a deadlock where the resume routine waits for an
initialization complete signal that while the initialization complete
can only be reached when the resume completes.

The only solution if we allow regmap functions to be used in resume
operations as well as during codec initialization is to use _no_pm
routines. The duty of making sure the bus is operational needs to be
handled above the regmap level.

Fixes: 7c22ce6e21840 ('regmap: Add SoundWire bus support')
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c | 4 ++--
 drivers/soundwire/bus.c          | 6 ++++--
 include/linux/soundwire/sdw.h    | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index c92d614b4943..4b8d2d010cab 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -11,7 +11,7 @@ static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
 	struct device *dev = context;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 
-	return sdw_write(slave, reg, val);
+	return sdw_write_no_pm(slave, reg, val);
 }
 
 static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
@@ -20,7 +20,7 @@ static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	int read;
 
-	read = sdw_read(slave, reg);
+	read = sdw_read_no_pm(slave, reg);
 	if (read < 0)
 		return read;
 
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 86c339d77a39..c5ea59673dee 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -405,10 +405,11 @@ sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	return sdw_transfer(slave->bus, &msg);
 }
 
-static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
+int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
 {
 	return sdw_nwrite_no_pm(slave, addr, 1, &value);
 }
+EXPORT_SYMBOL(sdw_write_no_pm);
 
 static int
 sdw_bread_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr)
@@ -476,7 +477,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
 }
 EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
 
-static int
+int
 sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 {
 	u8 buf;
@@ -488,6 +489,7 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
 	else
 		return buf;
 }
+EXPORT_SYMBOL(sdw_read_no_pm);
 
 static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
 {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index f0b01b728640..d08039d65825 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1005,6 +1005,8 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
 
 int sdw_read(struct sdw_slave *slave, u32 addr);
 int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
+int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
+int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
 int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
 
-- 
2.17.1

