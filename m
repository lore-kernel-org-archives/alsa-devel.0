Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A32FC2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:04:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6847020732
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="azbGCV9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6847020732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D910216C0;
	Mon, 23 Nov 2020 10:03:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D910216C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122255;
	bh=iIflz33mnJKdkJ8vKIm6Rhk5ymd17CPrwWDh91AaeIc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=azbGCV9vhZP/xVgmUFZkr8hJzjgWRR0EGXK6tmFX3qr9/G/+2TyHYG0LBtX9oFoZR
	 Di6zvtKdsY+qdV77Vq5pcmxWE3jr2If37OjGJ5lyVGk0218MIXgUectn6upG1FkkwE
	 UArNpaJlIRQ1vkQo5tBClVSVIFUlIbq5B7tQHJvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B2D1F805AA;
	Mon, 23 Nov 2020 09:55:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 774FEF804DF; Mon, 23 Nov 2020 09:54:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DF68F804E3
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DF68F804E3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DCEEAAFBF;
 Mon, 23 Nov 2020 08:53:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 18/41] ALSA: usb-audio: Pass snd_usb_audio object to quirk
 functions
Date: Mon, 23 Nov 2020 09:53:24 +0100
Message-Id: <20201123085347.19667-19-tiwai@suse.de>
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

A preliminary patch for the later big change.  Just a minor code
refactoring.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c  |  4 ++--
 sound/usb/pcm.c    | 17 +++++++++--------
 sound/usb/quirks.c | 10 ++++------
 sound/usb/quirks.h |  4 ++--
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index f174230d07d5..3298a654ce96 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -658,9 +658,9 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 	 * interface is active. */
 	if (rate != prev_rate) {
 		usb_set_interface(dev, iface, 0);
-		snd_usb_set_interface_quirk(dev);
+		snd_usb_set_interface_quirk(chip);
 		usb_set_interface(dev, iface, fmt->altsetting);
-		snd_usb_set_interface_quirk(dev);
+		snd_usb_set_interface_quirk(chip);
 	}
 
 validation:
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b0961ebd71f4..2518d4c82ad5 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -553,6 +553,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 {
 	struct usb_device *dev = subs->dev;
 	struct usb_host_interface *alts;
+	struct snd_usb_audio *chip = subs->stream->chip;
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ep;
 	int err;
@@ -569,7 +570,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	if (!alts)
 		return 0;
 
-	subs->sync_endpoint = snd_usb_get_endpoint(subs->stream->chip, ep);
+	subs->sync_endpoint = snd_usb_get_endpoint(chip, ep);
 	if (!subs->sync_endpoint) {
 		if (is_playback &&
 		    (fmt->ep_attr & USB_ENDPOINT_SYNCTYPE) == USB_ENDPOINT_SYNC_NONE)
@@ -596,7 +597,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 		dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
 			subs->sync_endpoint->iface,
 			subs->sync_endpoint->altsetting);
-		snd_usb_set_interface_quirk(dev);
+		snd_usb_set_interface_quirk(chip);
 	}
 
 	return 0;
@@ -608,6 +609,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 {
 	struct usb_device *dev = subs->dev;
+	struct snd_usb_audio *chip = subs->stream->chip;
 	struct usb_host_interface *alts;
 	struct usb_interface *iface;
 	struct snd_usb_endpoint *ep;
@@ -625,7 +627,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
 	/* shared EP with implicit fb */
 	if (fmt->implicit_fb && !subs->need_setup_fmt) {
-		ep = snd_usb_get_endpoint(subs->stream->chip, fmt->endpoint);
+		ep = snd_usb_get_endpoint(chip, fmt->endpoint);
 		if (ep && ep->use_count > 0)
 			goto add_data_ep;
 	}
@@ -648,7 +650,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
 	/* set interface */
 	if (iface->cur_altsetting != alts) {
-		err = snd_usb_select_mode_quirk(subs, fmt);
+		err = snd_usb_select_mode_quirk(chip, fmt);
 		if (err < 0)
 			return -EIO;
 
@@ -661,7 +663,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
 			fmt->iface, fmt->altsetting);
-		snd_usb_set_interface_quirk(dev);
+		snd_usb_set_interface_quirk(chip);
 	}
 
 	subs->need_setup_ep = true;
@@ -669,8 +671,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
  add_data_ep:
 	subs->interface = fmt->iface;
 	subs->altset_idx = fmt->altset_idx;
-	subs->data_endpoint = snd_usb_get_endpoint(subs->stream->chip,
-						   fmt->endpoint);
+	subs->data_endpoint = snd_usb_get_endpoint(chip, fmt->endpoint);
 	if (!subs->data_endpoint)
 		return -EINVAL;
 	subs->data_endpoint->iface = fmt->iface;
@@ -681,7 +682,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		return err;
 
 	if (subs->need_setup_ep) {
-		err = snd_usb_init_pitch(subs->stream->chip, fmt->iface, alts, fmt);
+		err = snd_usb_init_pitch(chip, fmt->iface, alts, fmt);
 		if (err < 0)
 			return err;
 	}
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index c50be2f75f70..bb4c1ae0a4a7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1553,13 +1553,13 @@ static bool is_itf_usb_dsd_dac(unsigned int id)
 	return false;
 }
 
-int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
+int snd_usb_select_mode_quirk(struct snd_usb_audio *chip,
 			      struct audioformat *fmt)
 {
-	struct usb_device *dev = subs->dev;
+	struct usb_device *dev = chip->dev;
 	int err;
 
-	if (is_itf_usb_dsd_dac(subs->stream->chip->usb_id)) {
+	if (is_itf_usb_dsd_dac(chip->usb_id)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1622,10 +1622,8 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 		ep->tenor_fb_quirk = 1;
 }
 
-void snd_usb_set_interface_quirk(struct usb_device *dev)
+void snd_usb_set_interface_quirk(struct snd_usb_audio *chip)
 {
-	struct snd_usb_audio *chip = dev_get_drvdata(&dev->dev);
-
 	if (!chip)
 		return;
 	/*
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index c76cf24a640a..011f22cf2bf6 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -35,12 +35,12 @@ int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 
 void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep);
 
-void snd_usb_set_interface_quirk(struct usb_device *dev);
+void snd_usb_set_interface_quirk(struct snd_usb_audio *chip);
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size);
 
-int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
+int snd_usb_select_mode_quirk(struct snd_usb_audio *chip,
 			      struct audioformat *fmt);
 
 u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
-- 
2.16.4

