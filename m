Return-Path: <SRS0=3Kie=HU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EB0C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 12:33:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8F261606
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Feb 2021 12:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8F261606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84EC6823;
	Thu, 18 Feb 2021 13:32:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84EC6823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613651623;
	bh=aDoVqxljDfiJlucQoKpRWcch+dQ6cV/CKt1gQRXRGFE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WAgKS0SCf0eazqK5qhQ6lfHvqACfzzYmXSzO8+4El3IDr2ZM7h0KpESwN0OFgYN3K
	 Kp6m7kerMjgKBPT/KPQy4wIpjAbTlKi4pI70qkQOXGZh6JYtkAHvOmy7nWfFff8L4/
	 SxNOawUav4f7rUooOmjXaMPqgltlxPaVipHXa79E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74389F80229;
	Thu, 18 Feb 2021 13:32:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3719F80274; Thu, 18 Feb 2021 13:32:03 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB19AF80155
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2021 13:31:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB19AF80155
IronPort-SDR: HVsNrMFwu0r3TV6N4PyLbfI1xJsAkjKLYDQPnf2VijQGqc8KfhF0UVXTOI+wQymJxt+608ZtLm
 0FGaZjnwDU0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="163264980"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="163264980"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2021 04:31:50 -0800
IronPort-SDR: Evj+bv0wuUAnAhsaCVFvvIPxcd9kGZsMXeFrYMXzpIXeRQfhZm86t17xafXEUZiTI0q9KVnpts
 kPdu4cgp4Jsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; d="scan'208";a="364821594"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by orsmga006.jf.intel.com with ESMTP; 18 Feb 2021 04:31:48 -0800
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: Intel: kbl: Remove option of choosing CH count
 based on pdata
Date: Thu, 18 Feb 2021 18:01:24 +0530
Message-Id: <20210218123125.15438-2-vamshi.krishna.gopal@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218123125.15438-1-vamshi.krishna.gopal@intel.com>
References: <20210218123125.15438-1-vamshi.krishna.gopal@intel.com>
Cc: harshapriya.n@intel.com, naveen.m@intel.com, biernacki@google.com,
 sathya.prakash.m.r@intel.com
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

From: Naveen Manohar <naveen.m@intel.com>

Remove option of choosing channel count based on pdata for
kbl_rt5663_max98927 machine driver.
As User-space expects 4ch DMIC data and uses channel-map in ucm to
figure-out the desired channel to use, Hence removing driver change
to allow choosing channels.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 26 --------------------
 1 file changed, 26 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 9a4b3d0973f6..adfa2c044aed 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -524,26 +524,6 @@ static struct snd_soc_ops kabylake_ssp0_ops = {
 	.hw_params = kabylake_ssp0_hw_params,
 };
 
-static unsigned int channels_dmic[] = {
-	2, 4,
-};
-
-static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
-	.count = ARRAY_SIZE(channels_dmic),
-	.list = channels_dmic,
-	.mask = 0,
-};
-
-static const unsigned int dmic_2ch[] = {
-	2,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_dmic_2ch = {
-	.count = ARRAY_SIZE(dmic_2ch),
-	.list = dmic_2ch,
-	.mask = 0,
-};
-
 static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -970,7 +950,6 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_rt5663_private *ctx;
-	struct snd_soc_acpi_mach *mach;
 	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -985,11 +964,6 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
 
-	mach = pdev->dev.platform_data;
-	if (mach)
-		dmic_constraints = mach->mach_params.dmic_num == 2 ?
-			&constraints_dmic_2ch : &constraints_dmic_channels;
-
 	ctx->mclk = devm_clk_get(&pdev->dev, "ssp1_mclk");
 	if (IS_ERR(ctx->mclk)) {
 		ret = PTR_ERR(ctx->mclk);
-- 
2.17.1

