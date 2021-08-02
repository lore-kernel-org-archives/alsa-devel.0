Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96FC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 07:34:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6B460F5A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 07:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC6B460F5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47C2717F7;
	Mon,  2 Aug 2021 09:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47C2717F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627889659;
	bh=B5RGubK+q3VLTR55IYNJqYtpVAPZ/BMtlOb5NuEz/lc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IwyNd4GCCOiJZPA6pwaQceAyRXypcsecBfq7MatjmVsI7GhMF+lA6y98eGHa4nEFk
	 OpaO6xwPqC+55N+enJCxFnUkPJK7kKs8hJ0HR+eeY0s+gsFizBsT0UCdxLmWdpesPK
	 jzHrIZsfqPq9v1k8hKYYY3EkAQEVhhqCn3YfqcA8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFD18F8053C;
	Mon,  2 Aug 2021 09:29:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5F10F801F7; Mon,  2 Aug 2021 09:28:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC477F804E5
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 09:28:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC477F804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="pj4C0ZGi"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="tk0RTvV+"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7E4A91FF3C;
 Mon,  2 Aug 2021 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627889298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2dzNViarco0AmwbieOC8R7UCnh2NiymHI1W10i8GVQ=;
 b=pj4C0ZGiX5fr70t96k41a9FSSG7qv8r7YNi6EG5oNffi83yFzfzH+HVTnqQcoY2IEedpZW
 WYoj4xhXM6btk/rFMvuNpZCtaViPvgHb/MFA0rS5dLZ2ipUl4M+pI70YrhmOzG/IxeMNdu
 1oPP1RtNd1OoOvcZYVJjir/boH7gIJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627889298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2dzNViarco0AmwbieOC8R7UCnh2NiymHI1W10i8GVQ=;
 b=tk0RTvV+62tSxBbnyfezxGeNUAkaSi3Qf0l8L4AGBGhKjNWaMPouuPbnwxwLLSEdwe4xSg
 thql4DHWRrkY5pAQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 773FBA3BA8;
 Mon,  2 Aug 2021 07:28:18 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 14/15] ASoC: qcom: qdsp6: Use managed buffer allocation
Date: Mon,  2 Aug 2021 09:28:14 +0200
Message-Id: <20210802072815.13551-15-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210802072815.13551-1-tiwai@suse.de>
References: <20210802072815.13551-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>
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

This patch simplifies the buffer pre-allocation code of qcom qdsp6
driver with the standard managed buffer helper.  It uses the newly
introduced fixed-size buffer allocation helper.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 63 ++------------------------------
 1 file changed, 3 insertions(+), 60 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 5ff56a735419..46f365528d50 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -429,8 +429,6 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 	else
 		prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
 
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
 	return 0;
 }
 
@@ -470,18 +468,6 @@ static snd_pcm_uframes_t q6asm_dai_pointer(struct snd_soc_component *component,
 	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
 }
 
-static int q6asm_dai_mmap(struct snd_soc_component *component,
-			  struct snd_pcm_substream *substream,
-			  struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct device *dev = component->dev;
-
-	return dma_mmap_coherent(dev, vma,
-			runtime->dma_area, runtime->dma_addr,
-			runtime->dma_bytes);
-}
-
 static int q6asm_dai_hw_params(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params)
@@ -1185,52 +1171,11 @@ static const struct snd_compress_ops q6asm_dai_compress_ops = {
 static int q6asm_dai_pcm_new(struct snd_soc_component *component,
 			     struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_pcm_substream *psubstream, *csubstream;
 	struct snd_pcm *pcm = rtd->pcm;
-	struct device *dev;
-	int size, ret;
-
-	dev = component->dev;
-	size = q6asm_dai_hardware_playback.buffer_bytes_max;
-	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-	if (psubstream) {
-		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
-					  &psubstream->dma_buffer);
-		if (ret) {
-			dev_err(dev, "Cannot allocate buffer(s)\n");
-			return ret;
-		}
-	}
+	size_t size = q6asm_dai_hardware_playback.buffer_bytes_max;
 
-	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
-	if (csubstream) {
-		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
-					  &csubstream->dma_buffer);
-		if (ret) {
-			dev_err(dev, "Cannot allocate buffer(s)\n");
-			if (psubstream)
-				snd_dma_free_pages(&psubstream->dma_buffer);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static void q6asm_dai_pcm_free(struct snd_soc_component *component,
-			       struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
-		substream = pcm->streams[i].substream;
-		if (substream) {
-			snd_dma_free_pages(&substream->dma_buffer);
-			substream->dma_buffer.area = NULL;
-			substream->dma_buffer.addr = 0;
-		}
-	}
+	return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+					    component->dev, size);
 }
 
 static const struct snd_soc_dapm_widget q6asm_dapm_widgets[] = {
@@ -1260,9 +1205,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.prepare	= q6asm_dai_prepare,
 	.trigger	= q6asm_dai_trigger,
 	.pointer	= q6asm_dai_pointer,
-	.mmap		= q6asm_dai_mmap,
 	.pcm_construct	= q6asm_dai_pcm_new,
-	.pcm_destruct	= q6asm_dai_pcm_free,
 	.compress_ops	= &q6asm_dai_compress_ops,
 	.dapm_widgets	= q6asm_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(q6asm_dapm_widgets),
-- 
2.26.2

