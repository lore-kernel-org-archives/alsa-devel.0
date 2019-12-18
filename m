Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB228C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:28:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432F424650
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NnGu8DlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432F424650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C29E1670;
	Wed, 18 Dec 2019 14:27:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C29E1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576675701;
	bh=3zqFtXn5mxlPKaEmivO2Ba8cGwwGN8oDuezL/gbirrw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NnGu8DlJzaoE0AYnm3mbPFOWnswHWWfwhI/LAAO01xXxhqNWGL8QKf6Ah5regs2wA
	 RMjbKapMJ81igaZa2csnmUTJj7CIbTmViO19Vy/BNrfhUT/QiDjfe4RQ+n8Py0hvog
	 PPKlqk1KSE5I+rAHlcnkXUo0icQW+wKujrNH2vfQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C0C9F80269;
	Wed, 18 Dec 2019 14:27:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FD8FF8026A; Wed, 18 Dec 2019 14:27:16 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE706F80059
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 14:27:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE706F80059
Received: from [123.114.41.248] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1ihZM7-0003N1-D6; Wed, 18 Dec 2019 13:27:12 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Date: Wed, 18 Dec 2019 21:26:50 +0800
Message-Id: <20191218132650.6303-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: set the interface format
	after resume on Dell WD19
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

Recently we found the headset-mic on the Dell Dock WD19 doesn't work
anymore after s3 (s2i or deep), this problem could be workarounded by
closeing (pcm_close) the app and then reopening (pcm_open) the app, so
this bug is not easy to be detected by users.

When problem happens, retire_capture_urb() could still be called
periodically, but the size of captured data is always 0, it could be
a firmware bug on the dock. Anyway I found after resuming, the
snd_usb_pcm_prepare() will be called, and if we forcibly run
set_format() to set the interface and its endpoint, the capture
size will be normal again. This problem and workaound also apply to
playback.

To fix it in the kernel, add a quirk to let set_format() run
forcibly once after resume.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/usb/card.h         |  1 +
 sound/usb/pcm.c          | 21 +++++++++++++++++++--
 sound/usb/quirks-table.h |  3 ++-
 sound/usb/quirks.c       | 11 +++++++++++
 sound/usb/usbaudio.h     |  3 ++-
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 2991b9986f66..395403a2d33f 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -145,6 +145,7 @@ struct snd_usb_substream {
 	struct snd_usb_endpoint *sync_endpoint;
 	unsigned long flags;
 	bool need_setup_ep;		/* (re)configure EP at prepare? */
+	bool need_setup_fmt;		/* (re)configure fmt after resume? */
 	unsigned int speed;		/* USB_SPEED_XXX */
 
 	u64 formats;			/* format bitmasks (all or'ed) */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8a52996041e9..4ac571b2e9a6 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -523,11 +523,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (WARN_ON(altsd->bAlternateSetting != fmt->altsetting))
 		return -EINVAL;
 
-	if (fmt == subs->cur_audiofmt)
+	if (fmt == subs->cur_audiofmt && !subs->need_setup_fmt)
 		return 0;
 
 	/* close the old interface */
-	if (subs->interface >= 0 && subs->interface != fmt->iface) {
+	if (subs->interface >= 0 && (subs->interface != fmt->iface || subs->need_setup_fmt)) {
 		if (!subs->stream->chip->keep_iface) {
 			err = usb_set_interface(subs->dev, subs->interface, 0);
 			if (err < 0) {
@@ -541,6 +541,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		subs->altset_idx = 0;
 	}
 
+	if (subs->need_setup_fmt)
+		subs->need_setup_fmt = false;
+
 	/* set interface */
 	if (iface->cur_altsetting != alts) {
 		err = snd_usb_select_mode_quirk(subs, fmt);
@@ -1734,6 +1737,13 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		subs->data_endpoint->retire_data_urb = retire_playback_urb;
 		subs->running = 0;
 		return 0;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (subs->stream->chip->setup_fmt_after_resume_quirk) {
+			stop_endpoints(subs, true);
+			subs->need_setup_fmt = true;
+			return 0;
+		}
+		break;
 	}
 
 	return -EINVAL;
@@ -1766,6 +1776,13 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->data_endpoint->retire_data_urb = retire_capture_urb;
 		subs->running = 1;
 		return 0;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (subs->stream->chip->setup_fmt_after_resume_quirk) {
+			stop_endpoints(subs, true);
+			subs->need_setup_fmt = true;
+			return 0;
+		}
+		break;
 	}
 
 	return -EINVAL;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 70c338f3ae24..d187aa6d50db 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3466,7 +3466,8 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		.vendor_name = "Dell",
 		.product_name = "WD19 Dock",
 		.profile_name = "Dell-WD15-Dock",
-		.ifnum = QUIRK_NO_INTERFACE
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_SETUP_FMT_AFTER_RESUME
 	}
 },
 /* MOTU Microbook II */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 349e1e52996d..a81c2066499f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -508,6 +508,16 @@ static int create_standard_mixer_quirk(struct snd_usb_audio *chip,
 	return snd_usb_create_mixer(chip, quirk->ifnum, 0);
 }
 
+
+static int setup_fmt_after_resume_quirk(struct snd_usb_audio *chip,
+				       struct usb_interface *iface,
+				       struct usb_driver *driver,
+				       const struct snd_usb_audio_quirk *quirk)
+{
+	chip->setup_fmt_after_resume_quirk = 1;
+	return 1;	/* Continue with creating streams and mixer */
+}
+
 /*
  * audio-interface quirks
  *
@@ -546,6 +556,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
+		[QUIRK_SETUP_FMT_AFTER_RESUME] = setup_fmt_after_resume_quirk,
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index ff3cbf653de8..6fe3ab582ec6 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -33,7 +33,7 @@ struct snd_usb_audio {
 	wait_queue_head_t shutdown_wait;
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 	unsigned int tx_length_quirk:1; /* Put length specifier in transfers */
-	
+	unsigned int setup_fmt_after_resume_quirk:1; /* setup the format to interface after resume */
 	int num_interfaces;
 	int num_suspended_intf;
 	int sample_rate_read_error;
@@ -98,6 +98,7 @@ enum quirk_type {
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
 	QUIRK_AUDIO_STANDARD_MIXER,
+	QUIRK_SETUP_FMT_AFTER_RESUME,
 
 	QUIRK_TYPE_COUNT
 };
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
