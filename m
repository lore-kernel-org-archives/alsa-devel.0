Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2326CC4321E
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 13:22:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66D9C17F0;
	Mon,  5 Dec 2022 14:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66D9C17F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670246545;
	bh=O3Xuifm3408NaRph+0QLbjYAPtAN+r/LZE8d1OnwVCw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AwO7Fo3wmvBdFEUyS1ETlD70qlcsxJgLl8f7JQ2OsAl68F5lj/oGWNPqXwuNzFbZ7
	 hRriHR3nsapvsiO9Ro1p7E6HVArND1cP/DG3YErc5zGlyKsZ1Oos8MlxelwEea5zHN
	 gGsvtf+DEsb9IKigRznN8VjszrL3GNkd6LCrYxJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18C66F80171;
	Mon,  5 Dec 2022 14:21:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0A39F8049E; Mon,  5 Dec 2022 14:21:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26EBAF800BD
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 14:21:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26EBAF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="DIA8h7i+"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="znx1Zl2f"
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DF8422622;
 Mon,  5 Dec 2022 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670246487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9bcg7EmxxzeLf6cduZG8Zb1DZo7TSFfgvxJ7pUe8Eo=;
 b=DIA8h7i+0qzMEI5AcTb1oNDJyEUPQNWpoTRKTRWzzp6J42aF2YLfB83Krw76sijD084sX6
 bAPNKYI7gK850PKdXs7Wt/eBEkHKs7ofGpRTGgKs7qsWROzbktTI1ulbZWox+PX5ZO9Mos
 aVe+2iCkLOc0TJMSWrG3b3rSO64BryM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670246487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9bcg7EmxxzeLf6cduZG8Zb1DZo7TSFfgvxJ7pUe8Eo=;
 b=znx1Zl2f3R2XPiNc1Nv1K9+h8cAqa6bXP/2jjcQXw+531iWEEX7eAzbpdGM93WBWfd3tOx
 Pl86vLe1hH/DU3AA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 76B881369C;
 Mon,  5 Dec 2022 13:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id uDRgHFfwjWOZagAAGKfGzw
 (envelope-from <tiwai@suse.de>); Mon, 05 Dec 2022 13:21:27 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ALSA: usb-audio: Workaround for XRUN at prepare
Date: Mon,  5 Dec 2022 14:21:24 +0100
Message-Id: <20221205132124.11585-4-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205132124.11585-1-tiwai@suse.de>
References: <20221205132124.11585-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Carl Hetherington <lists@carlh.net>
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

Under certain situations (typically in the implicit feedback mode),
USB-audio driver starts a playback stream already at PCM prepare call
even before the actual PCM trigger-START call.  For implicit feedback
mode, this effectively starts two streams for data and sync
endpoints, and if a coupled sync stream gets XRUN at this point, it
results in an error -EPIPE.

The problem is that currently we return -EPIPE error as is from the
prepare.  Then application tries to recover again via the prepare
call, but it'll fail again because the sync-stop is missing.  The
sync-stop is missing because it's an internal trigger call (hence the
PCM core isn't involved).

Since we'll need to re-issue the prepare in anyway when trapped into
this pitfall, this patch attempts to address it in a bit different
way; namely, the driver tries to prepare once again after syncing the
stop manually by itself -- so applications don't see the internal
error.  At the second failure, we report the error as is, but this
shouldn't happen in normal situations.

Reported-and-tested-by: Carl Hetherington <lists@carlh.net>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/b4e71631-4a94-613-27b2-fb595792630@carlh.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8ed165f036a0..9557bd4d1bbc 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -604,6 +604,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_usb_substream *subs = runtime->private_data;
 	struct snd_usb_audio *chip = subs->stream->chip;
+	int retry = 0;
 	int ret;
 
 	ret = snd_usb_lock_shutdown(chip);
@@ -614,6 +615,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
+ again:
 	if (subs->sync_endpoint) {
 		ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
 		if (ret < 0)
@@ -638,9 +640,16 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 
 	subs->lowlatency_playback = lowlatency_playback_available(runtime, subs);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    !subs->lowlatency_playback)
+	    !subs->lowlatency_playback) {
 		ret = start_endpoints(subs);
-
+		/* if XRUN happens at starting streams (possibly with implicit
+		 * fb case), restart again, but only try once.
+		 */
+		if (ret == -EPIPE && !retry++) {
+			sync_pending_stops(subs);
+			goto again;
+		}
+	}
  unlock:
 	snd_usb_unlock_shutdown(chip);
 	return ret;
-- 
2.35.3

