Return-Path: <SRS0=v/9x=ND=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B93C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 23:21:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172CB6104F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 23:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 172CB6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80C9D18FA;
	Fri, 13 Aug 2021 01:21:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80C9D18FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628810516;
	bh=yglBegxVAz5P4AfEKFKHmlYg9hXAoZJh2D3VY1o8DNo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMGHVV4jrqiXbCxbTPTO57fer8Vqm7LzVCAvYd80D4QwwMaKD+tKU4Op95x5B4pFt
	 k7luCWRpxEHHGoa1wHJQyai47/KnSzbMNzWapaegFTm7XA+iQ8/ThNbqy08KX3NZ/g
	 HB6/3sCYDLp0a0iiKabgB/LCpOjVcYibPZ/zv/7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB79AF804E1;
	Fri, 13 Aug 2021 01:20:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C0F4F804CF; Fri, 13 Aug 2021 01:20:16 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC9AAF80279
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 01:20:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC9AAF80279
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="202629477"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; d="scan'208";a="202629477"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 16:19:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; d="scan'208";a="507949893"
Received: from evanklei-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.77.110])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 16:19:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 3/4] ASoC: SOF: Intel: simplify logic for DMI_L1 handling
Date: Thu, 12 Aug 2021 18:19:39 -0500
Message-Id: <20210812231940.172547-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812231940.172547-1-pierre-louis.bossart@linux.intel.com>
References: <20210812231940.172547-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

We don't need to test in multiple places if the kconfig
SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1 is enabled or not, we might as
well set the existing DMI_L1_COMPATIBLE flag.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-pcm.c    |  3 ++-
 sound/soc/sof/intel/hda-stream.c | 11 +++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index df00db8369c7..59220fa1def1 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -229,7 +229,8 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 	}
 
 	/* All playback and D0i3 compatible streams are DMI L1 capable */
-	if (direction == SNDRV_PCM_STREAM_PLAYBACK ||
+	if (IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1) ||
+	    direction == SNDRV_PCM_STREAM_PLAYBACK ||
 	    spcm->stream[substream->stream].d0i3_compatible)
 		flags |= SOF_HDA_STREAM_DMI_L1_COMPATIBLE;
 
diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 5302464754f9..63c367478f1c 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -197,11 +197,10 @@ hda_dsp_stream_get(struct snd_sof_dev *sdev, int direction, u32 flags)
 	 * Workaround to address a known issue with host DMA that results
 	 * in xruns during pause/release in capture scenarios.
 	 */
-	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1))
-		if (!(flags & SOF_HDA_STREAM_DMI_L1_COMPATIBLE))
-			snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
-						HDA_VS_INTEL_EM2,
-						HDA_VS_INTEL_EM2_L1SEN, 0);
+	if (!(flags & SOF_HDA_STREAM_DMI_L1_COMPATIBLE))
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
+					HDA_VS_INTEL_EM2,
+					HDA_VS_INTEL_EM2_L1SEN, 0);
 
 	return stream;
 }
@@ -240,7 +239,7 @@ int hda_dsp_stream_put(struct snd_sof_dev *sdev, int direction, int stream_tag)
 	spin_unlock_irq(&bus->reg_lock);
 
 	/* Enable DMI L1 if permitted */
-	if (!IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1) && dmi_l1_enable)
+	if (dmi_l1_enable)
 		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, HDA_VS_INTEL_EM2,
 					HDA_VS_INTEL_EM2_L1SEN, HDA_VS_INTEL_EM2_L1SEN);
 
-- 
2.25.1

