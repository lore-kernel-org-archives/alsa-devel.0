Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD7C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:31:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD00C20836
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KR6Ed/CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD00C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A01316B4;
	Tue, 10 Dec 2019 15:30:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A01316B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575988298;
	bh=Gf5MDj7TRvYzFKKuFjEcXo2s6nAkusl4MRxd1+Jnq3M=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KR6Ed/CVPWI6IaaofDJArh3bfCgDHQH/1IHO9fDMk6DB7nNc9nvG/vILKcEfe8Tn7
	 lrVbJYHVNXaXfhCPJ62BXUrJHsST5bLPExSx6SQQK8kEOpA0Ykyaos1BvN+3w0sryw
	 +gOsGbcpcAoEF1ym99g+UjAloj0mah9Hl5rNRkzw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A242F80252;
	Tue, 10 Dec 2019 15:26:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D93DF80279; Tue, 10 Dec 2019 15:26:40 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09B0AF80249
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:26:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09B0AF80249
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 23073B1FF;
 Tue, 10 Dec 2019 14:26:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:26:00 +0100
Message-Id: <20191210142614.19405-10-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210142614.19405-1-tiwai@suse.de>
References: <20191210142614.19405-1-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH for-5.6 09/23] ASoC: siu_pcm: Use managed
	buffer allocation
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
The hw_params and hw_free callbacks became superfluous (the rest were
only debug prints) and got dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/sh/siu_pcm.c | 39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index a5e21e554da2..65637ad93630 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -281,41 +281,6 @@ static int siu_pcm_stmread_stop(struct siu_port *port_info)
 	return 0;
 }
 
-static int siu_pcm_hw_params(struct snd_soc_component *component,
-			     struct snd_pcm_substream *ss,
-			     struct snd_pcm_hw_params *hw_params)
-{
-	struct siu_info *info = siu_i2s_data;
-	struct device *dev = ss->pcm->card->dev;
-	int ret;
-
-	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
-
-	ret = snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(hw_params));
-	if (ret < 0)
-		dev_err(dev, "snd_pcm_lib_malloc_pages() failed\n");
-
-	return ret;
-}
-
-static int siu_pcm_hw_free(struct snd_soc_component *component,
-			   struct snd_pcm_substream *ss)
-{
-	struct siu_info *info = siu_i2s_data;
-	struct siu_port	*port_info = siu_port_info(ss);
-	struct device *dev = ss->pcm->card->dev;
-	struct siu_stream *siu_stream;
-
-	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		siu_stream = &port_info->playback;
-	else
-		siu_stream = &port_info->capture;
-
-	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
-
-	return snd_pcm_lib_free_pages(ss);
-}
-
 static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct sh_dmae_slave *param = slave;
@@ -548,7 +513,7 @@ static int siu_pcm_new(struct snd_soc_component *component,
 		if (ret < 0)
 			return ret;
 
-		snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_set_managed_buffer_all(pcm,
 				SNDRV_DMA_TYPE_DEV, card->dev,
 				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
 
@@ -584,8 +549,6 @@ struct const snd_soc_component_driver siu_component = {
 	.open		= siu_pcm_open,
 	.close		= siu_pcm_close,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
-	.hw_params	= siu_pcm_hw_params,
-	.hw_free	= siu_pcm_hw_free,
 	.prepare	= siu_pcm_prepare,
 	.trigger	= siu_pcm_trigger,
 	.pointer	= siu_pcm_pointer_dma,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
