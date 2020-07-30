Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F6DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:33:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A98D2074B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ea4lzMOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A98D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3BAF178C;
	Thu, 30 Jul 2020 14:32:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3BAF178C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596112379;
	bh=+5Ib50On5cErgNCxGiPKKyvnvAVeTnivCKBFdobnS/8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ea4lzMOoMTnTYZUdjMxZdAm1awbdtI2rO9MTSXjKxkBQ6IBRg9Nmo5nXOeBrp/jBt
	 XjAuFPbhTyLacbRZqPk3LMHgVtJ7aTneJ1GVj0NL0PTB+3WEj/b6Rin9+MJuYSnaWA
	 2HjyHPlgvJ11cj4GiR+xLD8jJTz1Ige7zJIesGqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 746B3F8021C;
	Thu, 30 Jul 2020 14:32:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AFE5F8021E; Thu, 30 Jul 2020 14:32:06 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7FCDF800C9
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 14:31:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7FCDF800C9
Received: from [123.112.106.30] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1k17iz-0005pe-S5; Thu, 30 Jul 2020 12:31:54 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
Subject: [PATCH v2] ASoC: amd: renoir: restore two more registers during resume
Date: Thu, 30 Jul 2020 20:31:38 +0800
Message-Id: <20200730123138.5659-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: stable@vger.kernel.org
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

Recently we found an issue about the suspend and resume. If dmic is
recording the sound, and we run suspend and resume, after the resume,
the dmic can't work well anymore. we need to close the app and reopen
the app, then the dmic could record the sound again.

For example, we run "arecord -D hw:CARD=acp,DEV=0 -f S32_LE -c 2
-r 48000 test.wav", then suspend and resume, after the system resume
back, we speak to the dmic. then stop the arecord, use aplay to play
the test.wav, we could hear the sound recorded after resume is weird,
it is not what we speak to the dmic.

I found two registers are set in the dai_hw_params(), if the two
registers are set during the resume, this issue could be fixed.
Move the code of the dai_hw_params() into the pdm_dai_trigger(), then
these two registers will be set during resume since pdm_dai_trigger()
will be called during resume. And delete the empty function
dai_hw_params().

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 29 +++++++++-------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 623dfd3ea705..7b14d9a81b97 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -314,40 +314,30 @@ static int acp_pdm_dma_close(struct snd_soc_component *component,
 	return 0;
 }
 
-static int acp_pdm_dai_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *dai)
+static int acp_pdm_dai_trigger(struct snd_pcm_substream *substream,
+			       int cmd, struct snd_soc_dai *dai)
 {
 	struct pdm_stream_instance *rtd;
+	int ret;
+	bool pdm_status;
 	unsigned int ch_mask;
 
 	rtd = substream->runtime->private_data;
-	switch (params_channels(params)) {
+	ret = 0;
+	switch (substream->runtime->channels) {
 	case TWO_CH:
 		ch_mask = 0x00;
 		break;
 	default:
 		return -EINVAL;
 	}
-	rn_writel(ch_mask, rtd->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
-	rn_writel(PDM_DECIMATION_FACTOR, rtd->acp_base +
-		  ACP_WOV_PDM_DECIMATION_FACTOR);
-	return 0;
-}
-
-static int acp_pdm_dai_trigger(struct snd_pcm_substream *substream,
-			       int cmd, struct snd_soc_dai *dai)
-{
-	struct pdm_stream_instance *rtd;
-	int ret;
-	bool pdm_status;
-
-	rtd = substream->runtime->private_data;
-	ret = 0;
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		rn_writel(ch_mask, rtd->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+		rn_writel(PDM_DECIMATION_FACTOR, rtd->acp_base +
+			  ACP_WOV_PDM_DECIMATION_FACTOR);
 		rtd->bytescount = acp_pdm_get_byte_count(rtd,
 							 substream->stream);
 		pdm_status = check_pdm_dma_status(rtd->acp_base);
@@ -369,7 +359,6 @@ static int acp_pdm_dai_trigger(struct snd_pcm_substream *substream,
 }
 
 static struct snd_soc_dai_ops acp_pdm_dai_ops = {
-	.hw_params = acp_pdm_dai_hw_params,
 	.trigger   = acp_pdm_dai_trigger,
 };
 
-- 
2.17.1

