Return-Path: <SRS0=ObP5=KM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BCC433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 13:19:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F012361059
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 13:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F012361059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CB401693;
	Mon, 17 May 2021 15:18:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CB401693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621257586;
	bh=HmRMqJvc0SdTExhcu+CX343XDbBgXkDs/PlBFExODew=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f56GFshjAdz0nW+AfEX4pOyT5TvI2J3MFeOIZRXL3pSIcTrOYVWhTg1g1CTLEKh1k
	 GONpShHWq3aozWyUzMgw75IuiPcRNNT9I9YkeREyc/l3X2XI4HCt5k1npwRTgH2hpb
	 b0zdLgy8QXM9sLubGIDNk0u17UjYKoEWmNVCcUJA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68496F804E4;
	Mon, 17 May 2021 15:16:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7EC8F804E0; Mon, 17 May 2021 15:16:11 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6E97F80169
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 15:15:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6E97F80169
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 89B86B1E6
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 13:15:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/11] ALSA: usx2y: Fix potential memory leaks
Date: Mon, 17 May 2021 15:15:40 +0200
Message-Id: <20210517131545.27252-7-tiwai@suse.de>
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

Theoretically the initialization functions in usx2y drivers may be
called multiple times as the driver gets initialized via hwpdep
ioctl.  Meanwhile, those functions including memory allocations don't
check whether they are called twice, and they forget the old
resources, which would lead to memory leaks.

This patch adds the sanity checks about the doubly initializations to
give kernel WARNING, and returns an error in such a case.  Also, each
allocation assures to release the resources at its error path
properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/usx2y/usbusx2y.c | 39 ++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 25e04a0ff97b..d2e1cf163521 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -150,6 +150,7 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 
 static void usx2y_usb_disconnect(struct usb_device *usb_device, void *ptr);
 static void snd_usx2y_card_private_free(struct snd_card *card);
+static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
 
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
@@ -252,6 +253,9 @@ int usx2y_async_seq04_init(struct usx2ydev *usx2y)
 {
 	int	err = 0, i;
 
+	if (WARN_ON(usx2y->as04.buffer))
+		return -EBUSY;
+
 	usx2y->as04.buffer = kmalloc_array(URBS_ASYNC_SEQ,
 					   URB_DATA_LEN_ASYNC_SEQ, GFP_KERNEL);
 	if (!usx2y->as04.buffer) {
@@ -272,27 +276,47 @@ int usx2y_async_seq04_init(struct usx2ydev *usx2y)
 				break;
 		}
 	}
+	if (err)
+		usx2y_unlinkseq(&usx2y->as04);
 	return err;
 }
 
 int usx2y_in04_init(struct usx2ydev *usx2y)
 {
+	int err;
+
+	if (WARN_ON(usx2y->in04_urb))
+		return -EBUSY;
+
 	usx2y->in04_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!usx2y->in04_urb)
-		return -ENOMEM;
+	if (!usx2y->in04_urb) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	usx2y->in04_buf = kmalloc(21, GFP_KERNEL);
-	if (!usx2y->in04_buf)
-		return -ENOMEM;
+	if (!usx2y->in04_buf) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	init_waitqueue_head(&usx2y->in04_wait_queue);
 	usb_fill_int_urb(usx2y->in04_urb, usx2y->dev, usb_rcvintpipe(usx2y->dev, 0x4),
 			 usx2y->in04_buf, 21,
 			 i_usx2y_in04_int, usx2y,
 			 10);
-	if (usb_urb_ep_type_check(usx2y->in04_urb))
-		return -EINVAL;
+	if (usb_urb_ep_type_check(usx2y->in04_urb)) {
+		err = -EINVAL;
+		goto error;
+	}
 	return usb_submit_urb(usx2y->in04_urb, GFP_KERNEL);
+
+ error:
+	kfree(usx2y->in04_buf);
+	usb_free_urb(usx2y->in04_urb);
+	usx2y->in04_buf = NULL;
+	usx2y->in04_urb = NULL;
+	return err;
 }
 
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s)
@@ -300,11 +324,14 @@ static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s)
 	int	i;
 
 	for (i = 0; i < URBS_ASYNC_SEQ; ++i) {
+		if (!s->urb[i])
+			continue;
 		usb_kill_urb(s->urb[i]);
 		usb_free_urb(s->urb[i]);
 		s->urb[i] = NULL;
 	}
 	kfree(s->buffer);
+	s->buffer = NULL;
 }
 
 static const struct usb_device_id snd_usx2y_usb_id_table[] = {
-- 
2.26.2

