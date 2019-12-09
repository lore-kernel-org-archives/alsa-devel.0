Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEFBC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:57:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCD92072D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cFOyVHge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCD92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 328B21678;
	Mon,  9 Dec 2019 10:56:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 328B21678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885441;
	bh=6mE/ZZzgtCbm2YSkEL6BRCV5AIEyb2ibqug9k0vfNLM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFOyVHgeEEE210N5lXt+8Y+m/4opVMObIhs+0rtF0K8N9NRSet279SPlZh8RyIuy7
	 QJehDE3iXTshGsvQzQR9Y7+jEOnnIUiXFmU+TL9OUFmrsp9XAe5sBkRQOhU661L5XK
	 9LDfm38hzY0ZaR+KFaYCpz9ojXJsww1AiWoDaXKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46187F80266;
	Mon,  9 Dec 2019 10:50:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99051F80308; Mon,  9 Dec 2019 10:50:07 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 273E5F80255
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 273E5F80255
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8A9ECB29E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:37 +0100
Message-Id: <20191209094943.14984-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 05/71] ALSA: dummy: Use managed buffer
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
 sound/drivers/dummy.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 022a0db692e0..ab6062dcd1b3 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -529,15 +529,7 @@ static int dummy_pcm_hw_params(struct snd_pcm_substream *substream,
 		substream->runtime->dma_bytes = params_buffer_bytes(hw_params);
 		return 0;
 	}
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
-static int dummy_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	if (fake_buffer)
-		return 0;
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int dummy_pcm_open(struct snd_pcm_substream *substream)
@@ -657,7 +649,6 @@ static struct snd_pcm_ops dummy_pcm_ops = {
 	.close =	dummy_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	dummy_pcm_hw_params,
-	.hw_free =	dummy_pcm_hw_free,
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
@@ -668,7 +659,6 @@ static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.close =	dummy_pcm_close,
 	.ioctl =	snd_pcm_lib_ioctl,
 	.hw_params =	dummy_pcm_hw_params,
-	.hw_free =	dummy_pcm_hw_free,
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
@@ -700,7 +690,7 @@ static int snd_card_dummy_pcm(struct snd_dummy *dummy, int device,
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "Dummy PCM");
 	if (!fake_buffer) {
-		snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_set_managed_buffer_all(pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
 			NULL,
 			0, 64*1024);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
