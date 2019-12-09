Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E07AC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:47:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93592073D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Lf5YABfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93592073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21A4416E9;
	Mon,  9 Dec 2019 11:46:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21A4416E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575888419;
	bh=X4q+90bD991tcUODxP3nu/4VPA5SpgUXx7ZWN96X8Jc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lf5YABfAsXGYtFRd/qlK3dlXojTAH7iMrz4FNqL6kS2gLsQ446AqcIA0WNBz8t3tb
	 14sY4ZOeTYfByLOMHDIT1vBvp3fuuuybhELLrAeX+/wAQL128fNuDphr/thSMu9OUQ
	 x2FJosW8IGNcGpBlDGsjKXK1dIUJePqyuFLGA/NE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 426DEF806FA;
	Mon,  9 Dec 2019 10:52:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21401F802FB; Mon,  9 Dec 2019 10:51:51 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DFA0F80245
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:49:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DFA0F80245
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 90CFDB287
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 09:49:48 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Mon,  9 Dec 2019 10:49:14 +0100
Message-Id: <20191209094943.14984-43-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191209094943.14984-1-tiwai@suse.de>
References: <20191209094943.14984-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 5.6 42/71] ALSA: ice1724: Use managed buffer
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
 sound/pci/ice1712/ice1724.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index c80a16ee6e76..ba992ce47282 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -704,7 +704,7 @@ static int snd_vt1724_pcm_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
-	int i, chs, err;
+	int i, chs;
 
 	chs = params_channels(hw_params);
 	mutex_lock(&ice->open_mutex);
@@ -740,11 +740,7 @@ static int snd_vt1724_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 	mutex_unlock(&ice->open_mutex);
 
-	err = snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
-	if (err < 0)
-		return err;
-
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+	return snd_vt1724_set_pro_rate(ice, params_rate(hw_params), 0);
 }
 
 static int snd_vt1724_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -758,7 +754,7 @@ static int snd_vt1724_pcm_hw_free(struct snd_pcm_substream *substream)
 		if (ice->pcm_reserved[i] == substream)
 			ice->pcm_reserved[i] = NULL;
 	mutex_unlock(&ice->open_mutex);
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int snd_vt1724_playback_pro_prepare(struct snd_pcm_substream *substream)
@@ -1142,9 +1138,8 @@ static int snd_vt1724_pcm_profi(struct snd_ice1712 *ice, int device)
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "ICE1724");
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &ice->pci->dev,
-					      256*1024, 256*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &ice->pci->dev, 256*1024, 256*1024);
 
 	ice->pcm_pro = pcm;
 
@@ -1340,9 +1335,8 @@ static int snd_vt1724_pcm_spdif(struct snd_ice1712 *ice, int device)
 	pcm->info_flags = 0;
 	strcpy(pcm->name, name);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &ice->pci->dev,
-					      256*1024, 256*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &ice->pci->dev, 256*1024, 256*1024);
 
 	ice->pcm = pcm;
 
@@ -1454,9 +1448,8 @@ static int snd_vt1724_pcm_indep(struct snd_ice1712 *ice, int device)
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "ICE1724 Surround PCM");
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      &ice->pci->dev,
-					      256*1024, 256*1024);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       &ice->pci->dev, 256*1024, 256*1024);
 
 	ice->pcm_ds = pcm;
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
