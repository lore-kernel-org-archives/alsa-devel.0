Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A51C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:56:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BEF2072D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PDS1EbaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BEF2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5469167A;
	Mon,  9 Dec 2019 10:55:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5469167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575885393;
	bh=Hf1ipiywhcZOSNXyfi8cZ+PfaZdoZZkv2zKGDKsXu9w=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PDS1EbaOJbt/zFFgijiW4l810RNfyZqU8eGM3htQlmzGrVFly5zmHN7g3CKSSnm38
	 fnpMXHzrD0Tap5cFbp9Qg7q3NwEf2/WHw/tBNwG+pt0uJM6AtsHT5e2qzgz5LagcKY
	 HTh37r9+hQheul0asR4HqT1MI5FYu7dsl3P85yik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09717F80333;
	Mon,  9 Dec 2019 10:50:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A224EF80306; Mon,  9 Dec 2019 10:50:05 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B984FF80254
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B984FF80254
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A4CD7B279
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:46 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:48:39 +0100
Message-Id: <20191209094943.14984-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 07/71] ALSA: pcsp: Use managed buffer
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
The superfluous snd_pcm_lib_malloc_pages() and
snd_pcm_lib_free_pages() are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/pcsp/pcsp_lib.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index f91316bf01cb..4fdc4dbdae57 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -214,12 +214,7 @@ static int snd_pcsp_playback_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_pcsp *chip = snd_pcm_substream_chip(substream);
-	int err;
 	pcsp_sync_stop(chip);
-	err = snd_pcm_lib_malloc_pages(substream,
-				      params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
 	return 0;
 }
 
@@ -230,7 +225,7 @@ static int snd_pcsp_playback_hw_free(struct snd_pcm_substream *substream)
 	printk(KERN_INFO "PCSP: hw_free called\n");
 #endif
 	pcsp_sync_stop(chip);
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int snd_pcsp_playback_prepare(struct snd_pcm_substream *substream)
@@ -350,11 +345,11 @@ int snd_pcsp_new_pcm(struct snd_pcsp *chip)
 	chip->pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
 	strcpy(chip->pcm->name, "pcsp");
 
-	snd_pcm_lib_preallocate_pages_for_all(chip->pcm,
-					      SNDRV_DMA_TYPE_CONTINUOUS,
-					      NULL,
-					      PCSP_BUFFER_SIZE,
-					      PCSP_BUFFER_SIZE);
+	snd_pcm_set_managed_buffer_all(chip->pcm,
+				       SNDRV_DMA_TYPE_CONTINUOUS,
+				       NULL,
+				       PCSP_BUFFER_SIZE,
+				       PCSP_BUFFER_SIZE);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
