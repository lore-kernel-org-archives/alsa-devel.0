Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801FC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:45:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFFA20775
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m9DcbqQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFFA20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1E4E190C;
	Thu,  3 Sep 2020 12:45:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1E4E190C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599129958;
	bh=4qzgDhjILBA4oGl8kaT+E/3ivsaEcRtpabmCfutZuaY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m9DcbqQhhSiS70G2CkAccYpria5qhIIsXFg3n5XAMxibwEvcfcZta4G7iKPawdJv3
	 AstqUCFicVMnDr91jKQqqAdh+baZVBpl5tJoVdubKA+XLHToCr0Lg2NlHCP/3ocrku
	 ncUgmYsx4frd/UR/FnQ3SwB1PKq+gzurUWZPqzhc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D631DF802E9;
	Thu,  3 Sep 2020 12:42:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2545F80217; Thu,  3 Sep 2020 12:41:56 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 305EBF8025F
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 12:41:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 305EBF8025F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B032CB148;
 Thu,  3 Sep 2020 10:41:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 03/11] ALSA: usb-audio: Replace tasklet with work
Date: Thu,  3 Sep 2020 12:41:23 +0200
Message-Id: <20200903104131.21097-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200903104131.21097-1-tiwai@suse.de>
References: <20200903104131.21097-1-tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
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

The tasklet is an old API that should be deprecated, usually can be
converted to another decent API.  In USB-audio driver, a tasklet is
still used in MIDI interface code for handling the output byte
stream.  It can be achieved gracefully with a work queued in the
high-prio system workqueue.

This patch replaces the tasklet usage in USB-audio driver with a
simple work.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index e8287a05e36b..c8213652470c 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -142,7 +142,7 @@ struct snd_usb_midi_out_endpoint {
 	unsigned int active_urbs;
 	unsigned int drain_urbs;
 	int max_transfer;		/* size of urb buffer */
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	unsigned int next_urb;
 	spinlock_t buffer_lock;
 
@@ -344,9 +344,10 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
 	spin_unlock_irqrestore(&ep->buffer_lock, flags);
 }
 
-static void snd_usbmidi_out_tasklet(struct tasklet_struct *t)
+static void snd_usbmidi_out_work(struct work_struct *work)
 {
-	struct snd_usb_midi_out_endpoint *ep = from_tasklet(ep, t, tasklet);
+	struct snd_usb_midi_out_endpoint *ep =
+		container_of(work, struct snd_usb_midi_out_endpoint, work);
 
 	snd_usbmidi_do_output(ep);
 }
@@ -1177,7 +1178,7 @@ static void snd_usbmidi_output_trigger(struct snd_rawmidi_substream *substream,
 			snd_rawmidi_proceed(substream);
 			return;
 		}
-		tasklet_schedule(&port->ep->tasklet);
+		queue_work(system_highpri_wq, &port->ep->work);
 	}
 }
 
@@ -1440,7 +1441,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 	}
 
 	spin_lock_init(&ep->buffer_lock);
-	tasklet_setup(&ep->tasklet, snd_usbmidi_out_tasklet);
+	INIT_WORK(&ep->work, snd_usbmidi_out_work);
 	init_waitqueue_head(&ep->drain_wait);
 
 	for (i = 0; i < 0x10; ++i)
@@ -1503,7 +1504,7 @@ void snd_usbmidi_disconnect(struct list_head *p)
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
-			tasklet_kill(&ep->out->tasklet);
+			cancel_work_sync(&ep->out->work);
 		if (ep->out) {
 			for (j = 0; j < OUTPUT_URBS; ++j)
 				usb_kill_urb(ep->out->urbs[j].urb);
-- 
2.16.4

