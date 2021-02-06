Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403B1C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:39:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D7564E52
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D7564E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03C39167B;
	Sat,  6 Feb 2021 21:38:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03C39167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612643957;
	bh=/yKY5ERVbDYXP8wPoEg9P6SRBjKflT0BK2YoxuKxr9k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3J2x9YWJF2qG1tXbvyXzwgmJuv6tm6J9+Q22E7rl8Utwzqu2hIcOvr4UQQP4Jojj
	 2sqtyLre3im+IhQl04uxQDqGJ9neIIG/OOqmB8ChN8e2Rem7JnM0WGKd3ztQh+UDMI
	 VproEd5t1HgOjGvFLqA/OI2109K9t+xfOqept4xM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00235F80139;
	Sat,  6 Feb 2021 21:37:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B52F7F8021C; Sat,  6 Feb 2021 21:37:34 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2FF5F8021C
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 21:37:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2FF5F8021C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2020BAE47
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 20:37:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ALSA: pcm: Use for_each_pcm_substream() macro
Date: Sat,  6 Feb 2021 21:36:56 +0100
Message-Id: <20210206203656.15959-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206203656.15959-1-tiwai@suse.de>
References: <20210206203656.15959-1-tiwai@suse.de>
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

There are a few places doing the same loop iterating all PCM
substreams belonging to the PCM object.  Introduce a local helper
macro, for_each_pcm_substream(), to simplify the code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c        | 29 +++++++++++++----------------
 sound/core/pcm_local.h  |  6 ++++++
 sound/core/pcm_memory.c | 12 ++++--------
 sound/core/pcm_native.c | 35 +++++++++++++++--------------------
 4 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 50eb29fcdfe7..b163164a83ec 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1095,25 +1095,22 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 	mutex_lock(&pcm->open_mutex);
 	wake_up(&pcm->open_wait);
 	list_del_init(&pcm->list);
-	for (cidx = 0; cidx < 2; cidx++) {
-		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next) {
-			snd_pcm_stream_lock_irq(substream);
-			if (substream->runtime) {
-				if (snd_pcm_running(substream))
-					snd_pcm_stop(substream,
-						     SNDRV_PCM_STATE_DISCONNECTED);
-				/* to be sure, set the state unconditionally */
-				substream->runtime->status->state = SNDRV_PCM_STATE_DISCONNECTED;
-				wake_up(&substream->runtime->sleep);
-				wake_up(&substream->runtime->tsleep);
-			}
-			snd_pcm_stream_unlock_irq(substream);
+
+	for_each_pcm_substream(pcm, cidx, substream) {
+		snd_pcm_stream_lock_irq(substream);
+		if (substream->runtime) {
+			if (snd_pcm_running(substream))
+				snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
+			/* to be sure, set the state unconditionally */
+			substream->runtime->status->state = SNDRV_PCM_STATE_DISCONNECTED;
+			wake_up(&substream->runtime->sleep);
+			wake_up(&substream->runtime->tsleep);
 		}
+		snd_pcm_stream_unlock_irq(substream);
 	}
 
-	for (cidx = 0; cidx < 2; cidx++)
-		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next)
-			snd_pcm_sync_stop(substream, false);
+	for_each_pcm_substream(pcm, cidx, substream)
+		snd_pcm_sync_stop(substream, false);
 
 	pcm_call_notify(pcm, n_disconnect);
 	for (cidx = 0; cidx < 2; cidx++) {
diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index b3e8be5aeafb..e3b3558aeab6 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -72,4 +72,10 @@ struct page *snd_pcm_sgbuf_ops_page(struct snd_pcm_substream *substream,
 
 #define PCM_RUNTIME_CHECK(sub) snd_BUG_ON(!(sub) || !(sub)->runtime)
 
+/* loop over all PCM substreams */
+#define for_each_pcm_substream(pcm, str, subs) \
+	for ((str) = 0; (str) < 2; (str)++) \
+		for ((subs) = (pcm)->streams[str].substream; (subs); \
+		     (subs) = (subs)->next)
+
 #endif	/* __SOUND_CORE_PCM_LOCAL_H */
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index ee6e9c5eec45..289dd1fd8fe7 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -111,9 +111,8 @@ void snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm)
 	struct snd_pcm_substream *substream;
 	int stream;
 
-	for (stream = 0; stream < 2; stream++)
-		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
-			snd_pcm_lib_preallocate_free(substream);
+	for_each_pcm_substream(pcm, stream, substream)
+		snd_pcm_lib_preallocate_free(substream);
 }
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_free_for_all);
 
@@ -246,11 +245,8 @@ static void preallocate_pages_for_all(struct snd_pcm *pcm, int type,
 	struct snd_pcm_substream *substream;
 	int stream;
 
-	for (stream = 0; stream < 2; stream++)
-		for (substream = pcm->streams[stream].substream; substream;
-		     substream = substream->next)
-			preallocate_pages(substream, type, data, size, max,
-					  managed);
+	for_each_pcm_substream(pcm, stream, substream)
+		preallocate_pages(substream, type, data, size, max, managed);
 }
 
 /**
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0ae2475465ab..17a85f4815d5 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1674,30 +1674,25 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
 	if (! pcm)
 		return 0;
 
-	for (stream = 0; stream < 2; stream++) {
-		for (substream = pcm->streams[stream].substream;
-		     substream; substream = substream->next) {
-			/* FIXME: the open/close code should lock this as well */
-			if (substream->runtime == NULL)
-				continue;
+	for_each_pcm_substream(pcm, stream, substream) {
+		/* FIXME: the open/close code should lock this as well */
+		if (!substream->runtime)
+			continue;
 
-			/*
-			 * Skip BE dai link PCM's that are internal and may
-			 * not have their substream ops set.
-			 */
-			if (!substream->ops)
-				continue;
+		/*
+		 * Skip BE dai link PCM's that are internal and may
+		 * not have their substream ops set.
+		 */
+		if (!substream->ops)
+			continue;
 
-			err = snd_pcm_suspend(substream);
-			if (err < 0 && err != -EBUSY)
-				return err;
-		}
+		err = snd_pcm_suspend(substream);
+		if (err < 0 && err != -EBUSY)
+			return err;
 	}
 
-	for (stream = 0; stream < 2; stream++)
-		for (substream = pcm->streams[stream].substream;
-		     substream; substream = substream->next)
-			snd_pcm_sync_stop(substream, false);
+	for_each_pcm_substream(pcm, stream, substream)
+		snd_pcm_sync_stop(substream, false);
 
 	return 0;
 }
-- 
2.26.2

