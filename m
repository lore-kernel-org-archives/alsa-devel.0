Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8AAC5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:25:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2093821A4A
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GN/H+HtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2093821A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53DF816CE;
	Tue,  5 Nov 2019 16:25:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53DF816CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572967555;
	bh=H/Xsw9dhFJMjdeZ+PEZnxtuzXWpxlq3h8NzQdTKbyS4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GN/H+HtZRot2bMMMAczdcFZxtntJyQAwqZiD/th3fJwAvcCAFGeD/mscv5H+ZOHG4
	 BjL7Ujq9DmWmY9v2nKdelSPBIgPWuRVSXCgScFdZzDgtVw0G8LAig2fNlnxrFN6U7Q
	 7xR4C+vLqkO2j0WSCZ7Wzg2KOTqKcC+uzjUMekT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 035B5F806E5;
	Tue,  5 Nov 2019 16:19:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C370F80639; Tue,  5 Nov 2019 16:19:12 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5666F805FB
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5666F805FB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 61B73B2BD
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:47 +0100
Message-Id: <20191105151856.10785-16-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 15/24] ALSA: vx: Convert to the common vmalloc
	memalloc
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

Since the driver requires the DMA32 allocation, it passes the
specially encoded device to snd_pcm_lib_preallocate_pages().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/vx/vx_pcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 4705c50fbf4f..f17e0a76c73c 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -778,8 +778,7 @@ static snd_pcm_uframes_t vx_pcm_playback_pointer(struct snd_pcm_substream *subs)
 static int vx_pcm_hw_params(struct snd_pcm_substream *subs,
 				     struct snd_pcm_hw_params *hw_params)
 {
-	return snd_pcm_lib_alloc_vmalloc_32_buffer
-					(subs, params_buffer_bytes(hw_params));
+	return snd_pcm_lib_malloc_pages(subs, params_buffer_bytes(hw_params));
 }
 
 /*
@@ -787,7 +786,7 @@ static int vx_pcm_hw_params(struct snd_pcm_substream *subs,
  */
 static int vx_pcm_hw_free(struct snd_pcm_substream *subs)
 {
-	return snd_pcm_lib_free_vmalloc_buffer(subs);
+	return snd_pcm_lib_free_pages(subs);
 }
 
 /*
@@ -867,7 +866,6 @@ static const struct snd_pcm_ops vx_pcm_playback_ops = {
 	.prepare =	vx_pcm_prepare,
 	.trigger =	vx_pcm_trigger,
 	.pointer =	vx_pcm_playback_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
 };
 
 
@@ -1088,7 +1086,6 @@ static const struct snd_pcm_ops vx_pcm_capture_ops = {
 	.prepare =	vx_pcm_prepare,
 	.trigger =	vx_pcm_trigger,
 	.pointer =	vx_pcm_capture_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
 };
 
 
@@ -1233,6 +1230,9 @@ int snd_vx_pcm_new(struct vx_core *chip)
 			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &vx_pcm_playback_ops);
 		if (ins)
 			snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &vx_pcm_capture_ops);
+		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_VMALLOC,
+						      snd_dma_continuous_data(GFP_KERNEL | GFP_DMA32),
+						      0, 0);
 
 		pcm->private_data = chip;
 		pcm->private_free = snd_vx_pcm_free;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
