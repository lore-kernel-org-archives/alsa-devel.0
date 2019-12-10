Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE676C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:35:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB372073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZvHQ9snS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB372073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7340169C;
	Tue, 10 Dec 2019 15:35:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7340169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575988551;
	bh=WY48sKq2i5xOdKp5K432o6wEw5QPaWL9SEt5Ev0d4iE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZvHQ9snSu97LX5jGA5wws/s+OJo1TTlwjYchdLDoFortvMvtlfa6A0IbgYcvCkM2q
	 J4rXuvkoEDQ31DETiZji/Rw9moL/O29p1qk8BdXCcXsqlOBFTvvptKnw9TxZ2jrzcJ
	 0uFddUNmCK1+J92opRqbZirhZdRjXzHvO5Qx8kRQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D083F802E8;
	Tue, 10 Dec 2019 15:27:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23384F8028F; Tue, 10 Dec 2019 15:26:52 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8430BF80258
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:26:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8430BF80258
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 30169B201;
 Tue, 10 Dec 2019 14:26:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:26:01 +0100
Message-Id: <20191210142614.19405-11-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210142614.19405-1-tiwai@suse.de>
References: <20191210142614.19405-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Lars-Peter Clausen <lars@metafoo.de>
Subject: [alsa-devel] [PATCH for-5.6 10/23] ASoC: generic-dmaengine-pcm: Use
	managed buffer allocation
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

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index a428ff393ea2..dd400afe3c8f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -104,7 +104,7 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
 			return ret;
 	}
 
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	return 0;
 }
 
 static int
@@ -168,12 +168,6 @@ static int dmaengine_pcm_close(struct snd_soc_component *component,
 	return snd_dmaengine_pcm_close(substream);
 }
 
-static int dmaengine_pcm_hw_free(struct snd_soc_component *component,
-				 struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static int dmaengine_pcm_trigger(struct snd_soc_component *component,
 				 struct snd_pcm_substream *substream, int cmd)
 {
@@ -261,7 +255,7 @@ static int dmaengine_pcm_new(struct snd_soc_component *component,
 			return -EINVAL;
 		}
 
-		snd_pcm_lib_preallocate_pages(substream,
+		snd_pcm_set_managed_buffer(substream,
 				SNDRV_DMA_TYPE_DEV_IRAM,
 				dmaengine_dma_dev(pcm, substream),
 				prealloc_buffer_size,
@@ -331,7 +325,6 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.close		= dmaengine_pcm_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= dmaengine_pcm_hw_params,
-	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
@@ -344,7 +337,6 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.close		= dmaengine_pcm_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= dmaengine_pcm_hw_params,
-	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.copy_user	= dmaengine_copy_user,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
