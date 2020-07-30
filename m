Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC41C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:01:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53682083E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vMMQVUbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53682083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BF0F176B;
	Thu, 30 Jul 2020 08:00:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BF0F176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596088860;
	bh=E6i9Wuh6GJm6dhAPkJQTuV3tkTDr3c8c9VWNKN8qgh4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMMQVUbMrBOAKvVK2Aetb1WEqjO3lP/2aBbWvEeNtSaaVM0QPxMkO1XJVr1jj7cVm
	 KW6tmwI9v8/ojBoBfFNmaa4ERas9VuEGb9jBYep5DHvrlmMIWSQZeUgjxh3XdlYApT
	 E/82/3lMEq6iQGzekHHx4ztq0aisuvDZFCCT1N50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA146F802DB;
	Thu, 30 Jul 2020 07:58:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51BBFF80227; Thu, 30 Jul 2020 07:58:41 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74354F80227
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 07:58:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74354F80227
IronPort-SDR: hmRWmKpn0URj0d6ZdDZIc5vBoTMp6frTx/XYk1hAnUPdCFV1HKXQKM156mbBkTDQuD+qdIQHVt
 5Lt+fQ3ipaKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139545720"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="139545720"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 22:58:31 -0700
IronPort-SDR: fDB/HC9cMCpau5jXc3bA3mRuDniLX7ufGKhGyIdOjWRy1jDwGfEU0ghVVEa6A78LQ4rLyYliYT
 kvvggnbHQ3wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; d="scan'208";a="434923885"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 22:58:29 -0700
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoC: Intel: KMB: Rework disable channel function
Date: Thu, 30 Jul 2020 13:53:17 +0800
Message-Id: <20200730055319.1522-3-michael.wei.hong.sit@intel.com>
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

All channels are enabled at boot up, this patch ensures that all
channels are disabled at boot and whenever the function is called.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Reviewed-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/keembay/kmb_platform.c | 10 +++++++---
 sound/soc/intel/keembay/kmb_platform.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index f94eb5b7598d..eaa4fd391171 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -109,14 +109,14 @@ static unsigned int kmb_pcm_rx_fn(struct kmb_i2s_info *kmb_i2s,
 static inline void kmb_i2s_disable_channels(struct kmb_i2s_info *kmb_i2s,
 					    u32 stream)
 {
-	struct i2s_clk_config_data *config = &kmb_i2s->config;
 	u32 i;
 
+	/* Disable all channels regardless of configuration*/
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < config->chan_nr / 2; i++)
+		for (i = 0; i < MAX_ISR; i++)
 			writel(0, kmb_i2s->i2s_base + TER(i));
 	} else {
-		for (i = 0; i < config->chan_nr / 2; i++)
+		for (i = 0; i < MAX_ISR; i++)
 			writel(0, kmb_i2s->i2s_base + RER(i));
 	}
 }
@@ -637,6 +637,10 @@ static int kmb_plat_dai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* To ensure none of the channels are enabled at boot up */
+	kmb_i2s_disable_channels(kmb_i2s, SNDRV_PCM_STREAM_PLAYBACK);
+	kmb_i2s_disable_channels(kmb_i2s, SNDRV_PCM_STREAM_CAPTURE);
+
 	dev_set_drvdata(dev, kmb_i2s);
 
 	return ret;
diff --git a/sound/soc/intel/keembay/kmb_platform.h b/sound/soc/intel/keembay/kmb_platform.h
index 29600652d8f4..da522b366995 100644
--- a/sound/soc/intel/keembay/kmb_platform.h
+++ b/sound/soc/intel/keembay/kmb_platform.h
@@ -90,6 +90,7 @@
 
 #define MAX_CHANNEL_NUM		8
 #define MIN_CHANNEL_NUM		2
+#define MAX_ISR			4
 
 #define TWO_CHANNEL_SUPPORT	2	/* up to 2.0 */
 #define FOUR_CHANNEL_SUPPORT	4	/* up to 3.1 */
-- 
2.17.1

