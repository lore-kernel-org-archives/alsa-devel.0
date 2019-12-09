Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE5C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:11:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95692077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UPZFsrOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95692077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20F1A16AF;
	Mon,  9 Dec 2019 11:10:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20F1A16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575886283;
	bh=IKHIjiZ+KpMD6GCsIbhkZaUY1lfV0eGe/PVXJGhpqYM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UPZFsrOGLrWIVWI9KW9NJ9K2/3+VrCLd2nCnIPyniaELBtdSl2nQ71v8lHlYCYKjR
	 v9vdiNz78eKTiJaFQH41oo3EjKPtfgI/BVXD7Yf8wmE5vtyxAvQ2PJYK9e4qkmn17+
	 ODWWM7eNHUHYW/2fAEiJ3ABQplrv1NhPx8yEA8ig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9757F803C9;
	Mon,  9 Dec 2019 10:51:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26281F80349; Mon,  9 Dec 2019 10:50:44 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD2F7F80278
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD2F7F80278
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1F489B2C6
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:06 +0100
Message-Id: <20191209094943.14984-35-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 34/71] ALSA: echoaudio: Use managed buffer
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
 sound/pci/echoaudio/echoaudio.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 1465813bf7c6..f8a4a8f6982e 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -547,16 +547,6 @@ static int init_engine(struct snd_pcm_substream *substream,
 		"pcm_hw_params (bufsize=%dB periods=%d persize=%dB)\n",
 		params_buffer_bytes(hw_params), params_periods(hw_params),
 		params_period_bytes(hw_params));
-	err = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
-	if (err < 0) {
-		dev_err(chip->card->dev, "malloc_pages err=%d\n", err);
-		spin_lock_irq(&chip->lock);
-		free_pipes(chip, pipe);
-		spin_unlock_irq(&chip->lock);
-		pipe->index = -1;
-		return err;
-	}
 
 	sglist_init(chip, pipe);
 	edge = PAGE_SIZE;
@@ -671,7 +661,6 @@ static int pcm_hw_free(struct snd_pcm_substream *substream)
 	}
 	spin_unlock_irq(&chip->lock);
 
-	snd_pcm_lib_free_pages(substream);
 	return 0;
 }
 
@@ -872,10 +861,10 @@ static void snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
 
 	for (stream = 0; stream < 2; stream++)
 		for (ss = pcm->streams[stream].substream; ss; ss = ss->next)
-			snd_pcm_lib_preallocate_pages(ss, SNDRV_DMA_TYPE_DEV_SG,
-						      dev,
-						      ss->number ? 0 : 128<<10,
-						      256<<10);
+			snd_pcm_set_managed_buffer(ss, SNDRV_DMA_TYPE_DEV_SG,
+						   dev,
+						   ss->number ? 0 : 128<<10,
+						   256<<10);
 }
 
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
