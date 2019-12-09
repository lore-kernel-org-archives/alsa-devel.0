Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78902C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:37:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021ED2073D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pxm9r+Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021ED2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F53916F5;
	Mon,  9 Dec 2019 11:36:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F53916F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887868;
	bh=f7oIGKDsQLa4LghGHk9U0VyFSbozr70fIkfJQX3efDI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pxm9r+Z1MzlXL3OfkpZaCHHn4qSbwug2m6nLRcMnOu9/TJuSwp0rvxMBi9tp8BmNK
	 FJIsPaeM7YRdz6ooNYiJmMItHE9tkq99dlT/PAomIVJc+9+Am+c2g9QLWtCp7iU/1h
	 TkcCvG523l/A8KoHNeSdfVxPw3+8kqD2kzJolKMM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C46FF805EE;
	Mon,  9 Dec 2019 10:52:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18E12F8029B; Mon,  9 Dec 2019 10:51:26 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA86EF8029B
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA86EF8029B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 20DE2B2D9
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:26 +0100
Message-Id: <20191209094943.14984-55-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 54/71] ALSA: trident: Use managed buffer
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
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/trident/trident_main.c | 49 ++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 07022c0dad40..93789069e78f 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -808,12 +808,9 @@ static int snd_trident_allocate_pcm_mem(struct snd_pcm_substream *substream,
 	struct snd_trident *trident = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_trident_voice *voice = runtime->private_data;
-	int err;
 
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
 	if (trident->tlb.entries) {
-		if (err > 0) { /* change */
+		if (runtime->buffer_changed) {
 			if (voice->memblk)
 				snd_trident_free_pages(trident, voice->memblk);
 			voice->memblk = snd_trident_alloc_pages(trident, substream);
@@ -911,7 +908,6 @@ static int snd_trident_hw_free(struct snd_pcm_substream *substream)
 			voice->memblk = NULL;
 		}
 	}
-	snd_pcm_lib_free_pages(substream);
 	if (evoice != NULL) {
 		snd_trident_free_voice(trident, evoice);
 		voice->extra = NULL;
@@ -1128,11 +1124,6 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 static int snd_trident_si7018_capture_hw_params(struct snd_pcm_substream *substream,
 						struct snd_pcm_hw_params *hw_params)
 {
-	int err;
-
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
-
 	return snd_trident_allocate_evoice(substream, hw_params);
 }
 
@@ -1154,7 +1145,6 @@ static int snd_trident_si7018_capture_hw_free(struct snd_pcm_substream *substrea
 	struct snd_trident_voice *voice = runtime->private_data;
 	struct snd_trident_voice *evoice = voice ? voice->extra : NULL;
 
-	snd_pcm_lib_free_pages(substream);
 	if (evoice != NULL) {
 		snd_trident_free_voice(trident, evoice);
 		voice->extra = NULL;
@@ -2183,17 +2173,17 @@ int snd_trident_pcm(struct snd_trident *trident, int device)
 	if (trident->tlb.entries) {
 		struct snd_pcm_substream *substream;
 		for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
-			snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG,
-						      &trident->pci->dev,
-						      64*1024, 128*1024);
-		snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
-					      SNDRV_DMA_TYPE_DEV,
-					      &trident->pci->dev,
-					      64*1024, 128*1024);
+			snd_pcm_set_managed_buffer(substream, SNDRV_DMA_TYPE_DEV_SG,
+						   &trident->pci->dev,
+						   64*1024, 128*1024);
+		snd_pcm_set_managed_buffer(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+					   SNDRV_DMA_TYPE_DEV,
+					   &trident->pci->dev,
+					   64*1024, 128*1024);
 	} else {
-		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						      &trident->pci->dev,
-						      64*1024, 128*1024);
+		snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+					       &trident->pci->dev,
+					       64*1024, 128*1024);
 	}
 
 	return 0;
@@ -2242,13 +2232,13 @@ int snd_trident_foldback_pcm(struct snd_trident *trident, int device)
 	trident->foldback = foldback;
 
 	if (trident->tlb.entries)
-		snd_pcm_lib_preallocate_pages_for_all(foldback, SNDRV_DMA_TYPE_DEV_SG,
-						      &trident->pci->dev,
-						      0, 128*1024);
+		snd_pcm_set_managed_buffer_all(foldback, SNDRV_DMA_TYPE_DEV_SG,
+					       &trident->pci->dev,
+					       0, 128*1024);
 	else
-		snd_pcm_lib_preallocate_pages_for_all(foldback, SNDRV_DMA_TYPE_DEV,
-						      &trident->pci->dev,
-						      64*1024, 128*1024);
+		snd_pcm_set_managed_buffer_all(foldback, SNDRV_DMA_TYPE_DEV,
+					       &trident->pci->dev,
+					       64*1024, 128*1024);
 
 	return 0;
 }
@@ -2282,9 +2272,8 @@ int snd_trident_spdif_pcm(struct snd_trident *trident, int device)
 	strcpy(spdif->name, "Trident 4DWave IEC958");
 	trident->spdif = spdif;
 
-	snd_pcm_lib_preallocate_pages_for_all(spdif, SNDRV_DMA_TYPE_DEV,
-					      &trident->pci->dev,
-					      64*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(spdif, SNDRV_DMA_TYPE_DEV,
+				       &trident->pci->dev, 64*1024, 128*1024);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
