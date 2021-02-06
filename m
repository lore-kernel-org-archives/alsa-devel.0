Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4845C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:40:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2AD64E57
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 20:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2AD64E57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B11E71687;
	Sat,  6 Feb 2021 21:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B11E71687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612644004;
	bh=lFng05FcrUTQESII0Gav2YsvjniRvZaVxdTlgp2WrtQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UtUAILEpkcQQPEKD5L3qDz56dkXIQA6ew3mhK/DlvGhq2jxS9iyeicBqdM2wynpG8
	 wgNhBGDCHGL8jeP2Vk4EKl5FFMoky+zESwZ7sUraF1FscYYKkjybpwkmKDI1LsLkzu
	 5tNQ2w8YTQ/v2dWMSb1RGcpLVBpFpSFpe6sBTdlA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F16BF802C8;
	Sat,  6 Feb 2021 21:37:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE002F8026B; Sat,  6 Feb 2021 21:37:35 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91931F80139
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 21:37:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91931F80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1D635AE3C
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 20:37:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ALSA: pcm: Don't call sync_stop if it hasn't been stopped
Date: Sat,  6 Feb 2021 21:36:55 +0100
Message-Id: <20210206203656.15959-4-tiwai@suse.de>
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

The PCM stop operation sets the stop_operating flag for indicating the
sync_stop post-process.  This flag is, however, set unconditionally
even if the PCM trigger weren't issued.  This may lead to
inconsistency in the driver side.

Correct the code to set stop_operating flag only after the trigger
STOP is actually called.

Fixes: 1e850beea278 ("ALSA: pcm: Add the support for sync-stop operation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index cbbdb75c66ea..0ae2475465ab 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1421,8 +1421,10 @@ static int snd_pcm_do_stop(struct snd_pcm_substream *substream,
 			   snd_pcm_state_t state)
 {
 	if (substream->runtime->trigger_master == substream &&
-	    snd_pcm_running(substream))
+	    snd_pcm_running(substream)) {
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
+		substream->runtime->stop_operating = true;
+	}
 	return 0; /* unconditonally stop all substreams */
 }
 
@@ -1435,7 +1437,6 @@ static void snd_pcm_post_stop(struct snd_pcm_substream *substream,
 		runtime->status->state = state;
 		snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTOP);
 	}
-	runtime->stop_operating = true;
 	wake_up(&runtime->sleep);
 	wake_up(&runtime->tsleep);
 }
-- 
2.26.2

