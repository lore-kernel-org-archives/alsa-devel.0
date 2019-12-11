Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA5AC43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:56:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84ECF214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s/ZN1ykz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ECF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEEA31668;
	Wed, 11 Dec 2019 17:55:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEEA31668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576083395;
	bh=nTfshf9C8cnb9au70z5ZYcwQFb/b7Rp2ZbLMDSqFW0s=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=s/ZN1ykzla1mewgcprBMoOviGXmUtIzjhT4564w0Nq4+fYZ0msy+nzKeoxLuZg80Z
	 WqAZVhqzodtoeocpF/uw33MtcntkdSiK6rlFm4+gzuTFiznyPOCPpKO/Ia4Vwjp/iL
	 Iw88Y5liK8WJgzB1lNf3AhAVOKehFf/3bkFQIp8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4D6FF80260;
	Wed, 11 Dec 2019 17:53:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30841F80265; Wed, 11 Dec 2019 17:53:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D68B4F8025F
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:53:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D68B4F8025F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A835330E;
 Wed, 11 Dec 2019 08:53:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285003F52E;
 Wed, 11 Dec 2019 08:53:14 -0800 (PST)
Date: Wed, 11 Dec 2019 16:53:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191210142614.19405-10-tiwai@suse.de>
Message-Id: <applied-20191210142614.19405-10-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: siu_pcm: Use managed buffer allocation"
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

   ASoC: siu_pcm: Use managed buffer allocation

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

From 2c7c9630db45129838ed09f0ada718b0ac222377 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Dec 2019 15:26:00 +0100
Subject: [PATCH] ASoC: siu_pcm: Use managed buffer allocation

Clean up the driver with the new managed buffer allocation API.
The hw_params and hw_free callbacks became superfluous (the rest were
only debug prints) and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191210142614.19405-10-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/siu_pcm.c | 39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index a5e21e554da2..65637ad93630 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -281,41 +281,6 @@ static int siu_pcm_stmread_stop(struct siu_port *port_info)
 	return 0;
 }
 
-static int siu_pcm_hw_params(struct snd_soc_component *component,
-			     struct snd_pcm_substream *ss,
-			     struct snd_pcm_hw_params *hw_params)
-{
-	struct siu_info *info = siu_i2s_data;
-	struct device *dev = ss->pcm->card->dev;
-	int ret;
-
-	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
-
-	ret = snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(hw_params));
-	if (ret < 0)
-		dev_err(dev, "snd_pcm_lib_malloc_pages() failed\n");
-
-	return ret;
-}
-
-static int siu_pcm_hw_free(struct snd_soc_component *component,
-			   struct snd_pcm_substream *ss)
-{
-	struct siu_info *info = siu_i2s_data;
-	struct siu_port	*port_info = siu_port_info(ss);
-	struct device *dev = ss->pcm->card->dev;
-	struct siu_stream *siu_stream;
-
-	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		siu_stream = &port_info->playback;
-	else
-		siu_stream = &port_info->capture;
-
-	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
-
-	return snd_pcm_lib_free_pages(ss);
-}
-
 static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct sh_dmae_slave *param = slave;
@@ -548,7 +513,7 @@ static int siu_pcm_new(struct snd_soc_component *component,
 		if (ret < 0)
 			return ret;
 
-		snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_set_managed_buffer_all(pcm,
 				SNDRV_DMA_TYPE_DEV, card->dev,
 				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
 
@@ -584,8 +549,6 @@ struct const snd_soc_component_driver siu_component = {
 	.open		= siu_pcm_open,
 	.close		= siu_pcm_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
-	.hw_params	= siu_pcm_hw_params,
-	.hw_free	= siu_pcm_hw_free,
 	.prepare	= siu_pcm_prepare,
 	.trigger	= siu_pcm_trigger,
 	.pointer	= siu_pcm_pointer_dma,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
