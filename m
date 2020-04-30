Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29320C28CBC
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFEB2076D
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hApLqW99";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSMFJE9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFEB2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0073016C3;
	Thu, 30 Apr 2020 16:09:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0073016C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588255832;
	bh=yVDzDf7BPjN8V3Q1sj6RasbrxByVjWam1uXEnqFNqCI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hApLqW99mfBWfX1Zzl18ShArst/sTCjG8Xn+lMSrpY0HKXTrHHJi+YW2l8eS7qKi/
	 uTRPGGF6EuG1QPmXQc9vwqQEMaeFQY55EmwK1M4ghQCc4BUE978G47uB1sYu7C7iB6
	 C3+vxQr3ZfxgJnrVhr6UYRAnhZ6wJTPXc6AxQv7I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07CDCF803D1;
	Thu, 30 Apr 2020 15:53:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD52BF803AF; Thu, 30 Apr 2020 15:53:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83458F80371
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:52:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83458F80371
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YSMFJE9O"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 484EC208D6;
 Thu, 30 Apr 2020 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254765;
 bh=yVDzDf7BPjN8V3Q1sj6RasbrxByVjWam1uXEnqFNqCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YSMFJE9OiX3uoaACvAsghtvRXNeshOFE856YUdaLMBtM+opDBhu3E2HPefVXnILN2
 j2kmmYw0Kjg+lgacxxXoDGNl0vauE33NgpDQ2T9FTjegxEILXOvIrPFtqdFDFimnmo
 ky3sZoKvPckTAyutniKwxh24nuMwS9HL3lgaN3Ho=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/57] ASoC: stm32: sai: fix sai probe
Date: Thu, 30 Apr 2020 09:51:44 -0400
Message-Id: <20200430135218.20372-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@st.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit e2bcb65782f91390952e849e21b82ed7cb05697f ]

pcm config must be set before snd_dmaengine_pcm_register() call.

Fixes: 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200417142122.10212-1-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d3259de43712b..7e965848796c3 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1543,6 +1543,9 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		conf = &stm32_sai_pcm_config_spdif;
+
 	ret = snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register pcm dma\n");
@@ -1551,15 +1554,10 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
-	if (ret) {
+	if (ret)
 		snd_dmaengine_pcm_unregister(&pdev->dev);
-		return ret;
-	}
-
-	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
-		conf = &stm32_sai_pcm_config_spdif;
 
-	return 0;
+	return ret;
 }
 
 static int stm32_sai_sub_remove(struct platform_device *pdev)
-- 
2.20.1

