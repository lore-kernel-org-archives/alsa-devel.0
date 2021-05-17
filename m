Return-Path: <SRS0=ObP5=KM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A2C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 13:20:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66468611BE
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 13:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66468611BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6117165E;
	Mon, 17 May 2021 15:19:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6117165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621257649;
	bh=pNYBCjJzYtEHhHajb7bGBkBfB8vzBE7963iQ8/iQ3V8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VzbFSZQc+ZdjDGzgiZtTy2Qsz0JJV7UizFE9TWe161kCiyefDRQvF1oNd2Xb2aFIr
	 82yoEgD5tKDQCeaxDlwa9kNmQbZWYNr0FbJnRNULyd6NC4SNB8MgWHkQ8KzJl1fGhf
	 06DKOrD41+PMkHIEAOXgvCsCtbibL4zt/ZnGz6CQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 119F1F804FC;
	Mon, 17 May 2021 15:16:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB0E2F804D9; Mon, 17 May 2021 15:16:13 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E370F80430
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 15:15:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E370F80430
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A4E15B205
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 13:15:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/11] ALSA: usx2y: Fix shmem initialization
Date: Mon, 17 May 2021 15:15:42 +0200
Message-Id: <20210517131545.27252-9-tiwai@suse.de>
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

Currently us428ctls_shmem pages are allocated dynamically upon the
mmap call, but this is quite racy.  Since the shared memory itself is
mandatory for the mmap, let's allocate it at the beginning of the card
initialization.  Also, fix the initialization of the wait queue, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usX2Yhwdep.c | 18 +++++++++---------
 sound/usb/usx2y/usbusx2y.c   |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index ec7e3beed4f9..c29da0341bc5 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -60,14 +60,6 @@ static int snd_us428ctls_mmap(struct snd_hwdep *hw, struct file *filp, struct vm
 		return -EINVAL;
 	}
 
-	if (!us428->us428ctls_sharedmem) {
-		init_waitqueue_head(&us428->us428ctls_wait_queue_head);
-		us428->us428ctls_sharedmem = alloc_pages_exact(US428_SHAREDMEM_PAGES, GFP_KERNEL);
-		if (!us428->us428ctls_sharedmem)
-			return -ENOMEM;
-		memset(us428->us428ctls_sharedmem, -1, US428_SHAREDMEM_PAGES);
-		us428->us428ctls_sharedmem->ctl_snapshot_last = -2;
-	}
 	area->vm_ops = &us428ctls_vm_ops;
 	area->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
 	area->vm_private_data = hw->private_data;
@@ -232,18 +224,26 @@ int usx2y_hwdep_new(struct snd_card *card, struct usb_device *device)
 {
 	int err;
 	struct snd_hwdep *hw;
+	struct usx2ydev	*us428 = usx2y(card);
 
 	err = snd_hwdep_new(card, SND_USX2Y_LOADER_ID, 0, &hw);
 	if (err < 0)
 		return err;
 
 	hw->iface = SNDRV_HWDEP_IFACE_USX2Y;
-	hw->private_data = usx2y(card);
+	hw->private_data = us428;
 	hw->ops.dsp_status = snd_usx2y_hwdep_dsp_status;
 	hw->ops.dsp_load = snd_usx2y_hwdep_dsp_load;
 	hw->ops.mmap = snd_us428ctls_mmap;
 	hw->ops.poll = snd_us428ctls_poll;
 	hw->exclusive = 1;
 	sprintf(hw->name, "/dev/bus/usb/%03d/%03d", device->bus->busnum, device->devnum);
+
+	us428->us428ctls_sharedmem = alloc_pages_exact(US428_SHAREDMEM_PAGES, GFP_KERNEL);
+	if (!us428->us428ctls_sharedmem)
+		return -ENOMEM;
+	memset(us428->us428ctls_sharedmem, -1, US428_SHAREDMEM_PAGES);
+	us428->us428ctls_sharedmem->ctl_snapshot_last = -2;
+
 	return 0;
 }
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index d2e1cf163521..09ead00e395e 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -375,6 +375,7 @@ static int usx2y_create_card(struct usb_device *device,
 	card->private_free = snd_usx2y_card_private_free;
 	usx2y(card)->dev = device;
 	init_waitqueue_head(&usx2y(card)->prepare_wait_queue);
+	init_waitqueue_head(&usx2y(card)->us428ctls_wait_queue_head);
 	mutex_init(&usx2y(card)->pcm_mutex);
 	INIT_LIST_HEAD(&usx2y(card)->midi_list);
 	strcpy(card->driver, "USB "NAME_ALLCAPS"");
-- 
2.26.2

