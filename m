Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0353C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:02:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB042078B
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PulF83af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB042078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7A0D1679;
	Thu, 13 Aug 2020 20:01:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7A0D1679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597341736;
	bh=sT39fZFgnUBbGyppcyKlJ9AIt0H37W1Qp7cNAAj2NPU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PulF83afbkU5+EkzcV/m/T9Kfq6X18R/v8mfld/JVkHm3n5bejiKyIpdRq9t/sCoa
	 fu0HoFGs7LHw5rvP3pE1cF4/wxSN288a7uknFLCokvyATm1O98PxozW+Fo55533k0j
	 T558C0UHdO0l2Cip5Q4KMOEG9mlJXnWA7qgEYLks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BF75F802DD;
	Thu, 13 Aug 2020 19:59:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7B6EF8025E; Thu, 13 Aug 2020 19:59:01 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7383FF800D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 19:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7383FF800D3
IronPort-SDR: uEGdZzvlf68N0zLku7XDg1wxGw/tCjs6MEC4uxNU7vQgDW5X50ncGbtViPRtieCJuE+T6pHVb3
 dA5+ye7sDXSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239124821"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="239124821"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 10:58:55 -0700
IronPort-SDR: 8rVtWSSaArLUfDo2r0xd90C8uED5jdzzyaGet3FSP+xwXOk2XTidXLtmdShPy2g5hmS4KiUXeE
 5m0IJcO38deA==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="295510750"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 10:58:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] ASoC: Intel: rename shadowed variable for all broadwell
 boards
Date: Thu, 13 Aug 2020 12:58:37 -0500
Message-Id: <20200813175839.59422-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
References: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
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

Fix cppcheck warnings:

sound/soc/intel/boards/bdw-rt5650.c:91:23: style: Local variable
'channels' shadows outer variable [shadowVariable]

sound/soc/intel/boards/bdw-rt5677.c:144:23: style: Local variable
'channels' shadows outer variable [shadowVariable]

sound/soc/intel/boards/broadwell.c:91:23: style: Local variable
'channels' shadows outer variable [shadowVariable]

This was fixed earlier in other machine drivers but keeps coming back
with copy/paste.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bdw-rt5650.c | 10 +++++-----
 sound/soc/intel/boards/bdw-rt5677.c |  8 ++++----
 sound/soc/intel/boards/broadwell.c  |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index ce7320916b22..1412a9941ed4 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -87,14 +87,14 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *rate = hw_param_interval(params,
-			SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-						SNDRV_PCM_HW_PARAM_CHANNELS);
+						      SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *chan = hw_param_interval(params,
+						      SNDRV_PCM_HW_PARAM_CHANNELS);
 
 	/* The ADSP will covert the FE rate to 48k, max 4-channels */
 	rate->min = rate->max = 48000;
-	channels->min = 2;
-	channels->max = 4;
+	chan->min = 2;
+	chan->max = 4;
 
 	/* set SSP0 to 24 bit */
 	snd_mask_set_format(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 86e427e3822f..297871bcaf5d 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -140,13 +140,13 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *rate = hw_param_interval(params,
-			SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-						SNDRV_PCM_HW_PARAM_CHANNELS);
+						      SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *chan = hw_param_interval(params,
+						      SNDRV_PCM_HW_PARAM_CHANNELS);
 
 	/* The ADSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
-	channels->min = channels->max = 2;
+	chan->min = chan->max = 2;
 
 	/* set SSP0 to 16 bit */
 	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index f6399077d291..56972af13b6f 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -87,13 +87,13 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *rate = hw_param_interval(params,
-			SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-						SNDRV_PCM_HW_PARAM_CHANNELS);
+						      SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *chan = hw_param_interval(params,
+						      SNDRV_PCM_HW_PARAM_CHANNELS);
 
 	/* The ADSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
-	channels->min = channels->max = 2;
+	chan->min = chan->max = 2;
 
 	/* set SSP0 to 16 bit */
 	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
-- 
2.25.1

