Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF70C433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:25:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7BC207DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NiK6wNkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7BC207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40BBC170A;
	Tue, 18 Aug 2020 05:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40BBC170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721109;
	bh=jGULt1JZWOFBfbW/xJVvyW/m/dzy9nNsmCiaOC+et+E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NiK6wNkXGP76VXT+VKvuo4QowUVYQvnCA4XxKYy5Sz6QD1NCaGJQFOQ3AI63qA5Cj
	 7ZzS0FS7uNazq5xL9hS5nd99eM57+LmfYljmXHf5m1oZ4ai3yaoTRNA0mB3HEBC6uE
	 gwvSFnWEiYJ5dtOv6E9G2x/hrT+ruOmXRjEo43Sk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9F63F8029A;
	Tue, 18 Aug 2020 05:23:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43FB4F802A2; Tue, 18 Aug 2020 05:23:29 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0659BF80228
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0659BF80228
IronPort-SDR: txxKEvjxbrd2BCFfg2C56lZ3lOjgK5+/UxlvdU3PwF80QAiD8VSgiYgRsSJbFdgoWZzNHqwH6H
 6p76Z/0ulzcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152242994"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152242994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:17 -0700
IronPort-SDR: iuwlMXkzkkXZgDe6II3DQsWTehxuWimWWNNnPcZbtnL6O647vWst7hgAul3E9GcWs/jTNapDup
 nmAgqcd9ZSNw==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084528"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 01/12] soundwire: intel: add pm_runtime support
Date: Mon, 17 Aug 2020 23:29:12 +0800
Message-Id: <20200817152923.3259-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
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

Add basic hooks in DAI .startup and .shutdown callbacks.

The SoundWire IP should be powered between those two calls. The power
dependencies between SoundWire and DSP are handled with the
parent/child relationship, before the SoundWire master device becomes
active the parent device will become active and power-up the shared
rails.

For now the strategy is to rely on complete enumeration when the
device becomes active, so the code is a copy/paste of the sequence for
system suspend/resume. In future patches, the strategy will optionally
be to rely on clock stop if the enumeration time is prohibitive or
when the devices connected to a link can signal a wake.

A module parameter is added to make integration of new Slave devices
easier, to e.g. keep the device active or prevent clock-stop.

Note that we need to we have to disable runtime pm before device
unregister, otherwise we will see "Failed to power up link: -11" error
on module remove test.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c      | 112 +++++++++++++++++++++++++++++++--
 drivers/soundwire/intel_init.c |   5 +-
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 88aeef8b7c0c..85a0bb6af4fe 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -22,6 +22,22 @@
 #include "bus.h"
 #include "intel.h"
 
+#define INTEL_MASTER_SUSPEND_DELAY_MS	3000
+
+/*
+ * debug/config flags for the Intel SoundWire Master.
+ *
+ * Since we may have multiple masters active, we can have up to 8
+ * flags reused in each byte, with master0 using the ls-byte, etc.
+ */
+
+#define SDW_INTEL_MASTER_DISABLE_PM_RUNTIME BIT(0)
+#define SDW_INTEL_MASTER_DISABLE_CLOCK_STOP BIT(1)
+
+static int md_flags;
+module_param_named(sdw_md_flags, md_flags, int, 0444);
+MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
+
 /* Intel SHIM Registers Definition */
 #define SDW_SHIM_LCAP			0x0
 #define SDW_SHIM_LCTL			0x4
@@ -807,10 +823,17 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
 static int intel_startup(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
-	/*
-	 * TODO: add pm_runtime support here, the startup callback
-	 * will make sure the IP is 'active'
-	 */
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = pm_runtime_get_sync(cdns->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(cdns->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(cdns->dev);
+		return ret;
+	}
 	return 0;
 }
 
@@ -985,7 +1008,10 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 static void intel_shutdown(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 
+	pm_runtime_mark_last_busy(cdns->dev);
+	pm_runtime_put_autosuspend(cdns->dev);
 }
 
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
@@ -1270,6 +1296,7 @@ int intel_master_startup(struct platform_device *pdev)
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
+	int link_flags;
 	int ret;
 
 	if (bus->prop.hw_disabled) {
@@ -1314,6 +1341,18 @@ int intel_master_startup(struct platform_device *pdev)
 
 	intel_debugfs_init(sdw);
 
+	/* Enable runtime PM */
+	link_flags = md_flags >> (bus->link_id * 8);
+	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
+		pm_runtime_set_autosuspend_delay(dev,
+						 INTEL_MASTER_SUSPEND_DELAY_MS);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_mark_last_busy(dev);
+
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
+
 	return 0;
 
 err_interrupt:
@@ -1412,6 +1451,36 @@ static int intel_suspend(struct device *dev)
 	return 0;
 }
 
+static int intel_suspend_runtime(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, false);
+	if (ret < 0) {
+		dev_err(dev, "cannot disable interrupts on suspend\n");
+		return ret;
+	}
+
+	ret = intel_link_power_down(sdw);
+	if (ret) {
+		dev_err(dev, "Link power down failed: %d", ret);
+		return ret;
+	}
+
+	intel_shim_wake(sdw, false);
+
+	return 0;
+}
+
 static int intel_resume(struct device *dev)
 {
 	struct sdw_cdns *cdns = dev_get_drvdata(dev);
@@ -1446,10 +1515,45 @@ static int intel_resume(struct device *dev)
 	return ret;
 }
 
+static int intel_resume_runtime(struct device *dev)
+{
+	struct sdw_cdns *cdns = dev_get_drvdata(dev);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	ret = intel_init(sdw);
+	if (ret) {
+		dev_err(dev, "%s failed: %d", __func__, ret);
+		return ret;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable interrupts during resume\n");
+		return ret;
+	}
+
+	ret = sdw_cdns_exit_reset(cdns);
+	if (ret < 0) {
+		dev_err(dev, "unable to exit bus reset sequence during resume\n");
+		return ret;
+	}
+
+	return ret;
+}
+
 #endif
 
 static const struct dev_pm_ops intel_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
 };
 
 static struct platform_driver sdw_intel_drv = {
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 047252a91c9e..a1f210853545 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_intel.h>
 #include "cadence_master.h"
 #include "intel.h"
@@ -68,8 +69,10 @@ static int sdw_intel_cleanup(struct sdw_intel_ctx *ctx)
 		if (!(link_mask & BIT(i)))
 			continue;
 
-		if (link->pdev)
+		if (link->pdev) {
+			pm_runtime_disable(&link->pdev->dev);
 			platform_device_unregister(link->pdev);
+		}
 	}
 
 	return 0;
-- 
2.17.1

