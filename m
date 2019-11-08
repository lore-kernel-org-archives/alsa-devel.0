Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B08C5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:55:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4CC21D6C
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mfzl0k8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4CC21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C4EE1690;
	Fri,  8 Nov 2019 10:54:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C4EE1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573206919;
	bh=gJSlCNIY36BrQalqGw3w12TV4rtn6SyvIdmUtD82xko=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfzl0k8a4lEayzu6MnrYnKzcNjER1zftuWwTbuERXC5+myZi1mwTUeLsA0+1/QOpx
	 QUSHy+9eK4rqt9gT8pXpVThiA3nIEW7dafsOndhxg8HNo3EqKfD9YKWCtOfpwg3mu9
	 nzwXR8nraZ8sardg6xKRyZdZXjXiBDyDCq94G8pM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2183BF8065D;
	Fri,  8 Nov 2019 10:49:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69FBBF803D0; Fri,  8 Nov 2019 10:48:19 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E147EF805DF
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 10:46:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E147EF805DF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F16CDB14F;
 Fri,  8 Nov 2019 09:46:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  8 Nov 2019 10:46:40 +0100
Message-Id: <20191108094641.20086-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191108094641.20086-1-tiwai@suse.de>
References: <20191108094641.20086-1-tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [alsa-devel] [PATCH 7/8] ASoC: cros_ec_codec: Convert to the common
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
(*) 1fe7f397cfe2: ALSA: memalloc: Add vmalloc buffer allocation
                  support
    7e8edae39fd1: ALSA: pcm: Handle special page mapping in the
                  default mmap handler

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/cros_ec_codec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index dd14caf9091a..7b17f39a6a10 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -918,8 +918,7 @@ static int wov_pcm_hw_params(struct snd_soc_component *component,
 	priv->wov_burst_read = true;
 	mutex_unlock(&priv->wov_dma_lock);
 
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-			params_buffer_bytes(hw_params));
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 }
 
 static int wov_pcm_hw_free(struct snd_soc_component *component,
@@ -935,7 +934,7 @@ static int wov_pcm_hw_free(struct snd_soc_component *component,
 
 	cancel_delayed_work_sync(&priv->wov_copy_work);
 
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
+	return snd_pcm_lib_free_pages(substream);
 }
 
 static snd_pcm_uframes_t wov_pcm_pointer(struct snd_soc_component *component,
@@ -948,11 +947,12 @@ static snd_pcm_uframes_t wov_pcm_pointer(struct snd_soc_component *component,
 	return bytes_to_frames(runtime, priv->wov_dma_offset);
 }
 
-static struct page *wov_pcm_page(struct snd_soc_component *component,
-				 struct snd_pcm_substream *substream,
-				 unsigned long offset)
+static int wov_pcm_new(struct snd_soc_component *component,
+		       struct snd_soc_pcm_runtime *rtd)
 {
-	return snd_pcm_lib_get_vmalloc_page(substream, offset);
+	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_VMALLOC,
+					      NULL, 0, 0);
+	return 0;
 }
 
 static const struct snd_soc_component_driver wov_component_driver = {
@@ -964,7 +964,7 @@ static const struct snd_soc_component_driver wov_component_driver = {
 	.hw_params	= wov_pcm_hw_params,
 	.hw_free	= wov_pcm_hw_free,
 	.pointer	= wov_pcm_pointer,
-	.page		= wov_pcm_page,
+	.pcm_construct	= wov_pcm_new,
 };
 
 static int cros_ec_codec_platform_probe(struct platform_device *pdev)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
