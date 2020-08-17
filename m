Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A9C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:29:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0B5207DE
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tRnXSKic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0B5207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06CBC1719;
	Tue, 18 Aug 2020 05:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06CBC1719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597721360;
	bh=yWZ70K4e92KTGNdVohfl0OZFYX7tPdbF36ZdRgUccy0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tRnXSKic50b1ZEhGpp88exK3HORHiDwp1m5hP+zibh0ojdy5FaDu/u+88FlXu6ecG
	 jqli4B1rs2Bd+JGBdkDfEwDH5qnXl9YVaSr3AvPZeBCnXB/2rqpNtS4MPEREkWeFuN
	 m4VnIB88cyP/cvcFJp/r4S/msGzAfUs2x4h8pM2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29859F80321;
	Tue, 18 Aug 2020 05:23:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3EFAF802FF; Tue, 18 Aug 2020 05:23:48 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0C3FF802EB
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 05:23:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0C3FF802EB
IronPort-SDR: yThhDqZSk3uSrBJ6IRIiRRgKeuSVzRc5AD2pcqoH1a0Lzc4hV+nCPOjwk63vFI9mmg6WXndb8R
 Np1vG4e89Jew==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152243040"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="152243040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:44 -0700
IronPort-SDR: 3uNF3wfHbS4SFkosHNHgGmXYY5/3DHNSEDjHQ3d0j0t7K7+ch1FvfbuHAyNicBX0UmUALxlWXi
 ofKhHgkkKh9g==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; d="scan'208";a="441084647"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 20:23:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 08/12] soundwire: intel: add CLK_STOP_BUS_RESET support
Date: Mon, 17 Aug 2020 23:29:19 +0800
Message-Id: <20200817152923.3259-9-yung-chuan.liao@linux.intel.com>
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

From: Rander Wang <rander.wang@intel.com>

Move existing pm_runtime suspend under the CLK_STOP_TEARDOWN case.

In this mode the Master IP will lose all context but in-band wakes are
supported.

On pm_runtime resume a complete re-enumeration will be performed after
a bus reset.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 68c1cdfb7999..ad476e9e4d25 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1575,6 +1575,26 @@ static int intel_suspend_runtime(struct device *dev)
 
 		intel_shim_wake(sdw, false);
 
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
+		ret = sdw_cdns_clock_stop(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable clock stop on suspend\n");
+			return ret;
+		}
+
+		ret = sdw_cdns_enable_interrupt(cdns, false);
+		if (ret < 0) {
+			dev_err(dev, "cannot disable interrupts on suspend\n");
+			return ret;
+		}
+
+		ret = intel_link_power_down(sdw);
+		if (ret) {
+			dev_err(dev, "Link power down failed: %d", ret);
+			return ret;
+		}
+
+		intel_shim_wake(sdw, true);
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
@@ -1691,6 +1711,30 @@ static int intel_resume_runtime(struct device *dev)
 			dev_err(dev, "unable to exit bus reset sequence during resume\n");
 			return ret;
 		}
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
+		ret = intel_init(sdw);
+		if (ret) {
+			dev_err(dev, "%s failed: %d", __func__, ret);
+			return ret;
+		}
+
+		/*
+		 * make sure all Slaves are tagged as UNATTACHED and
+		 * provide reason for reinitialization
+		 */
+		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
+		ret = sdw_cdns_clock_restart(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "unable to restart clock during resume\n");
+			return ret;
+		}
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.17.1

