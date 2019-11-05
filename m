Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36868C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:21:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79F321929
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PhbXKBn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79F321929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C439816F0;
	Tue,  5 Nov 2019 16:20:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C439816F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572967299;
	bh=qylrYnyPXZdaUU0mOk5qc9oxRPwcUOdhZIxIYzbYYv8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PhbXKBn40FO5UYcHIOV0hkZ7BO3mJAJR7shWkIJWsByGcTAF0yrjWwNgsD0bD18K1
	 1GwMFY+/vCic6fYCCPALP1wjkdm3+Zkx7L8S3m5yWQa601Z5lZVTDAQz5Cz9X+m+1/
	 ddS0CzXxqj+/UZhCvxlgW29JwT6kN+gvVtTHKuuQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1A28F8060D;
	Tue,  5 Nov 2019 16:19:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C78EF80637; Tue,  5 Nov 2019 16:19:06 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57D33F8049B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:18:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57D33F8049B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E33A1B261
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:33 +0100
Message-Id: <20191105151856.10785-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 01/24] ALSA: drivers: Remove superfluous
	snd_dma_continuous_data()
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

The recent change (commit b8a7d422280c: "ALSA: memalloc: Allow NULL
device for SNDRV_DMA_TYPE_CONTINOUS type") made the PCM preallocation
helper accepting NULL as the device pointer for the default usage.
Drop the snd_dma_continuous_data() usage that became superfluous from
the callers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c         | 2 +-
 sound/drivers/ml403-ac97cr.c  | 2 +-
 sound/drivers/pcsp/pcsp_lib.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index aee7c04d49e5..022a0db692e0 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -702,7 +702,7 @@ static int snd_card_dummy_pcm(struct snd_dummy *dummy, int device,
 	if (!fake_buffer) {
 		snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
-			snd_dma_continuous_data(GFP_KERNEL),
+			NULL,
 			0, 64*1024);
 	}
 	return 0;
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index a3c1c064d1b5..70a6d1832698 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1242,7 +1242,7 @@ snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device)
 	ml403_ac97cr->pcm = pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-					  snd_dma_continuous_data(GFP_KERNEL),
+					  NULL,
 					  64 * 1024,
 					  128 * 1024);
 	return 0;
diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 8f0f05bbc081..f91316bf01cb 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -352,8 +352,8 @@ int snd_pcsp_new_pcm(struct snd_pcsp *chip)
 
 	snd_pcm_lib_preallocate_pages_for_all(chip->pcm,
 					      SNDRV_DMA_TYPE_CONTINUOUS,
-					      snd_dma_continuous_data
-					      (GFP_KERNEL), PCSP_BUFFER_SIZE,
+					      NULL,
+					      PCSP_BUFFER_SIZE,
 					      PCSP_BUFFER_SIZE);
 
 	return 0;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
