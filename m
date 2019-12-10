Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A225C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:00:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA33720652
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SgQSaYzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA33720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A8F7166D;
	Tue, 10 Dec 2019 15:00:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A8F7166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575986451;
	bh=bzgOPLoO+9a0iXaj1CneEBC73yNLebrxn0AIOXEUoBo=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SgQSaYzKHEbLtrxf/AuoXNk/T+x1xu8LDsDi0l2mXlHXRRihXJ7CbJ3InuB+mnjvL
	 vdyUBabJpHMEGY5PZcE1uP7GIfXKcSC60/60rkuQsq2jYboUP/+xN+uq71ZWOuFAEp
	 hplmyuVdmRQDWiLBL/CUAsBlMfG1Dppdx7ty1ix0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BD15F80260;
	Tue, 10 Dec 2019 14:59:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FB72F80256; Tue, 10 Dec 2019 14:59:04 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30E55F8011E
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:59:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30E55F8011E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E4854AD6C;
 Tue, 10 Dec 2019 13:58:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: linux-media@vger.kernel.org
Date: Tue, 10 Dec 2019 14:58:38 +0100
Message-Id: <20191210135849.15607-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [alsa-devel] [PATCH for-5.6 03/14] media: usbtv: Use managed buffer
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
The hw_params and hw_free callbacks became superfluous and dropped.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/usb/usbtv/usbtv-audio.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-audio.c b/drivers/media/usb/usbtv/usbtv-audio.c
index e746c8ddfc49..b27009875758 100644
--- a/drivers/media/usb/usbtv/usbtv-audio.c
+++ b/drivers/media/usb/usbtv/usbtv-audio.c
@@ -85,30 +85,6 @@ static int snd_usbtv_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_usbtv_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *hw_params)
-{
-	int rv;
-	struct usbtv *chip = snd_pcm_substream_chip(substream);
-
-	rv = snd_pcm_lib_malloc_pages(substream,
-		params_buffer_bytes(hw_params));
-
-	if (rv < 0) {
-		dev_warn(chip->dev, "pcm audio buffer allocation failure %i\n",
-			rv);
-		return rv;
-	}
-
-	return 0;
-}
-
-static int snd_usbtv_hw_free(struct snd_pcm_substream *substream)
-{
-	snd_pcm_lib_free_pages(substream);
-	return 0;
-}
-
 static int snd_usbtv_prepare(struct snd_pcm_substream *substream)
 {
 	struct usbtv *chip = snd_pcm_substream_chip(substream);
@@ -337,8 +313,6 @@ static const struct snd_pcm_ops snd_usbtv_pcm_ops = {
 	.open = snd_usbtv_pcm_open,
 	.close = snd_usbtv_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_usbtv_hw_params,
-	.hw_free = snd_usbtv_hw_free,
 	.prepare = snd_usbtv_prepare,
 	.trigger = snd_usbtv_card_trigger,
 	.pointer = snd_usbtv_pointer,
@@ -377,7 +351,7 @@ int usbtv_audio_init(struct usbtv *usbtv)
 	pcm->private_data = usbtv;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_usbtv_pcm_ops);
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 		NULL, USBTV_AUDIO_BUFFER, USBTV_AUDIO_BUFFER);
 
 	rv = snd_card_register(card);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
