Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69405C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:01:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E371A206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JJr2dNtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E371A206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0198E169D;
	Mon,  9 Dec 2019 11:01:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0198E169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885717;
	bh=gREdIfYPx1DzyKBBkmiNKjc/92GEyK72zM55SojduFY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JJr2dNtJNw3OkrglXAaZSKTrPyg0c3quu05/qlPWa0VQSjiLP3Ab/PhJo2sprc6Ug
	 n+lBg01qUOrtLVEPM6nR8pT2Zih+fyxg3OTN+Wd4VlRpzJynR5Pbu1H6lt9wfwxXmF
	 e9rSwOiYwjVo/9BsHKKlRhj2N0n/QHo35LUlk0jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3015F8034F;
	Mon,  9 Dec 2019 10:50:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAB93F80332; Mon,  9 Dec 2019 10:50:18 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 628BAF8025E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 628BAF8025E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 95316B2BC
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:56 +0100
Message-Id: <20191209094943.14984-25-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 24/71] ALSA: atiixp: Use managed buffer
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
 sound/pci/atiixp.c       | 14 ++++----------
 sound/pci/atiixp_modem.c |  9 ++-------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 1e1ededf8eb2..6fb56952c9c7 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -952,9 +952,6 @@ static int snd_atiixp_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct atiixp_dma *dma = substream->runtime->private_data;
 	int err;
 
-	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
 	dma->buf_addr = substream->runtime->dma_addr;
 	dma->buf_bytes = params_buffer_bytes(hw_params);
 
@@ -994,7 +991,6 @@ static int snd_atiixp_pcm_hw_free(struct snd_pcm_substream *substream)
 		dma->pcm_open_flag = 0;
 	}
 	atiixp_clear_dma_packets(chip, dma, substream);
-	snd_pcm_lib_free_pages(substream);
 	return 0;
 }
 
@@ -1283,9 +1279,8 @@ static int snd_atiixp_pcm_new(struct atiixp *chip)
 	strcpy(pcm->name, "ATI IXP AC97");
 	chip->pcmdevs[ATI_PCMDEV_ANALOG] = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->pci->dev,
-					      64*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &chip->pci->dev, 64*1024, 128*1024);
 
 	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				     snd_pcm_alt_chmaps, chip->max_channels, 0,
@@ -1316,9 +1311,8 @@ static int snd_atiixp_pcm_new(struct atiixp *chip)
 		strcpy(pcm->name, "ATI IXP IEC958 (Direct)");
 	chip->pcmdevs[ATI_PCMDEV_DIGITAL] = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->pci->dev,
-					      64*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &chip->pci->dev, 64*1024, 128*1024);
 
 	/* pre-select AC97 SPDIF slots 10/11 */
 	for (i = 0; i < NUM_ATI_CODECS; i++) {
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 6f088c1949f3..dc40fdaa71cb 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -783,9 +783,6 @@ static int snd_atiixp_pcm_hw_params(struct snd_pcm_substream *substream,
 	int err;
 	int i;
 
-	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
 	dma->buf_addr = substream->runtime->dma_addr;
 	dma->buf_bytes = params_buffer_bytes(hw_params);
 
@@ -812,7 +809,6 @@ static int snd_atiixp_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct atiixp_dma *dma = substream->runtime->private_data;
 
 	atiixp_clear_dma_packets(chip, dma, substream);
-	snd_pcm_lib_free_pages(substream);
 	return 0;
 }
 
@@ -994,9 +990,8 @@ static int snd_atiixp_pcm_new(struct atiixp_modem *chip)
 	strcpy(pcm->name, "ATI IXP MC97");
 	chip->pcmdevs[ATI_PCMDEV_ANALOG] = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->pci->dev,
-					      64*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &chip->pci->dev, 64*1024, 128*1024);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
