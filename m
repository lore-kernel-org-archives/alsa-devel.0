Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68D9C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 11:26:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71D960724
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 11:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C71D960724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 563AF17EB;
	Wed, 28 Jul 2021 13:25:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 563AF17EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627471598;
	bh=R/EbTH48hk7nmUGCTlD/zaZJpaLACYTopxj9jOPgL1M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5TP89M22SgzcuAAm1EqK4xrsldBHENpnkG2qwVptbk1YF3l6EVaRLjOw4IUZ2APJ
	 x0OV4u0F6yj/hH2CHoopYF3GYcpbIJegodJYEF4B/t1SLkfRgtuAFPNKGFrUTwy//c
	 seU0Q+osMcu2lVo33GcwusAyv85it16F/Fpki54M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9B3FF804E5;
	Wed, 28 Jul 2021 13:24:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 223C4F80253; Wed, 28 Jul 2021 13:24:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9CE6F8025A
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 13:23:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9CE6F8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="D681HtsG"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="gETVdqo/"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B164F22319;
 Wed, 28 Jul 2021 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627471434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fM5L7tzMu1HQAnmsbEtalzZb96qT6ACZ9lqfleebnVU=;
 b=D681HtsGQOJ6i3SS3thiPmAEtNvj9jSQXnakhP6HbKmhjScjidF3GgZMtHXNuEUmjzTTib
 2e3eimdIHiVLw5eOU+ODekcSn52A5G8E2qLMASg4d78dr/XmwLWYVgpZvwCfoV2HyOZrkm
 GaAxitUzRaTXq2IZY4lgPWBYRMHZ4iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627471434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fM5L7tzMu1HQAnmsbEtalzZb96qT6ACZ9lqfleebnVU=;
 b=gETVdqo/Hhg22ajCP4Wz97obPDaFVgJuCbx9tcsxy5bP5T3EAR0uwfdzlgX1inswaXE3NC
 OKmg3UOpCT3Wm+Ag==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 9CC25A3B8B;
 Wed, 28 Jul 2021 11:23:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: kirkwood: Fix reference to PCM buffer address
Date: Wed, 28 Jul 2021 13:23:53 +0200
Message-Id: <20210728112353.6675-6-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210728112353.6675-1-tiwai@suse.de>
References: <20210728112353.6675-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 stable@vger.kernel.org
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

The transition to the managed PCM buffers allowed the dynamically
buffer allocation, while the driver code still assumes the fixed
preallocation buffer and sets up the DMA stuff at the open call.
This needs to be moved to hw_params after the buffer allocation and
setup.  Also, the reference to the buffer address has to be corrected
to runtime->dma_addr.

Fixes: b3c0ae75f5d3 ("ASoC: kirkwood: Use managed DMA buffer allocation")
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/kirkwood/kirkwood-dma.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index c2a5933bfcfc..700a18561a94 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -104,8 +104,6 @@ static int kirkwood_dma_open(struct snd_soc_component *component,
 	int err;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct kirkwood_dma_data *priv = kirkwood_priv(substream);
-	const struct mbus_dram_target_info *dram;
-	unsigned long addr;
 
 	snd_soc_set_runtime_hwparams(substream, &kirkwood_dma_snd_hw);
 
@@ -142,20 +140,14 @@ static int kirkwood_dma_open(struct snd_soc_component *component,
 		writel((unsigned int)-1, priv->io + KIRKWOOD_ERR_MASK);
 	}
 
-	dram = mv_mbus_dram_info();
-	addr = substream->dma_buffer.addr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (priv->substream_play)
 			return -EBUSY;
 		priv->substream_play = substream;
-		kirkwood_dma_conf_mbus_windows(priv->io,
-			KIRKWOOD_PLAYBACK_WIN, addr, dram);
 	} else {
 		if (priv->substream_rec)
 			return -EBUSY;
 		priv->substream_rec = substream;
-		kirkwood_dma_conf_mbus_windows(priv->io,
-			KIRKWOOD_RECORD_WIN, addr, dram);
 	}
 
 	return 0;
@@ -182,6 +174,23 @@ static int kirkwood_dma_close(struct snd_soc_component *component,
 	return 0;
 }
 
+static int kirkwood_dma_hw_params(struct snd_soc_component *component,
+				  struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
+{
+	struct kirkwood_dma_data *priv = kirkwood_priv(substream);
+	const struct mbus_dram_target_info *dram = mv_mbus_dram_info();
+	unsigned long addr = substream->runtime->dma_addr;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		kirkwood_dma_conf_mbus_windows(priv->io,
+			KIRKWOOD_PLAYBACK_WIN, addr, dram);
+	else
+		kirkwood_dma_conf_mbus_windows(priv->io,
+			KIRKWOOD_RECORD_WIN, addr, dram);
+	return 0;
+}
+
 static int kirkwood_dma_prepare(struct snd_soc_component *component,
 				struct snd_pcm_substream *substream)
 {
@@ -246,6 +255,7 @@ const struct snd_soc_component_driver kirkwood_soc_component = {
 	.name		= DRV_NAME,
 	.open		= kirkwood_dma_open,
 	.close		= kirkwood_dma_close,
+	.hw_params	= kirkwood_dma_hw_params,
 	.prepare	= kirkwood_dma_prepare,
 	.pointer	= kirkwood_dma_pointer,
 	.pcm_construct	= kirkwood_dma_new,
-- 
2.26.2

