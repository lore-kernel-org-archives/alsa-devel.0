Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA50DC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743522065D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WggX3z9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743522065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB47F825;
	Wed, 22 Jul 2020 17:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB47F825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595432235;
	bh=ph8aiVYbwMWppQoGy0zGSf9lLjF1wUSnbZl2Tq4dzUc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WggX3z9ROvFPMnQ+tH9NWzD+uWZdlyEcbDZFKFC3NDAMqp07jD6eTuAmJDoZ6vfoG
	 fki83aOv77S75E0smPz1pQ4r1K6mlr89PIgKfXOY7oKMIZiXRoPgXVASdFUGozzYfp
	 xmZNj1vQzQhGDUcWFrgjjNX2q4l3LEB3mFRnAzWc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87455F80141;
	Wed, 22 Jul 2020 17:36:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0B9EF8014C; Wed, 22 Jul 2020 17:36:22 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80531F800CE
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 17:36:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80531F800CE
IronPort-SDR: PWF7KsPoX2lV6Nx/YVsTr17qr7xIloxXjWzUXERB03TPsrCcakIaDCFLcTsvdaNuKJhcpKFs50
 hYRTIFlevP/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="138435954"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="138435954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 08:35:52 -0700
IronPort-SDR: InKhxv2ZRnhBJC7HFJxAVVgOABhjSI+st+9I4nYVZ6lazHbO58YWBhSEoK0vJqNTEMaAHSu+E+
 pxqoIkwGiN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="328248757"
Received: from joycetoh-desk.sc.intel.com ([172.25.206.187])
 by orsmga007.jf.intel.com with ESMTP; 22 Jul 2020 08:35:52 -0700
From: Harsha Priya <harshapriya.n@intel.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH v8] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix
 kabylake_ssp_fixup function
Date: Wed, 22 Jul 2020 08:35:47 -0700
Message-Id: <1595432147-11166-1-git-send-email-harshapriya.n@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Harsha Priya <harshapriya.n@intel.com>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
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

kabylake_ssp_fixup function uses snd_soc_dpcm to identify the
codecs DAIs. The HW parameters are changed based on the codec DAI of the
stream. The earlier approach to get snd_soc_dpcm was using container_of()
macro on snd_pcm_hw_params.

The structures have been modified over time and snd_soc_dpcm does not have
snd_pcm_hw_params as a reference but as a copy. This causes the current
driver to crash when used.

This patch changes the way snd_soc_dpcm is extracted. snd_soc_pcm_runtime
holds 2 dpcm instances (one for playback and one for capture). 2 codecs
on the SSP are dmic (capture) and speakers (playback). Based on the
stream direction, snd_soc_dpcm is extracted from snd_soc_pcm_runtime.

Tested for all use cases of the driver.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
---
v1 -> v2:
- Extract dmic from SSP0 as every BE should have own fixup function.
v2 -> v3:
- Restore naming in the dapm route table to not confuse with other
drivers
- Fixed indentations
v3 -> v4:
- Updated code and commit description according to
solution proposed by Harsha
v4 -> v5:
- Cosmetic Changes
v5 -> v6:
- Dmic regression seen with v4 fixed 
- Using available routines for obtaining dpcm information
v6 -> v7:
- Updated comments
- initilize rtd_dpcm variable
- added break statement in the loop
v7 -> v8:
- Updated commit message
- return on rtd_dpcm being NULL
- typo fixed
---
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 41 +++++++++++++++----
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 584e4f9cedc2..21808fe13481 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -379,22 +379,45 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *chan = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	struct snd_soc_dpcm *dpcm = container_of(
-			params, struct snd_soc_dpcm, hw_params);
-	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
-	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
+	struct snd_soc_dpcm *dpcm, *rtd_dpcm = NULL;
+
+	/*
+	 * The following loop will be called only for playback stream
+	 * In this platform, there is only one playback device on every SSP
+	 */
+	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
+		rtd_dpcm = dpcm;
+		break;
+	}
+
+	/*
+	 * This following loop will be called only for capture stream
+	 * In this platform, there is only one capture device on every SSP
+	 */
+	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_CAPTURE, dpcm) {
+		rtd_dpcm = dpcm;
+		break;
+	}
+
+	if (!rtd_dpcm)
+		return -EINVAL;
+
+	/*
+	 * The above 2 loops are mutually exclusive based on the stream direction,
+	 * thus rtd_dpcm variable will never be overwritten
+	 */
 
 	/*
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
-	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
+	if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Port") ||
+	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Headset Playback") ||
+	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Capture Port")) {
 		rate->min = rate->max = 48000;
 		chan->min = chan->max = 2;
 		snd_mask_none(fmt);
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
-	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
+	} else if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio DMIC cap")) {
 		if (params_channels(params) == 2 ||
 				DMIC_CH(dmic_constraints) == 2)
 			chan->min = chan->max = 2;
@@ -405,7 +428,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
 	 * thus changing the mask here
 	 */
-	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
+	if (!strcmp(rtd_dpcm->be->dai_link->name, "SSP0-Codec"))
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
-- 
2.17.1

