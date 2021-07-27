Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F01C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 05:58:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C66610E9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 05:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3C66610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E3011EEE;
	Tue, 27 Jul 2021 07:57:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E3011EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627365496;
	bh=iGltmtret1uyU0jN9dWOkZziU2i5WhyACh+F2AtLiNs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a9ril8pI2OoIVkPrkzCJqPM10OVQUhZ1535X+XD6FrfYq/bMl7MdYN0aQrNHMCr5y
	 bsJ9PjxRoD6Q+TBSYUN+H33VChwHzPzYD12bF/tKEXW8xq2dJx/pLHdCv9o9dfafHr
	 gquRpdENxvjl/9ZtUAIlNoTCt7kNqZ47kIy9zn+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71F91F804DA;
	Tue, 27 Jul 2021 07:56:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 015E0F802E7; Tue, 27 Jul 2021 07:56:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52E10F8026C
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 07:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52E10F8026C
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="276163941"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; d="scan'208";a="276163941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 22:56:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; d="scan'208";a="474302618"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 22:56:19 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 2/4] soundwire: intel: skip suspend/resume/wake when link was
 not started
Date: Tue, 27 Jul 2021 13:56:06 +0800
Message-Id: <20210727055608.30247-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210727055608.30247-1-yung-chuan.liao@linux.intel.com>
References: <20210727055608.30247-1-yung-chuan.liao@linux.intel.com>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

On some HDaudio platforms, SoundWire devices are described in the
DSDT but never used. This patch adds a boolean status flag to skip all
suspend/resume/wake sequences for this configuration.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 22 ++++++++++++----------
 drivers/soundwire/intel.h |  1 +
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3af922e20e64..46d1645cb7fe 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1456,6 +1456,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
 		pm_runtime_idle(dev);
 
+	sdw->startup_done = true;
 	return 0;
 
 err_interrupt:
@@ -1495,8 +1496,9 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
 	sdw = dev_get_drvdata(dev);
 	bus = &sdw->cdns.bus;
 
-	if (bus->prop.hw_disabled) {
-		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n", bus->link_id);
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
 		return 0;
 	}
 
@@ -1533,8 +1535,8 @@ static int __maybe_unused intel_suspend(struct device *dev)
 	u32 clock_stop_quirks;
 	int ret;
 
-	if (bus->prop.hw_disabled) {
-		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
 			bus->link_id);
 		return 0;
 	}
@@ -1587,8 +1589,8 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 	u32 clock_stop_quirks;
 	int ret;
 
-	if (bus->prop.hw_disabled) {
-		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
 			bus->link_id);
 		return 0;
 	}
@@ -1652,8 +1654,8 @@ static int __maybe_unused intel_resume(struct device *dev)
 	bool multi_link;
 	int ret;
 
-	if (bus->prop.hw_disabled) {
-		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
 			bus->link_id);
 		return 0;
 	}
@@ -1750,8 +1752,8 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	int status;
 	int ret;
 
-	if (bus->prop.hw_disabled) {
-		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+	if (bus->prop.hw_disabled || !sdw->startup_done) {
+		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
 			bus->link_id);
 		return 0;
 	}
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 0b47b148da3f..cd93a44dba9a 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -41,6 +41,7 @@ struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
 	struct sdw_intel_link_res *link_res;
+	bool startup_done;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
-- 
2.17.1

