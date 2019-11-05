Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D6FC5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:22:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005F721929
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n+GwdeNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005F721929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3267616DE;
	Tue,  5 Nov 2019 16:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3267616DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572967345;
	bh=QkwRbmdfDsX/GLgrtFPoTPyM1bv5Z6CT6rBAVYUKCl4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n+GwdeNbYB6M5zmFgeUKbTSCvEqPCGyU7mfgfFX/1m9YFgypUQq/BW3uhOSF3adoy
	 GgArMBJgeyYsKgJCR0I4d3j1IYzi9jXlgFtRz5rBKnLxMBDuzaSMtgqN28p3uUBqRt
	 I4BeF7soenxaQKZL9zfaQ/DaZtaEzIziRGXV1w5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 363D6F8060E;
	Tue,  5 Nov 2019 16:19:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1983F80638; Tue,  5 Nov 2019 16:19:05 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DCE7F805DF
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DCE7F805DF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 29EE1B28E
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:40 +0100
Message-Id: <20191105151856.10785-9-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 08/24] ALSA: usb-audio: Convert to the common
	vmalloc memalloc
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

The recent change (*) in the ALSA memalloc core allows us to drop the
special vmalloc-specific allocation and page handling.  This patch
coverts to the common code.
(*) df3fd6509421: ALSA: memalloc: Add vmalloc buffer allocation
                  support
    6ef6be988f98: ALSA: pcm: Handle special page mapping in the
                  default mmap handler

Also, since the SG-buffer-specific PCM ops becomes identical with the
normal PCM ops, unify them again to the single ops, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 50 ++++++++------------------------------------------
 1 file changed, 8 insertions(+), 42 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ff5ab24f3bd1..9c8930bb00c8 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -785,12 +785,8 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	if (snd_usb_use_vmalloc)
-		ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						       params_buffer_bytes(hw_params));
-	else
-		ret = snd_pcm_lib_malloc_pages(substream,
-					       params_buffer_bytes(hw_params));
+	ret = snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(hw_params));
 	if (ret < 0)
 		goto stop_pipeline;
 
@@ -857,10 +853,7 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 		snd_usb_unlock_shutdown(subs->stream->chip);
 	}
 
-	if (snd_usb_use_vmalloc)
-		return snd_pcm_lib_free_vmalloc_buffer(substream);
-	else
-		return snd_pcm_lib_free_pages(substream);
+	return snd_pcm_lib_free_pages(substream);
 }
 
 /*
@@ -1781,7 +1774,6 @@ static const struct snd_pcm_ops snd_usb_playback_ops = {
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_playback_trigger,
 	.pointer =	snd_usb_pcm_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
 };
 
 static const struct snd_pcm_ops snd_usb_capture_ops = {
@@ -1793,43 +1785,14 @@ static const struct snd_pcm_ops snd_usb_capture_ops = {
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_capture_trigger,
 	.pointer =	snd_usb_pcm_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
-};
-
-static const struct snd_pcm_ops snd_usb_playback_dev_ops = {
-	.open =		snd_usb_pcm_open,
-	.close =	snd_usb_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_usb_hw_params,
-	.hw_free =	snd_usb_hw_free,
-	.prepare =	snd_usb_pcm_prepare,
-	.trigger =	snd_usb_substream_playback_trigger,
-	.pointer =	snd_usb_pcm_pointer,
-	.page =		snd_pcm_sgbuf_ops_page,
-};
-
-static const struct snd_pcm_ops snd_usb_capture_dev_ops = {
-	.open =		snd_usb_pcm_open,
-	.close =	snd_usb_pcm_close,
-	.ioctl =	snd_pcm_lib_ioctl,
-	.hw_params =	snd_usb_hw_params,
-	.hw_free =	snd_usb_hw_free,
-	.prepare =	snd_usb_pcm_prepare,
-	.trigger =	snd_usb_substream_capture_trigger,
-	.pointer =	snd_usb_pcm_pointer,
-	.page =		snd_pcm_sgbuf_ops_page,
 };
 
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream)
 {
 	const struct snd_pcm_ops *ops;
 
-	if (snd_usb_use_vmalloc)
-		ops = stream == SNDRV_PCM_STREAM_PLAYBACK ?
+	ops = stream == SNDRV_PCM_STREAM_PLAYBACK ?
 			&snd_usb_playback_ops : &snd_usb_capture_ops;
-	else
-		ops = stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			&snd_usb_playback_dev_ops : &snd_usb_capture_dev_ops;
 	snd_pcm_set_ops(pcm, stream, ops);
 }
 
@@ -1839,7 +1802,10 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs)
 	struct snd_pcm_substream *s = pcm->streams[subs->direction].substream;
 	struct device *dev = subs->dev->bus->controller;
 
-	if (!snd_usb_use_vmalloc)
+	if (snd_usb_use_vmalloc)
+		snd_pcm_lib_preallocate_pages(s, SNDRV_DMA_TYPE_VMALLOC,
+					      NULL, 0, 0);
+	else
 		snd_pcm_lib_preallocate_pages(s, SNDRV_DMA_TYPE_DEV_SG,
 					      dev, 64*1024, 512*1024);
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
