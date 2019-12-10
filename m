Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383A7C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:30:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB69520836
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RM58vhPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB69520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22E3B16B5;
	Tue, 10 Dec 2019 15:30:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22E3B16B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575988251;
	bh=qhwgi0YTDow1RIViroQtXFR6CRDMAg2PwoWx8mXZSU0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RM58vhPEKZ92Da+jJmGNXf5vjNdEyWkC1UyBQj/ygMwQ/0boZALVbLczMIg+2dwWV
	 uN2uPZzGmXknH1xTbBQ1JCxs8mB5TVezGNLX3yNGWKfMN9OsC5P5OnJk2N2ig7lVsl
	 Ob38iDfBw0SvIbpRAAH+BGVKI7B/mRqzU7O8pOms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 140E6F80254;
	Tue, 10 Dec 2019 15:26:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80F7DF80278; Tue, 10 Dec 2019 15:26:38 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 915EEF801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:26:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 915EEF801D8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AE9B7B178;
 Tue, 10 Dec 2019 14:26:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:25:53 +0100
Message-Id: <20191210142614.19405-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210142614.19405-1-tiwai@suse.de>
References: <20191210142614.19405-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH for-5.6 02/23] ASoC: au1x: Use managed buffer
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
 sound/soc/au1x/dbdma2.c | 14 +-------------
 sound/soc/au1x/dma.c    | 21 ++++++---------------
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 4553108ec92a..b2c0a0d8a407 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -197,10 +197,6 @@ static int au1xpsc_pcm_hw_params(struct snd_soc_component *component,
 	struct au1xpsc_audio_dmadata *pcd;
 	int stype, ret;
 
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	if (ret < 0)
-		goto out;
-
 	stype = substream->stream;
 	pcd = to_dmadata(substream, component);
 
@@ -232,13 +228,6 @@ static int au1xpsc_pcm_hw_params(struct snd_soc_component *component,
 	return ret;
 }
 
-static int au1xpsc_pcm_hw_free(struct snd_soc_component *component,
-			       struct snd_pcm_substream *substream)
-{
-	snd_pcm_lib_free_pages(substream);
-	return 0;
-}
-
 static int au1xpsc_pcm_prepare(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream)
 {
@@ -315,7 +304,7 @@ static int au1xpsc_pcm_new(struct snd_soc_component *component,
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_pcm *pcm = rtd->pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
 		card->dev, AU1XPSC_BUFFER_MIN_BYTES, (4096 * 1024) - 1);
 
 	return 0;
@@ -328,7 +317,6 @@ static struct snd_soc_component_driver au1xpsc_soc_component = {
 	.close		= au1xpsc_pcm_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
 	.hw_params	= au1xpsc_pcm_hw_params,
-	.hw_free	= au1xpsc_pcm_hw_free,
 	.prepare	= au1xpsc_pcm_prepare,
 	.trigger	= au1xpsc_pcm_trigger,
 	.pointer	= au1xpsc_pcm_pointer,
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 054dfda89d3e..037f4a98fb76 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -231,19 +231,10 @@ static int alchemy_pcm_hw_params(struct snd_soc_component *component,
 				 struct snd_pcm_hw_params *hw_params)
 {
 	struct audio_stream *stream = ss_to_as(substream, component);
-	int err;
-
-	err = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
-	err = au1000_setup_dma_link(stream,
-				    params_period_bytes(hw_params),
-				    params_periods(hw_params));
-	if (err)
-		snd_pcm_lib_free_pages(substream);
 
-	return err;
+	return au1000_setup_dma_link(stream,
+				     params_period_bytes(hw_params),
+				     params_periods(hw_params));
 }
 
 static int alchemy_pcm_hw_free(struct snd_soc_component *component,
@@ -251,7 +242,7 @@ static int alchemy_pcm_hw_free(struct snd_soc_component *component,
 {
 	struct audio_stream *stream = ss_to_as(substream, component);
 	au1000_release_dma_link(stream);
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int alchemy_pcm_trigger(struct snd_soc_component *component,
@@ -292,8 +283,8 @@ static int alchemy_pcm_new(struct snd_soc_component *component,
 {
 	struct snd_pcm *pcm = rtd->pcm;
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-					      NULL, 65536, (4096 * 1024) - 1);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+				       NULL, 65536, (4096 * 1024) - 1);
 
 	return 0;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
