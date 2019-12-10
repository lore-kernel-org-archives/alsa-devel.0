Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5868C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:02:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309EC20652
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ul4U3914"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309EC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D0C31695;
	Tue, 10 Dec 2019 15:01:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D0C31695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575986545;
	bh=c51lN2Xk/mV34IEZJKNzdvHwOp+5y5coeaZV6KEqJfA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ul4U3914dNDx/5Xm4eUVIkFKveCF6SwKrwN+LTykfju8zJTK74194FLWAZ3bd0CVu
	 q5eweJZKO69LFTu+sjvGQJfOCb1iLyx2ZQN8o+5a3PqPGuoXXWi90nf6jFY59FscO5
	 NhvHg6gcR0XUrK0l2u5PV9Oqi5UdvucPdysiCuFY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F8D9F80276;
	Tue, 10 Dec 2019 14:59:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 597FBF80271; Tue, 10 Dec 2019 14:59:11 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89861F8024A
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89861F8024A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 14E9BAFA1;
 Tue, 10 Dec 2019 13:59:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: linux-media@vger.kernel.org
Date: Tue, 10 Dec 2019 14:58:43 +0100
Message-Id: <20191210135849.15607-9-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [alsa-devel] [PATCH for-5.6 08/14] media: em28xx: Clean up ALSA PCM
	API usages
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

With the recent change in ALSA PCM core, the whole open-coded vmalloc
buffer handling in this driver can be dropped by replacing with the
managed buffer allocation.

Also, snd_em28xx_hw_capture_free() is dropped since the check of
stream_started flag makes no sense; hw_free callback is guaranteed to
be called after the stream gets stopped.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/usb/em28xx/em28xx-audio.c | 86 +--------------------------------
 1 file changed, 1 insertion(+), 85 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index 79dfbb25714b..a5215fb1d36a 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -30,7 +30,6 @@
 #include <linux/spinlock.h>
 #include <linux/soundcard.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -192,28 +191,6 @@ static int em28xx_init_audio_isoc(struct em28xx *dev)
 	return 0;
 }
 
-static int snd_pcm_alloc_vmalloc_buffer(struct snd_pcm_substream *subs,
-					size_t size)
-{
-	struct em28xx *dev = snd_pcm_substream_chip(subs);
-	struct snd_pcm_runtime *runtime = subs->runtime;
-
-	dprintk("Allocating vbuffer\n");
-	if (runtime->dma_area) {
-		if (runtime->dma_bytes > size)
-			return 0;
-
-		vfree(runtime->dma_area);
-	}
-	runtime->dma_area = vmalloc(size);
-	if (!runtime->dma_area)
-		return -ENOMEM;
-
-	runtime->dma_bytes = size;
-
-	return 0;
-}
-
 static const struct snd_pcm_hardware snd_em28xx_hw_capture = {
 	.info = SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP           |
@@ -341,63 +318,12 @@ static int snd_em28xx_pcm_close(struct snd_pcm_substream *substream)
 	}
 
 	em28xx_audio_analog_set(dev);
-	if (substream->runtime->dma_area) {
-		dprintk("freeing\n");
-		vfree(substream->runtime->dma_area);
-		substream->runtime->dma_area = NULL;
-	}
 	mutex_unlock(&dev->lock);
 	kref_put(&dev->ref, em28xx_free_device);
 
 	return 0;
 }
 
-static int snd_em28xx_hw_capture_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *hw_params)
-{
-	int ret;
-	struct em28xx *dev = snd_pcm_substream_chip(substream);
-
-	if (dev->disconnected)
-		return -ENODEV;
-
-	dprintk("Setting capture parameters\n");
-
-	ret = snd_pcm_alloc_vmalloc_buffer(substream,
-					   params_buffer_bytes(hw_params));
-	if (ret < 0)
-		return ret;
-#if 0
-	/*
-	 * TODO: set up em28xx audio chip to deliver the correct audio format,
-	 * current default is 48000hz multiplexed => 96000hz mono
-	 * which shouldn't matter since analogue TV only supports mono
-	 */
-	unsigned int channels, rate, format;
-
-	format = params_format(hw_params);
-	rate = params_rate(hw_params);
-	channels = params_channels(hw_params);
-#endif
-
-	return 0;
-}
-
-static int snd_em28xx_hw_capture_free(struct snd_pcm_substream *substream)
-{
-	struct em28xx *dev = snd_pcm_substream_chip(substream);
-	struct em28xx_audio *adev = &dev->adev;
-
-	dprintk("Stop capture, if needed\n");
-
-	if (atomic_read(&adev->stream_started) > 0) {
-		atomic_set(&adev->stream_started, 0);
-		schedule_work(&adev->wq_trigger);
-	}
-
-	return 0;
-}
-
 static int snd_em28xx_prepare(struct snd_pcm_substream *substream)
 {
 	struct em28xx *dev = snd_pcm_substream_chip(substream);
@@ -471,14 +397,6 @@ static snd_pcm_uframes_t snd_em28xx_capture_pointer(struct snd_pcm_substream
 	return hwptr_done;
 }
 
-static struct page *snd_pcm_get_vmalloc_page(struct snd_pcm_substream *subs,
-					     unsigned long offset)
-{
-	void *pageptr = subs->runtime->dma_area + offset;
-
-	return vmalloc_to_page(pageptr);
-}
-
 /*
  * AC97 volume control support
  */
@@ -709,12 +627,9 @@ static const struct snd_pcm_ops snd_em28xx_pcm_capture = {
 	.open      = snd_em28xx_capture_open,
 	.close     = snd_em28xx_pcm_close,
 	.ioctl     = snd_pcm_lib_ioctl,
-	.hw_params = snd_em28xx_hw_capture_params,
-	.hw_free   = snd_em28xx_hw_capture_free,
 	.prepare   = snd_em28xx_prepare,
 	.trigger   = snd_em28xx_capture_trigger,
 	.pointer   = snd_em28xx_capture_pointer,
-	.page      = snd_pcm_get_vmalloc_page,
 };
 
 static void em28xx_audio_free_urb(struct em28xx *dev)
@@ -936,6 +851,7 @@ static int em28xx_audio_init(struct em28xx *dev)
 		goto card_free;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_em28xx_pcm_capture);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_VMALLOC, NULL, 0, 0);
 	pcm->info_flags = 0;
 	pcm->private_data = dev;
 	strscpy(pcm->name, "Empia 28xx Capture", sizeof(pcm->name));
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
