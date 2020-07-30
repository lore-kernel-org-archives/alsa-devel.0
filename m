Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD2DC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:00:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E1B2083B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O1/bgjDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F10F8175C;
	Thu, 30 Jul 2020 07:59:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F10F8175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596088810;
	bh=wSy96axaqL1Jx9iLlARbQaZlGAbdzgvsqbs4h7N2rBY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O1/bgjDlGYfAO8nTnnl+OYf9qqRQ3+JEGR325TwD/SKJImf7jhNn0YZ0DfXHbbCmj
	 ZDHc+pluDk3YGOnSUN9JoYuKtGq4b7WYkUE/pK4QpUiNqOMJI9/qLGl3QDeDcqKBpi
	 /wBQ8Rx6J8eGTxDEnIWRqEbwlFKgNPrrUF4/Js30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51190F80240;
	Thu, 30 Jul 2020 07:58:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D702BF80240; Thu, 30 Jul 2020 07:58:35 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5565BF8012F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 07:58:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5565BF8012F
IronPort-SDR: /PKs3QrUJTiQheE9aVJVD2AVwLwE7152UeGTPd9X9BmTJBFWd+v7ODBL+x4k7FQBDnK6xY5/OB
 UTnhSWJq5mfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139077825"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="139077825"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 22:58:26 -0700
IronPort-SDR: oBzjFSU1JDiErCIiRDaJesFB2EM9e/1NS5EwAFDNFh6KGOddn4fXUfRoOTBhSxC0TqwrXpelNN
 Ahq896hSo41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="434923877"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 22:58:24 -0700
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: Intel: KMB: Add 8kHz audio support
Date: Thu, 30 Jul 2020 13:53:16 +0800
Message-Id: <20200730055319.1522-2-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
References: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com, tiwai@suse.com,
 jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

Enable 8kHz audio support for Intel Keem Bay platform.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Reviewed-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/keembay/kmb_platform.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 2ce21336c06b..f94eb5b7598d 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -28,8 +28,10 @@ static const struct snd_pcm_hardware kmb_pcm_hardware = {
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER,
-	.rates = SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_48000,
-	.rate_min = 16000,
+	.rates = SNDRV_PCM_RATE_8000 |
+		 SNDRV_PCM_RATE_16000 |
+		 SNDRV_PCM_RATE_48000,
+	.rate_min = 8000,
 	.rate_max = 48000,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE |
 		   SNDRV_PCM_FMTBIT_S24_LE |
@@ -533,8 +535,10 @@ static struct snd_soc_dai_driver intel_kmb_platform_dai[] = {
 		.playback = {
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_48000,
-			.rate_min = 16000,
+			.rates = SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000,
+			.rate_min = 8000,
 			.rate_max = 48000,
 			.formats = (SNDRV_PCM_FMTBIT_S32_LE |
 				    SNDRV_PCM_FMTBIT_S24_LE |
@@ -543,8 +547,14 @@ static struct snd_soc_dai_driver intel_kmb_platform_dai[] = {
 		.capture = {
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_48000,
-			.rate_min = 16000,
+			/*
+			 * .channels_max will be overwritten
+			 * if provided by Device Tree
+			 */
+			.rates = SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 |
+				 SNDRV_PCM_RATE_48000,
+			.rate_min = 8000,
 			.rate_max = 48000,
 			.formats = (SNDRV_PCM_FMTBIT_S32_LE |
 				    SNDRV_PCM_FMTBIT_S24_LE |
-- 
2.17.1

