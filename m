Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0635C433E0
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:39:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F16064E50
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F16064E50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BA371675;
	Sat,  6 Feb 2021 21:38:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BA371675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612643952;
	bh=YKFmaqEgf4ZbkiMHnY1kJxvG1ARUTZp+wwoEsZ28r6Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KlI3ZXY2yaU+8e7i5DNcVywfAVD747P0qd+Ofe35KOuQMQD8p2Plm9FcGosWUtsJr
	 dA+iyCNBSbBWm1bMzU+fQW7OcsWaGKxKZ4g+fv0+HIBuZ9fcW4W+/U+oCHSa3KnWAf
	 854O9SisQWnSjSJM0KWp4WVIHLgrPEGR1s2+X9xY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2238F800B8;
	Sat,  6 Feb 2021 21:37:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B92AF80264; Sat,  6 Feb 2021 21:37:33 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99EB3F800B8
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 21:37:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99EB3F800B8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1DA4DAE3F
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 20:37:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ALSA: pcm: Assure sync with the pending stop operation at
 suspend
Date: Sat,  6 Feb 2021 21:36:54 +0100
Message-Id: <20210206203656.15959-3-tiwai@suse.de>
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

The current PCM code calls the sync_stop at the resume action due to
the analogy to the PCM prepare call pattern.  But, it makes little
sense, as the sync should have been done rather at the suspend time,
not at the resume time.

This patch corrects the sync_stop call at suspend/resume to assure the
sync before finishing the suspend.

Fixes: 1e850beea278 ("ALSA: pcm: Add the support for sync-stop operation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1f5acf08cdcd..cbbdb75c66ea 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1615,6 +1615,7 @@ static int snd_pcm_do_suspend(struct snd_pcm_substream *substream,
 	if (! snd_pcm_running(substream))
 		return 0;
 	substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_SUSPEND);
+	runtime->stop_operating = true;
 	return 0; /* suspend unconditionally */
 }
 
@@ -1691,6 +1692,12 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
 				return err;
 		}
 	}
+
+	for (stream = 0; stream < 2; stream++)
+		for (substream = pcm->streams[stream].substream;
+		     substream; substream = substream->next)
+			snd_pcm_sync_stop(substream, false);
+
 	return 0;
 }
 EXPORT_SYMBOL(snd_pcm_suspend_all);
@@ -1736,7 +1743,6 @@ static void snd_pcm_post_resume(struct snd_pcm_substream *substream,
 	snd_pcm_trigger_tstamp(substream);
 	runtime->status->state = runtime->status->suspended_state;
 	snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MRESUME);
-	snd_pcm_sync_stop(substream, true);
 }
 
 static const struct action_ops snd_pcm_action_resume = {
-- 
2.26.2

