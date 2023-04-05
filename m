Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6B8C76188
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Apr 2023 20:15:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF8CB1E3;
	Wed,  5 Apr 2023 22:15:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF8CB1E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680725750;
	bh=h+zmd3FPSugrnOxMxSg5JCfi/td+IImY9ZE0rihFXzA=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DucCnoV2jMuz+luv312GDLk5qGsXIH7ff1Ycs/U1Ra9ZavbhYDxLAwGQdZk+11v1F
	 3ppLzMg5R4oSRJikGj5W9zr6xdhEz9eWuCShoHRlphKOLwl3wiQ0/Sfalwu0wdxIgm
	 lkU9GMFNv8QGM2MFntdsGSqScWZCTLs//96HDA4k=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F2A3F8057D;
	Wed,  5 Apr 2023 22:12:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E9B4F80563; Wed,  5 Apr 2023 22:12:45 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1E092F8052D
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2023 22:12:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E092F8052D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E647C2420C
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2023 16:12:19 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pk9UR-Dk7-00
	for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2023 22:12:19 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: fix wait_time calculations
Date: Wed,  5 Apr 2023 22:12:19 +0200
Message-Id: <20230405201219.2197774-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7WMT7AMADE6D2CU7XSOPC37CLN6DI5U4
X-Message-ID-Hash: 7WMT7AMADE6D2CU7XSOPC37CLN6DI5U4
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7WMT7AMADE6D2CU7XSOPC37CLN6DI5U4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

... in wait_for_avail() and snd_pcm_drain().

t was calculated in seconds, so it would be pretty much always zero, to
be subsequently de-facto ignored due to being max(t, 10)'d. And then it
(i.e., 10) would be treated as secs, which doesn't seem right.

However, fixing it to properly calculate msecs would potentially cause
timeouts when using twice the period size for the default timeout (which
seems reasonable to me), so instead use the buffer size plus 10 percent
to be on the safe side ... but that still seems insufficient, presumably
because the hardware typically needs a moment to fire up. To compensate
for this, we up the minimal timeout to 100ms, which is still two orders
of magnitude less than the bogus minimum.

substream->wait_time was also misinterpreted as jiffies, despite being
documented as being in msecs. Only the soc/sof driver sets it - to 500,
which looks very much like msecs were intended.

Speaking of which, shouldn't snd_pcm_drain() also use substream->
wait_time?

As a drive-by, make the debug messages on timeout less confusing.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 sound/core/pcm_lib.c    | 11 +++++------
 sound/core/pcm_native.c |  8 ++++----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 02fd65993e7e..af1eb136feb0 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1878,15 +1878,14 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		if (substream->wait_time) {
 			wait_time = substream->wait_time;
 		} else {
-			wait_time = 10;
+			wait_time = 100;
 
 			if (runtime->rate) {
-				long t = runtime->period_size * 2 /
-					 runtime->rate;
+				long t = runtime->buffer_size * 1100 / runtime->rate;
 				wait_time = max(t, wait_time);
 			}
-			wait_time = msecs_to_jiffies(wait_time * 1000);
 		}
+		wait_time = msecs_to_jiffies(wait_time);
 	}
 
 	for (;;) {
@@ -1934,8 +1933,8 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		}
 		if (!tout) {
 			pcm_dbg(substream->pcm,
-				"%s write error (DMA or IRQ trouble?)\n",
-				is_playback ? "playback" : "capture");
+				"%s timeout (DMA or IRQ trouble?)\n",
+				is_playback ? "playback write" : "capture read");
 			err = -EIO;
 			break;
 		}
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 331380c2438b..94185267a7b9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2159,12 +2159,12 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		if (runtime->no_period_wakeup)
 			tout = MAX_SCHEDULE_TIMEOUT;
 		else {
-			tout = 10;
+			tout = 100;
 			if (runtime->rate) {
-				long t = runtime->period_size * 2 / runtime->rate;
+				long t = runtime->buffer_size * 1100 / runtime->rate;
 				tout = max(t, tout);
 			}
-			tout = msecs_to_jiffies(tout * 1000);
+			tout = msecs_to_jiffies(tout);
 		}
 		tout = schedule_timeout(tout);
 
@@ -2187,7 +2187,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 				result = -ESTRPIPE;
 			else {
 				dev_dbg(substream->pcm->card->dev,
-					"playback drain error (DMA or IRQ trouble?)\n");
+					"playback drain timeout (DMA or IRQ trouble?)\n");
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 				result = -EIO;
 			}
-- 
2.40.0.152.g15d061e6df

