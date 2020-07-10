Return-Path: <SRS0=u2Q7=AV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59404C433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:08:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9173206C3
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bEApRh1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9173206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DF441616;
	Fri, 10 Jul 2020 18:07:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DF441616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594397280;
	bh=Eu+OmCKKGqZLCVlbOV0zGHHS7qPRU/BjIxNtcxCXdTU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bEApRh1fFZWk+zmuKDm8SqjyIf8Xzsqbp4LuGRsNoIPLmGagom2t+bTTU4QXUajl6
	 ghKhTIlY1+hGee+3xwnTD+0MjeepvIZFG5NpII+10nm8VJrI2EZhnotp0/ggnYmJqD
	 ZeF2IsdGMZc6FgBP95f9kdx+XbfZdTS+sOaUgT3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72CF4F80150;
	Fri, 10 Jul 2020 18:07:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F266F8015A; Fri, 10 Jul 2020 18:07:08 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EE44F8011C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 18:06:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EE44F8011C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F040BAD9F
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 16:06:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix race against the error recovery URB
 submission
Date: Fri, 10 Jul 2020 18:06:56 +0200
Message-Id: <20200710160656.16819-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

USB MIDI driver has an error recovery mechanism to resubmit the URB in
the delayed timer handler, and this may race with the standard start /
stop operations.  Although both start and stop operations themselves
don't race with each other due to the umidi->mutex protection, but
this isn't applied to the timer handler.

For fixing this potential race, the following changes are applied:

- Since the timer handler can't use the mutex, we apply the
  umidi->disc_lock protection at each input stream URB submission;
  this also needs to change the GFP flag to GFP_ATOMIC
- Add a check of the URB refcount and skip if already submitted
- Move the timer cancel call at disconnection to the beginning of the
  procedure; this assures the in-flight timer handler is gone properly
  before killing all pending URBs

Reported-by: syzbot+0f4ecfe6a2c322c81728@syzkaller.appspotmail.com
Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 047b90595d65..354f57692938 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1499,6 +1499,8 @@ void snd_usbmidi_disconnect(struct list_head *p)
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
+	del_timer_sync(&umidi->error_timer);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1525,7 +1527,6 @@ void snd_usbmidi_disconnect(struct list_head *p)
 			ep->in = NULL;
 		}
 	}
-	del_timer_sync(&umidi->error_timer);
 }
 EXPORT_SYMBOL(snd_usbmidi_disconnect);
 
@@ -2301,16 +2302,22 @@ void snd_usbmidi_input_stop(struct list_head *p)
 }
 EXPORT_SYMBOL(snd_usbmidi_input_stop);
 
-static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint *ep)
+static void snd_usbmidi_input_start_ep(struct snd_usb_midi *umidi,
+				       struct snd_usb_midi_in_endpoint *ep)
 {
 	unsigned int i;
+	unsigned long flags;
 
 	if (!ep)
 		return;
 	for (i = 0; i < INPUT_URBS; ++i) {
 		struct urb *urb = ep->urbs[i];
-		urb->dev = ep->umidi->dev;
-		snd_usbmidi_submit_urb(urb, GFP_KERNEL);
+		spin_lock_irqsave(&umidi->disc_lock, flags);
+		if (!atomic_read(&urb->use_count)) {
+			urb->dev = ep->umidi->dev;
+			snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+		}
+		spin_unlock_irqrestore(&umidi->disc_lock, flags);
 	}
 }
 
@@ -2326,7 +2333,7 @@ void snd_usbmidi_input_start(struct list_head *p)
 	if (umidi->input_running || !umidi->opened[1])
 		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
+		snd_usbmidi_input_start_ep(umidi, umidi->endpoints[i].in);
 	umidi->input_running = 1;
 }
 EXPORT_SYMBOL(snd_usbmidi_input_start);
-- 
2.16.4

