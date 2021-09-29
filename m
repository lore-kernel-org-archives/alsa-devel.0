Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8CC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 08:11:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A65610CC
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 08:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54A65610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6F7B16BB;
	Wed, 29 Sep 2021 10:10:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6F7B16BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632903108;
	bh=Fkm0CcHls22WyBGnw4lS0st9TKBVOmACthgcQwdNM5E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vGkS5Wv6zrVO7vg1JaztAwQFmxQq107sz+lqjwz2ENcxJtOTYfF/y8z18UdaWsDWF
	 UqyXYtAFLBKB5cq8ZHO9NWC4/xKXL3fnkUCApcM3MAMFfn7qMhHbpqbRdIbUypMGcb
	 BB7kE7TLLHcHGe0iCmUVA7DT1sB/0IFHe9X7dOEM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0045F80508;
	Wed, 29 Sep 2021 10:09:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0608F804F1; Wed, 29 Sep 2021 10:09:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3400F80301
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 10:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3400F80301
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="0Eq1879n"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="6JbzT9qJ"
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out2.suse.de (Postfix) with ESMTP id C05B0202F7
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 08:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632902928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zk++28ud6DZ4PZ5Vl6zKc3iF9c1skEicitVtfEO4ZhI=;
 b=0Eq1879nxeLK+0Z5J4KqsnOz2bAWeL5w7QEYsNQHHGv6RNonLjehTbyARuU8CkW+Rs6vod
 5FDZz08JKj7OV8aRh1B2MN17U14THffRTWbap3DlWYCth/u6luT05bRA3LZpx2GmKMBi6U
 p4HRuS+1MS4xJYQGdU4GAn5A39fdROU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632902928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zk++28ud6DZ4PZ5Vl6zKc3iF9c1skEicitVtfEO4ZhI=;
 b=6JbzT9qJ7eayhTyFJ3l+PtpTbQYxLX1OEkd0OgWIN/YeNMLByjBzv+4ZV7bOCfXG2kse8V
 QciidgPSxBPT25BA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay1.suse.de (Postfix) with ESMTP id AFE7525D6E;
 Wed, 29 Sep 2021 08:08:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/9] ALSA: usb-audio: Rename early_playback_start flag with
 lowlatency_playback
Date: Wed, 29 Sep 2021 10:08:38 +0200
Message-Id: <20210929080844.11583-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210929080844.11583-1-tiwai@suse.de>
References: <20210929080844.11583-1-tiwai@suse.de>
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

This is a preparation patch for the upcoming low-latency improvement
changes.

Rename early_playback_start flag with lowlatency_playback as it's more
intuitive.  The new flag is basically a reverse meaning.

Along with the rename, factor out the code to set the flag to a
function.  This makes the complex condition checks simpler.

Also, the same flag is introduced to snd_usb_endpoint, too, that is
carried from the snd_usb_substream flag.  Currently the endpoint flag
isn't still referred, but will be used in later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.h     |  3 ++-
 sound/usb/endpoint.c |  4 ++++
 sound/usb/pcm.c      | 29 ++++++++++++++++++++---------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 746a765b2437..a00caa1db37e 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -126,6 +126,7 @@ struct snd_usb_endpoint {
 	int skip_packets;		/* quirks for devices to ignore the first n packets
 					   in a stream */
 	bool implicit_fb_sync;		/* syncs with implicit feedback */
+	bool lowlatency_playback;	/* low-latency playback mode */
 	bool need_setup;		/* (re-)need for configure? */
 
 	/* for hw constraints */
@@ -190,7 +191,7 @@ struct snd_usb_substream {
 	} dsd_dop;
 
 	bool trigger_tstamp_pending_update; /* trigger timestamp being updated from initial estimate */
-	bool early_playback_start;	/* early start needed for playback? */
+	bool lowlatency_playback;	/* low-latency playback mode */
 	struct media_ctl *media_ctl;
 };
 
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 06241568abf7..8e164d71d9ac 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -794,6 +794,10 @@ void snd_usb_endpoint_set_callback(struct snd_usb_endpoint *ep,
 {
 	ep->prepare_data_urb = prepare;
 	ep->retire_data_urb = retire;
+	if (data_subs)
+		ep->lowlatency_playback = data_subs->lowlatency_playback;
+	else
+		ep->lowlatency_playback = false;
 	WRITE_ONCE(ep->data_subs, data_subs);
 }
 
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 19392117de9e..4dd7f1c9e2af 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -581,6 +581,22 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+/* check whether early start is needed for playback stream */
+static int lowlatency_playback_available(struct snd_usb_substream *subs)
+{
+	struct snd_usb_audio *chip = subs->stream->chip;
+
+	if (subs->direction == SNDRV_PCM_STREAM_CAPTURE)
+		return false;
+	/* disabled via module option? */
+	if (!chip->lowlatency)
+		return false;
+	/* too short periods? */
+	if (subs->data_endpoint->nominal_queue_size >= subs->buffer_bytes)
+		return false;
+	return true;
+}
+
 /*
  * prepare callback
  *
@@ -614,13 +630,8 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->period_elapsed_pending = 0;
 	runtime->delay = 0;
 
-	/* check whether early start is needed for playback stream */
-	subs->early_playback_start =
-		subs->direction == SNDRV_PCM_STREAM_PLAYBACK &&
-		(!chip->lowlatency ||
-		 (subs->data_endpoint->nominal_queue_size >= subs->buffer_bytes));
-
-	if (subs->early_playback_start)
+	subs->lowlatency_playback = lowlatency_playback_available(subs);
+	if (!subs->lowlatency_playback)
 		ret = start_endpoints(subs);
 
  unlock:
@@ -1412,7 +1423,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 		subs->trigger_tstamp_pending_update = false;
 	}
 
-	if (period_elapsed && !subs->running && !subs->early_playback_start) {
+	if (period_elapsed && !subs->running && subs->lowlatency_playback) {
 		subs->period_elapsed_pending = 1;
 		period_elapsed = 0;
 	}
@@ -1466,7 +1477,7 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 					      prepare_playback_urb,
 					      retire_playback_urb,
 					      subs);
-		if (!subs->early_playback_start &&
+		if (subs->lowlatency_playback &&
 		    cmd == SNDRV_PCM_TRIGGER_START) {
 			err = start_endpoints(subs);
 			if (err < 0) {
-- 
2.26.2

