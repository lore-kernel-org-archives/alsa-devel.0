Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB9C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:12:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA7C207FF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DEFThfzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA7C207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DC9816B1;
	Mon,  9 Dec 2019 11:11:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DC9816B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575886318;
	bh=to+ZN1nKfkZXw18KiH1xZym0m6eLCurRkAZikEnCrfE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DEFThfzGRs5kAXsflFKzXmyYbjXoeGkUiA7Thkdn0qxK9wrUf4Nk/Q+0lxkunS9Bc
	 9InQKxaC/VmlysXvmd4WMVHdwAXnF/BIB8cQIPazKMc/jeB4FR0U+ABrKZ3b6V9bQk
	 66C7S0Gt4QE1ODldyo4jkw16o5mFXf+fiUlEpB+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E61A5F803CA;
	Mon,  9 Dec 2019 10:51:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E048BF80278; Mon,  9 Dec 2019 10:50:44 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C7D9F80276
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C7D9F80276
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1137BAEA7
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:05 +0100
Message-Id: <20191209094943.14984-34-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 33/71] ALSA: ctxfi: Use managed buffer
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
snd_pcm_lib_free_pages() calls are dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ctxfi/ctpcm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/pci/ctxfi/ctpcm.c b/sound/pci/ctxfi/ctpcm.c
index 7ae5b238703c..5ee2316827d8 100644
--- a/sound/pci/ctxfi/ctpcm.c
+++ b/sound/pci/ctxfi/ctpcm.c
@@ -178,15 +178,10 @@ static int ct_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct ct_atc *atc = snd_pcm_substream_chip(substream);
 	struct ct_atc_pcm *apcm = substream->runtime->private_data;
-	int err;
 
-	err = snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
 	/* clear previous resources */
 	atc->pcm_release_resources(atc, apcm);
-	return err;
+	return 0;
 }
 
 static int ct_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -196,8 +191,7 @@ static int ct_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	/* clear previous resources */
 	atc->pcm_release_resources(atc, apcm);
-	/* Free snd-allocated pages */
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 
@@ -449,9 +443,8 @@ int ct_alsa_pcm_create(struct ct_atc *atc,
 		snd_pcm_set_ops(pcm,
 				SNDRV_PCM_STREAM_CAPTURE, &ct_pcm_capture_ops);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-					      &atc->pci->dev,
-					      128*1024, 128*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
+				       &atc->pci->dev, 128*1024, 128*1024);
 
 	chs = 2;
 	switch (device) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
