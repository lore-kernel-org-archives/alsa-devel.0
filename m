Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3509C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:25:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36F321929
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CcqqUFRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36F321929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE97916F6;
	Tue,  5 Nov 2019 16:24:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE97916F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572967503;
	bh=cF/dt9dt7e/bdfiPjsvEMb0sOM3Q+IRi5HtQKf4cXok=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CcqqUFRwhZOANPlBkwyIclFEnu+SY9AzqAzA6iNjyBQYmD6W9txT09vLBmomtkOwA
	 hq0wUhjX8y0BJr2lDpEufrw+5KhtGza5vbAewZrWACqTXuS0jmGu1RjrB6Ym5Geuat
	 lxQDrhAxkPnvbZEtuPjWagBbUKQqaw9IyaE1FytE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BA47F80672;
	Tue,  5 Nov 2019 16:19:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5954F80638; Tue,  5 Nov 2019 16:19:09 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B0E6F805E0
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B0E6F805E0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3C145B28F
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:41 +0100
Message-Id: <20191105151856.10785-10-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 09/24] ALSA: aloop: Convert to the common
	vmalloc memalloc
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

The recent change (*) in the ALSA memalloc core allows us to drop the
special vmalloc-specific allocation and page handling.  This patch
coverts to the common code.
(*) df3fd6509421: ALSA: memalloc: Add vmalloc buffer allocation
                  support
    6ef6be988f98: ALSA: pcm: Handle special page mapping in the
                  default mmap handler

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9ccdad89c288..54f8b17476a1 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -576,8 +576,7 @@ static void loopback_runtime_free(struct snd_pcm_runtime *runtime)
 static int loopback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(params));
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 }
 
 static int loopback_hw_free(struct snd_pcm_substream *substream)
@@ -589,7 +588,7 @@ static int loopback_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&dpcm->loopback->cable_lock);
 	cable->valid &= ~(1 << substream->stream);
 	mutex_unlock(&dpcm->loopback->cable_lock);
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
+	return snd_pcm_lib_free_pages(substream);
 }
 
 static unsigned int get_cable_index(struct snd_pcm_substream *substream)
@@ -765,7 +764,6 @@ static const struct snd_pcm_ops loopback_pcm_ops = {
 	.prepare =	loopback_prepare,
 	.trigger =	loopback_trigger,
 	.pointer =	loopback_pointer,
-	.page =		snd_pcm_lib_get_vmalloc_page,
 };
 
 static int loopback_pcm_new(struct loopback *loopback,
@@ -780,6 +778,8 @@ static int loopback_pcm_new(struct loopback *loopback,
 		return err;
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &loopback_pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &loopback_pcm_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_VMALLOC,
+					      NULL, 0, 0);
 
 	pcm->private_data = loopback;
 	pcm->info_flags = 0;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
