Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E086C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:00:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBF4206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sc07bWf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBF4206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 403CC1690;
	Mon,  9 Dec 2019 10:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 403CC1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885626;
	bh=hOOr2M4tpi9v2buGpLEelF4C53Vi7hHeCrqXm61ITS0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sc07bWf+lFAJBWmbq9KmuNh3Ho3V0sqY60Hr0KDCgTM6iB8cUBeoqaehWWAiMAlAB
	 NCrIbG6QNgZRaDrcGPwesLzKufGAHdQtY8QzSqnFa8fXckqmGREI+EynbMiFb1uCPm
	 DRMoGnyGXi8iiCxY/OlxsbU4rQVqzjczWbug3hyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 706D4F80349;
	Mon,  9 Dec 2019 10:50:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26548F8032A; Mon,  9 Dec 2019 10:50:17 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FCE3F8025F
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FCE3F8025F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 25597B2AA
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:47 +0100
Message-Id: <20191209094943.14984-16-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 15/71] ALSA: gus: Use managed buffer
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

Clean up the driver with the new managed buffer allocation API.
The hw_free callback became superfluous and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/gus/gus_pcm.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 6385b61aa094..bd3a54bc4a94 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -423,11 +423,8 @@ static int snd_gf1_pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	struct snd_gus_card *gus = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct gus_pcm_private *pcmp = runtime->private_data;
-	int err;
-	
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
-	if (err > 0) {	/* change */
+
+	if (runtime->buffer_changed) {
 		struct snd_gf1_mem_block *block;
 		if (pcmp->memory > 0) {
 			snd_gf1_mem_free(&gus->gf1.mem_alloc, pcmp->memory);
@@ -471,7 +468,6 @@ static int snd_gf1_pcm_playback_hw_free(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct gus_pcm_private *pcmp = runtime->private_data;
 
-	snd_pcm_lib_free_pages(substream);
 	if (pcmp->pvoices[0]) {
 		snd_gf1_free_voice(pcmp->gus, pcmp->pvoices[0]);
 		pcmp->pvoices[0] = NULL;
@@ -574,12 +570,7 @@ static int snd_gf1_pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		gus->gf1.pcm_rcntrl_reg |= 4;
 	if (snd_pcm_format_unsigned(params_format(hw_params)))
 		gus->gf1.pcm_rcntrl_reg |= 0x80;
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-}
-
-static int snd_gf1_pcm_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int snd_gf1_pcm_capture_prepare(struct snd_pcm_substream *substream)
@@ -846,7 +837,6 @@ static const struct snd_pcm_ops snd_gf1_pcm_capture_ops = {
 	.close =	snd_gf1_pcm_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_gf1_pcm_capture_hw_params,
-	.hw_free =	snd_gf1_pcm_capture_hw_free,
 	.prepare =	snd_gf1_pcm_capture_prepare,
 	.trigger =	snd_gf1_pcm_capture_trigger,
 	.pointer =	snd_gf1_pcm_capture_pointer,
@@ -875,9 +865,9 @@ int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_gf1_pcm_playback_ops);
 
 	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
-		snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV,
-					      card->dev,
-					      64*1024, gus->gf1.dma1 > 3 ? 128*1024 : 64*1024);
+		snd_pcm_set_managed_buffer(substream, SNDRV_DMA_TYPE_DEV,
+					   card->dev,
+					   64*1024, gus->gf1.dma1 > 3 ? 128*1024 : 64*1024);
 	
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
@@ -885,9 +875,9 @@ int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_gf1_pcm_capture_ops);
 		if (gus->gf1.dma2 == gus->gf1.dma1)
 			pcm->info_flags |= SNDRV_PCM_INFO_HALF_DUPLEX;
-		snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
-					      SNDRV_DMA_TYPE_DEV, card->dev,
-					      64*1024, gus->gf1.dma2 > 3 ? 128*1024 : 64*1024);
+		snd_pcm_set_managed_buffer(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+					   SNDRV_DMA_TYPE_DEV, card->dev,
+					   64*1024, gus->gf1.dma2 > 3 ? 128*1024 : 64*1024);
 	}
 	strcpy(pcm->name, pcm->id);
 	if (gus->interwave) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
