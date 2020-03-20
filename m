Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A24BC4332E
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE27F20753
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FDhym4+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE27F20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43368886;
	Fri, 20 Mar 2020 17:33:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43368886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584722063;
	bh=Eo07KKVRT77+jL4fMagNQDh36B/3uwggwvS7l19LzQA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FDhym4+F94+JkQoZ2dzzLyaEXGgWD2tnO3jzcQ9Z8N+7vYrPuIkpoVk+oGXz2v6C/
	 bl/XYoxRop0ku7hY9//j9GrEACt+6q0+SIPrR80mOVrpmV3jgIxj0CJSNR5iXh2XiA
	 RCryudIyrIK9fNqShwcyF9AOqGVERqAOHNs/vFm0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2E93F80292;
	Fri, 20 Mar 2020 17:30:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96181F802BD; Fri, 20 Mar 2020 17:30:25 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24677F80292
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 17:30:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24677F80292
IronPort-SDR: otsaesnZEPsJDcH4GoeuyzqHB+9NMKsCy46RZRurHMGpavx5vX+XThYL9G8kehMhpBmQlnYAt+
 V8uL7+/76eJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 09:30:19 -0700
IronPort-SDR: HyPVTzu48bSrw0HptvLFMfL9uQXSceqJNE9LnB9ATdLMEQHyo8G6P9U6+F9IdMTyE/rcHoAux1
 CJW/2SsmrquA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="248931040"
Received: from manallet-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.34.12])
 by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 09:30:14 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] soundwire: qcom: add sdw_master_device support
Date: Fri, 20 Mar 2020 11:29:47 -0500
Message-Id: <20200320162947.17663-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
References: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, Andy Gross <agross@kernel.org>,
 jank@cadence.com,
 "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

Add new device as a child of the platform device, following the
following hierarchy:

platform_device
    sdw_master_device
        sdw_slave0
	...
	sdw_slaveN

For the Qualcomm implementation no sdw_master_driver is registered so
the dais have to be registered using the platform_device and likely
all power management is handled at the platform device level.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/qcom.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 77783ae4b71d..86b46415e50b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -89,6 +89,7 @@ struct qcom_swrm_port_config {
 struct qcom_swrm_ctrl {
 	struct sdw_bus bus;
 	struct device *dev;
+	struct sdw_master_device *md;
 	struct regmap *regmap;
 	struct completion *comp;
 	struct work_struct slave_work;
@@ -775,14 +776,31 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	mutex_init(&ctrl->port_lock);
 	INIT_WORK(&ctrl->slave_work, qcom_swrm_slave_wq);
 
-	ctrl->bus.dev = dev;
+	/*
+	 * add sdw_master_device.
+	 * For the Qualcomm implementation there is no driver.
+	 */
+	ctrl->md = sdw_master_device_add(NULL,	/* no driver name */
+					 dev,	/* platform device is parent */
+					 dev->fwnode,
+					 0,	/* only one link supported */
+					 NULL);	/* no context */
+	if (IS_ERR(ctrl->md)) {
+		dev_err(dev, "Could not create sdw_master_device\n");
+		ret = PTR_ERR(ctrl->md);
+		goto err_clk;
+	}
+
+	/* the bus uses the sdw_master_device, not the platform device */
+	ctrl->bus.dev = &ctrl->md->dev;
+
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
 
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
-		goto err_clk;
+		goto err_md;
 
 	params = &ctrl->bus.params;
 	params->max_dr_freq = DEFAULT_CLK_FREQ;
@@ -809,14 +827,14 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 					"soundwire", ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request soundwire irq\n");
-		goto err_clk;
+		goto err_md;
 	}
 
 	ret = sdw_add_bus_master(&ctrl->bus);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
 			ret);
-		goto err_clk;
+		goto err_md;
 	}
 
 	qcom_swrm_init(ctrl);
@@ -832,6 +850,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 err_master_add:
 	sdw_delete_bus_master(&ctrl->bus);
+err_md:
+	device_unregister(&ctrl->md->dev);
 err_clk:
 	clk_disable_unprepare(ctrl->hclk);
 err_init:
@@ -843,6 +863,7 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
 
 	sdw_delete_bus_master(&ctrl->bus);
+	device_unregister(&ctrl->md->dev);
 	clk_disable_unprepare(ctrl->hclk);
 
 	return 0;
-- 
2.20.1

