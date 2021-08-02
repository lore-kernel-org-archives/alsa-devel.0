Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB9C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 07:32:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E652160F5A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 07:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E652160F5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7217717F4;
	Mon,  2 Aug 2021 09:32:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7217717F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627889575;
	bh=hUM0S222Av90n36bY22pOAAAx3ZuLE4fDbJ7sTCLJts=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sr1Sr9r7VPUkhJKGeRnJtfXRAqCCi9ZWQlhWpy0BWrPd5DO5eyH5aIC4LU/bhUw/G
	 ZFO4IHdnneQSHJzHPMowXuiDLrB39vhPS28VkqHN+BJNDwSXOMrXAhg2dQzquCoi2V
	 wJgGt1hkdEkJDJZX5BsNRgjNsvAlA48wq2pCkxaM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2989FF80525;
	Mon,  2 Aug 2021 09:28:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D752F804F1; Mon,  2 Aug 2021 09:28:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42B85F804E2
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 09:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42B85F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="vAZwZ3lt"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="WW58HtMw"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 10A5A21FDC;
 Mon,  2 Aug 2021 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627889298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAXkjoG0XBWzOLP9/+t4EtuYEir/7G52JU7J2dwCcD0=;
 b=vAZwZ3lteLIvvn6ityzcNtS4xwzmXnlpX617HkwdbpZHh+0uPE6cu3nU/QuKD/atpZeJjo
 moWQMyi/8UzSwhP6Ua4mXD2iSubzxmMf+ScGNr7JyiB0ulB0a9+BBpq0wtY7OKacnd+OIT
 f7SGOBJL59J/Vsj0tYz9lEUUHcWzNY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627889298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAXkjoG0XBWzOLP9/+t4EtuYEir/7G52JU7J2dwCcD0=;
 b=WW58HtMwVgZGxAORepSUxQd7ty1B3Lo2sy8kzpyWDCWdXN6emmIQ++Tq6gApOyiTPUW9hE
 ojIZv0i//C9D/HBQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 001FAA3B83;
 Mon,  2 Aug 2021 07:28:17 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/15] ASoC: bcm: Use managed PCM buffer allocation
Date: Mon,  2 Aug 2021 09:28:06 +0200
Message-Id: <20210802072815.13551-7-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210802072815.13551-1-tiwai@suse.de>
References: <20210802072815.13551-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

As the standard buffer allocation helper supports WC pages now, we can
convert bcm driver to use that.  This allows us to remove lots of
superfluous code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 82 ++--------------------------
 1 file changed, 6 insertions(+), 76 deletions(-)

diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index 7ec8559d53a2..b5096f64c576 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -46,10 +46,6 @@ static int bcm63xx_pcm_hw_params(struct snd_soc_component *component,
 {
 	struct i2s_dma_desc *dma_desc;
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = params_buffer_bytes(params);
 
 	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
 	if (!dma_desc)
@@ -68,7 +64,6 @@ static int bcm63xx_pcm_hw_free(struct snd_soc_component *component,
 
 	dma_desc = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
 	kfree(dma_desc);
-	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	return 0;
 }
@@ -190,19 +185,6 @@ bcm63xx_pcm_pointer(struct snd_soc_component *component,
 	return x == substream->runtime->buffer_size ? 0 : x;
 }
 
-static int bcm63xx_pcm_mmap(struct snd_soc_component *component,
-				struct snd_pcm_substream *substream,
-				struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	return  dma_mmap_wc(substream->pcm->card->dev, vma,
-			    runtime->dma_area,
-			    runtime->dma_addr,
-			    runtime->dma_bytes);
-
-}
-
 static int bcm63xx_pcm_open(struct snd_soc_component *component,
 			struct snd_pcm_substream *substream)
 {
@@ -362,25 +344,6 @@ static irqreturn_t i2s_dma_isr(int irq, void *bcm_i2s_priv)
 	return IRQ_HANDLED;
 }
 
-static int bcm63xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = bcm63xx_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-
-	buf->area = dma_alloc_wc(pcm->card->dev,
-				 size, &buf->addr,
-				 GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-	buf->bytes = size;
-	return 0;
-}
-
 static int bcm63xx_soc_pcm_new(struct snd_soc_component *component,
 		struct snd_soc_pcm_runtime *rtd)
 {
@@ -394,49 +357,18 @@ static int bcm63xx_soc_pcm_new(struct snd_soc_component *component,
 
 	ret = dma_coerce_mask_and_coherent(pcm->card->dev, DMA_BIT_MASK(32));
 	if (ret)
-		goto out;
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = bcm63xx_pcm_preallocate_dma_buffer(pcm,
-						 SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto out;
+		return ret;
 
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
 		i2s_priv->play_substream =
 			pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = bcm63xx_pcm_preallocate_dma_buffer(pcm,
-					SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto out;
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream)
 		i2s_priv->capture_substream =
 			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	}
 
-out:
-	return ret;
-}
-
-static void bcm63xx_pcm_free_dma_buffers(struct snd_soc_component *component,
-			 struct snd_pcm *pcm)
-{
-	int stream;
-	struct snd_dma_buffer *buf;
-	struct snd_pcm_substream *substream;
-
-	for (stream = 0; stream < 2; stream++) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-		dma_free_wc(pcm->card->dev, buf->bytes,
-					buf->area, buf->addr);
-		buf->area = NULL;
-	}
+	return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV_WC,
+					    pcm->card->dev,
+					    bcm63xx_pcm_hardware.buffer_bytes_max);
 }
 
 static const struct snd_soc_component_driver bcm63xx_soc_platform = {
@@ -447,9 +379,7 @@ static const struct snd_soc_component_driver bcm63xx_soc_platform = {
 	.prepare = bcm63xx_pcm_prepare,
 	.trigger = bcm63xx_pcm_trigger,
 	.pointer = bcm63xx_pcm_pointer,
-	.mmap = bcm63xx_pcm_mmap,
 	.pcm_construct = bcm63xx_soc_pcm_new,
-	.pcm_destruct = bcm63xx_pcm_free_dma_buffers,
 };
 
 int bcm63xx_soc_platform_probe(struct platform_device *pdev,
-- 
2.26.2

