Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F0BC56202
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 08:55:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D895720738
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XvEi6dq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D895720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16F0C15F2;
	Mon, 23 Nov 2020 09:55:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16F0C15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606121753;
	bh=bwOZ6calY1h3OmC7kbXEZV+Ml8cZIgyTHBYTr4fJn4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XvEi6dq0uzWG4eYkvZHeOs2gvQtJ3VdD4DwDOWrtMiPNMbuX/o+0TZqsnjJt98WP7
	 j9SdNx/76LcTgJTOexrMpH8fkiwvGTxvkJWEhm9WP1Fe555lsy00BWVn1qrokuNe13
	 MQd0/nsjuo0KPaU5lPD9Jr0FRGHaFmpBFqLDkDJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F59BF80269;
	Mon, 23 Nov 2020 09:54:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A878AF80515; Mon, 23 Nov 2020 09:54:09 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 052E3F80269
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:53:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 052E3F80269
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3D306AF93;
 Mon, 23 Nov 2020 08:53:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/41] ALSA: usb-audio: Improve some debug prints
Date: Mon, 23 Nov 2020 09:53:13 +0100
Message-Id: <20201123085347.19667-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

There are a few rooms for improvements wrt the debug prints:
- The EP debug print is shown only at starting, not at stopping
- The EP debug print contains useless object addresses
- Some helpers show the urb and the EP object addresses, too

This patch addresses those shortcomings.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c |  8 ++++----
 sound/usb/pcm.c      | 11 ++++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index cf00871fd278..8205a64a734e 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -367,8 +367,8 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 		err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
 		if (err < 0)
 			usb_audio_err(ep->chip,
-				"Unable to submit urb #%d: %d (urb %p)\n",
-				ctx->index, err, ctx->urb);
+				      "Unable to submit urb #%d: %d at %s\n",
+				      ctx->index, err, __func__);
 		else
 			set_bit(ctx->index, &ep->active_mask);
 	}
@@ -494,8 +494,8 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 				  alts->desc.bInterfaceNumber,
 				  alts->desc.bAlternateSetting);
 	if (ep) {
-		usb_audio_dbg(ep->chip, "Re-using EP %x in iface %d,%d @%p\n",
-			      ep_num, ep->iface, ep->altsetting, ep);
+		usb_audio_dbg(ep->chip, "Re-using EP %x in iface %d,%d\n",
+			      ep_num, ep->iface, ep->altsetting);
 		goto __exit_unlock;
 	}
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8800ec627a73..8f4fe65d5c37 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -218,7 +218,7 @@ static int start_endpoints(struct snd_usb_substream *subs)
 	if (!test_and_set_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags)) {
 		struct snd_usb_endpoint *ep = subs->data_endpoint;
 
-		dev_dbg(&subs->dev->dev, "Starting data EP @%p\n", ep);
+		dev_dbg(&subs->dev->dev, "Starting data EP 0x%x\n", ep->ep_num);
 
 		ep->data_subs = subs;
 		err = snd_usb_endpoint_start(ep);
@@ -232,7 +232,7 @@ static int start_endpoints(struct snd_usb_substream *subs)
 	    !test_and_set_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags)) {
 		struct snd_usb_endpoint *ep = subs->sync_endpoint;
 
-		dev_dbg(&subs->dev->dev, "Starting sync EP @%p\n", ep);
+		dev_dbg(&subs->dev->dev, "Starting sync EP 0x%x\n", ep->ep_num);
 
 		ep->sync_slave = subs->data_endpoint;
 		err = snd_usb_endpoint_start(ep);
@@ -255,12 +255,17 @@ static void sync_pending_stops(struct snd_usb_substream *subs)
 static void stop_endpoints(struct snd_usb_substream *subs)
 {
 	if (test_and_clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags)) {
+		dev_dbg(&subs->dev->dev, "Stopping sync EP 0x%x\n",
+			subs->sync_endpoint->ep_num);
 		snd_usb_endpoint_stop(subs->sync_endpoint);
 		subs->sync_endpoint->sync_slave = NULL;
 	}
 
-	if (test_and_clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags))
+	if (test_and_clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags)) {
+		dev_dbg(&subs->dev->dev, "Stopping data EP 0x%x\n",
+			subs->data_endpoint->ep_num);
 		snd_usb_endpoint_stop(subs->data_endpoint);
+	}
 }
 
 /* PCM sync_stop callback */
-- 
2.16.4

