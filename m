Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325CC433E9
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:44:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B451420716
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sVWrvEAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B451420716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 355731904;
	Thu,  3 Sep 2020 12:43:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 355731904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599129872;
	bh=pnLeTLPJsC5fEWl/RezUySyEYBmGMG1bL4I9CrorFhs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVWrvEAluHpA2+VD/lT30SXkBdifC10J5us912iMPTyx+jqexQkPbbe83l6x/EeTt
	 eZFc4JgKogz03fpSU3VlW7p9rCPIdIMEAVyQ953xS/Lhvr/sZyhWb9zbak2fg9IFqL
	 UT2MYDuXaqgzWU+dYd+GvnjPWsWSatMfhlHt3WL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7344DF802DF;
	Thu,  3 Sep 2020 12:42:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08FF4F802E1; Thu,  3 Sep 2020 12:41:55 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AB9FF80217
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 12:41:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AB9FF80217
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C182BB149;
 Thu,  3 Sep 2020 10:41:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/11] ALSA: ua101: Replace tasklet with work
Date: Thu,  3 Sep 2020 12:41:24 +0200
Message-Id: <20200903104131.21097-5-tiwai@suse.de>
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
converted to another decent API.  In UA101 driver, a tasklet is still
used for handling the output URBs.  It can be achieved gracefully with
a work queued in the high-prio system workqueue, too.

This patch replaces the tasklet usage in UA101 driver with a simple
work.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/misc/ua101.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 3b2dce1043f5..6b30155964ec 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -96,7 +96,7 @@ struct ua101 {
 	u8 rate_feedback[MAX_QUEUE_LENGTH];
 
 	struct list_head ready_playback_urbs;
-	struct tasklet_struct playback_tasklet;
+	struct work_struct playback_work;
 	wait_queue_head_t alsa_capture_wait;
 	wait_queue_head_t rate_feedback_wait;
 	wait_queue_head_t alsa_playback_wait;
@@ -188,7 +188,7 @@ static void playback_urb_complete(struct urb *usb_urb)
 		spin_lock_irqsave(&ua->lock, flags);
 		list_add_tail(&urb->ready_list, &ua->ready_playback_urbs);
 		if (ua->rate_feedback_count > 0)
-			tasklet_schedule(&ua->playback_tasklet);
+			queue_work(system_highpri_wq, &ua->playback_work);
 		ua->playback.substream->runtime->delay -=
 				urb->urb.iso_frame_desc[0].length /
 						ua->playback.frame_bytes;
@@ -247,9 +247,9 @@ static inline void add_with_wraparound(struct ua101 *ua,
 		*value -= ua->playback.queue_length;
 }
 
-static void playback_tasklet(struct tasklet_struct *t)
+static void playback_work(struct work_struct *work)
 {
-	struct ua101 *ua = from_tasklet(ua, t, playback_tasklet);
+	struct ua101 *ua = container_of(work, struct ua101, playback_work);
 	unsigned long flags;
 	unsigned int frames;
 	struct ua101_urb *urb;
@@ -401,7 +401,7 @@ static void capture_urb_complete(struct urb *urb)
 		}
 		if (test_bit(USB_PLAYBACK_RUNNING, &ua->states) &&
 		    !list_empty(&ua->ready_playback_urbs))
-			tasklet_schedule(&ua->playback_tasklet);
+			queue_work(system_highpri_wq, &ua->playback_work);
 	}
 
 	spin_unlock_irqrestore(&ua->lock, flags);
@@ -532,7 +532,7 @@ static void stop_usb_playback(struct ua101 *ua)
 
 	kill_stream_urbs(&ua->playback);
 
-	tasklet_kill(&ua->playback_tasklet);
+	cancel_work_sync(&ua->playback_work);
 
 	disable_iso_interface(ua, INTF_PLAYBACK);
 }
@@ -550,7 +550,7 @@ static int start_usb_playback(struct ua101 *ua)
 		return 0;
 
 	kill_stream_urbs(&ua->playback);
-	tasklet_kill(&ua->playback_tasklet);
+	cancel_work_sync(&ua->playback_work);
 
 	err = enable_iso_interface(ua, INTF_PLAYBACK);
 	if (err < 0)
@@ -1218,7 +1218,7 @@ static int ua101_probe(struct usb_interface *interface,
 	spin_lock_init(&ua->lock);
 	mutex_init(&ua->mutex);
 	INIT_LIST_HEAD(&ua->ready_playback_urbs);
-	tasklet_setup(&ua->playback_tasklet, playback_tasklet);
+	INIT_WORK(&ua->playback_work, playback_work);
 	init_waitqueue_head(&ua->alsa_capture_wait);
 	init_waitqueue_head(&ua->rate_feedback_wait);
 	init_waitqueue_head(&ua->alsa_playback_wait);
-- 
2.16.4

