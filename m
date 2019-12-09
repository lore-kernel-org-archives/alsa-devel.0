Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555EEC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:44:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E0C2073D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NSMPUNd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E0C2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1247F1703;
	Mon,  9 Dec 2019 11:43:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1247F1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575888264;
	bh=p+6nGKyqpMvRJK6qY2Ym/z9pBJU8iDJnkx6SEPU2Kh0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSMPUNd9OXd72pHzQEoiUWlBtw4+hE97SDpXiH8WUM87X0BZyHLuLhswjRdC/kO3s
	 APgzEBLPlqs2l3hf95Abhi5Ghd3S1d1KbvtMSpWwDOlnwCi7AMwNloMIq3MAlDUME4
	 7WwAgpy+EjZDVUy7qGmXIubZU6vIM8IveF+7fgI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81368F8067C;
	Mon,  9 Dec 2019 10:52:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CC48F803BE; Mon,  9 Dec 2019 10:51:46 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 959FCF802E9
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 959FCF802E9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A12D9B2E5
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:37 +0100
Message-Id: <20191209094943.14984-66-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 65/71] ALSA: caiaq: Use managed buffer
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
The hw_params callback became superfluous and dropped.
The hw_free callback still remains because of the substream
deactivation sync call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/caiaq/audio.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 970eb0865ba3..8513b120e57e 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -167,17 +167,11 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
-				       struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(sub, params_buffer_bytes(hw_params));
-}
-
 static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(sub);
 	deactivate_substream(cdev, sub);
-	return snd_pcm_lib_free_pages(sub);
+	return 0;
 }
 
 /* this should probably go upstream */
@@ -328,7 +322,6 @@ static const struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.open =		snd_usb_caiaq_substream_open,
 	.close =	snd_usb_caiaq_substream_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_usb_caiaq_pcm_hw_params,
 	.hw_free =	snd_usb_caiaq_pcm_hw_free,
 	.prepare =	snd_usb_caiaq_pcm_prepare,
 	.trigger =	snd_usb_caiaq_pcm_trigger,
@@ -841,8 +834,8 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 				&snd_usb_caiaq_ops);
 	snd_pcm_set_ops(cdev->pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&snd_usb_caiaq_ops);
-	snd_pcm_lib_preallocate_pages_for_all(cdev->pcm, SNDRV_DMA_TYPE_VMALLOC,
-					      NULL, 0, 0);
+	snd_pcm_set_managed_buffer_all(cdev->pcm, SNDRV_DMA_TYPE_VMALLOC,
+				       NULL, 0, 0);
 
 	cdev->data_cb_info =
 		kmalloc_array(N_URBS, sizeof(struct snd_usb_caiaq_cb_info),
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
