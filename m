Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A4C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 08:59:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3281020731
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d/Nf+0mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3281020731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 942FA1693;
	Mon, 23 Nov 2020 09:58:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 942FA1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606121954;
	bh=xsB/jsjf7Aon/wFPbUsmCnEu5AxktczKTY+btqmVrbs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/Nf+0mhCMK/MA1Yx8BKpOIDF9K67VBsfom7agY2/jvx5gYlH4BZSSzcJ4pG2nybp
	 l4VRuREbbF0HHXBJ1qrd/vlQaLzUnjT4APv49eiQSEDqHspMf3bqYrBvzyBQ4+6rIs
	 3lLolYJK46PStFcNB1EAVfFf9OlO59vC2kA/qYbk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D677AF80537;
	Mon, 23 Nov 2020 09:54:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1127F80525; Mon, 23 Nov 2020 09:54:16 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4483DF804BD
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:53:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4483DF804BD
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9B5ECAFAB;
 Mon, 23 Nov 2020 08:53:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/41] ALSA: usb-audio: Avoid doubly initialization for
 implicit fb
Date: Mon, 23 Nov 2020 09:53:19 +0100
Message-Id: <20201123085347.19667-14-tiwai@suse.de>
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

The implicit feedback mode initializes both the main data stream and
the sync data stream.  When a sync stream was already opened, this
would result in the doubly initialization and might screw up things.

Add the check of already opened sync streams and skip the unnecessary
initialization.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d83a6a6ac023..8ae7d2fdba0d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -601,8 +601,9 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
-	if (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
-	    subs->data_endpoint->altsetting != subs->sync_endpoint->altsetting) {
+	if (!subs->sync_endpoint->use_count &&
+	    (subs->data_endpoint->iface != subs->sync_endpoint->iface ||
+	     subs->data_endpoint->altsetting != subs->sync_endpoint->altsetting)) {
 		err = usb_set_interface(subs->dev,
 					subs->sync_endpoint->iface,
 					subs->sync_endpoint->altsetting);
@@ -625,6 +626,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	struct usb_device *dev = subs->dev;
 	struct usb_host_interface *alts;
 	struct usb_interface *iface;
+	struct snd_usb_endpoint *ep;
 	int err;
 
 	iface = usb_ifnum_to_if(dev, fmt->iface);
@@ -637,6 +639,14 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (fmt == subs->cur_audiofmt && !subs->need_setup_fmt)
 		return 0;
 
+	/* shared EP with implicit fb */
+	if (fmt->implicit_fb && !subs->need_setup_fmt) {
+		ep = snd_usb_get_endpoint(subs->stream->chip, fmt->endpoint,
+					  fmt->iface, fmt->altsetting);
+		if (ep && ep->use_count > 0)
+			goto add_data_ep;
+	}
+
 	/* close the old interface */
 	if (subs->interface >= 0 && (subs->interface != fmt->iface || subs->need_setup_fmt)) {
 		if (!subs->stream->chip->keep_iface) {
@@ -673,6 +683,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		snd_usb_set_interface_quirk(dev);
 	}
 
+	subs->need_setup_ep = true;
+
+ add_data_ep:
 	subs->interface = fmt->iface;
 	subs->altset_idx = fmt->altset_idx;
 	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
@@ -686,9 +699,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (err < 0)
 		return err;
 
-	err = snd_usb_init_pitch(subs->stream->chip, fmt->iface, alts, fmt);
-	if (err < 0)
-		return err;
+	if (subs->need_setup_ep) {
+		err = snd_usb_init_pitch(subs->stream->chip, fmt->iface, alts, fmt);
+		if (err < 0)
+			return err;
+	}
 
 	subs->cur_audiofmt = fmt;
 
@@ -940,10 +955,6 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		goto unlock;
 
-	subs->interface = fmt->iface;
-	subs->altset_idx = fmt->altset_idx;
-	subs->need_setup_ep = true;
-
  unlock:
 	snd_usb_unlock_shutdown(subs->stream->chip);
 	if (ret < 0)
-- 
2.16.4

