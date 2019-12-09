Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF2BC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA182073D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="otmgDycF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA182073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E2FB1707;
	Mon,  9 Dec 2019 11:38:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E2FB1707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887944;
	bh=1tmQyCar1HlXMa0lWg5fAnOpH1DaueVHq2TotXRluFY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=otmgDycF6pCEkmqkwobHRbf5gieoT/ydBgVhgiiNc50qpeI3bNP56/BjUA0pCyy82
	 /Bt06YvhktSUEEklm6KRSeJMzAqsmc4gf8VVqTE1v8lHDBco0ea6cDX39BIRsndaMa
	 dA4Yi1QgwqVKWlO9sqSPhtkisUP1KXaGnbWphxv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6350F805F5;
	Mon,  9 Dec 2019 10:52:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE542F80392; Mon,  9 Dec 2019 10:51:30 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA393F802D2
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA393F802D2
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5B14AB2DF
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:31 +0100
Message-Id: <20191209094943.14984-60-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 59/71] ALSA: ps3: Use managed buffer
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
The hw_params and hw_free callbacks became superfluous and got
dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/snd_ps3.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index c213eb7ca23c..c6c004958e6f 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -535,22 +535,6 @@ static int snd_ps3_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 };
 
-static int snd_ps3_pcm_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *hw_params)
-{
-	size_t size;
-
-	/* alloc transport buffer */
-	size = params_buffer_bytes(hw_params);
-	snd_pcm_lib_malloc_pages(substream, size);
-	return 0;
-};
-
-static int snd_ps3_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-};
-
 static int snd_ps3_delay_to_bytes(struct snd_pcm_substream *substream,
 				  unsigned int delay_ms)
 {
@@ -759,8 +743,6 @@ static const struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
 	.open = snd_ps3_pcm_open,
 	.close = snd_ps3_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_ps3_pcm_hw_params,
-	.hw_free = snd_ps3_pcm_hw_free,
 	.prepare = snd_ps3_pcm_prepare,
 	.trigger = snd_ps3_pcm_trigger,
 	.pointer = snd_ps3_pcm_pointer,
@@ -1007,11 +989,11 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 
 	the_card.pcm->info_flags = SNDRV_PCM_INFO_NONINTERLEAVED;
 	/* pre-alloc PCM DMA buffer*/
-	snd_pcm_lib_preallocate_pages_for_all(the_card.pcm,
-					SNDRV_DMA_TYPE_DEV,
-					&dev->core,
-					SND_PS3_PCM_PREALLOC_SIZE,
-					SND_PS3_PCM_PREALLOC_SIZE);
+	snd_pcm_set_managed_buffer_all(the_card.pcm,
+				       SNDRV_DMA_TYPE_DEV,
+				       &dev->core,
+				       SND_PS3_PCM_PREALLOC_SIZE,
+				       SND_PS3_PCM_PREALLOC_SIZE);
 
 	/*
 	 * allocate null buffer
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
