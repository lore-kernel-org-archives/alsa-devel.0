Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92287C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:50:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C17324686
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Eu06EqvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C17324686
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12B4810E;
	Mon,  9 Dec 2019 10:49:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12B4810E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885045;
	bh=WmI0lFD06G8OnNPbpyDqHbWqMMzXL4nU+yd2CtIMZao=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eu06EqvKoedprDxdQe9V3O1slZbYM5DQV5sjnEkADFVcv9agCAf+2UXTgIxxi4ny8
	 peSb58jBaD6k+5gb7aoiOat2crI+yEQuPzNob6uXq6T3bh/tJy+aZsJdRfHh4f5NK3
	 FsFtYab1y52fOGxPrzLl5H9xHR9o5FnNHPSmGXAs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31C76F8028C;
	Mon,  9 Dec 2019 10:49:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B268F8025E; Mon,  9 Dec 2019 10:49:50 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DC42F8011E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DC42F8011E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6DE52B298
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:35 +0100
Message-Id: <20191209094943.14984-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 03/71] ALSA: atmel: Use managed buffer
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
The hw_free_free callbacks became superfluous and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/atmel/ac97c.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index eef7ec77db1a..44507e43ed28 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -159,12 +159,6 @@ static int atmel_ac97c_playback_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *hw_params)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	int retval;
-
-	retval = snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-	if (retval < 0)
-		return retval;
 
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
@@ -172,19 +166,13 @@ static int atmel_ac97c_playback_hw_params(struct snd_pcm_substream *substream,
 	chip->cur_format = params_format(hw_params);
 	mutex_unlock(&opened_mutex);
 
-	return retval;
+	return 0;
 }
 
 static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *hw_params)
 {
 	struct atmel_ac97c *chip = snd_pcm_substream_chip(substream);
-	int retval;
-
-	retval = snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-	if (retval < 0)
-		return retval;
 
 	/* Set restrictions to params. */
 	mutex_lock(&opened_mutex);
@@ -192,7 +180,7 @@ static int atmel_ac97c_capture_hw_params(struct snd_pcm_substream *substream,
 	chip->cur_format = params_format(hw_params);
 	mutex_unlock(&opened_mutex);
 
-	return retval;
+	return 0;
 }
 
 static int atmel_ac97c_playback_prepare(struct snd_pcm_substream *substream)
@@ -461,7 +449,6 @@ static const struct snd_pcm_ops atmel_ac97_playback_ops = {
 	.close		= atmel_ac97c_playback_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_ac97c_playback_hw_params,
-	.hw_free	= snd_pcm_lib_free_pages,
 	.prepare	= atmel_ac97c_playback_prepare,
 	.trigger	= atmel_ac97c_playback_trigger,
 	.pointer	= atmel_ac97c_playback_pointer,
@@ -472,7 +459,6 @@ static const struct snd_pcm_ops atmel_ac97_capture_ops = {
 	.close		= atmel_ac97c_capture_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= atmel_ac97c_capture_hw_params,
-	.hw_free	= snd_pcm_lib_free_pages,
 	.prepare	= atmel_ac97c_capture_prepare,
 	.trigger	= atmel_ac97c_capture_trigger,
 	.pointer	= atmel_ac97c_capture_pointer,
@@ -600,7 +586,7 @@ static int atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &atmel_ac97_capture_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &atmel_ac97_playback_ops);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
 			&chip->pdev->dev, hw.periods_min * hw.period_bytes_min,
 			hw.buffer_bytes_max);
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
