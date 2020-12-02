Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E02C64E7C
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 08:59:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD4F22202
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 08:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD4F22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C82E17D9;
	Wed,  2 Dec 2020 09:59:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C82E17D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606899594;
	bh=4wWcur5DlsfV0lXw+0GFCRuwJmV24Pfs1EWJ0dKu/e0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uu3ke8yrg/AIBHSd7WJaPCzU36BcwfnzFiDh+r9qx5+gP2E829cv1/n8+56u5vBJ/
	 WGsb21zmlM35jjJkiUFekain7+5ozy+oXrpKMt+ts5DhigOYCc2Qb4zmdHOmA3aFsF
	 HUlPQd4cMX6fw+HeDrFYCfj0Z3ZIG32pWK/+nZLk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B49BCF8025F;
	Wed,  2 Dec 2020 09:59:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBDCBF8026B; Wed,  2 Dec 2020 09:59:01 +0100 (CET)
Received: from esa1.microchip.iphmx.com (esa1.microchip.iphmx.com
 [68.232.147.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52318F80158
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 09:58:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52318F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.b="aclhel4D"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1606899536; x=1638435536;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4wWcur5DlsfV0lXw+0GFCRuwJmV24Pfs1EWJ0dKu/e0=;
 b=aclhel4DsPrxbTRb92XPoGjLBlcjVkqm/2f0YHIz4QqEN82Y6qSJIEhH
 /5vN7d1yq2KYR6tq1jTSfvT4ikV00Ujwx9YfEttL9Eldk9yvjqF9Q+rh5
 jZIxraj9iaadH3pbeNZUVUiYUYNjezNPj+8ZeVzFGVTQ/jiv/PGXmFFCa
 mU3vl2csIdpDcuG+PqxePi38ZwgZPfNTkECIpdBc5Ys7WoDq9oNEatJVt
 hIBnru0doHJmOZnh2E8tT9W0qkX0unsZz/rDfFNFHdKQw+7wvH9rPe4aR
 buJ5N3ydXU650n3RmXd8dHHki401qQXKhFM4epY/XkiMLYGtoJmyNMeD/ g==;
IronPort-SDR: q5U6gLx4CEBN2KAufOk1EWi97dBu/2+kfYG6StG7i7Z8vucCkMNhZhibAzzXV/ez1xZAxFNoup
 DauJHg09cB9dTe6D6GurXYVyntLnbd2XWOczd1UNTZw2K0VlsKjCfYpdfe7atD6LDM8khumRcy
 f3Zp3ipp2XKm3oYiI7tk8kuejALLeY6Su413PEtIceoF43XkO8cjldn7ogcrs7ZEAse8upKZrr
 M8h2wACC0kcZuC1woo1DmZAnPRpJZl7KAOX9GEgM1kVlb8B6qj+g39aFTAfMUtvOpe1MtrV8+x
 C3c=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; d="scan'208";a="105815768"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 02 Dec 2020 01:58:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 01:58:50 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 01:58:47 -0700
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] ASoC: pcm_dmaengine: Add support for BE DAIs
Date: Wed, 2 Dec 2020 10:58:38 +0200
Message-ID: <20201202085838.1779525-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: lars@metafoo.de, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Considering the bellow scenarios:
                                                /- Gen DMA engine -\
       48KHz    ********     *******   44.1KHz  ********     *******     *********
PCM0 <-FE DAI-> * FE   * <-> * DSP * <-BE DAI-> *      *     *     *     *       *
                * Ring *     *     *            * Ring * <-> * CPU * <-> * Codec *
                * buff *     *******            * buff *     * DAI *     * DAI   *
       44.1KHz  ********                        *      *     *     *     *       *
PCM1 <--------------------DAI-----------------> *      *     *     *     *       *
                                                ********     *******     *********

For PCM0, we have two DAI links. The first DAI link is a FE, with a DSP as
a CPU DAI and a platform driver .The second DAI link is a BE DAI link,
with separate CPU, codec and platform drivers. We can also notice that
there are two Ring buffers: the first one used by the DSP to communicate
with the user-space and the second one used to move data between FE
(DSP) and BE (CPU).
PCM1 is a normal DAI link, with a CPU, codec and platform driver. It is
exactly the previous BE DAI link from PCM0, so the samples from user-space
are copied directly into the second Ring buffer.

In this scenario, the BE DAI link driver should be the same, since it is
decided at runtime whether the DAI is a used as a BE or not. The generic
platform driver needs to be aware of this thing. For the BE case (PCM0),
some callbacks of the platform driver are not called, hence the
preallocated buffer is not available. Also, the PCM runtime strcture
must not be touched, since it should be only used by the FE platform
driver.

With these changes, the generic dmaengine can also be used as a BE
platform driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Hello,
 
This patch is more or less incomplete for the described scenario. This
is because DMAengine's pcm->config is ignored for the BE DAI link, so
runtime->hw is not updated. Also, since pcm_construct/destruct are not
called, the DMA channels are allocated only if DT is used.
Underrun/overrun support would also be a nice to have for the transfers
involving the buffer allocated for the BE.
One way to hold trach of these would be to use a substream_be->runtime
different than the one used for the FE.

Please share your thoughts.

 sound/core/pcm_dmaengine.c            | 18 ++++++++++--
 sound/soc/soc-generic-dmaengine-pcm.c | 40 +++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 4d059ff2b2e4..5e96bc27628d 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -137,7 +137,9 @@ static void dmaengine_pcm_dma_complete(void *arg)
 	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
 		prtd->pos = 0;
 
-	snd_pcm_period_elapsed(substream);
+	/* do no update period for an internal PCM */
+	if (!substream->pcm->internal)
+		snd_pcm_period_elapsed(substream);
 }
 
 static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
@@ -147,6 +149,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	struct dma_async_tx_descriptor *desc;
 	enum dma_transfer_direction direction;
 	unsigned long flags = DMA_CTRL_ACK;
+	dma_addr_t addr;
 
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
@@ -154,11 +157,15 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 		flags |= DMA_PREP_INTERRUPT;
 
 	prtd->pos = 0;
+	if (substream->pcm->internal)
+		addr = substream->dma_buffer.addr;
+	else
+		addr = substream->runtime->dma_addr;
+
 	desc = dmaengine_prep_dma_cyclic(chan,
-		substream->runtime->dma_addr,
+		addr,
 		snd_pcm_lib_buffer_bytes(substream),
 		snd_pcm_lib_period_bytes(substream), direction, flags);
-
 	if (!desc)
 		return -ENOMEM;
 
@@ -315,6 +322,11 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 
 	substream->runtime->private_data = prtd;
 
+	if (substream->pcm->internal) {
+		substream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_IRAM;
+		substream->dma_buffer.dev.dev = chan->device->dev;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 9ef80a48707e..f403849cd1aa 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -97,6 +97,31 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
 		if (ret)
 			return ret;
 	}
+	if (!substream->pcm->internal) {
+		return snd_pcm_lib_malloc_pages(substream,
+						params_buffer_bytes(params));
+	}
+
+	/* allocate a buffer for BE DAI; for now, the buffer will have the same
+	 * size as the buffer used by the FE
+	 */
+	if (snd_dma_alloc_pages(substream->dma_buffer.dev.type,
+				substream->dma_buffer.dev.dev,
+				params_buffer_bytes(params),
+				&substream->dma_buffer) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int dmaengine_pcm_hw_free(struct snd_soc_component *component,
+				 struct snd_pcm_substream *substream)
+{
+	if (!substream->pcm->internal)
+		return 0;
+
+	snd_dma_free_pages(&substream->dma_buffer);
+	substream->dma_buffer.area = NULL;
 
 	return 0;
 }
@@ -157,9 +182,12 @@ static int dmaengine_pcm_open(struct snd_soc_component *component,
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	int ret;
 
-	ret = dmaengine_pcm_set_runtime_hwparams(component, substream);
-	if (ret)
-		return ret;
+	/* do not touch runtime if this is an internal PCM */
+	if (!substream->pcm->internal) {
+		ret = dmaengine_pcm_set_runtime_hwparams(component, substream);
+		if (ret)
+			return ret;
+	}
 
 	return snd_dmaengine_pcm_open(substream, chan);
 }
@@ -309,7 +337,7 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 			channel * (runtime->dma_bytes / runtime->channels);
 	int ret;
 
-	if (is_playback)
+	if (!substream->pcm->internal && is_playback)
 		if (copy_from_user(dma_ptr, buf, bytes))
 			return -EFAULT;
 
@@ -319,7 +347,7 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 			return ret;
 	}
 
-	if (!is_playback)
+	if (!substream->pcm->internal && !is_playback)
 		if (copy_to_user(buf, dma_ptr, bytes))
 			return -EFAULT;
 
@@ -332,6 +360,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.open		= dmaengine_pcm_open,
 	.close		= dmaengine_pcm_close,
 	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
@@ -344,6 +373,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.close		= dmaengine_pcm_close,
 	.hw_params	= dmaengine_pcm_hw_params,
 	.trigger	= dmaengine_pcm_trigger,
+	.hw_free	= dmaengine_pcm_hw_free,
 	.pointer	= dmaengine_pcm_pointer,
 	.copy_user	= dmaengine_copy_user,
 	.pcm_construct	= dmaengine_pcm_new,
-- 
2.27.0

