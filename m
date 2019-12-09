Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C92C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:42:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B910207FF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y1Wl+RSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B910207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB27116CE;
	Mon,  9 Dec 2019 11:41:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB27116CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575888145;
	bh=fD/AjNRGLfpxLyvqsZmvjUm8Y4RuadASuBGXIY3flqo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y1Wl+RSAr1l5PjOz/mQ2YX/j+cPJR3jvXrztND3GhKH8jewMrqG5hNPc3a4nPE0qj
	 m6/ABaSNpGqhgiYgAr551WZONtyqfx2nUyuXUZ8aGGDpEknIxxQNDi39Rvzh9jVFjv
	 THsEEgQfp36BGJKwQ9bxf57JPTnxEqofmslQM7+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92840F8065B;
	Mon,  9 Dec 2019 10:52:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C040F803B1; Mon,  9 Dec 2019 10:51:37 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 385A3F802DF
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 385A3F802DF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 90E37B2E3
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:35 +0100
Message-Id: <20191209094943.14984-64-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 63/71] ALSA: spi: Use managed buffer
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
 sound/spi/at73c213.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 4de1ba9a418d..8b1b5c86cebf 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -242,13 +242,7 @@ static int snd_at73c213_pcm_hw_params(struct snd_pcm_substream *substream,
 	val = SSC_BFINS(TFMR_DATNB, channels - 1, val);
 	ssc_writel(chip->ssc->regs, TFMR, val);
 
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
-static int snd_at73c213_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int snd_at73c213_pcm_prepare(struct snd_pcm_substream *substream)
@@ -324,7 +318,6 @@ static const struct snd_pcm_ops at73c213_playback_ops = {
 	.close		= snd_at73c213_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= snd_at73c213_pcm_hw_params,
-	.hw_free	= snd_at73c213_pcm_hw_free,
 	.prepare	= snd_at73c213_pcm_prepare,
 	.trigger	= snd_at73c213_pcm_trigger,
 	.pointer	= snd_at73c213_pcm_pointer,
@@ -347,7 +340,7 @@ static int snd_at73c213_pcm_new(struct snd_at73c213 *chip, int device)
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &at73c213_playback_ops);
 
-	snd_pcm_lib_preallocate_pages_for_all(chip->pcm,
+	snd_pcm_set_managed_buffer_all(chip->pcm,
 			SNDRV_DMA_TYPE_DEV, &chip->ssc->pdev->dev,
 			64 * 1024, 64 * 1024);
 out:
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
