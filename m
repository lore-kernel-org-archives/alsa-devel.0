Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135A0C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:03:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CFC21556
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XPJGwqjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CFC21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D740F1660;
	Wed, 11 Dec 2019 18:02:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D740F1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576083804;
	bh=arbkMgyppTtPllApp7jFE9o81oEHgGcJW3iZ7+dlIMY=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=XPJGwqjRjpN6WehEj40++YQgEG53smZnhxx2YjcktoUXqCk6EoxB5pPWW/9GSbseA
	 YX9VVwEa7zcbcHoNi3QKXtgEoy+gxfoXDiPAsRVxL+DOw3Kog3F+AcP/Ny3DnNdP/O
	 t/RO3CvTzPKlx9WbrcnkMT/EdOmeHBZWWHH5B6VE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85FB8F80306;
	Wed, 11 Dec 2019 17:53:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBD62F802F7; Wed, 11 Dec 2019 17:53:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3742EF802C3
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:53:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3742EF802C3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E0330E;
 Wed, 11 Dec 2019 08:53:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC4E3F52E;
 Wed, 11 Dec 2019 08:53:38 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210142614.19405-16-tiwai@suse.de>
Message-Id: <applied-20191210142614.19405-16-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>
Subject: [alsa-devel] Applied "ASoC: xilinx: Use managed buffer allocation"
	to the asoc tree
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

   ASoC: xilinx: Use managed buffer allocation

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

From 52f0ac153d12beb5af9d8a1ad3013762e919ffa6 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:26:06 +0100
Subject: [PATCH] ASoC: xilinx: Use managed buffer allocation

Clean up the driver with the new managed buffer allocation API.
The hw_free callback became superfluous and got dropped.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210142614.19405-16-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index 14767f507cea..1d59fb668c77 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -426,7 +426,6 @@ static int xlnx_formatter_pcm_hw_params(struct snd_soc_component *component,
 {
 	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
 	u32 aes_reg1_val, aes_reg2_val;
-	int status;
 	u64 size;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
@@ -450,9 +449,6 @@ static int xlnx_formatter_pcm_hw_params(struct snd_soc_component *component,
 	}
 
 	size = params_buffer_bytes(params);
-	status = snd_pcm_lib_malloc_pages(substream, size);
-	if (status < 0)
-		return status;
 
 	stream_data->buffer_size = size;
 
@@ -495,12 +491,6 @@ static int xlnx_formatter_pcm_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
-static int xlnx_formatter_pcm_hw_free(struct snd_soc_component *component,
-				      struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int xlnx_formatter_pcm_trigger(struct snd_soc_component *component,
 				      struct snd_pcm_substream *substream,
 				      int cmd)
@@ -532,7 +522,7 @@ static int xlnx_formatter_pcm_trigger(struct snd_soc_component *component,
 static int xlnx_formatter_pcm_new(struct snd_soc_component *component,
 				  struct snd_soc_pcm_runtime *rtd)
 {
-	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+	snd_pcm_set_managed_buffer_all(rtd->pcm,
 			SNDRV_DMA_TYPE_DEV, component->dev,
 			xlnx_pcm_hardware.buffer_bytes_max,
 			xlnx_pcm_hardware.buffer_bytes_max);
@@ -544,7 +534,6 @@ static const struct snd_soc_component_driver xlnx_asoc_component = {
 	.open		= xlnx_formatter_pcm_open,
 	.close		= xlnx_formatter_pcm_close,
 	.hw_params	= xlnx_formatter_pcm_hw_params,
-	.hw_free	= xlnx_formatter_pcm_hw_free,
 	.trigger	= xlnx_formatter_pcm_trigger,
 	.pointer	= xlnx_formatter_pcm_pointer,
 	.pcm_construct	= xlnx_formatter_pcm_new,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
