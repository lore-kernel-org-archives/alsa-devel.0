Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8F5C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:01:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9359214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rqfYnDY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9359214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ACB7166B;
	Wed, 11 Dec 2019 18:00:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ACB7166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576083675;
	bh=5N58jGGNMONXfK980mw1Fm5nGq/ZAEZICyrzH/JHDg0=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=rqfYnDY3Iop+z6Lt35aURvoBMmM8Ur89EwYWJcK1hynhJA7aXXB2cZx+b6H49UqzD
	 iEKAYirdiUXvnjBEhGqhZkYnEmK0nkDP3u6IFJu57wWdksxjgBz3aeUEvy+2aFDQA4
	 vDu88D/h7yAIznI4wyY39tRFT9wsz8qe6IucXBg8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE4E1F802E1;
	Wed, 11 Dec 2019 17:53:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09D3EF802D2; Wed, 11 Dec 2019 17:53:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 80593F802A0
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:53:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80593F802A0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1382831B;
 Wed, 11 Dec 2019 08:53:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8647E3F52E;
 Wed, 11 Dec 2019 08:53:31 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210142614.19405-19-tiwai@suse.de>
Message-Id: <applied-20191210142614.19405-19-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: rt5514-spi: Use managed buffer
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

   ASoC: rt5514-spi: Use managed buffer allocation

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

From cae8055e065644fd1d92d2f0c23a39b6768d168a Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:26:09 +0100
Subject: [PATCH] ASoC: rt5514-spi: Use managed buffer allocation

Clean up the driver with the new managed buffer allocation API.
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210142614.19405-19-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index f1b7b947ecbd..1a25a3787935 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -215,11 +215,9 @@ static int rt5514_spi_hw_params(struct snd_soc_component *component,
 {
 	struct rt5514_dsp *rt5514_dsp =
 		snd_soc_component_get_drvdata(component);
-	int ret;
 	u8 buf[8];
 
 	mutex_lock(&rt5514_dsp->dma_lock);
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 	rt5514_dsp->substream = substream;
 	rt5514_dsp->dma_offset = 0;
 
@@ -230,7 +228,7 @@ static int rt5514_spi_hw_params(struct snd_soc_component *component,
 
 	mutex_unlock(&rt5514_dsp->dma_lock);
 
-	return ret;
+	return 0;
 }
 
 static int rt5514_spi_hw_free(struct snd_soc_component *component,
@@ -245,7 +243,7 @@ static int rt5514_spi_hw_free(struct snd_soc_component *component,
 
 	cancel_delayed_work_sync(&rt5514_dsp->copy_work);
 
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static snd_pcm_uframes_t rt5514_spi_pcm_pointer(
@@ -294,8 +292,8 @@ static int rt5514_spi_pcm_probe(struct snd_soc_component *component)
 static int rt5514_spi_pcm_new(struct snd_soc_component *component,
 			      struct snd_soc_pcm_runtime *rtd)
 {
-	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_VMALLOC,
-					      NULL, 0, 0);
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_VMALLOC,
+				       NULL, 0, 0);
 	return 0;
 }
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
