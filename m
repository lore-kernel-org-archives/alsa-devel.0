Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCCC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:15:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0B32077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qwor6IFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0B32077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73E281696;
	Mon,  9 Dec 2019 11:14:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73E281696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575886512;
	bh=cnEpcbxi2Z/n2+UrAa5bY8I1DEN6lb2SMmicgU2DYxI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwor6IFXHxNPjjQisQks21ZG7WJsgvMJd4uZIkBaz2VtB6Gacs/AX2h3a2uFLlojn
	 QmccIoOz8pP/EARi9Gxjl18BMCDKQIGL9k2tVtji+rdFsOjsPb1Aho/jEPy+IKDwyF
	 E8AlAOa6zSvbtpXO0kayfngZvYImrFHcaAYEefKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28035F80405;
	Mon,  9 Dec 2019 10:52:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81D4DF8034B; Mon,  9 Dec 2019 10:50:52 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E23EF8028B
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E23EF8028B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2E5BCB2C7
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:07 +0100
Message-Id: <20191209094943.14984-36-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 35/71] ALSA: emu10k1x: Use managed buffer
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
 sound/pci/emu10k1/emu10k1x.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 241b4a0631ab..ef34fe711813 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -411,8 +411,7 @@ static int snd_emu10k1x_pcm_hw_params(struct snd_pcm_substream *substream,
 		epcm->voice->epcm = epcm;
 	}
 
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
+	return 0;
 }
 
 /* hw_free callback */
@@ -432,7 +431,7 @@ static int snd_emu10k1x_pcm_hw_free(struct snd_pcm_substream *substream)
 		epcm->voice = NULL;
 	}
 
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 /* prepare callback */
@@ -594,8 +593,7 @@ static int snd_emu10k1x_pcm_hw_params_capture(struct snd_pcm_substream *substrea
 		epcm->voice->use = 1;
 	}
 
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
+	return 0;
 }
 
 /* hw_free callback */
@@ -615,7 +613,7 @@ static int snd_emu10k1x_pcm_hw_free_capture(struct snd_pcm_substream *substream)
 		epcm->voice = NULL;
 	}
 
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 /* prepare capture callback */
@@ -876,9 +874,8 @@ static int snd_emu10k1x_pcm(struct emu10k1x *emu, int device)
 	}
 	emu->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &emu->pci->dev,
-					      32*1024, 32*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &emu->pci->dev, 32*1024, 32*1024);
   
 	return snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK, map, 2,
 				     1 << 2, NULL);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
