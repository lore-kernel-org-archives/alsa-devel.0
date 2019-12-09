Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3FC2D0C0
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:54:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8A624683
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R/62YeXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8A624683
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5F12165D;
	Mon,  9 Dec 2019 10:53:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5F12165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885241;
	bh=Ol2y1c5S5BRCA9yt9wyBkyGWccd7NuB81nsPXXCiRys=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/62YeXpHR1oADR+ZIfqN9GnXq5ITY1paLLkph7UA8ERppcvH5vqfsRehGbZyH3Wv
	 d36AzV3bth3zoWvRc0r1MNA4YZO1xJH6Zb3pmV7FfzPAPqoh9TB0B2XrtkxNXKaQV4
	 s7XCvzx1CGujaZXOD6ZamTtRC61q1HQ800qjHiQU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 612F8F80315;
	Mon,  9 Dec 2019 10:50:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD22BF802F8; Mon,  9 Dec 2019 10:49:58 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2D0BF8023F
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2D0BF8023F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9797DB29F
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:38 +0100
Message-Id: <20191209094943.14984-7-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 06/71] ALSA: ml403: Use managed buffer
	allocation
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

Clean up the driver with the new managed buffer allocation API.
The hw_params and hw_free callbacks became superfluous (they were only
useless debug prints) and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/ml403-ac97cr.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 70a6d1832698..fad63783b4ae 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -670,23 +670,6 @@ snd_ml403_ac97cr_pcm_capture_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_ml403_ac97cr_hw_free(struct snd_pcm_substream *substream)
-{
-	PDEBUG(WORK_INFO, "hw_free()\n");
-	return snd_pcm_lib_free_pages(substream);
-}
-
-static int
-snd_ml403_ac97cr_hw_params(struct snd_pcm_substream *substream,
-			   struct snd_pcm_hw_params *hw_params)
-{
-	PDEBUG(WORK_INFO, "hw_params(): desired buffer bytes=%d, desired "
-	       "period bytes=%d\n",
-	       params_buffer_bytes(hw_params), params_period_bytes(hw_params));
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
 static int snd_ml403_ac97cr_playback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_ml403_ac97cr *ml403_ac97cr;
@@ -749,8 +732,6 @@ static const struct snd_pcm_ops snd_ml403_ac97cr_playback_ops = {
 	.open = snd_ml403_ac97cr_playback_open,
 	.close = snd_ml403_ac97cr_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_ml403_ac97cr_hw_params,
-	.hw_free = snd_ml403_ac97cr_hw_free,
 	.prepare = snd_ml403_ac97cr_pcm_playback_prepare,
 	.trigger = snd_ml403_ac97cr_pcm_playback_trigger,
 	.pointer = snd_ml403_ac97cr_pcm_pointer,
@@ -760,8 +741,6 @@ static const struct snd_pcm_ops snd_ml403_ac97cr_capture_ops = {
 	.open = snd_ml403_ac97cr_capture_open,
 	.close = snd_ml403_ac97cr_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_ml403_ac97cr_hw_params,
-	.hw_free = snd_ml403_ac97cr_hw_free,
 	.prepare = snd_ml403_ac97cr_pcm_capture_prepare,
 	.trigger = snd_ml403_ac97cr_pcm_capture_trigger,
 	.pointer = snd_ml403_ac97cr_pcm_pointer,
@@ -1241,10 +1220,10 @@ snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device)
 	strcpy(pcm->name, "ML403AC97CR DAC/ADC");
 	ml403_ac97cr->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-					  NULL,
-					  64 * 1024,
-					  128 * 1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+				       NULL,
+				       64 * 1024,
+				       128 * 1024);
 	return 0;
 }
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
