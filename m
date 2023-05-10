Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7530BC7EE22
	for <alsa-devel@archiver.kernel.org>; Wed, 10 May 2023 16:31:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35CC51040;
	Wed, 10 May 2023 18:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35CC51040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683736261;
	bh=uFRBIsM4eywiSjqAUUBMHvvTFGynTDjRsYjOaenNnvc=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZZqw21ySabxhzNal0mzyQ96yg2kiLZmfEE6cDJ/RZckmLSErnr8YPE2MiMhtk1tO+
	 /XqSTY7YxrdgyogwdVSZXoY2c/FszC4bVZmK6rGXvK4XFDnUK7lYq7LcCy3UxxstW0
	 8iBzx1bwMcRUJ8+1ilouDsJNXclixb+YFrJCGOD8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E93ABF8053B;
	Wed, 10 May 2023 18:29:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 686F7F8053B; Wed, 10 May 2023 18:29:39 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AE831F802E8
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2023 18:29:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE831F802E8
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 816CC20081;
	Wed, 10 May 2023 12:29:24 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pwmgu-r2Y-00; Wed, 10 May 2023 18:29:24 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3] ALSA: pcm: auto-fill buffer with silence when draining
 playback
Date: Wed, 10 May 2023 18:29:24 +0200
Message-Id: <20230510162924.3063817-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: G5VANGBU246QLWSK2AJOTVKA7QPHTLAA
X-Message-ID-Hash: G5VANGBU246QLWSK2AJOTVKA7QPHTLAA
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G5VANGBU246QLWSK2AJOTVKA7QPHTLAA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Draining will always playback somewhat beyond the end of the filled
buffer. This would produce artifacts if the user did not set up the
auto-silencing machinery, which is an extremely easy mistake to make, as
the API strongly suggests convenient fire-and-forget semantics. This
patch makes it work out of the box.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
you are NOT expected to apply this. i just needed it for my testing
(it's easier to deploy as i'm hacking on the kernel anyway) and wanted
to post it for posterity.

v3:
- rebased to updated silencing code
- intro period alignment to reduce redundant fill
- cut down commit message again, as it's disabled by default now
v2:
- fill only up to two periods, to avoid undue load with big buffers
- added discussion to commit message
---
 sound/core/pcm_lib.c    | 35 ++++++++++++++++++++++++++++++++++-
 sound/core/pcm_native.c |  3 ++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9c121a921b04..46e63e653789 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -67,6 +67,11 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 	snd_pcm_uframes_t frames, ofs, transfer;
 	int err;
 
+	if (runtime->silence_size == 0 &&
+	    (runtime->state != SNDRV_PCM_STATE_DRAINING ||
+	     (runtime->info & SNDRV_PCM_HW_PARAMS_NO_DRAIN_SILENCE) ||
+	     (runtime->hw.info & SNDRV_PCM_INFO_PERFECT_DRAIN)))
+		return;
 	if (runtime->silence_size < runtime->boundary) {
 		snd_pcm_sframes_t noise_dist;
 		snd_pcm_uframes_t appl_ptr = READ_ONCE(runtime->control->appl_ptr);
@@ -80,6 +85,33 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 			noise_dist += runtime->boundary;
 		/* total noise distance */
 		noise_dist += runtime->silence_filled;
+		if (runtime->state == SNDRV_PCM_STATE_DRAINING) {
+			snd_pcm_uframes_t slack = runtime->rate / 10;
+			snd_pcm_sframes_t threshold;
+			snd_pcm_uframes_t ps = runtime->period_size;
+			snd_pcm_uframes_t silence_size = ps;
+			// Round down to start of next period. This is disabled
+			// if the period count is not integer.
+			if (runtime->periods * ps == runtime->buffer_size)
+				silence_size = ps - (appl_ptr + ps - 1) % ps - 1;
+			// Add overshoot to accomodate FIFOs and IRQ delays.
+			// The default 1/10th secs is very generous. But more than one
+			// period doesn't make sense; the driver would set the minimum
+			// period size accordingly.
+			slack = min(slack, ps);
+			silence_size += slack;
+			// This catches the periods == 1 case.
+			silence_size = min(silence_size, runtime->buffer_size);
+
+			threshold = ps + slack;
+			if (noise_dist >= threshold)
+				return;
+			frames = threshold - noise_dist;
+			if (frames > silence_size)
+				frames = silence_size;
+
+			goto avoid_reindent;
+		}
 		if (noise_dist >= (snd_pcm_sframes_t) runtime->silence_threshold)
 			return;
 		frames = runtime->silence_threshold - noise_dist;
@@ -118,6 +150,7 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
 		 */
 		frames = runtime->buffer_size - runtime->silence_filled;
 	}
+avoid_reindent:
 	if (snd_BUG_ON(frames > runtime->buffer_size))
 		return;
 	if (frames == 0)
@@ -465,7 +498,7 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    runtime->silence_size > 0)
+	    (runtime->silence_size > 0 || runtime->state == SNDRV_PCM_STATE_DRAINING))
 		snd_pcm_playback_silence(substream, new_hw_ptr);
 
 	if (in_interrupt) {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 39a65d1415ab..913dae449ba0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1454,7 +1454,7 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream,
 							    runtime->rate;
 	__snd_pcm_set_state(runtime, state);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    runtime->silence_size > 0)
+	    (runtime->silence_size > 0 || state == SNDRV_PCM_STATE_DRAINING))
 		snd_pcm_playback_silence(substream, ULONG_MAX);
 	snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTART);
 }
@@ -2045,6 +2045,7 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream,
 			break;
 		case SNDRV_PCM_STATE_RUNNING:
 			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_DRAINING);
+			snd_pcm_playback_silence(substream, ULONG_MAX);
 			break;
 		case SNDRV_PCM_STATE_XRUN:
 			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
-- 
2.40.0.152.g15d061e6df

