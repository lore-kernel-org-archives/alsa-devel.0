Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA6DC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:09:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A71F2073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mVaV3g7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A71F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91AA21669;
	Tue, 10 Dec 2019 15:08:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91AA21669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575986940;
	bh=/JxQugzsF8S4bEHHnRp1CnUyW/5oQYShKFVEh9kebTs=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mVaV3g7zAceGMYis+o5qwwzRLRIqmxQs/74pw8q1ZOvP4E8fKzZZyTaUEBAjqSh/q
	 S0/L9FgKKIM6GTqqdzqdoMIYKPfh5I5613toXPxYyLsKsrMxu58U7c62Qj4r+TVRhY
	 4T0YKKYtsSKRc+pmGdAm6rnGLBpwbRHnuwpWKsto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BA7FF802FB;
	Tue, 10 Dec 2019 14:59:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54D0EF8027B; Tue, 10 Dec 2019 14:59:23 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72E9EF8025A
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72E9EF8025A
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 18955AFFE;
 Tue, 10 Dec 2019 13:59:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: linux-media@vger.kernel.org
Date: Tue, 10 Dec 2019 14:58:44 +0100
Message-Id: <20191210135849.15607-10-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [alsa-devel] [PATCH for-5.6 09/14] media: go7007: Clean up ALSA PCM
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

Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/usb/go7007/snd-go7007.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/media/usb/go7007/snd-go7007.c b/drivers/media/usb/go7007/snd-go7007.c
index b05fa227ffb2..40dbf081ef6b 100644
--- a/drivers/media/usb/go7007/snd-go7007.c
+++ b/drivers/media/usb/go7007/snd-go7007.c
@@ -9,7 +9,6 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
-#include <linux/vmalloc.h>
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/i2c.h>
@@ -100,16 +99,7 @@ static int go7007_snd_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *hw_params)
 {
 	struct go7007 *go = snd_pcm_substream_chip(substream);
-	unsigned int bytes;
-
-	bytes = params_buffer_bytes(hw_params);
-	if (substream->runtime->dma_bytes > 0)
-		vfree(substream->runtime->dma_area);
-	substream->runtime->dma_bytes = 0;
-	substream->runtime->dma_area = vmalloc(bytes);
-	if (substream->runtime->dma_area == NULL)
-		return -ENOMEM;
-	substream->runtime->dma_bytes = bytes;
+
 	go->audio_deliver = parse_audio_stream_data;
 	return 0;
 }
@@ -119,9 +109,6 @@ static int go7007_snd_hw_free(struct snd_pcm_substream *substream)
 	struct go7007 *go = snd_pcm_substream_chip(substream);
 
 	go->audio_deliver = NULL;
-	if (substream->runtime->dma_bytes > 0)
-		vfree(substream->runtime->dma_area);
-	substream->runtime->dma_bytes = 0;
 	return 0;
 }
 
@@ -185,12 +172,6 @@ static snd_pcm_uframes_t go7007_snd_pcm_pointer(struct snd_pcm_substream *substr
 	return gosnd->hw_ptr;
 }
 
-static struct page *go7007_snd_pcm_page(struct snd_pcm_substream *substream,
-					unsigned long offset)
-{
-	return vmalloc_to_page(substream->runtime->dma_area + offset);
-}
-
 static const struct snd_pcm_ops go7007_snd_capture_ops = {
 	.open		= go7007_snd_capture_open,
 	.close		= go7007_snd_capture_close,
@@ -200,7 +181,6 @@ static const struct snd_pcm_ops go7007_snd_capture_ops = {
 	.prepare	= go7007_snd_pcm_prepare,
 	.trigger	= go7007_snd_pcm_trigger,
 	.pointer	= go7007_snd_pcm_pointer,
-	.page		= go7007_snd_pcm_page,
 };
 
 static int go7007_snd_free(struct snd_device *device)
@@ -260,6 +240,8 @@ int go7007_snd_init(struct go7007 *go)
 	gosnd->pcm->private_data = go;
 	snd_pcm_set_ops(gosnd->pcm, SNDRV_PCM_STREAM_CAPTURE,
 			&go7007_snd_capture_ops);
+	snd_pcm_set_managed_buffer_all(gosnd->pcm, SNDRV_DMA_TYPE_VMALLOC,
+				       NULL, 0, 0);
 
 	ret = snd_card_register(gosnd->card);
 	if (ret < 0) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
