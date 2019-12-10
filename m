Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79062C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:27:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853A920838
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Eh/tWCw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853A920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66E591666;
	Tue, 10 Dec 2019 15:26:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66E591666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575988042;
	bh=P615hHRL+H8qTMWSY4fCMow4Us/2mfZaiIUfw9XOzyw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eh/tWCw5R60FHkQYz8KmSqb5kB+VhwPDA5IfzhdYTZkTnK5usmm7wY9ylqn5MjirP
	 E0dv+dl271sC+oYhdU/SfjC7fEku+Ww0Mkuv7seahXPr9VSWtG6lRYxC1h4eaz33kX
	 f4r8epS3S9cFc1gswP6jHKMhfDAV/UOH9CfdgUHA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BFA3F8026A;
	Tue, 10 Dec 2019 15:26:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D46D3F8025F; Tue, 10 Dec 2019 15:26:29 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CB24F800B4
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:26:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CB24F800B4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9CDE8AF86;
 Tue, 10 Dec 2019 14:26:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:25:52 +0100
Message-Id: <20191210142614.19405-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210142614.19405-1-tiwai@suse.de>
References: <20191210142614.19405-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH for-5.6 01/23] ASoC: amd: Use managed buffer
	allocation
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

Clean up the drivers with the new managed buffer allocation API.
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/amd/acp-pcm-dma.c         | 58 +++++++++++++------------------------
 sound/soc/amd/raven/acp3x-pcm-dma.c | 30 ++++---------------
 2 files changed, 26 insertions(+), 62 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 4b9a27e25206..98400aaf0305 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -836,7 +836,6 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-	int status;
 	uint64_t size;
 	u32 val = 0;
 	struct snd_pcm_runtime *runtime;
@@ -967,35 +966,19 @@ static int acp_dma_hw_params(struct snd_soc_component *component,
 	}
 
 	size = params_buffer_bytes(params);
-	status = snd_pcm_lib_malloc_pages(substream, size);
-	if (status < 0)
-		return status;
-
-	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 
-	if (substream->dma_buffer.area) {
-		acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
-		/* Save for runtime private data */
-		rtd->dma_addr = substream->dma_buffer.addr;
-		rtd->order = get_order(size);
+	acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
+	/* Save for runtime private data */
+	rtd->dma_addr = substream->dma_buffer.addr;
+	rtd->order = get_order(size);
 
-		/* Fill the page table entries in ACP SRAM */
-		rtd->size = size;
-		rtd->num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-		rtd->direction = substream->stream;
+	/* Fill the page table entries in ACP SRAM */
+	rtd->size = size;
+	rtd->num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	rtd->direction = substream->stream;
 
-		config_acp_dma(rtd->acp_mmio, rtd, adata->asic_type);
-		status = 0;
-	} else {
-		status = -ENOMEM;
-	}
-	return status;
-}
-
-static int acp_dma_hw_free(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
+	config_acp_dma(rtd->acp_mmio, rtd, adata->asic_type);
+	return 0;
 }
 
 static u64 acp_get_byte_count(struct audio_substream_data *rtd)
@@ -1142,18 +1125,18 @@ static int acp_dma_new(struct snd_soc_component *component,
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
-		snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-						      SNDRV_DMA_TYPE_DEV,
-						      parent,
-						      ST_MIN_BUFFER,
-						      ST_MAX_BUFFER);
+		snd_pcm_set_managed_buffer_all(rtd->pcm,
+					       SNDRV_DMA_TYPE_DEV,
+					       parent,
+					       ST_MIN_BUFFER,
+					       ST_MAX_BUFFER);
 		break;
 	default:
-		snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-						      SNDRV_DMA_TYPE_DEV,
-						      parent,
-						      MIN_BUFFER,
-						      MAX_BUFFER);
+		snd_pcm_set_managed_buffer_all(rtd->pcm,
+					       SNDRV_DMA_TYPE_DEV,
+					       parent,
+					       MIN_BUFFER,
+					       MAX_BUFFER);
 		break;
 	}
 	return 0;
@@ -1221,7 +1204,6 @@ static const struct snd_soc_component_driver acp_asoc_platform = {
 	.close		= acp_dma_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= acp_dma_hw_params,
-	.hw_free	= acp_dma_hw_free,
 	.trigger	= acp_dma_trigger,
 	.pointer	= acp_dma_pointer,
 	.mmap		= acp_dma_mmap,
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 60709e3ba99d..98b76c38dae0 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -334,7 +334,6 @@ static int acp3x_dma_hw_params(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params)
 {
-	int status;
 	u64 size;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct i2s_stream_instance *rtd = runtime->private_data;
@@ -343,20 +342,10 @@ static int acp3x_dma_hw_params(struct snd_soc_component *component,
 		return -EINVAL;
 
 	size = params_buffer_bytes(params);
-	status = snd_pcm_lib_malloc_pages(substream, size);
-	if (status < 0)
-		return status;
-
-	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
-	if (substream->dma_buffer.area) {
-		rtd->dma_addr = substream->dma_buffer.addr;
-		rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
-		config_acp3x_dma(rtd, substream->stream);
-		status = 0;
-	} else {
-		status = -ENOMEM;
-	}
-	return status;
+	rtd->dma_addr = substream->dma_buffer.addr;
+	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
+	config_acp3x_dma(rtd, substream->stream);
+	return 0;
 }
 
 static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_soc_component *component,
@@ -381,17 +370,11 @@ static int acp3x_dma_new(struct snd_soc_component *component,
 			 struct snd_soc_pcm_runtime *rtd)
 {
 	struct device *parent = component->dev->parent;
-	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-					      parent, MIN_BUFFER, MAX_BUFFER);
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       parent, MIN_BUFFER, MAX_BUFFER);
 	return 0;
 }
 
-static int acp3x_dma_hw_free(struct snd_soc_component *component,
-			     struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int acp3x_dma_mmap(struct snd_soc_component *component,
 			  struct snd_pcm_substream *substream,
 			  struct vm_area_struct *vma)
@@ -601,7 +584,6 @@ static const struct snd_soc_component_driver acp3x_i2s_component = {
 	.close		= acp3x_dma_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= acp3x_dma_hw_params,
-	.hw_free	= acp3x_dma_hw_free,
 	.pointer	= acp3x_dma_pointer,
 	.mmap		= acp3x_dma_mmap,
 	.pcm_construct	= acp3x_dma_new,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
