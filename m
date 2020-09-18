Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655FC43463
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:34:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B4B20C56
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PaaDqgTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B4B20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 256941616;
	Fri, 18 Sep 2020 12:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 256941616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600425242;
	bh=OUrU7+LsqBqs+CA4r6SKynHlv+4ofJcnozNlpQDTmm4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PaaDqgTKTQXslAJqvWGbjD2KlRSXXmH8C9w2ktvla5OF9rVTIQJMIA+9kkuwl9Iey
	 Dc420TTCgozUQUx+kkU6j/BswEmYnaoT68POkxnkOHiD+eZjsuoH7lBjhJyXUjmlE4
	 ctXn6HKsIZHTBew0bnMzqTEAJnkmVuujH0IR0Ne4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 937E0F80150;
	Fri, 18 Sep 2020 12:33:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06968F8015A; Fri, 18 Sep 2020 12:33:10 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B4B5F800E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 12:32:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B4B5F800E8
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EEFE7201194;
 Fri, 18 Sep 2020 12:32:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B6DE2014E3;
 Fri, 18 Sep 2020 12:32:50 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A982F402AE;
 Fri, 18 Sep 2020 12:32:44 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com
Subject: [PATCH] ASoC: fsl_sai: Instantiate snd_soc_dai_driver
Date: Fri, 18 Sep 2020 18:26:00 +0800
Message-Id: <1600424760-32071-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

Instantiate snd_soc_dai_driver for independent symmetric control.
Otherwise the symmetric setting may be overwritten by other
instance.

Fixes: 08fdf65e37d5 ("ASoC: fsl_sai: Add asynchronous mode support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 19 +++++++++++--------
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5117c1cd5682..3e5c1eaccd5e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -725,7 +725,7 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	return 0;
 }
 
-static struct snd_soc_dai_driver fsl_sai_dai = {
+static struct snd_soc_dai_driver fsl_sai_dai_template = {
 	.probe = fsl_sai_dai_probe,
 	.playback = {
 		.stream_name = "CPU-Playback",
@@ -1062,12 +1062,15 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	memcpy(&sai->cpu_dai_drv, &fsl_sai_dai_template,
+	       sizeof(fsl_sai_dai_template));
+
 	/* Sync Tx with Rx as default by following old DT binding */
 	sai->synchronous[RX] = true;
 	sai->synchronous[TX] = false;
-	fsl_sai_dai.symmetric_rates = 1;
-	fsl_sai_dai.symmetric_channels = 1;
-	fsl_sai_dai.symmetric_samplebits = 1;
+	sai->cpu_dai_drv.symmetric_rates = 1;
+	sai->cpu_dai_drv.symmetric_channels = 1;
+	sai->cpu_dai_drv.symmetric_samplebits = 1;
 
 	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
 	    of_find_property(np, "fsl,sai-asynchronous", NULL)) {
@@ -1084,9 +1087,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		/* Discard all settings for asynchronous mode */
 		sai->synchronous[RX] = false;
 		sai->synchronous[TX] = false;
-		fsl_sai_dai.symmetric_rates = 0;
-		fsl_sai_dai.symmetric_channels = 0;
-		fsl_sai_dai.symmetric_samplebits = 0;
+		sai->cpu_dai_drv.symmetric_rates = 0;
+		sai->cpu_dai_drv.symmetric_channels = 0;
+		sai->cpu_dai_drv.symmetric_samplebits = 0;
 	}
 
 	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
@@ -1128,7 +1131,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	regcache_cache_only(sai->regmap, true);
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
-			&fsl_sai_dai, 1);
+					      &sai->cpu_dai_drv, 1);
 	if (ret)
 		goto err_pm_disable;
 
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index ba7425a9e217..4bbcd0dbe8f1 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -267,6 +267,7 @@ struct fsl_sai {
 	unsigned int bclk_ratio;
 
 	const struct fsl_sai_soc_data *soc_data;
+	struct snd_soc_dai_driver cpu_dai_drv;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct fsl_sai_verid verid;
-- 
2.27.0

