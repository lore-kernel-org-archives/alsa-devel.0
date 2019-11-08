Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D1FC5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:54:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D37121D7E
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YX40/QRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D37121D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DD3E1693;
	Fri,  8 Nov 2019 10:53:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DD3E1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573206839;
	bh=4HtBibI6+vKbwrcZMMKFf0wLslc7LHAMxa8OM9b/tOc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YX40/QRP9k+bbUTGcmDs3d19iJwQ4fo9tmyLvci4KzBYUtejc4GKE0kRb5Gi78iZG
	 piKVALKT+q/GjCbtjMWXA84zyegmlZskvLVhVTZuSLyVFEnvzVOrel1wVkvb1Q/aIe
	 Rm4K5G/1HzwRswh2EvjK6mLvD1fBlBCfGeq0+/7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A469F8063B;
	Fri,  8 Nov 2019 10:49:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F200FF80321; Fri,  8 Nov 2019 10:48:18 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41785F803F4
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 10:46:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41785F803F4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 99428AE8A;
 Fri,  8 Nov 2019 09:46:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  8 Nov 2019 10:46:34 +0100
Message-Id: <20191108094641.20086-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191108094641.20086-1-tiwai@suse.de>
References: <20191108094641.20086-1-tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/8] ASoC: Remove superfluous
	snd_dma_continuous_data()
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The recent change (commit 08422d2c559d: "ALSA: memalloc: Allow NULL
device for SNDRV_DMA_TYPE_CONTINOUS type") made the PCM preallocation
helper accepting NULL as the device pointer for the default usage.
Drop the snd_dma_continuous_data() usage that became superfluous from
the callers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/au1x/dma.c      | 2 +-
 sound/soc/dwc/dwc-pcm.c   | 2 +-
 sound/soc/sh/dma-sh7760.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 49556eb409cd..054dfda89d3e 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -293,7 +293,7 @@ static int alchemy_pcm_new(struct snd_soc_component *component,
 	struct snd_pcm *pcm = rtd->pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-		snd_dma_continuous_data(GFP_KERNEL), 65536, (4096 * 1024) - 1);
+					      NULL, 65536, (4096 * 1024) - 1);
 
 	return 0;
 }
diff --git a/sound/soc/dwc/dwc-pcm.c b/sound/soc/dwc/dwc-pcm.c
index de6fcc808832..4771eb5fbe2a 100644
--- a/sound/soc/dwc/dwc-pcm.c
+++ b/sound/soc/dwc/dwc-pcm.c
@@ -258,7 +258,7 @@ static int dw_pcm_new(struct snd_soc_component *component,
 
 	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
-			snd_dma_continuous_data(GFP_KERNEL), size, size);
+			NULL, size, size);
 	return 0;
 }
 
diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 93bb80d089be..2b0eca02a8b9 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -309,7 +309,7 @@ static int camelot_pcm_new(struct snd_soc_component *component,
 	 */
 	snd_pcm_lib_preallocate_pages_for_all(pcm,
 		SNDRV_DMA_TYPE_CONTINUOUS,
-		snd_dma_continuous_data(GFP_KERNEL),
+		NULL,
 		DMABRG_PREALLOC_BUFFER,	DMABRG_PREALLOC_BUFFER_MAX);
 
 	return 0;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
