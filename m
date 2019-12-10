Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9AAC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:26:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5CA206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="obDR6h3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5CA206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3558516EF;
	Tue, 10 Dec 2019 16:01:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3558516EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575990127;
	bh=3LXWrr36PzKZub/GudsJYR14sUhgif9wCs4/N9zTBGU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=obDR6h3h5oSke22qTjIIFEsy48+CKrxgHoEfUxpAEjy8oWliMkOcpCw6AjFhR1msv
	 sOdjnSVtGczMMW2mC8uReGbPCkHz+BEGpL6h5mvxhGwxjW1/5UOc/kSS2QYlZkEqEX
	 GgK7v9CBlXufwHnOlVJ/NnmQSzmT5+lMeLXbbmoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC1A2F802C3;
	Tue, 10 Dec 2019 15:54:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58EBDF80255; Tue, 10 Dec 2019 15:54:32 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E635BF80258
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:54:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E635BF80258
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 848C9AE07;
 Tue, 10 Dec 2019 14:54:12 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:53:49 +0100
Message-Id: <20191210145406.21419-7-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210145406.21419-1-tiwai@suse.de>
References: <20191210145406.21419-1-tiwai@suse.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>
Subject: [alsa-devel] [PATCH for-5.6 06/23] ASoC: fsl: Drop superfluous
	ioctl PCM ops
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

ASoC PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/fsl/fsl_asrc_dma.c | 1 -
 sound/soc/fsl/fsl_dma.c      | 1 -
 sound/soc/fsl/imx-pcm-fiq.c  | 1 -
 sound/soc/fsl/mpc5200_dma.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index d6146de9acd2..79d66224c0a8 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -428,7 +428,6 @@ static void fsl_asrc_dma_pcm_free(struct snd_soc_component *component,
 
 struct snd_soc_component_driver fsl_asrc_component = {
 	.name		= DRV_NAME,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= fsl_asrc_dma_hw_params,
 	.hw_free	= fsl_asrc_dma_hw_free,
 	.trigger	= fsl_asrc_dma_trigger,
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 2868c4f97cb2..13ae089c1911 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -903,7 +903,6 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	dma->dai.name = DRV_NAME;
 	dma->dai.open = fsl_dma_open;
 	dma->dai.close = fsl_dma_close;
-	dma->dai.ioctl = snd_soc_pcm_lib_ioctl;
 	dma->dai.hw_params = fsl_dma_hw_params;
 	dma->dai.hw_free = fsl_dma_hw_free;
 	dma->dai.pointer = fsl_dma_pointer;
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 08131d147983..f20d5b1c3848 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -338,7 +338,6 @@ static void snd_imx_pcm_free(struct snd_soc_component *component,
 static const struct snd_soc_component_driver imx_soc_component_fiq = {
 	.open		= snd_imx_open,
 	.close		= snd_imx_close,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= snd_imx_pcm_hw_params,
 	.prepare	= snd_imx_pcm_prepare,
 	.trigger	= snd_imx_pcm_trigger,
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 5237ac96b756..ed7211d744b3 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -360,7 +360,6 @@ static const struct snd_soc_component_driver mpc5200_audio_dma_component = {
 	.open		= psc_dma_open,
 	.close		= psc_dma_close,
 	.hw_free	= psc_dma_hw_free,
-	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.pointer	= psc_dma_pointer,
 	.trigger	= psc_dma_trigger,
 	.hw_params	= psc_dma_hw_params,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
