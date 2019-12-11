Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE173C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:06:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576BF2054F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="krL0pLXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576BF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EA421675;
	Wed, 11 Dec 2019 18:05:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EA421675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576083963;
	bh=cmxaJNd9L8cuQ0p+nUJfnsxhxrtqQi0Oy6ZYMdkixAM=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=krL0pLXotwrtW9cklKcd1gxHaJNpfpm1xww4SIalH8M3M1a2ovKJFhXRK6lkDtVxp
	 LYiDFlIu5UW2ATDbnKmHoMJZwtXBqPn21/Qsc7rQ7Fz9CFxY1P4I1q7dSrJ36bw+nk
	 trJSQQp1Xr8IfoOJR4CwEVCu31pKTBJu9qxek2o0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DC0BF80307;
	Wed, 11 Dec 2019 17:54:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CE41F80328; Wed, 11 Dec 2019 17:53:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3123BF802F9
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:53:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3123BF802F9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B0C231B;
 Wed, 11 Dec 2019 08:53:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9D23F52E;
 Wed, 11 Dec 2019 08:53:50 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210142614.19405-7-tiwai@suse.de>
Message-Id: <applied-20191210142614.19405-7-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: dma-sh7760: Use managed buffer
	allocation" to the asoc tree
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

The patch

   ASoC: dma-sh7760: Use managed buffer allocation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d23a16584b4f4cc7226c75793d1797e5505a193b Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:25:57 +0100
Subject: [PATCH] ASoC: dma-sh7760: Use managed buffer allocation

Clean up the drivers with the new managed buffer allocation API.
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210142614.19405-7-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/dma-sh7760.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 2b0eca02a8b9..4d0f2f738ffa 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -179,11 +179,6 @@ static int camelot_hw_params(struct snd_soc_component *component,
 	int recv = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0:1;
 	int ret;
 
-	ret = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
-	if (ret < 0)
-		return ret;
-
 	if (recv) {
 		cam->rx_period_size = params_period_bytes(hw_params);
 		cam->rx_period = 0;
@@ -194,12 +189,6 @@ static int camelot_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
-static int camelot_hw_free(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int camelot_prepare(struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream)
 {
@@ -307,7 +296,7 @@ static int camelot_pcm_new(struct snd_soc_component *component,
 	/* dont use SNDRV_DMA_TYPE_DEV, since it will oops the SH kernel
 	 * in MMAP mode (i.e. aplay -M)
 	 */
-	snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_set_managed_buffer_all(pcm,
 		SNDRV_DMA_TYPE_CONTINUOUS,
 		NULL,
 		DMABRG_PREALLOC_BUFFER,	DMABRG_PREALLOC_BUFFER_MAX);
@@ -320,7 +309,6 @@ static const struct snd_soc_component_driver sh7760_soc_component = {
 	.close		= camelot_pcm_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= camelot_hw_params,
-	.hw_free	= camelot_hw_free,
 	.prepare	= camelot_prepare,
 	.trigger	= camelot_trigger,
 	.pointer	= camelot_pos,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
