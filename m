Return-Path: <SRS0=XhTq=FD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF00C5519F
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 11:47:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A35206F1
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Nov 2020 11:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Du/Ctaab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A35206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20D5D188C;
	Sun, 29 Nov 2020 12:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20D5D188C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606650450;
	bh=L20P6XEhc0WjwttmV+kaLLNz/RMXBbJAvfGL5yO9Xvo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Du/CtaabS1sFrP1OwMwP+UOjsucXYT2Eh9S0WisB9s/gSRy1zp8nZvE5M4prAetIY
	 W5ldI8pgS5uzg7zCepaxyOPtOCo4IlqRTOAquukIIhFm5gXwJmVl7oZYD5KU8puIQP
	 5vQ+HO2XuvBDD/BXS8gv2H5XlFZjR1uFod48rHMs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83091F804ED;
	Sun, 29 Nov 2020 12:43:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE017F8016D; Sun, 29 Nov 2020 12:43:27 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 367E2F8016E
 for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2020 12:43:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 367E2F8016E
IronPort-SDR: pSg7ShuAxTT/n3PpLBTaB/+XTNHWLc2sfZXJqYyFxqTTwZ1IQv6Agd0h7DTHth9ECxSkqBzRX7
 QDfWm9ig6bUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="151779977"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; d="scan'208";a="151779977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 03:43:14 -0800
IronPort-SDR: y+h36jCuOb3LQ75mQ4kkcuGpJEMWwob8XsN74kQi30UhvBWEMtXJ5jpwNUGxb6M/w1TOJa+A/z
 FOfOBMYB/0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; d="scan'208";a="480261657"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 29 Nov 2020 03:43:12 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ASoC: Intel: Allow for ROM init retry on CNL platforms
Date: Sun, 29 Nov 2020 12:41:45 +0100
Message-Id: <20201129114148.13772-6-cezary.rojewski@intel.com>
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

commit 024aa45f55ccd40704cfdef61b2a8b6d0de9cdd1 upstream.

Due to unconditional initial timeouts, firmware may fail to load during
its initialization. This issue cannot be resolved on driver side as it
is caused by external sources such as CSME but has to be accounted for
nonetheless.

Fixes: cb6a55284629 ("ASoC: Intel: cnl: Add sst library functions for cnl platform")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-7-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
---
 sound/soc/intel/skylake/bxt-sst.c     |  2 --
 sound/soc/intel/skylake/cnl-sst.c     | 15 ++++++++++-----
 sound/soc/intel/skylake/skl-sst-dsp.h |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 92a82e6b5fe6..cdafade8abd6 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -38,8 +38,6 @@
 /* Delay before scheduling D0i3 entry */
 #define BXT_D0I3_DELAY 5000
 
-#define BXT_FW_ROM_INIT_RETRY 3
-
 static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 {
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 4f64f097e9ae..060e47ae3391 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -109,7 +109,7 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
 	struct skl_dev *cnl = ctx->thread_context;
-	int ret;
+	int ret, i;
 
 	if (!ctx->fw) {
 		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
@@ -131,12 +131,16 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 	stripped_fw.size = ctx->fw->size;
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
-	ret = cnl_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
-	if (ret < 0) {
-		dev_err(ctx->dev, "prepare firmware failed: %d\n", ret);
-		goto cnl_load_base_firmware_failed;
+	for (i = 0; i < BXT_FW_ROM_INIT_RETRY; i++) {
+		ret = cnl_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
+		if (!ret)
+			break;
+		dev_dbg(ctx->dev, "prepare firmware failed: %d\n", ret);
 	}
 
+	if (ret < 0)
+		goto cnl_load_base_firmware_failed;
+
 	ret = sst_transfer_fw_host_dma(ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "transfer firmware failed: %d\n", ret);
@@ -158,6 +162,7 @@ static int cnl_load_base_firmware(struct sst_dsp *ctx)
 	return 0;
 
 cnl_load_base_firmware_failed:
+	dev_err(ctx->dev, "firmware load failed: %d\n", ret);
 	release_firmware(ctx->fw);
 	ctx->fw = NULL;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index cdfec0fca577..067d1ea11cde 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -67,6 +67,7 @@ struct skl_dev;
 
 #define SKL_FW_INIT			0x1
 #define SKL_FW_RFW_START		0xf
+#define BXT_FW_ROM_INIT_RETRY		3
 
 #define SKL_ADSPIC_IPC			1
 #define SKL_ADSPIS_IPC			1
-- 
2.17.1

