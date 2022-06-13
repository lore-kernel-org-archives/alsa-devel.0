Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6140C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jun 2022 09:10:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C2661838;
	Mon, 13 Jun 2022 11:09:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C2661838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655111448;
	bh=mENeUuivVPJj9cqU4y5T8qfMdoCEA6BJ/ZdaFwXSDtk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHb+LpG8MaBKlvroDd+Pg8ov3VW0IFxBzhd1pObBpZPgo8E1dZbvxlCogA/K8ZxPG
	 OgSp4g0sUp0Ht/m4GS82mLIm+Krom4MEy+OaTCY4B5pMDHlc7NdJ6Zp8RMffx5CFAk
	 0+P5gtd/5s7ofuyRHUu6/XsZ7pOzKO2bv2zg4LsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19B1BF805B6;
	Mon, 13 Jun 2022 11:06:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89BE4F805B1; Mon, 13 Jun 2022 11:06:18 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D2C8F80589
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2022 11:06:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D2C8F80589
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Xx7NPU+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655111172; x=1686647172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mENeUuivVPJj9cqU4y5T8qfMdoCEA6BJ/ZdaFwXSDtk=;
 b=Xx7NPU+mc2c7GWxc5cVDEBFbNo15kZZBkbY5ihzCGRxLoEkNNkbRcqW4
 IM+0+qYSrWvx8uh8jqdzSMRCQUTR3ZCDVQ4Hpg9ye1esUvCMLoMTw1PZN
 Rwp8iDz5RDopukEVlnLF7QgAK3yCdUoTjIivUI0BmgL0fml57Nt+eFu3p
 jle2gWEl1MobraR44027oohXgmxlX0qDH7eELFHf3ATTwnbSQbHSo90aD
 4hlS9DCIcZDgmIlTn1KoIgYbr8DYPPiWm4T2Sg+dJk/QtbgKZqQRa5Flg
 dPQdJnSo8ubDn+xMaVaOhW6pSHX9yAkmZPMYWLwQPBJ1g+ikWn8SHglp5 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="275753973"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; d="scan'208";a="275753973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 02:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; d="scan'208";a="639626320"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2022 02:06:01 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v2 17/17] ASoC: Intel: bdw_rt286: Remove FE DAI ops
Date: Mon, 13 Jun 2022 11:15:46 +0200
Message-Id: <20220613091546.1565167-18-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613091546.1565167-1-cezary.rojewski@intel.com>
References: <20220613091546.1565167-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

bdw_rt286_fe_ops is redundant as platform FE DAIs already limit the
number of channels available for the endpoint.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/boards/bdw_rt286.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/sound/soc/intel/boards/bdw_rt286.c b/sound/soc/intel/boards/bdw_rt286.c
index 106a06398858..4d30e1811139 100644
--- a/sound/soc/intel/boards/bdw_rt286.c
+++ b/sound/soc/intel/boards/bdw_rt286.c
@@ -108,30 +108,6 @@ static const struct snd_soc_ops codec_link_ops = {
 	.hw_params = codec_link_hw_params,
 };
 
-static const unsigned int channels[] = {
-	2,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_channels = {
-	.count = ARRAY_SIZE(channels),
-	.list = channels,
-	.mask = 0,
-};
-
-static int bdw_rt286_fe_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	/* Board supports stereo configuration only */
-	runtime->hw.channels_max = 2;
-	return snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-					  &constraints_channels);
-}
-
-static const struct snd_soc_ops bdw_rt286_fe_ops = {
-	.startup = bdw_rt286_fe_startup,
-};
-
 SND_SOC_DAILINK_DEF(system, DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
 SND_SOC_DAILINK_DEF(offload0, DAILINK_COMP_ARRAY(COMP_CPU("Offload0 Pin")));
 SND_SOC_DAILINK_DEF(offload1, DAILINK_COMP_ARRAY(COMP_CPU("Offload1 Pin")));
@@ -150,7 +126,6 @@ static struct snd_soc_dai_link card_dai_links[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 		.trigger = { SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST },
-		.ops = &bdw_rt286_fe_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		SND_SOC_DAILINK_REG(system, dummy, platform),
-- 
2.25.1

