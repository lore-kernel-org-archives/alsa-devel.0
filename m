Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0202C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:55:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A21214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VHYzOQmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A21214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 779841677;
	Wed, 11 Dec 2019 17:54:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 779841677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576083349;
	bh=8iZQI8BpsWEONpN/dioDzOLUoJ+J1g1LemGseO+cdBE=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VHYzOQmMNkLPpCXQ1F/ig3zFYvS9Tt3qJkbXFS3Sp0nk5AErwjHVpqEDn5XFRWDLU
	 nfmYrU1+xYAOd32VLEsWaeu3VqemwmullGlIS3X+Sog/sn3xc+94E0B6DAWFBafvCq
	 SN12QAhpFQkSnlSLYZeDO4YjrQQYcHi+Nbx5igrg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5383BF80256;
	Wed, 11 Dec 2019 17:53:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CA13F80265; Wed, 11 Dec 2019 17:53:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 6A504F80256
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:53:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A504F80256
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B8131B;
 Wed, 11 Dec 2019 08:53:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5F6D3F52E;
 Wed, 11 Dec 2019 08:53:11 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210142614.19405-15-tiwai@suse.de>
Message-Id: <applied-20191210142614.19405-15-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: uniphier: Use managed buffer
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

   ASoC: uniphier: Use managed buffer allocation

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

From d55894bc27636ebaf66c7c6eca8da5548911f8c9 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:26:05 +0100
Subject: [PATCH] ASoC: uniphier: Use managed buffer allocation

Clean up the driver with the new managed buffer allocation API.
The hw_params and hw_free callbacks became superfluous and got
dropped, as well as the pcm_destruct callback just containing the
superfluous snd_pcm_lib_preallocate_free_for_all() call.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210142614.19405-15-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-dma.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index 700d936ed94e..388f4785d93a 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -104,25 +104,6 @@ static int uniphier_aiodma_open(struct snd_soc_component *component,
 		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 256);
 }
 
-static int uniphier_aiodma_hw_params(struct snd_soc_component *component,
-				     struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params)
-{
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	substream->runtime->dma_bytes = params_buffer_bytes(params);
-
-	return 0;
-}
-
-static int uniphier_aiodma_hw_free(struct snd_soc_component *component,
-				   struct snd_pcm_substream *substream)
-{
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	substream->runtime->dma_bytes = 0;
-
-	return 0;
-}
-
 static int uniphier_aiodma_prepare(struct snd_soc_component *component,
 				   struct snd_pcm_substream *substream)
 {
@@ -232,30 +213,21 @@ static int uniphier_aiodma_new(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_set_managed_buffer_all(pcm,
 		SNDRV_DMA_TYPE_DEV, dev,
 		uniphier_aiodma_hw.buffer_bytes_max,
 		uniphier_aiodma_hw.buffer_bytes_max);
 	return 0;
 }
 
-static void uniphier_aiodma_free(struct snd_soc_component *component,
-				 struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static const struct snd_soc_component_driver uniphier_soc_platform = {
 	.open		= uniphier_aiodma_open,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
-	.hw_params	= uniphier_aiodma_hw_params,
-	.hw_free	= uniphier_aiodma_hw_free,
 	.prepare	= uniphier_aiodma_prepare,
 	.trigger	= uniphier_aiodma_trigger,
 	.pointer	= uniphier_aiodma_pointer,
 	.mmap		= uniphier_aiodma_mmap,
 	.pcm_construct	= uniphier_aiodma_new,
-	.pcm_destruct	= uniphier_aiodma_free,
 	.compr_ops	= &uniphier_aio_compr_ops,
 };
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
