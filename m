Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD72C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56959207D8
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bsBQw2eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56959207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB5D01681;
	Fri, 12 Jun 2020 09:50:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB5D01681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591948301;
	bh=lkRZCjA8/+V/cWEodiZko2HWNlcYg1MX9hzjIhp81H4=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=bsBQw2ePygHXe8QJ9eLmEsAgsTPpKrFcmo8GZT8Abdr7ttuJLkNEMEN/lTuZ7eeAN
	 9o1xHhyqIS1ZP3L6NMP8ohuw3AGcnGCKyoDgG6kDBWvymg8FSsh0kwsbM60yBpIpv4
	 FbZ09bDpGCmG/YplUrbwEIGtq2DgqP03H1t4H4vk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4854FF802D2;
	Fri, 12 Jun 2020 09:49:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6E6DF802BE; Fri, 12 Jun 2020 09:48:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2D8BF8021E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 09:48:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2D8BF8021E
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20D9F1A0B79;
 Fri, 12 Jun 2020 09:48:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07E061A0B77;
 Fri, 12 Jun 2020 09:48:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B54D1402FF;
 Fri, 12 Jun 2020 15:48:39 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 3/4] ASoC: fsl_asrc_dma: Reuse the dma channel if
 available in Back-End
Date: Fri, 12 Jun 2020 15:37:50 +0800
Message-Id: <3a79f0442cb4930c633cf72145cfe95a45b9c78e.1591947428.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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

The dma channel has been requested by Back-End cpu dai driver already.
If fsl_asrc_dma requests dma chan with same dma:tx symlink, then
there will be below warning with SDMA.

[   48.174236] fsl-esai-dai 2024000.esai: Cannot create DMA dma:tx symlink

So if we can reuse the dma channel of Back-End, then the issue can be
fixed.

In order to get the dma channel which is already requested in Back-End.
we use the exported two functions (snd_soc_lookup_component_nolocked
and soc_component_to_pcm). If we can get the dma channel, then reuse it,
if can't, then request a new one.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index d6a3fc5f87e5..d88e6343e0a2 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -135,6 +135,8 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	struct snd_dmaengine_dai_dma_data *dma_params_be = NULL;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
+	struct dma_chan *tmp_chan = NULL, *be_chan = NULL;
+	struct snd_soc_component *component_be = NULL;
 	struct fsl_asrc *asrc = pair->asrc;
 	struct dma_slave_config config_fe, config_be;
 	enum asrc_pair_index index = pair->index;
@@ -142,7 +144,6 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	int stream = substream->stream;
 	struct imx_dma_data *tmp_data;
 	struct snd_soc_dpcm *dpcm;
-	struct dma_chan *tmp_chan;
 	struct device *dev_be;
 	u8 dir = tx ? OUT : IN;
 	dma_cap_mask_t mask;
@@ -197,18 +198,30 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_CYCLIC, mask);
 
+	/*
+	 * The Back-End device might have already requested a DMA channel,
+	 * so try to reuse it first, and then request a new one upon NULL.
+	 */
+	component_be = snd_soc_lookup_component_nolocked(dev_be, SND_DMAENGINE_PCM_DRV_NAME);
+	if (component_be) {
+		be_chan = soc_component_to_pcm(component_be)->chan[substream->stream];
+		tmp_chan = be_chan;
+	}
+	if (!tmp_chan)
+		tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
+
 	/*
 	 * An EDMA DEV_TO_DEV channel is fixed and bound with DMA event of each
 	 * peripheral, unlike SDMA channel that is allocated dynamically. So no
-	 * need to configure dma_request and dma_request2, but get dma_chan via
-	 * dma_request_slave_channel directly with dma name of Front-End device
+	 * need to configure dma_request and dma_request2, but get dma_chan of
+	 * Back-End device directly via dma_request_slave_channel.
 	 */
 	if (!asrc->use_edma) {
 		/* Get DMA request of Back-End */
-		tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
 		tmp_data = tmp_chan->private;
 		pair->dma_data.dma_request = tmp_data->dma_request;
-		dma_release_channel(tmp_chan);
+		if (!be_chan)
+			dma_release_channel(tmp_chan);
 
 		/* Get DMA request of Front-End */
 		tmp_chan = asrc->get_dma_channel(pair, dir);
@@ -221,6 +234,8 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 		pair->dma_chan[dir] =
 			dma_request_channel(mask, filter, &pair->dma_data);
 	} else {
+		if (!be_chan)
+			dma_release_channel(tmp_chan);
 		pair->dma_chan[dir] =
 			asrc->get_dma_channel(pair, dir);
 	}
-- 
2.21.0

