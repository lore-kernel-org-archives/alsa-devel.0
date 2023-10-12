Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B9ECDB47E
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Oct 2023 08:40:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37D3684B;
	Thu, 12 Oct 2023 10:39:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37D3684B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697100006;
	bh=S5jBDTM+DQJlLKIXoEEMCnr1Umj8uKrhTUOCgEUlDEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kuGxkge3odfJeIuMzXC3VhIj5C0oLLubz33r5wMsKC2e0uqS9agNrvC9Ei0Vwsaoi
	 h9gmlaAlBLFeGu5S5mrn6HOb7XrEp0VP+7JeIocHs5AVBO/qdwleVdwvYeqHL0Kc21
	 cModjDwEYtYMcBru2qIh/BpGgCwUSTr+4vXH+P4g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57B00F80536; Thu, 12 Oct 2023 10:38:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 503C3F80310;
	Thu, 12 Oct 2023 10:38:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26DEEF8055C; Thu, 12 Oct 2023 10:35:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D45CF80130
	for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2023 10:35:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D45CF80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZtY71SCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697099716; x=1728635716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S5jBDTM+DQJlLKIXoEEMCnr1Umj8uKrhTUOCgEUlDEI=;
  b=ZtY71SCAaQFRt72gxYK21dFi8dRdhCe82H/QUrkdxk3kgp0HuRuuj8TP
   i1IZ19uQO87PwBZbWPtpbGdCccAMpdNxGDPti9feAT3iRR5cDuCYopmtX
   dZuV3SCUmVNA1dNqARRBvJz0U58yzV5SzslqQug/d/db6FbGssZQhhaRX
   43lp4GV6aHf4aVvM1G9+4kqPcm+LaxkCWTjkIIDVaG+cHxMhwyoMVsVzM
   OlvU9M+3eEBjR8v9q/+aAj6pxOnKIbsPeypR7T1NM6wmw61pj+4L0P+GV
   MWJsT1lYcBrkQQwDBqD85g391zlYGVk1JG4woEey/RQicDCN6yvyWY7ZU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="6417196"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200";
   d="scan'208";a="6417196"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 01:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824516576"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200";
   d="scan'208";a="824516576"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2023 01:35:07 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 01/16] ASoC: Intel: avs: Only create SSP%d
 snd_soc_dai_driver when requested
Date: Thu, 12 Oct 2023 10:34:59 +0200
Message-Id: <20231012083514.492626-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012083514.492626-1-amadeuszx.slawinski@linux.intel.com>
References: <20231012083514.492626-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: R67TX6D4WLNCOU6BCRRLSUAM4MSIMKVN
X-Message-ID-Hash: R67TX6D4WLNCOU6BCRRLSUAM4MSIMKVN
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R67TX6D4WLNCOU6BCRRLSUAM4MSIMKVN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

When using TDM configuration some other device may be using SSP%d, so
don't create snd_soc_dai_driver configuration for it unless requested
by TDM configuration.

While at it adjust tdf8532 board to explicitly describe TDM
configuration.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/board_selection.c |  2 +-
 sound/soc/intel/avs/pcm.c             | 28 ++++++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 59a13feec57b..c10fff705496 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -193,7 +193,7 @@ static struct snd_soc_acpi_mach avs_apl_i2s_machines[] = {
 		.mach_params = {
 			.i2s_link_mask = AVS_SSP_RANGE(0, 5),
 		},
-		.pdata = (unsigned long[]){ 0, 0, 0x14, 0, 0, 0 }, /* SSP2 TDMs */
+		.pdata = (unsigned long[]){ 0x1, 0x1, 0x14, 0x1, 0x1, 0x1 }, /* SSP2 TDMs */
 		.tplg_filename = "tdf8532-tplg.bin",
 	},
 	{
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 5b31203bd56a..bea66e6bd438 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -1238,7 +1238,11 @@ int avs_i2s_platform_register(struct avs_dev *adev, const char *name, unsigned l
 	int i, j;
 
 	ssp_count = adev->hw_cfg.i2s_caps.ctrl_count;
-	cpu_count = hweight_long(port_mask);
+
+	cpu_count = 0;
+	for_each_set_bit(i, &port_mask, ssp_count)
+		if (!tdms || test_bit(0, &tdms[i]))
+			cpu_count++;
 	if (tdms)
 		for_each_set_bit(i, &port_mask, ssp_count)
 			cpu_count += hweight_long(tdms[i]);
@@ -1249,18 +1253,20 @@ int avs_i2s_platform_register(struct avs_dev *adev, const char *name, unsigned l
 
 	dai = cpus;
 	for_each_set_bit(i, &port_mask, ssp_count) {
-		memcpy(dai, &i2s_dai_template, sizeof(*dai));
+		if (!tdms || test_bit(0, &tdms[i])) {
+			memcpy(dai, &i2s_dai_template, sizeof(*dai));
 
-		dai->name =
-			devm_kasprintf(adev->dev, GFP_KERNEL, "SSP%d Pin", i);
-		dai->playback.stream_name =
-			devm_kasprintf(adev->dev, GFP_KERNEL, "ssp%d Tx", i);
-		dai->capture.stream_name =
-			devm_kasprintf(adev->dev, GFP_KERNEL, "ssp%d Rx", i);
+			dai->name =
+				devm_kasprintf(adev->dev, GFP_KERNEL, "SSP%d Pin", i);
+			dai->playback.stream_name =
+				devm_kasprintf(adev->dev, GFP_KERNEL, "ssp%d Tx", i);
+			dai->capture.stream_name =
+				devm_kasprintf(adev->dev, GFP_KERNEL, "ssp%d Rx", i);
 
-		if (!dai->name || !dai->playback.stream_name || !dai->capture.stream_name)
-			return -ENOMEM;
-		dai++;
+			if (!dai->name || !dai->playback.stream_name || !dai->capture.stream_name)
+				return -ENOMEM;
+			dai++;
+		}
 	}
 
 	if (!tdms)
-- 
2.34.1

