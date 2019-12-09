Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC79C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:31:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E180207FF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p0TUrrHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E180207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5674816E2;
	Mon,  9 Dec 2019 11:30:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5674816E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887507;
	bh=AISh/GVxExSctWfJr+eqmiQwFMyFQ+lQu0vFistDEzg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p0TUrrHwyZlvWNDM3KpbpnWwH7nQ8B5MgBItxpdAyW7p8HF2F4MHAgHIobi3sDq8C
	 GSx5thT1Y/lOTHkLf9R1IPlWyBi2jE9+/zWqycyazixRzzNp4Tbg8tHKGXN3Wr4QJp
	 H/IdkbWS6K3B5xW78r7n8e4DxybCmeTMhTytwRIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D7D3F80566;
	Mon,  9 Dec 2019 10:52:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 744CEF802A1; Mon,  9 Dec 2019 10:51:11 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EBEDF802A2
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EBEDF802A2
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CC8EBB2D3
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:20 +0100
Message-Id: <20191209094943.14984-49-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 48/71] ALSA: oxygen: Use managed buffer
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
 sound/pci/oxygen/oxygen_pcm.c | 52 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/sound/pci/oxygen/oxygen_pcm.c b/sound/pci/oxygen/oxygen_pcm.c
index 203c8fe48a01..4c2bf6952e21 100644
--- a/sound/pci/oxygen/oxygen_pcm.c
+++ b/sound/pci/oxygen/oxygen_pcm.c
@@ -304,12 +304,6 @@ static int oxygen_hw_params(struct snd_pcm_substream *substream,
 {
 	struct oxygen *chip = snd_pcm_substream_chip(substream);
 	unsigned int channel = oxygen_substream_channel(substream);
-	int err;
-
-	err = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
 
 	oxygen_write32(chip, channel_base_registers[channel],
 		       (u32)substream->runtime->dma_addr);
@@ -529,7 +523,7 @@ static int oxygen_hw_free(struct snd_pcm_substream *substream)
 	oxygen_clear_bits8(chip, OXYGEN_DMA_FLUSH, channel_mask);
 	spin_unlock_irq(&chip->reg_lock);
 
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int oxygen_spdif_hw_free(struct snd_pcm_substream *substream)
@@ -711,17 +705,17 @@ int oxygen_pcm_init(struct oxygen *chip)
 		pcm->private_data = chip;
 		strcpy(pcm->name, "Multichannel");
 		if (outs)
-			snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
-						      SNDRV_DMA_TYPE_DEV,
-						      &chip->pci->dev,
-						      DEFAULT_BUFFER_BYTES_MULTICH,
-						      BUFFER_BYTES_MAX_MULTICH);
+			snd_pcm_set_managed_buffer(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,
+						   SNDRV_DMA_TYPE_DEV,
+						   &chip->pci->dev,
+						   DEFAULT_BUFFER_BYTES_MULTICH,
+						   BUFFER_BYTES_MAX_MULTICH);
 		if (ins)
-			snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
-						      SNDRV_DMA_TYPE_DEV,
-						      &chip->pci->dev,
-						      DEFAULT_BUFFER_BYTES,
-						      BUFFER_BYTES_MAX);
+			snd_pcm_set_managed_buffer(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream,
+						   SNDRV_DMA_TYPE_DEV,
+						   &chip->pci->dev,
+						   DEFAULT_BUFFER_BYTES,
+						   BUFFER_BYTES_MAX);
 	}
 
 	outs = !!(chip->model.device_config & PLAYBACK_1_TO_SPDIF);
@@ -738,10 +732,10 @@ int oxygen_pcm_init(struct oxygen *chip)
 					&oxygen_rec_c_ops);
 		pcm->private_data = chip;
 		strcpy(pcm->name, "Digital");
-		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						      &chip->pci->dev,
-						      DEFAULT_BUFFER_BYTES,
-						      BUFFER_BYTES_MAX);
+		snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+					       &chip->pci->dev,
+					       DEFAULT_BUFFER_BYTES,
+					       BUFFER_BYTES_MAX);
 	}
 
 	if (chip->has_ac97_1) {
@@ -768,10 +762,10 @@ int oxygen_pcm_init(struct oxygen *chip)
 					&oxygen_rec_b_ops);
 		pcm->private_data = chip;
 		strcpy(pcm->name, outs ? "Front Panel" : "Analog 2");
-		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						      &chip->pci->dev,
-						      DEFAULT_BUFFER_BYTES,
-						      BUFFER_BYTES_MAX);
+		snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+					       &chip->pci->dev,
+					       DEFAULT_BUFFER_BYTES,
+					       BUFFER_BYTES_MAX);
 	}
 
 	ins = !!(chip->model.device_config & CAPTURE_3_FROM_I2S_3);
@@ -786,10 +780,10 @@ int oxygen_pcm_init(struct oxygen *chip)
 				     OXYGEN_REC_C_ROUTE_MASK);
 		pcm->private_data = chip;
 		strcpy(pcm->name, "Analog 3");
-		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						      &chip->pci->dev,
-						      DEFAULT_BUFFER_BYTES,
-						      BUFFER_BYTES_MAX);
+		snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+					       &chip->pci->dev,
+					       DEFAULT_BUFFER_BYTES,
+					       BUFFER_BYTES_MAX);
 	}
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
