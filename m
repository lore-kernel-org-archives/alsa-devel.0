Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E08DC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:02:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA0F206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qD1Qt6mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA0F206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22B291616;
	Mon,  9 Dec 2019 11:01:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22B291616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885757;
	bh=JaBksQZ7w95DcWoLYBzSWF17CBerp8RUOKUFIb+qbLA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qD1Qt6mVadyDUKI9WwQmHJ53WurjrSrBGcN6aU9xZm0ehTkgFhsLwH06cKCqYwiNz
	 3ISeIaF3RD7J/EaWMAqLZNK7EmlHZ+/s9qiIzWq5F6iF32dna/JUIIVLqb+EO+tAHD
	 ufN0xtkAABLismQeK2eATtrXuYiMWRz2FAzNS/xU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECEAFF8028F;
	Mon,  9 Dec 2019 10:51:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 843D4F8032A; Mon,  9 Dec 2019 10:50:20 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3E3FF8025A
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3E3FF8025A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 08824B2A6
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:45 +0100
Message-Id: <20191209094943.14984-14-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 13/71] ALSA: es18xx: Use managed buffer
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
 sound/isa/es18xx.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 01ad15086c4a..1346447ffe01 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -434,7 +434,7 @@ static int snd_es18xx_playback_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_es18xx *chip = snd_pcm_substream_chip(substream);
-	int shift, err;
+	int shift;
 
 	shift = 0;
 	if (params_channels(hw_params) == 2)
@@ -453,16 +453,9 @@ static int snd_es18xx_playback_hw_params(struct snd_pcm_substream *substream,
 	} else {
 		chip->dma1_shift = shift;
 	}
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
 	return 0;
 }
 
-static int snd_es18xx_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int snd_es18xx_playback1_prepare(struct snd_es18xx *chip,
 					struct snd_pcm_substream *substream)
 {
@@ -543,7 +536,7 @@ static int snd_es18xx_capture_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_es18xx *chip = snd_pcm_substream_chip(substream);
-	int shift, err;
+	int shift;
 
 	shift = 0;
 	if ((chip->caps & ES18XX_DUPLEX_MONO) &&
@@ -557,8 +550,6 @@ static int snd_es18xx_capture_hw_params(struct snd_pcm_substream *substream,
 	if (snd_pcm_format_width(params_format(hw_params)) == 16)
 		shift++;
 	chip->dma1_shift = shift;
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
 	return 0;
 }
 
@@ -915,7 +906,6 @@ static int snd_es18xx_playback_close(struct snd_pcm_substream *substream)
 	else
 		chip->playback_b_substream = NULL;
 	
-	snd_pcm_lib_free_pages(substream);
 	return 0;
 }
 
@@ -924,7 +914,6 @@ static int snd_es18xx_capture_close(struct snd_pcm_substream *substream)
         struct snd_es18xx *chip = snd_pcm_substream_chip(substream);
 
         chip->capture_a_substream = NULL;
-	snd_pcm_lib_free_pages(substream);
         return 0;
 }
 
@@ -1656,7 +1645,6 @@ static const struct snd_pcm_ops snd_es18xx_playback_ops = {
 	.close =	snd_es18xx_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_es18xx_playback_hw_params,
-	.hw_free =	snd_es18xx_pcm_hw_free,
 	.prepare =	snd_es18xx_playback_prepare,
 	.trigger =	snd_es18xx_playback_trigger,
 	.pointer =	snd_es18xx_playback_pointer,
@@ -1667,7 +1655,6 @@ static const struct snd_pcm_ops snd_es18xx_capture_ops = {
 	.close =	snd_es18xx_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	snd_es18xx_capture_hw_params,
-	.hw_free =	snd_es18xx_pcm_hw_free,
 	.prepare =	snd_es18xx_capture_prepare,
 	.trigger =	snd_es18xx_capture_trigger,
 	.pointer =	snd_es18xx_capture_pointer,
@@ -1701,10 +1688,9 @@ static int snd_es18xx_pcm(struct snd_card *card, int device)
 	sprintf(pcm->name, "ESS AudioDrive ES%x", chip->version);
         chip->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      card->dev,
-					      64*1024,
-					      chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, card->dev,
+				       64*1024,
+				       chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
 	return 0;
 }
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
