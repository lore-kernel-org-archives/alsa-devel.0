Return-Path: <SRS0=ObP5=KM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9205CC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 13:17:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E37B610E9
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 13:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E37B610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 119F3165E;
	Mon, 17 May 2021 15:17:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 119F3165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621257470;
	bh=ogZSauXy09SC7Swe+w93+FBrRyeBkmv84vnElaSaCc0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fBor++nlH70jDEaiZjla4dIUQL9EKVL1bvcDvtxdhy/VYReMSqwtJyqdRAGnY1sUa
	 dysn3AzrtoaGrfN0q0YHVURiy+iSyaIniX5QFYuClLeAWi99qGmW64YaguSseOrux1
	 8rHtmW6d3o/Pj4CcDtCR2H3/jDGbVY7OSUcvdno4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4001F804AE;
	Mon, 17 May 2021 15:16:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76BC2F804AA; Mon, 17 May 2021 15:16:06 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A203F80259
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 15:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A203F80259
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 71856B1DD
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 13:15:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/11] ALSA: usx2y: Fix potential leaks of uninitialized memory
Date: Mon, 17 May 2021 15:15:38 +0200
Message-Id: <20210517131545.27252-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210517131545.27252-1-tiwai@suse.de>
References: <20210517131545.27252-1-tiwai@suse.de>
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

usx2y drivers may expose the allocated pages via mmap, but it performs
zero-clear only for the struct size, not aligned with the page size.
This leaves out some uninitialized trailing bytes.

This patch fixes the clearance to cover all memory that are exposed to
user-space.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usX2Yhwdep.c      |  8 ++++----
 sound/usb/usx2y/usbus428ctldefs.h |  2 ++
 sound/usb/usx2y/usbusx2y.c        |  2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c   | 13 ++++++++-----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 2d4e943be2da..0ed50be89271 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -55,17 +55,17 @@ static int snd_us428ctls_mmap(struct snd_hwdep *hw, struct file *filp, struct vm
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */
-	if (size > PAGE_ALIGN(sizeof(struct us428ctls_sharedmem))) {
-		snd_printd("%lu > %lu\n", size, (unsigned long)sizeof(struct us428ctls_sharedmem));
+	if (size > US428_SHAREDMEM_PAGES) {
+		snd_printd("%lu > %lu\n", size, (unsigned long)US428_SHAREDMEM_PAGES);
 		return -EINVAL;
 	}
 
 	if (!us428->us428ctls_sharedmem) {
 		init_waitqueue_head(&us428->us428ctls_wait_queue_head);
-		us428->us428ctls_sharedmem = alloc_pages_exact(sizeof(struct us428ctls_sharedmem), GFP_KERNEL);
+		us428->us428ctls_sharedmem = alloc_pages_exact(US428_SHAREDMEM_PAGES, GFP_KERNEL);
 		if (!us428->us428ctls_sharedmem)
 			return -ENOMEM;
-		memset(us428->us428ctls_sharedmem, -1, sizeof(struct us428ctls_sharedmem));
+		memset(us428->us428ctls_sharedmem, -1, US428_SHAREDMEM_PAGES);
 		us428->us428ctls_sharedmem->ctl_snapshot_last = -2;
 	}
 	area->vm_ops = &us428ctls_vm_ops;
diff --git a/sound/usb/usx2y/usbus428ctldefs.h b/sound/usb/usx2y/usbus428ctldefs.h
index 06b27d23d3c2..9ba15d974e63 100644
--- a/sound/usb/usx2y/usbus428ctldefs.h
+++ b/sound/usb/usx2y/usbus428ctldefs.h
@@ -89,3 +89,5 @@ struct us428ctls_sharedmem {
 	struct us428_p4out	p4out[N_US428_P4OUT_BUFS];
 	int			p4out_last, p4out_sent;
 };
+
+#define US428_SHAREDMEM_PAGES	PAGE_ALIGN(sizeof(struct us428ctls_sharedmem))
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 05b10bdc6380..25e04a0ff97b 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -430,7 +430,7 @@ static void snd_usx2y_card_private_free(struct snd_card *card)
 	usb_free_urb(usx2y->in04_urb);
 	if (usx2y->us428ctls_sharedmem)
 		free_pages_exact(usx2y->us428ctls_sharedmem,
-				 sizeof(*usx2y->us428ctls_sharedmem));
+				 US428_SHAREDMEM_PAGES);
 	if (usx2y->card_index >= 0 && usx2y->card_index < SNDRV_CARDS)
 		snd_usx2y_card_used[usx2y->card_index] = 0;
 }
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 9219341d71c7..b988a4870de4 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -485,6 +485,9 @@ static int usx2y_usbpcm_urbs_start(struct snd_usx2y_substream *subs)
 	return err;
 }
 
+#define USX2Y_HWDEP_PCM_PAGES	\
+	PAGE_ALIGN(sizeof(struct snd_usx2y_hwdep_pcm_shm))
+
 /*
  * prepare callback
  *
@@ -501,11 +504,11 @@ static int snd_usx2y_usbpcm_prepare(struct snd_pcm_substream *substream)
 	snd_printdd("snd_usx2y_pcm_prepare(%p)\n", substream);
 
 	if (!usx2y->hwdep_pcm_shm) {
-		usx2y->hwdep_pcm_shm = alloc_pages_exact(sizeof(struct snd_usx2y_hwdep_pcm_shm),
+		usx2y->hwdep_pcm_shm = alloc_pages_exact(USX2Y_HWDEP_PCM_PAGES,
 							 GFP_KERNEL);
 		if (!usx2y->hwdep_pcm_shm)
 			return -ENOMEM;
-		memset(usx2y->hwdep_pcm_shm, 0, sizeof(struct snd_usx2y_hwdep_pcm_shm));
+		memset(usx2y->hwdep_pcm_shm, 0, USX2Y_HWDEP_PCM_PAGES);
 	}
 
 	mutex_lock(&usx2y->pcm_mutex);
@@ -692,8 +695,8 @@ static int snd_usx2y_hwdep_pcm_mmap(struct snd_hwdep *hw, struct file *filp, str
 		return -EBUSY;
 
 	/* if userspace tries to mmap beyond end of our buffer, fail */
-	if (size > PAGE_ALIGN(sizeof(struct snd_usx2y_hwdep_pcm_shm))) {
-		snd_printd("%lu > %lu\n", size, (unsigned long)sizeof(struct snd_usx2y_hwdep_pcm_shm));
+	if (size > USX2Y_HWDEP_PCM_PAGES) {
+		snd_printd("%lu > %lu\n", size, (unsigned long)USX2Y_HWDEP_PCM_PAGES);
 		return -EINVAL;
 	}
 
@@ -711,7 +714,7 @@ static void snd_usx2y_hwdep_pcm_private_free(struct snd_hwdep *hwdep)
 	struct usx2ydev *usx2y = hwdep->private_data;
 
 	if (usx2y->hwdep_pcm_shm)
-		free_pages_exact(usx2y->hwdep_pcm_shm, sizeof(struct snd_usx2y_hwdep_pcm_shm));
+		free_pages_exact(usx2y->hwdep_pcm_shm, USX2Y_HWDEP_PCM_PAGES);
 }
 
 int usx2y_hwdep_pcm_new(struct snd_card *card)
-- 
2.26.2

