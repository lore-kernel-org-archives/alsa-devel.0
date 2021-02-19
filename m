Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ECC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:18:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A97E64EB3
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A97E64EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF3D61676;
	Sat, 20 Feb 2021 00:17:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF3D61676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776715;
	bh=17U6IROiqw54fhZvzNPs4+WRcLL+suXTDq/giDcW9lY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GPHeHKd5sutjK6IUTETyTuSx83cigZbtUNNpg4vCF1Bmu5Rw9Y1GzxjrJNNcIsqTG
	 XpBViQpzd6FuZw5RMD/wGCGJCw40d8hNuuPRDb5Tby+J1ZXWdh2LDdUxx0rZ3tvhuc
	 c+EdBiZkt0gYcV3ZpaCzRt0hbJ3d1LyHk39vLCIQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5490CF802A9;
	Sat, 20 Feb 2021 00:17:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E45F1F802C4; Sat, 20 Feb 2021 00:16:58 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA199F800C7
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:16:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA199F800C7
IronPort-SDR: iLgDh4vFxGvu6Vdogb5zKgDTpqKcA4Eh6vUsdWXEf+JWtCt42PMSn7kTN5LrAsVPpSsjpsCbuQ
 rNV6HQULs/8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="203290902"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="203290902"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:16:45 -0800
IronPort-SDR: edGFEe202eaI9mwPtb41x+fZJ1fngVqQ96B2i+EGRKGvjp6zx2R/BoO4Xp8cdTEcQE33n/i/Ee
 Fr4sg/4v/+rQ==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="420329780"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:16:45 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/8] ASoC: sh: dma-sh7760: remove unused variable
Date: Fri, 19 Feb 2021 17:16:28 -0600
Message-Id: <20210219231635.5749-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219231635.5749-1-pierre-louis.bossart@linux.intel.com>
References: <20210219231635.5749-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

cppcheck warning:

sound/soc/sh/dma-sh7760.c:180:6: style: Unused variable: ret
[unusedVariable]
 int ret;
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sh/dma-sh7760.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index b70068dd5a06..121e48f984c5 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -177,7 +177,6 @@ static int camelot_hw_params(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct camelot_pcm *cam = &cam_pcm_data[asoc_rtd_to_cpu(rtd, 0)->id];
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
-	int ret;
 
 	if (recv) {
 		cam->rx_period_size = params_period_bytes(hw_params);
-- 
2.25.1

