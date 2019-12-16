Return-Path: <SRS0=bmHO=2G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55C5C43603
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:17:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1F4206CB
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="in2t3A0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1F4206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B80D4167B;
	Mon, 16 Dec 2019 13:16:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B80D4167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576498624;
	bh=ZI0gbf9qUZwTSpGUDbcYGFyy8ZxRY0eODjL6ZhPvFOQ=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=in2t3A0U7KtytV0p8MTau/oIJcT0e0YC6Z3rNmIUxJnskz+rx4xYGznwYYeAl79Xp
	 CXrX7vV9CpLyWEQn2dzFLQm4AjIWIr+c6v5wDNDyHU2JdNtEVaQ9aP6IVz7/48nnXm
	 OURo6TdDtUcZMvIVtvEmg6NF9s6z8q1zxt60GYZM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 820EBF80339;
	Mon, 16 Dec 2019 13:05:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6699F802F8; Mon, 16 Dec 2019 13:05:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D6379F802FF
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2019 13:05:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6379F802FF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 113A811B3;
 Mon, 16 Dec 2019 04:05:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85A513F719;
 Mon, 16 Dec 2019 04:05:40 -0800 (PST)
Date: Mon, 16 Dec 2019 12:05:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20191211172019.23206-2-tiwai@suse.de>
Message-Id: <applied-20191211172019.23206-2-tiwai@suse.de>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: SOF: Use managed buffer allocation" to
	the asoc tree
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

   ASoC: SOF: Use managed buffer allocation

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

From 57e960f0020ec46db277426762ba5ffe77e03e3c Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 11 Dec 2019 18:20:19 +0100
Subject: [PATCH] ASoC: SOF: Use managed buffer allocation

Clean up the drivers with the new managed buffer allocation API.
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20191211172019.23206-2-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pcm.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 67ba317942d3..86829e5bd62d 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -118,20 +118,8 @@ static int sof_pcm_hw_params(struct snd_soc_component *component,
 
 	memset(&pcm, 0, sizeof(pcm));
 
-	/* allocate audio buffer pages */
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	if (ret < 0) {
-		dev_err(component->dev, "error: could not allocate %d bytes for PCM %d\n",
-			params_buffer_bytes(params), spcm->pcm.pcm_id);
-		return ret;
-	}
-	if (ret) {
-		/*
-		 * ret == 1 means the buffer is changed
-		 * create compressed page table for audio firmware
-		 * ret == 0 means the buffer is not changed
-		 * so no need to regenerate the page table
-		 */
+	/* create compressed page table for audio firmware */
+	if (runtime->buffer_changed) {
 		ret = create_page_table(component, substream, runtime->dma_area,
 					runtime->dma_bytes);
 		if (ret < 0)
@@ -259,8 +247,6 @@ static int sof_pcm_hw_free(struct snd_soc_component *component,
 			err = ret;
 	}
 
-	snd_pcm_lib_free_pages(substream);
-
 	cancel_work_sync(&spcm->stream[substream->stream].period_elapsed_work);
 
 	ret = snd_sof_pcm_platform_hw_free(sdev, substream);
@@ -596,10 +582,10 @@ static int sof_pcm_new(struct snd_soc_component *component,
 		"spcm: allocate %s playback DMA buffer size 0x%x max 0x%x\n",
 		caps->name, caps->buffer_size_min, caps->buffer_size_max);
 
-	snd_pcm_lib_preallocate_pages(pcm->streams[stream].substream,
-				      SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
-				      le32_to_cpu(caps->buffer_size_min),
-				      le32_to_cpu(caps->buffer_size_max));
+	snd_pcm_set_managed_buffer(pcm->streams[stream].substream,
+				   SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
+				   le32_to_cpu(caps->buffer_size_min),
+				   le32_to_cpu(caps->buffer_size_max));
 capture:
 	stream = SNDRV_PCM_STREAM_CAPTURE;
 
@@ -614,10 +600,10 @@ static int sof_pcm_new(struct snd_soc_component *component,
 		"spcm: allocate %s capture DMA buffer size 0x%x max 0x%x\n",
 		caps->name, caps->buffer_size_min, caps->buffer_size_max);
 
-	snd_pcm_lib_preallocate_pages(pcm->streams[stream].substream,
-				      SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
-				      le32_to_cpu(caps->buffer_size_min),
-				      le32_to_cpu(caps->buffer_size_max));
+	snd_pcm_set_managed_buffer(pcm->streams[stream].substream,
+				   SNDRV_DMA_TYPE_DEV_SG, sdev->dev,
+				   le32_to_cpu(caps->buffer_size_min),
+				   le32_to_cpu(caps->buffer_size_max));
 
 	return 0;
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
