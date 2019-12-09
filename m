Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640ACC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3CA2077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BEtwABYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3CA2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 102FA86F;
	Mon,  9 Dec 2019 11:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 102FA86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885997;
	bh=+gp2ZxouUGQQsgfLwgb/exRMz7CfRL2+7TFV4Xo1Ly4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BEtwABYvzWjxwIVnRBeLGKS4pQWG+E7H0piO646kwwTcPXDUmbAFXSp2FK1Ozw9v+
	 0QsHXtwk58hhHdYcVd+9+D9wCU25iQUOD456EGQGUmHzETFnNoQG2nlLTHQJqatJvZ
	 /6jGIyZALbp5LjNBb/3LarlADe8qarD5Hyo7vSaA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B33B0F80385;
	Mon,  9 Dec 2019 10:51:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA459F80342; Mon,  9 Dec 2019 10:50:31 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECC53F80272
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECC53F80272
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A1946B2BD
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:47 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:57 +0100
Message-Id: <20191209094943.14984-26-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 25/71] ALSA: au88x0: Use managed buffer
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

Clean up the drivers with the new managed buffer allocation API.
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0_pcm.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index a2dcf43beedf..9d7436cd7b0f 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -209,15 +209,7 @@ snd_vortex_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	vortex_t *chip = snd_pcm_substream_chip(substream);
 	stream_t *stream = (stream_t *) (substream->runtime->private_data);
-	int err;
 
-	// Alloc buffer memory.
-	err =
-	    snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-	if (err < 0) {
-		dev_err(chip->card->dev, "Vortex: pcm page alloc failed!\n");
-		return err;
-	}
 	/*
 	   pr_info( "Vortex: periods %d, period_bytes %d, channels = %d\n", params_periods(hw_params),
 	   params_period_bytes(hw_params), params_channels(hw_params));
@@ -304,7 +296,7 @@ static int snd_vortex_pcm_hw_free(struct snd_pcm_substream *substream)
 	substream->runtime->private_data = NULL;
 	spin_unlock_irq(&chip->lock);
 
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 /* prepare callback */
@@ -636,9 +628,8 @@ static int snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
 	
 	/* pre-allocation of Scatter-Gather buffers */
 	
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-					      &chip->pci_dev->dev,
-					      0x10000, 0x10000);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+				       &chip->pci_dev->dev, 0x10000, 0x10000);
 
 	switch (VORTEX_PCM_TYPE(pcm)) {
 	case VORTEX_PCM_ADB:
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
