Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2322C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:51:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E48E20672
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fhDNJVVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E48E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B51191752;
	Thu, 30 Jul 2020 09:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B51191752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596095516;
	bh=5wJeYPAhJ0SjwhIdomOZBEPpFm4qPGb6yG7/O2uLQT4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fhDNJVVifK7gG7WcOyqY1SOnHIpL616O3vMYkDOMl/H1S+w55AwYZMndlf/1Bz3eZ
	 1lZtNSOIvJyUDgRPKMCPy5efkax2jjAcFbLKIsaJtyTj9Hon9OxYrTQFFWLum/16r6
	 MMY+2XcSRzmPpvz6IEYeCNjHcRFjJ6S8YiWEq9w4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42C73F8021C;
	Thu, 30 Jul 2020 09:51:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EA93F8021E; Thu, 30 Jul 2020 09:51:05 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13775F800C9
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 09:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13775F800C9
Received: from [123.112.106.30] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1k13L5-0000Wf-HG; Thu, 30 Jul 2020 07:50:56 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org, Vijendar.Mukunda@amd.com
Subject: [PATCH] ASoC: amd: renoir: restore two more registers during resume
Date: Thu, 30 Jul 2020 15:50:20 +0800
Message-Id: <20200730075020.15667-1-hui.wang@canonical.com>
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
registers are set in the resume() too, this issue could be fixed.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 623dfd3ea705..8acb0315a169 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -474,6 +474,11 @@ static int acp_pdm_resume(struct device *dev)
 		rtd = runtime->private_data;
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
 		buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
+		if (runtime->channels == TWO_CH) {
+			rn_writel(0x0 , rtd->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
+			rn_writel(PDM_DECIMATION_FACTOR, rtd->acp_base +
+				  ACP_WOV_PDM_DECIMATION_FACTOR);
+		}
 		config_acp_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
 		init_pdm_ring_buffer(MEM_WINDOW_START, buffer_len, period_bytes,
 				     adata->acp_base);
-- 
2.17.1

