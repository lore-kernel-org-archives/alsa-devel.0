Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A13FF8860
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:51:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82D33601F7;
	Mon, 27 Apr 2026 16:51:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82D33601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777301475;
	bh=hx6CDD6lckc6noGNCHtnF/bVe/IQOKztf4+JjKP4HJk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AnA6fb220i33t8A+5PGmdz2evZGxrwOE+c1WBthObVIpaVXuDJAdW5vxZJOy0iQPI
	 0PJpYxwID2Kdau37KRHWmvQ64lonjm9fdVv1zpjksF4WsT9Jk6Pjj2V3IYC0YnrcvK
	 v6irKzJzUnncIKbYWIn1jq6jqM4dRBTS+XhPau08=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3891DF805F7; Mon, 27 Apr 2026 16:50:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AB59F805E4;
	Mon, 27 Apr 2026 16:50:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F67DF80518; Mon, 27 Apr 2026 16:50:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ED471F800BA
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2026 16:50:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED471F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ledXtBap
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777301428; x=1808837428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hx6CDD6lckc6noGNCHtnF/bVe/IQOKztf4+JjKP4HJk=;
  b=ledXtBap0nlFGjQ8xK4cyhWaSIWaY+uo+/rUIcAGE4c7xIa4uatpLxjq
   Skc1wgfiROnM6wow1GoLPfPyWtKTuNSLlCvLfh2RZQ0nfzB34nCPGN5un
   bYwM4/ZrmZm0TeHljQzntZnZVtJMf72lucaMhYEcV2L11SarGp6Dt+Ewh
   Sjp07BB19veQur7tCzj3fkmrNaDgU89ylhzc21kphsqh2flI3tfvDx8K+
   MA8qm0qmf8IfK9VuhU4oZ4f1KvjZgoaje87o7kOIDsSGYaPBvWu8N88rg
   OhUtcqH/ykulY8rMJKO5L954W4TYJYO97EYkbAs4KOOD9gFgApKZLd0RD
   A==;
X-CSE-ConnectionGUID: GAeP3QaTT3KSbfUrD99VkQ==
X-CSE-MsgGUID: IBpAtRBkTD+vizh1soOXnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78109152"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000";
   d="scan'208";a="78109152"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 07:50:21 -0700
X-CSE-ConnectionGUID: U8vRv1PETqaJWktuKpvECg==
X-CSE-MsgGUID: eU5bMmzfRWmVGD33J+I11w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000";
   d="scan'208";a="271794364"
Received: from jpp-desktop.igk.intel.com ([10.91.221.24])
  by orviesa001.jf.intel.com with ESMTP; 27 Apr 2026 07:50:20 -0700
From: Sachin Mokashi <sachin.mokashi@intel.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	cezary.rojewski@intel.com,
	Sachin Mokashi <sachin.mokashi@intel.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5672: Simplify probe() with local
 'dev' pointer
Date: Mon, 27 Apr 2026 10:46:19 -0400
Message-Id: <20260427144619.1739971-1-sachin.mokashi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 3APKUV6EEHAKZMGKVXF6B2XB753F2RQA
X-Message-ID-Hash: 3APKUV6EEHAKZMGKVXF6B2XB753F2RQA
X-MailFrom: sachin.mokashi@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3APKUV6EEHAKZMGKVXF6B2XB753F2RQA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In snd_cht_mc_probe(), &pdev->dev is dereferenced repeatedly throughout
the function. Introduce a local dev pointer
early in the function and use it consistently in place of all open-coded
&pdev->dev references.

It reduces repetition, improves readability, and aligns with the common
kernel driver pattern of caching the device pointer at function entry.

Signed-off-by: Sachin Mokashi <sachin.mokashi@intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 359723f2700e..0c6a3b6829a7 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -450,12 +450,13 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	struct cht_mc_private *drv;
 	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
 	const char *platform_name;
+	struct device *dev = &pdev->dev;
 	struct acpi_device *adev;
 	bool sof_parent;
 	int dai_index = 0;
 	int i;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
@@ -477,7 +478,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 			 "i2c-%s", acpi_dev_name(adev));
 		cht_dailink[dai_index].codecs->name = drv->codec_name;
 	}  else {
-		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
 		return -ENOENT;
 	}
 
@@ -490,7 +491,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 
 	/* override platform name, if required */
-	snd_soc_card_cht.dev = &pdev->dev;
+	snd_soc_card_cht.dev = dev;
 	platform_name = mach->mach_params.platform;
 
 	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
@@ -500,16 +501,16 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	snd_soc_card_cht.components = rt5670_components();
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	drv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
 	if (IS_ERR(drv->mclk)) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
 			PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
 	}
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
-	sof_parent = snd_soc_acpi_sof_parent(&pdev->dev);
+	sof_parent = snd_soc_acpi_sof_parent(dev);
 
 	/* set card and driver name */
 	if (sof_parent) {
@@ -525,9 +526,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		pdev->dev.driver->pm = &snd_soc_pm_ops;
 
 	/* register the soc card */
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
+	ret_val = devm_snd_soc_register_card(dev, &snd_soc_card_cht);
 	if (ret_val) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"snd_soc_register_card failed %d\n", ret_val);
 		return ret_val;
 	}
-- 
2.34.1

Intel Deutschland GmbH
Registered Address: Dornacher Strasse 1, 85622 Feldkirchen, Germany
Tel: +49 89 991 430, www.intel.de
Managing Directors: Harry Demas, Jeffrey Schneiderman, Yin Chong Sorrell
Chairperson of the Supervisory Board: Nicole Lau
Registered Seat: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

