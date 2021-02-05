Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 14:47:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD7164DDC
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 14:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD7164DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BC1D165E;
	Fri,  5 Feb 2021 15:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BC1D165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612536423;
	bh=Exn6kpTeqxavHQkoeYIgFLcSRNui7o51lnVxtpJ2R3Q=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aGdsYvgDby6Si+8DI1zA/WSnZilJvUoxbeRUR7YB8Y6b5dRQaRO24Xm6bRWRZej9b
	 6LdhLPZwAbA342Elo6bY2VAwFKUdu01yJnbLlcV/63uydI1ssrWpePppHt1nXTHCwF
	 Hf/xucQeb05+AUWG1jseupuK9IstW1UaXDcOWvoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB63EF80156;
	Fri,  5 Feb 2021 15:46:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0E7AF8015A; Fri,  5 Feb 2021 15:46:09 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9411CF80139
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 15:46:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9411CF80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 28ABEAEBD
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 14:46:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix PCM buffer allocation in non-vmalloc mode
Date: Fri,  5 Feb 2021 15:45:59 +0100
Message-Id: <20210205144559.29555-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The commit f274baa49be6 ("ALSA: usb-audio: Allow non-vmalloc buffer
for PCM buffers") introduced the mode to allocate coherent pages for
PCM buffers, and it used bus->controller device as its DMA device.
It turned out, however, that bus->sysdev is a more appropriate device
to be used for DMA mapping in HCD code.

This patch corrects the device reference accordingly.

Note that, on most platforms, both point to the very same device,
hence this patch doesn't change anything practically.  But on
platforms like xhcd-plat hcd, the change becomes effective.

Fixes: f274baa49be6 ("ALSA: usb-audio: Allow non-vmalloc buffer for PCM buffers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 078bb4c94033..dcadf8f164b2 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1558,7 +1558,7 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs)
 {
 	struct snd_pcm *pcm = subs->stream->pcm;
 	struct snd_pcm_substream *s = pcm->streams[subs->direction].substream;
-	struct device *dev = subs->dev->bus->controller;
+	struct device *dev = subs->dev->bus->sysdev;
 
 	if (snd_usb_use_vmalloc)
 		snd_pcm_set_managed_buffer(s, SNDRV_DMA_TYPE_VMALLOC,
-- 
2.26.2

