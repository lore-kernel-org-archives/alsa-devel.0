Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9027DC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:04:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C4964F2C
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 21:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C4964F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46C7C1921;
	Tue,  2 Mar 2021 22:03:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46C7C1921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614719084;
	bh=Do9Z8nXayfA3ujmxvXy6RtrQcGK3ywIgDU2ktHcmCh8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSMnOxBn/cUnBM3CWQSoQB0SF42I8LAEVHfN/dTdE63QIv8GHXpDQLsyzM1gWgQBc
	 cNFb99Wqyaek8LBi7UZRW2Nv+vXVOf/Y5RUUZy2h1ago1IoCAq7SMSuYh0hO1lvGlT
	 IJjzbaZ8gMGNDe8SJr47yMCXOxpSplcTo5MxMXZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CE9DF804B4;
	Tue,  2 Mar 2021 22:00:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E970CF80423; Tue,  2 Mar 2021 22:00:44 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB2EEF80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 22:00:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB2EEF80088
IronPort-SDR: 6FC1xnQZwPllojyub0nY1zkwuUZ8luwShuYz8Nad7Z2lzhLl4PE0f0Pdhna/EuSlwgOCF+ganS
 aeD+uHvHpDPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174623766"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174623766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:00:32 -0800
IronPort-SDR: aVIV8pIp7CqP7EE65GJVUM/07JdJWkr4lAaCIkijBvqemnWcMJzx1K0pekGlV/ksa+LiIJ1GB8
 yklKlHXgc9ag==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="373727809"
Received: from btucker-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.60.230])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 13:00:31 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 8/9] ASoC: Intel: bytcr_wm5102: remove unused static variable
Date: Tue,  2 Mar 2021 14:59:25 -0600
Message-Id: <20210302205926.49063-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302205926.49063-1-pierre-louis.bossart@linux.intel.com>
References: <20210302205926.49063-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

make W=1 warning:

sound/soc/intel/boards/bytcr_wm5102.c:216:40: error:
‘byt_wm5102_dai_params’ defined but not used
[-Werror=unused-const-variable=]
  216 | static const struct snd_soc_pcm_stream byt_wm5102_dai_params = {
      |                                        ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index f38850eb2eaf..fd584e380340 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -213,14 +213,6 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 	return 0;
 }
 
-static const struct snd_soc_pcm_stream byt_wm5102_dai_params = {
-	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rate_min = 48000,
-	.rate_max = 48000,
-	.channels_min = 2,
-	.channels_max = 2,
-};
-
 static int byt_wm5102_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 				  struct snd_pcm_hw_params *params)
 {
-- 
2.25.1

