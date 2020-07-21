Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B2C433E3
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:34:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D0E20717
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m9j06LJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D0E20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2C0B10E;
	Wed, 22 Jul 2020 10:33:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2C0B10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595406876;
	bh=6ySk8/c+XmyrcM1Kz3ppRA2FfWzNrDFDJBPI5jKs9sk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m9j06LJzo1jaD3FJ8+s5W4Pl6OBkrGMJ5uONqIvxqmIkouzqRFRqBO/5xs3MKoZIa
	 Zky2rgr/7nj7g16JhpyO1frbyQOh/NgzPBBUnr0VSV7FSyEL8+OEZqGyDR5NegS7PF
	 LYcMNEgrUjMovESrq8PKfYchdmBsEK77qSrhx8B8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7415FF80290;
	Wed, 22 Jul 2020 10:32:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84009F8028C; Wed, 22 Jul 2020 10:32:09 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD42EF8014C
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 10:31:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD42EF8014C
IronPort-SDR: lX16rxyUmVrSfuaWnRmS9Fwos7mpSjZpiMQP9rZBSrZx8/t8lvR/scUrucccAOtpNjebnPNrjz
 KseINzlOBpWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="149457247"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="149457247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 01:31:48 -0700
IronPort-SDR: PvAEKZv+qpQ+GdZaWS5N/8uJnBcw2oEDj56hyXGUACViOog9I07fC1uBSGQVW6dteYspJvl8AW
 lsP+4lpwdTAw==
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; d="scan'208";a="432303146"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 01:31:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 01/13] soundwire: intel: Add basic power management support
Date: Wed, 22 Jul 2020 04:37:11 +0800
Message-Id: <20200721203723.18305-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Implement suspend/resume capabilities (not runtime_pm for now)
The resume part is essentially a full-blown re-enumeration.

When S0ix is supported, we will select clock stop mode when the ACPI
target state is S0, and tear down the link for S3.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 81 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 23b66dcf9966..eb628f255cf5 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -463,7 +463,7 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
-static int __maybe_unused intel_link_power_down(struct sdw_intel *sdw)
+static int intel_link_power_down(struct sdw_intel *sdw)
 {
 	int link_control, spa_mask, cpa_mask;
 	unsigned int link_id = sdw->instance;
@@ -1375,12 +1375,89 @@ int intel_master_process_wakeen_event(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * PM calls
+ */
+
+#ifdef CONFIG_PM
+
+static int intel_suspend(struct device *dev)
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
+static int intel_resume(struct device *dev)
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
+#endif
+
+static const struct dev_pm_ops intel_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+};
+
 static struct platform_driver sdw_intel_drv = {
 	.probe = intel_master_probe,
 	.remove = intel_master_remove,
 	.driver = {
 		.name = "intel-sdw",
-	},
+		.pm = &intel_pm,
+	}
 };
 
 module_platform_driver(sdw_intel_drv);
-- 
2.17.1

