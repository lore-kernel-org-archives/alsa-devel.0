Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499EFC2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:32:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F125F2065D
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aww5s1fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F125F2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FF7F16F4;
	Wed, 23 Sep 2020 09:31:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FF7F16F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600846340;
	bh=D3OP+pyBjqc36JePvjQmvWRVDq5xMzuDefsAaM5bm7s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aww5s1fIP6kGp4ywEnyTTpwaBmSAGdU8NG/iqcJWgi5V5pY8dwBvlbCLvujIZ5rKi
	 0TBeDaVPNrCKXcYP9r7CEF8rDN/GuJH3XTl/YVlWtQ5IuZgxz+eyHVrTxktnY7LzWz
	 0uxbYc6WDSdlABp8Auz0LWZYocD3lE+y4EpDytj0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE09BF800B4;
	Wed, 23 Sep 2020 09:31:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93BC4F80171; Wed, 23 Sep 2020 09:31:27 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14943F800B4
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 09:31:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14943F800B4
IronPort-SDR: CZslRaf535WTNmmZvium/jSuIAENmkcV+Lgu366OPtpFFIO+R3YA+wv/dNN7EaZKLS6Hk88R7K
 isEzTKP3sdUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="140285247"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="140285247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 00:31:12 -0700
IronPort-SDR: QBfPKMLWTUj3N267vODLl1gE4wZQPs2lYvgImXCj8Uso4e8DT2fbafMZI8jGl78bpYvO2PtOAh
 hmw3f/n2do1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="338566774"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008.jf.intel.com with ESMTP; 23 Sep 2020 00:31:10 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: Intel: hda_dsp_common: use static function in
 conditional block
Date: Wed, 23 Sep 2020 10:29:39 +0300
Message-Id: <20200923072939.3100468-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jaska Uimonen <jaska.uimonen@intel.com>, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

cppcheck reports the following warning:

sound/soc/intel/boards/hda_dsp_common.c:17:0: style: The function
'hda_dsp_hdmi_pcm_handle' is never used. [unusedFunction]

Fix by moving to static inside compilation block.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/hda_dsp_common.c | 7 ++++---
 sound/soc/intel/boards/hda_dsp_common.h | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/hda_dsp_common.c b/sound/soc/intel/boards/hda_dsp_common.c
index 244b57fba64c..91ad2a0ad1ce 100644
--- a/sound/soc/intel/boards/hda_dsp_common.c
+++ b/sound/soc/intel/boards/hda_dsp_common.c
@@ -10,12 +10,14 @@
 
 #include "hda_dsp_common.h"
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+
 /*
  * Search card topology and return PCM device number
  * matching Nth HDMI device (zero-based index).
  */
-struct snd_pcm *hda_dsp_hdmi_pcm_handle(struct snd_soc_card *card,
-					int hdmi_idx)
+static struct snd_pcm *hda_dsp_hdmi_pcm_handle(struct snd_soc_card *card,
+					       int hdmi_idx)
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_pcm *spcm;
@@ -34,7 +36,6 @@ struct snd_pcm *hda_dsp_hdmi_pcm_handle(struct snd_soc_card *card,
 	return NULL;
 }
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 /*
  * Search card topology and register HDMI PCM related controls
  * to codec driver.
diff --git a/sound/soc/intel/boards/hda_dsp_common.h b/sound/soc/intel/boards/hda_dsp_common.h
index 727edd256962..ea4ae9285cf0 100644
--- a/sound/soc/intel/boards/hda_dsp_common.h
+++ b/sound/soc/intel/boards/hda_dsp_common.h
@@ -15,9 +15,6 @@
 #include <sound/hda_i915.h>
 #include "../../codecs/hdac_hda.h"
 
-struct snd_pcm *hda_dsp_hdmi_pcm_handle(struct snd_soc_card *card,
-					int hdmi_idx);
-
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 int hda_dsp_hdmi_build_controls(struct snd_soc_card *card,
 				struct snd_soc_component *comp);
-- 
2.27.0

