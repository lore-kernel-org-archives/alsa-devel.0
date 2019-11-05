Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEEBC5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C85214B2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MvvwEWNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C85214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC96F16EF;
	Tue,  5 Nov 2019 16:28:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC96F16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572967747;
	bh=oXmMVeZwQJbrtEjah+ktvGaea51NwuXAJEb4n5fihdk=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvvwEWNh/ndiq9CxiRc96ndAgzAPMd+zoqev+BvmG5abTwqoKPuv6tB4aN1fMaRNW
	 mgrR/QhDaSn/rMHTm/oayKVe7B2OENPID2tzFqwRfn3gdHY7PtHR+qnglJ6nZgUcAo
	 TJYVCzkPOK6Ve/C9K+o+b/3HoVyODvFGPRlI3vqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73F37F80722;
	Tue,  5 Nov 2019 16:19:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 863D7F80600; Tue,  5 Nov 2019 16:19:17 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16432F8060E
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16432F8060E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 55F73B29D
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:44 +0100
Message-Id: <20191105151856.10785-13-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 12/24] ALSA: caiaq: Convert to the common
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/caiaq/audio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 444bb637ce13..970eb0865ba3 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -170,15 +170,14 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
 				       struct snd_pcm_hw_params *hw_params)
 {
-	return snd_pcm_lib_alloc_vmalloc_buffer(sub,
-						params_buffer_bytes(hw_params));
+	return snd_pcm_lib_malloc_pages(sub, params_buffer_bytes(hw_params));
 }
 
 static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(sub);
 	deactivate_substream(cdev, sub);
-	return snd_pcm_lib_free_vmalloc_buffer(sub);
+	return snd_pcm_lib_free_pages(sub);
 }
 
 /* this should probably go upstream */
@@ -334,7 +333,6 @@ static const struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.prepare =	snd_usb_caiaq_pcm_prepare,
 	.trigger =	snd_usb_caiaq_pcm_trigger,
 	.pointer =	snd_usb_caiaq_pcm_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
 };
 
 static void check_for_elapsed_periods(struct snd_usb_caiaqdev *cdev,
@@ -843,6 +841,8 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 				&snd_usb_caiaq_ops);
 	snd_pcm_set_ops(cdev->pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&snd_usb_caiaq_ops);
+	snd_pcm_lib_preallocate_pages_for_all(cdev->pcm, SNDRV_DMA_TYPE_VMALLOC,
+					      NULL, 0, 0);
 
 	cdev->data_cb_info =
 		kmalloc_array(N_URBS, sizeof(struct snd_usb_caiaq_cb_info),
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
