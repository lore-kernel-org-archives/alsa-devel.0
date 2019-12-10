Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750BBC00454
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E60F20637
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dxo83Zry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E60F20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90BE916CC;
	Tue, 10 Dec 2019 15:41:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90BE916CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575988946;
	bh=GtbAdmFRPEQP3/D+R0sa0/c42QnWXklcasyFoHc2w50=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dxo83ZrypXqtMdz/S+Pzf61NfdqUmT8zjbRg18KXMu7GeDJgqwtTK3bbY03VvEHN6
	 9vXoVvL+iX/XSzPm7IXk/aLEyiGqJZtfTT7nCcSnfGfKT1NMLYXNYD1ydErMEaTq4d
	 i5zP+dDWIi8TCJDv8eO0Wra10Dp9CuExbK70MNzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC730F8035E;
	Tue, 10 Dec 2019 15:27:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80CAFF802DF; Tue, 10 Dec 2019 15:27:11 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CE13F80265
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 15:26:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CE13F80265
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D6F3FB222;
 Tue, 10 Dec 2019 14:26:26 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Dec 2019 15:26:13 +0100
Message-Id: <20191210142614.19405-23-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210142614.19405-1-tiwai@suse.de>
References: <20191210142614.19405-1-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [alsa-devel] [PATCH for-5.6 22/23] ASoC: intel: haswell: Use
	managed buffer allocation
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

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index a3a5bba2fbd9..59c63ccc7bb3 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -592,13 +592,6 @@ static int hsw_pcm_hw_params(struct snd_soc_component *component,
 		return ret;
 	}
 
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	if (ret < 0) {
-		dev_err(rtd->dev, "error: could not allocate %d bytes for PCM %d\n",
-			params_buffer_bytes(params), ret);
-		return ret;
-	}
-
 	dmab = snd_pcm_get_dma_buf(substream);
 
 	ret = create_adsp_page_table(substream, pdata, rtd, runtime->dma_area,
@@ -656,13 +649,6 @@ static int hsw_pcm_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
-static int hsw_pcm_hw_free(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
-{
-	snd_pcm_lib_free_pages(substream);
-	return 0;
-}
-
 static int hsw_pcm_trigger(struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream, int cmd)
 {
@@ -930,7 +916,7 @@ static int hsw_pcm_new(struct snd_soc_component *component,
 
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
 			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_set_managed_buffer_all(pcm,
 			SNDRV_DMA_TYPE_DEV_SG,
 			dev,
 			hsw_pcm_hardware.buffer_bytes_max,
@@ -1114,7 +1100,6 @@ static const struct snd_soc_component_driver hsw_dai_component = {
 	.open		= hsw_pcm_open,
 	.close		= hsw_pcm_close,
 	.hw_params	= hsw_pcm_hw_params,
-	.hw_free	= hsw_pcm_hw_free,
 	.trigger	= hsw_pcm_trigger,
 	.pointer	= hsw_pcm_pointer,
 	.ioctl		= snd_soc_pcm_lib_ioctl,
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
