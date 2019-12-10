Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74414C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:03:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B8120652
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k/7T0SQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B8120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BF8D1668;
	Tue, 10 Dec 2019 15:02:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BF8D1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575986616;
	bh=51qW7/8voLPYdCS9h548WuO26cSxsgjO1RaWuU/1JJ0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k/7T0SQxJVkOOkJG2A5EIk72vxsig6Ja2yRRXKO+qdYkviZckLVtaAQHd7ZR/NUZn
	 9LYUDGmZOKEoVsBZUKMK2cpG43sVxAXGByrxezPitwQFkYz+6mDEXGoAI0g+tUaI99
	 Iw+BBY78dCTxxhc/bhQE1yU3FD7GfaR/amMeKbLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AC1FF80279;
	Tue, 10 Dec 2019 14:59:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46D66F80271; Tue, 10 Dec 2019 14:59:12 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F66CF80248
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 14:59:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F66CF80248
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E43C4AC9F;
 Tue, 10 Dec 2019 13:58:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: linux-media@vger.kernel.org
Date: Tue, 10 Dec 2019 14:58:37 +0100
Message-Id: <20191210135849.15607-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210135849.15607-1-tiwai@suse.de>
References: <20191210135849.15607-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [alsa-devel] [PATCH for-5.6 02/14] media: tw686x: Use managed
	buffer allocation
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

Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/tw686x/tw686x-audio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/media/pci/tw686x/tw686x-audio.c b/drivers/media/pci/tw686x/tw686x-audio.c
index 7786e51d19ae..f5065c72bb28 100644
--- a/drivers/media/pci/tw686x/tw686x-audio.c
+++ b/drivers/media/pci/tw686x/tw686x-audio.c
@@ -78,17 +78,6 @@ void tw686x_audio_irq(struct tw686x_dev *dev, unsigned long requests,
 	}
 }
 
-static int tw686x_pcm_hw_params(struct snd_pcm_substream *ss,
-				struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(hw_params));
-}
-
-static int tw686x_pcm_hw_free(struct snd_pcm_substream *ss)
-{
-	return snd_pcm_lib_free_pages(ss);
-}
-
 /*
  * Audio parameters are global and shared among all
  * capture channels. The driver prevents changes to
@@ -270,8 +259,6 @@ static const struct snd_pcm_ops tw686x_pcm_ops = {
 	.open = tw686x_pcm_open,
 	.close = tw686x_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = tw686x_pcm_hw_params,
-	.hw_free = tw686x_pcm_hw_free,
 	.prepare = tw686x_pcm_prepare,
 	.trigger = tw686x_pcm_trigger,
 	.pointer = tw686x_pcm_pointer,
@@ -298,7 +285,7 @@ static int tw686x_snd_pcm_init(struct tw686x_dev *dev)
 	     ss; ss = ss->next, i++)
 		snprintf(ss->name, sizeof(ss->name), "vch%u audio", i);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_set_managed_buffer_all(pcm,
 				SNDRV_DMA_TYPE_DEV,
 				&dev->pci_dev->dev,
 				TW686X_AUDIO_PAGE_MAX * AUDIO_DMA_SIZE_MAX,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
