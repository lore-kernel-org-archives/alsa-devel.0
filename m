Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2334C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:30:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8D3207FD
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FMcf+/DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8D3207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95C5C16ED;
	Mon,  9 Dec 2019 11:29:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95C5C16ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575887425;
	bh=kXLlBRabA2rUidLHRHBF2n2R/n6/YxtTWqxlcUfyJA0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FMcf+/DUmvnY6ykVajCUzbQq0CEeyQfkMs8abPIQpS6ExurQjUtnVhwkJFbPWoWTy
	 3ppwExGci7FmKq03pz1igYYM0eyFvHwa9K4lr/Tiqua2lc9eq6rFCoSRvlMmrjzjKf
	 r6JEtCU0Q/2plW0SavlM5/B+xAXxrjoHFJmOP8go=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87CBCF80553;
	Mon,  9 Dec 2019 10:52:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FCAAF8036E; Mon,  9 Dec 2019 10:51:09 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20481F802A1
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20481F802A1
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D98C4B2D4
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:21 +0100
Message-Id: <20191209094943.14984-50-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 49/71] ALSA: pcxhr: Use managed buffer
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
The hw_free callback became superfluous and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/pcxhr/pcxhr.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 4af34d6d92df..72c0d1552f30 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -940,32 +940,16 @@ static int pcxhr_hw_params(struct snd_pcm_substream *subs,
 	struct snd_pcxhr *chip = snd_pcm_substream_chip(subs);
 	struct pcxhr_mgr *mgr = chip->mgr;
 	struct pcxhr_stream *stream = subs->runtime->private_data;
-	snd_pcm_format_t format;
-	int err;
-	int channels;
-
-	/* set up channels */
-	channels = params_channels(hw);
-
-	/*  set up format for the stream */
-	format = params_format(hw);
 
 	mutex_lock(&mgr->setup_mutex);
 
-	stream->channels = channels;
-	stream->format = format;
-
-	/* allocate buffer */
-	err = snd_pcm_lib_malloc_pages(subs, params_buffer_bytes(hw));
+	/* set up channels */
+	stream->channels = params_channels(hw);
+	/* set up format for the stream */
+	stream->format = params_format(hw);
 
 	mutex_unlock(&mgr->setup_mutex);
 
-	return err;
-}
-
-static int pcxhr_hw_free(struct snd_pcm_substream *subs)
-{
-	snd_pcm_lib_free_pages(subs);
 	return 0;
 }
 
@@ -1139,7 +1123,6 @@ static const struct snd_pcm_ops pcxhr_ops = {
 	.ioctl     = snd_pcm_lib_ioctl,
 	.prepare   = pcxhr_prepare,
 	.hw_params = pcxhr_hw_params,
-	.hw_free   = pcxhr_hw_free,
 	.trigger   = pcxhr_trigger,
 	.pointer   = pcxhr_stream_pointer,
 };
@@ -1170,9 +1153,9 @@ int pcxhr_create_pcm(struct snd_pcxhr *chip)
 	pcm->nonatomic = true;
 	strcpy(pcm->name, name);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &chip->mgr->pci->dev,
-					      32*1024, 32*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &chip->mgr->pci->dev,
+				       32*1024, 32*1024);
 	chip->pcm = pcm;
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
