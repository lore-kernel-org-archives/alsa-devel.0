Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CA3C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 07:19:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC0A60F92
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 07:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFC0A60F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8A9E167B;
	Mon,  9 Aug 2021 09:18:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8A9E167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628493571;
	bh=YnxI0PlQXDFuOPDVpsE7+IA3Ga26d+jznx3+r4B2cVA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aUORiJne+8CmH64jA/hSlhqNO5RCMRYKEPuV9+qOkFtahftlUc3a5m1FTrLgoLzr2
	 gNfGNlVCFTuJe4aZw2Ai0ChSN7AlGHC7xkvued8LNQoBeDXKUG55JMf6KXSxE3xCD/
	 eq4TYHXAX40tcBVYaZKbA9aUL4qCo06rByYr5Xdo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 598F5F804AE;
	Mon,  9 Aug 2021 09:18:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47E27F804B0; Mon,  9 Aug 2021 09:18:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44F2BF800FD
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 09:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44F2BF800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="gLYQ/rHh"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="c8ygw2p1"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DBCEB1FD9A
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628493510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+dNoYaWFX4MfYyLQWN/6sfFfVFohE3MaNlq8WHANJg=;
 b=gLYQ/rHh3/97iA24bYZwHo6yduX9XFeiF8dhdGUH8BoeIFNn0p1Ckn8IqZmxSBcVk7BxS0
 VF0RUmM6wKskKiRn2i8EXL2O63gjsUewND8f1I9y4zldmdifNEaJaTr7fGokfTZ+LBTkp5
 OXyoiI1We9baLkAZqRR0sj+C7gyo2k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628493510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+dNoYaWFX4MfYyLQWN/6sfFfVFohE3MaNlq8WHANJg=;
 b=c8ygw2p1isKLYGTzAIQMC53fUS8cI9L7FtlOylSY+27N0sxXBFmhloE4i1DkvLpSwrYVjS
 buLVa1V1hZ98zmAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id CBA88A3B88;
 Mon,  9 Aug 2021 07:18:30 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ALSA: pci: cs46xx: Fix set up buffer type properly
Date: Mon,  9 Aug 2021 09:18:29 +0200
Message-Id: <20210809071829.22238-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809071829.22238-1-tiwai@suse.de>
References: <20210809071829.22238-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

CS46xx driver switches the buffer depending on the number of periods,
and in some cases it switches to the own buffer without updating the
buffer type properly.  This may cause a problem with the mmap on
exotic architectures that require the own mmap call for the coherent
DMA buffer.

This patch addresses the potential breakage by replacing the buffer
setup with the proper macro.  It also simplifies the source code,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs46xx/cs46xx_lib.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 8877afb66704..62f45847b351 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1121,9 +1121,7 @@ static int snd_cs46xx_playback_hw_params(struct snd_pcm_substream *substream,
 	if (params_periods(hw_params) == CS46XX_FRAGS) {
 		if (runtime->dma_area != cpcm->hw_buf.area)
 			snd_pcm_lib_free_pages(substream);
-		runtime->dma_area = cpcm->hw_buf.area;
-		runtime->dma_addr = cpcm->hw_buf.addr;
-		runtime->dma_bytes = cpcm->hw_buf.bytes;
+		snd_pcm_set_runtime_buffer(substream, &cpcm->hw_buf);
 
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
@@ -1143,11 +1141,8 @@ static int snd_cs46xx_playback_hw_params(struct snd_pcm_substream *substream,
 #endif
 
 	} else {
-		if (runtime->dma_area == cpcm->hw_buf.area) {
-			runtime->dma_area = NULL;
-			runtime->dma_addr = 0;
-			runtime->dma_bytes = 0;
-		}
+		if (runtime->dma_area == cpcm->hw_buf.area)
+			snd_pcm_set_runtime_buffer(substream, NULL);
 		err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 		if (err < 0) {
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
@@ -1196,9 +1191,7 @@ static int snd_cs46xx_playback_hw_free(struct snd_pcm_substream *substream)
 	if (runtime->dma_area != cpcm->hw_buf.area)
 		snd_pcm_lib_free_pages(substream);
     
-	runtime->dma_area = NULL;
-	runtime->dma_addr = 0;
-	runtime->dma_bytes = 0;
+	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	return 0;
 }
@@ -1287,16 +1280,11 @@ static int snd_cs46xx_capture_hw_params(struct snd_pcm_substream *substream,
 	if (runtime->periods == CS46XX_FRAGS) {
 		if (runtime->dma_area != chip->capt.hw_buf.area)
 			snd_pcm_lib_free_pages(substream);
-		runtime->dma_area = chip->capt.hw_buf.area;
-		runtime->dma_addr = chip->capt.hw_buf.addr;
-		runtime->dma_bytes = chip->capt.hw_buf.bytes;
+		snd_pcm_set_runtime_buffer(substream, &chip->capt.hw_buf);
 		substream->ops = &snd_cs46xx_capture_ops;
 	} else {
-		if (runtime->dma_area == chip->capt.hw_buf.area) {
-			runtime->dma_area = NULL;
-			runtime->dma_addr = 0;
-			runtime->dma_bytes = 0;
-		}
+		if (runtime->dma_area == chip->capt.hw_buf.area)
+			snd_pcm_set_runtime_buffer(substream, NULL);
 		err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 		if (err < 0)
 			return err;
@@ -1313,9 +1301,7 @@ static int snd_cs46xx_capture_hw_free(struct snd_pcm_substream *substream)
 
 	if (runtime->dma_area != chip->capt.hw_buf.area)
 		snd_pcm_lib_free_pages(substream);
-	runtime->dma_area = NULL;
-	runtime->dma_addr = 0;
-	runtime->dma_bytes = 0;
+	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	return 0;
 }
-- 
2.26.2

