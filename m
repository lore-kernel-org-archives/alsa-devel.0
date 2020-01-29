Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB47C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:00:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B26920716
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pm/LZQRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B26920716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A7CA1671;
	Wed, 29 Jan 2020 20:59:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A7CA1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580328005;
	bh=1aHLtEM6spF/1zZTfBAXoEysm+qq6fuChT3FywQWFjk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pm/LZQRSC5BJJ748bp27NMKOfbIqWrg0RUZlyqYs95bCLYLhZowYFjT++t4ZJAp4h
	 3YekIbYizRk+B0S7rKnSonCNC+08DJhN2Eglu3LyVuDCUl/wb86tU/MTfeKa05W4v+
	 lQ1DwHxML4LfqMT1wuJDZ5eLy5f5NRk0ed9wsHPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6433F80218;
	Wed, 29 Jan 2020 20:59:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6419F8021E; Wed, 29 Jan 2020 20:59:12 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 273BCF80122
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 20:59:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 273BCF80122
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D42D7AE5C
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 19:59:08 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Wed, 29 Jan 2020 20:59:07 +0100
Message-Id: <20200129195907.12197-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: pcm: Fix memory leak at closing a stream
	without hw_free
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

ALSA PCM core recently introduced a new managed PCM buffer allocation
mode that does allocate / free automatically at hw_params and
hw_free.  However, it overlooked the code path directly calling
hw_free PCM ops at releasing the PCM substream, and it may result in a
memory leak as spotted by syzkaller when no buffer preallocation is
used (e.g. vmalloc buffer).

This patch papers over it with a slight refactoring.  The hw_free ops
call and relevant tasks are unified in a new helper function, and call
it from both places.

Fixes: 0dba808eae26 ("ALSA: pcm: Introduce managed buffer allocation mode")
Reported-by: syzbot+30edd0f34bfcdc548ac4@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bb23f5066654..4ac42ee1238c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -786,10 +786,22 @@ static int snd_pcm_hw_params_user(struct snd_pcm_substream *substream,
 	return err;
 }
 
+static int do_hw_free(struct snd_pcm_substream *substream)
+{
+	int result = 0;
+
+	snd_pcm_sync_stop(substream);
+	if (substream->ops->hw_free)
+		result = substream->ops->hw_free(substream);
+	if (substream->managed_buffer_alloc)
+		snd_pcm_lib_free_pages(substream);
+	return result;
+}
+
 static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
-	int result = 0;
+	int result;
 
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
@@ -806,11 +818,7 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irq(substream);
 	if (atomic_read(&substream->mmap_count))
 		return -EBADFD;
-	snd_pcm_sync_stop(substream);
-	if (substream->ops->hw_free)
-		result = substream->ops->hw_free(substream);
-	if (substream->managed_buffer_alloc)
-		snd_pcm_lib_free_pages(substream);
+	result = do_hw_free(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_OPEN);
 	pm_qos_remove_request(&substream->latency_pm_qos_req);
 	return result;
@@ -2529,9 +2537,7 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 
 	snd_pcm_drop(substream);
 	if (substream->hw_opened) {
-		if (substream->ops->hw_free &&
-		    substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
-			substream->ops->hw_free(substream);
+		do_hw_free(substream);
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
 	}
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
