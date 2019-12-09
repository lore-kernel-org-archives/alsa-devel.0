Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DD5C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:06:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F212073D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iZCv4/4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F212073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E65D1697;
	Mon,  9 Dec 2019 11:05:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E65D1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885959;
	bh=ER/pm9Nm8A1n1dwWQu6R9EeDtU+Cb1aOj/4EkBVzEPI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iZCv4/4JuSAD25dqz335XH10N1CGYzyIpDuwM6/JEL2ZSuaLoTpUp1vUpS9JddswV
	 2lMMWjv+Ro5fam/N02OB4b7oO+W+HOBHItIVeaV/CriDkG9NhmXJ69OflAGhxkOvsF
	 hiIGSnF1/staKj+5JdLLQG4uVpogJe623wlkw+7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC613F802BC;
	Mon,  9 Dec 2019 10:51:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C101BF8033F; Mon,  9 Dec 2019 10:50:28 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D11AF80266
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D11AF80266
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 44FB4B2AD
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:50 +0100
Message-Id: <20191209094943.14984-19-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 18/71] ALSA: parisc: Use managed buffer
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
The hw_free callbacks became superfluous and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/parisc/harmony.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 6acc59c25379..1a4c40aafcbe 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -567,20 +567,12 @@ static int
 snd_harmony_hw_params(struct snd_pcm_substream *ss,
 		      struct snd_pcm_hw_params *hw)
 {
-	int err;
 	struct snd_harmony *h = snd_pcm_substream_chip(ss);
 	
-	err = snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(hw));
-	if (err > 0 && h->dma.type == SNDRV_DMA_TYPE_CONTINUOUS)
+	if (h->dma.type == SNDRV_DMA_TYPE_CONTINUOUS)
 		ss->runtime->dma_addr = __pa(ss->runtime->dma_area);
-	
-	return err;
-}
 
-static int 
-snd_harmony_hw_free(struct snd_pcm_substream *ss) 
-{
-	return snd_pcm_lib_free_pages(ss);
+	return 0;
 }
 
 static const struct snd_pcm_ops snd_harmony_playback_ops = {
@@ -588,7 +580,6 @@ static const struct snd_pcm_ops snd_harmony_playback_ops = {
 	.close = snd_harmony_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
 	.hw_params = snd_harmony_hw_params,
-	.hw_free = snd_harmony_hw_free,
 	.prepare = snd_harmony_playback_prepare,
 	.trigger = snd_harmony_playback_trigger,
  	.pointer = snd_harmony_playback_pointer,
@@ -599,7 +590,6 @@ static const struct snd_pcm_ops snd_harmony_capture_ops = {
         .close = snd_harmony_capture_close,
         .ioctl = snd_pcm_lib_ioctl,
         .hw_params = snd_harmony_hw_params,
-        .hw_free = snd_harmony_hw_free,
         .prepare = snd_harmony_capture_prepare,
         .trigger = snd_harmony_capture_trigger,
         .pointer = snd_harmony_capture_pointer,
@@ -656,8 +646,8 @@ snd_harmony_pcm_init(struct snd_harmony *h)
 	}
 
 	/* pre-allocate space for DMA */
-	snd_pcm_lib_preallocate_pages_for_all(pcm, h->dma.type, h->dma.dev,
-					      MAX_BUF_SIZE, MAX_BUF_SIZE);
+	snd_pcm_set_managed_buffer_all(pcm, h->dma.type, h->dma.dev,
+				       MAX_BUF_SIZE, MAX_BUF_SIZE);
 
 	h->st.format = snd_harmony_set_data_format(h,
 		SNDRV_PCM_FORMAT_S16_BE, 1);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
