Return-Path: <SRS0=XhTq=FD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694ECC3E8C5
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 11:46:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89676206DF
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 11:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C7B6x8Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89676206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AB191896;
	Sun, 29 Nov 2020 12:45:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AB191896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606650403;
	bh=75FpB/AZCwdv4NpvD+TfRl63Z4tdmEpBkVWhz4TI80M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C7B6x8Kpj/Q3eE1XpN9izRVFjBTC3NsPMKp2zkb395VPTUQVWxfjjWBmQW0S963/Q
	 clM/CG3Rak9Pwn9F9+gsQJIk0aaBLyGWETgHutbKGlJO+hndyt0Hwtfrnl4nkOe/Xn
	 X0MC7ALWsvzfb7cvMf5BMCL+4tnGw+CKmTynVo5I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54BFBF804E2;
	Sun, 29 Nov 2020 12:43:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E73C1F804C2; Sun, 29 Nov 2020 12:43:27 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3246BF8016D
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2020 12:43:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3246BF8016D
IronPort-SDR: +mwHlyhktjGDyAI8AY6yT0ctwUwV5fHLbU3PuzhzBvzhwmKOs4dwnuuYOhnTgEfFohOfITQdd/
 33VYWpfk8ZlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="151779975"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; d="scan'208";a="151779975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 03:43:12 -0800
IronPort-SDR: UTqLxCcKQjJf0OjHSzZEOo4sFVs3Ra0eGlQ+wvvPkSSnH2HSOKT5PqlNILnA6cBC0giRSdb+Pb
 +xdXcCFFZ9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; d="scan'208";a="480261645"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 29 Nov 2020 03:43:10 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] ASoC: Intel: Skylake: Shield against no-NHLT
 configurations
Date: Sun, 29 Nov 2020 12:41:44 +0100
Message-Id: <20201129114148.13772-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129114148.13772-1-cezary.rojewski@intel.com>
References: <20201129114148.13772-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 tiwai@suse.com, broonie@kernel.org, mateusz.gorski@linux.intel.com
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

commit 9e6c382f5a6161eb55115fb56614b9827f2e7da3 upstream.

Some configurations expose no NHLT table at all within their
/sys/firmware/acpi/tables. To prevent NULL-dereference errors from
occurring, adjust probe flow and append additional safety checks in
functions involved in NHLT lifecycle.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-5-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
---
 sound/soc/intel/skylake/skl-nhlt.c | 3 ++-
 sound/soc/intel/skylake/skl.c      | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 19f328d71f24..d9c8f5cb389e 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -182,7 +182,8 @@ void skl_nhlt_remove_sysfs(struct skl_dev *skl)
 {
 	struct device *dev = &skl->pci->dev;
 
-	sysfs_remove_file(&dev->kobj, &dev_attr_platform_id.attr);
+	if (skl->nhlt)
+		sysfs_remove_file(&dev->kobj, &dev_attr_platform_id.attr);
 }
 
 /*
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1a3a3d6a3141..2e5fbd220923 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -632,6 +632,9 @@ static int skl_clock_device_register(struct skl_dev *skl)
 	struct platform_device_info pdevinfo = {NULL};
 	struct skl_clk_pdata *clk_pdata;
 
+	if (!skl->nhlt)
+		return 0;
+
 	clk_pdata = devm_kzalloc(&skl->pci->dev, sizeof(*clk_pdata),
 							GFP_KERNEL);
 	if (!clk_pdata)
@@ -1090,7 +1093,8 @@ static int skl_probe(struct pci_dev *pci,
 out_clk_free:
 	skl_clock_device_unregister(skl);
 out_nhlt_free:
-	intel_nhlt_free(skl->nhlt);
+	if (skl->nhlt)
+		intel_nhlt_free(skl->nhlt);
 out_free:
 	skl_free(bus);
 
@@ -1139,7 +1143,8 @@ static void skl_remove(struct pci_dev *pci)
 	skl_dmic_device_unregister(skl);
 	skl_clock_device_unregister(skl);
 	skl_nhlt_remove_sysfs(skl);
-	intel_nhlt_free(skl->nhlt);
+	if (skl->nhlt)
+		intel_nhlt_free(skl->nhlt);
 	skl_free(bus);
 	dev_set_drvdata(&pci->dev, NULL);
 }
-- 
2.17.1

