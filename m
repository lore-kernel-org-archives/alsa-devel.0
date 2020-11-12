Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB5DC2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7619D2068D
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QRzWDZAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7619D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2DCD1750;
	Thu, 12 Nov 2020 23:43:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2DCD1750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605221040;
	bh=09KabHtRpQ0CUzN3t7L1HQL4/RRVqyeGSHFuholz0Jg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRzWDZAsi+dTd70FMH1izNsHz+L3XuIDkp+xvrtuWyxo4hlWsqUK5PM+zxHb0fuSi
	 w0xM/bBl295JBod5Cp5Ubao+tICVeAFOU4b/NStHn/fkvZW9XpoWcQbBjQpM57jaoY
	 Roxb3HKRkLAtvsdq37HHsTnS9u2+S/9BFDVrmFUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55D38F80515;
	Thu, 12 Nov 2020 23:39:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36133F804E3; Thu, 12 Nov 2020 23:39:13 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 616B9F8021C
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 23:38:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 616B9F8021C
IronPort-SDR: txuW4HxJhMT4v/EtyTsyKXutpblGDbazdK3xT8Eaohn0eZ1lSMlFYX1gJJc+mCKN+JxrUcR30i
 0cxp20VVWMpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="166885005"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; d="scan'208";a="166885005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 14:38:56 -0800
IronPort-SDR: KK0CLd+ctZklIdcDPlAxvVRXXEzH9rVyvw8zMwUPGbeF1Zqk9g/bvuCykBgAjmLGaSsNaTHYwv
 PvPUczR2zBnw==
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; d="scan'208";a="323797490"
Received: from gjshield-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.180.118])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 14:38:55 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/14] ASoC: SOF: acpi: add dynamic selection of DSP driver
Date: Thu, 12 Nov 2020 16:38:18 -0600
Message-Id: <20201112223825.39765-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
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

Follow PCI example and stop the probe when another driver is desired
for the same ACPI HID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig  |  1 +
 sound/soc/sof/sof-acpi-dev.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index b233302f05e4..b593b29789d5 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -78,6 +78,7 @@ config SND_SOC_SOF_BAYTRAIL_SUPPORT
 config SND_SOC_SOF_BAYTRAIL
 	tristate
 	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
+	select SND_INTEL_DSP_CONFIG
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level.
diff --git a/sound/soc/sof/sof-acpi-dev.c b/sound/soc/sof/sof-acpi-dev.c
index a78b76ef37b2..2a369c2c6551 100644
--- a/sound/soc/sof/sof-acpi-dev.c
+++ b/sound/soc/sof/sof-acpi-dev.c
@@ -12,6 +12,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <sound/intel-dsp-config.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 #include <sound/sof.h>
@@ -120,12 +121,23 @@ static void sof_acpi_probe_complete(struct device *dev)
 static int sof_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct acpi_device_id *id;
 	const struct sof_dev_desc *desc;
 	struct snd_sof_pdata *sof_pdata;
 	const struct snd_sof_dsp_ops *ops;
 	int ret;
 
-	dev_dbg(&pdev->dev, "ACPI DSP detected");
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return -ENODEV;
+
+	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
+	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_SOF) {
+		dev_dbg(dev, "SOF ACPI driver not selected, aborting probe\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "ACPI DSP detected");
 
 	sof_pdata = devm_kzalloc(dev, sizeof(*sof_pdata), GFP_KERNEL);
 	if (!sof_pdata)
-- 
2.25.1

