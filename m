Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D4C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:33:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459EE2073B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tCT+Zo+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459EE2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0C4416BC;
	Tue, 10 Dec 2019 15:32:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0C4416BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575988389;
	bh=NRk8MzwoOjrPADiCaugExRziVKG7A8UvfO7RRqguclo=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tCT+Zo+PtVb8aADMGswCNYu9h5UOJFTV5Dna1AkWc4pH/WvOMWb74qf1tpQ8bZy9v
	 jBsbcGH8hTeqyW0ecmcqheuXiLQuwh4eSXFwvFSZepW0x5IHcePvVp3ttmskChaVFM
	 Y3pVX5d+2FfJqbv3jO94ys800DocL6TSa8C3x+2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66ECBF802A7;
	Tue, 10 Dec 2019 15:27:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A74D3F8028E; Tue, 10 Dec 2019 15:26:44 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E791CF80252
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:26:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E791CF80252
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 05741B15B;
 Tue, 10 Dec 2019 14:26:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:25:58 +0100
Message-Id: <20191210142614.19405-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210142614.19405-1-tiwai@suse.de>
References: <20191210142614.19405-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH for-5.6 07/23] ASoC: fsi: Use managed buffer
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
The hw_params and hw_free callbacks became superfluous and got
dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sh/fsi.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index e384fdc8d60e..1cebddd76d12 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1732,20 +1732,6 @@ static int fsi_pcm_open(struct snd_soc_component *component,
 	return ret;
 }
 
-static int fsi_hw_params(struct snd_soc_component *component,
-			 struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *hw_params)
-{
-	return snd_pcm_lib_malloc_pages(substream,
-					params_buffer_bytes(hw_params));
-}
-
-static int fsi_hw_free(struct snd_soc_component *component,
-		       struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 static snd_pcm_uframes_t fsi_pointer(struct snd_soc_component *component,
 				     struct snd_pcm_substream *substream)
 {
@@ -1765,7 +1751,7 @@ static snd_pcm_uframes_t fsi_pointer(struct snd_soc_component *component,
 static int fsi_pcm_new(struct snd_soc_component *component,
 		       struct snd_soc_pcm_runtime *rtd)
 {
-	snd_pcm_lib_preallocate_pages_for_all(
+	snd_pcm_set_managed_buffer_all(
 		rtd->pcm,
 		SNDRV_DMA_TYPE_DEV,
 		rtd->card->snd_card->dev,
@@ -1816,8 +1802,6 @@ static const struct snd_soc_component_driver fsi_soc_component = {
 	.name		= "fsi",
 	.open		= fsi_pcm_open,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
-	.hw_params	= fsi_hw_params,
-	.hw_free	= fsi_hw_free,
 	.pointer	= fsi_pointer,
 	.pcm_construct	= fsi_pcm_new,
 };
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
