Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B02C55ABD
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 10:10:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6253B20797
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 10:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gGFdYjN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6253B20797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuvoton.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C065C16E8;
	Tue, 10 Nov 2020 11:09:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C065C16E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605003042;
	bh=ZRA5ar5oRc9KhH4sv/bc040jD4W2h07i50b8bs/x4TE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gGFdYjN6E3TBBoju0MIkaMzYdIYf9REnLDpqiKVcq1Pu11N0FVCo0v1x8OHkmL0+4
	 JOe49mCLK2Gf/W/iF4UYKAu+Qmwg8ykSFYpZgDy4ut++LsBD2f7lKdL8wWn8yLVWVs
	 D8Ij3fOEzXiZptGmpkaoIFFHV4eAlOPR9fC2IQYc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36BF7F80161;
	Tue, 10 Nov 2020 11:09:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5789F801D5; Tue, 10 Nov 2020 11:09:50 +0100 (CET)
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 7C2E1F80059
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 11:09:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C2E1F80059
Received: from NTHCCAS04.nuvoton.com (nthccas04.nuvoton.com [10.1.8.29])
 by maillog.nuvoton.com (Postfix) with ESMTP id 08E961C80F3D;
 Tue, 10 Nov 2020 18:09:39 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Nov 2020 18:09:38 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.1847.3 via Frontend
 Transport; Tue, 10 Nov 2020 18:09:38 +0800
From: David Lin <CTLIN0@nuvoton.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: nau8315: revise the power event of EN_PIN dapm
 widget for symmetry
Date: Tue, 10 Nov 2020 17:58:25 +0800
Message-ID: <20201110095823.3512447-1-CTLIN0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102023212.594137-1-CTLIN0@nuvoton.com>
References: <20201102023212.594137-1-CTLIN0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotRedirectTo-PP: TRUE
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, KCHSU0@nuvoton.com,
 lgirdwood@gmail.com, YHCHuang@nuvoton.com, David Lin <CTLIN0@nuvoton.com>
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

This patch is to revise the power event of EN_PIN dapm widget for symmetry.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
---
 sound/soc/codecs/nau8315.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8315.c b/sound/soc/codecs/nau8315.c
index e6bc5c0a5036..2b66e3f7a8b7 100644
--- a/sound/soc/codecs/nau8315.c
+++ b/sound/soc/codecs/nau8315.c
@@ -65,7 +65,7 @@ static int nau8315_enpin_event(struct snd_soc_dapm_widget *w,
 	struct nau8315_priv *nau8315 =
 		snd_soc_component_get_drvdata(component);
 
-	if (event & SND_SOC_DAPM_POST_PMU)
+	if (event & SND_SOC_DAPM_PRE_PMU)
 		nau8315->enpin_switch = 1;
 	else if (event & SND_SOC_DAPM_POST_PMD)
 		nau8315->enpin_switch = 0;
@@ -77,7 +77,7 @@ static const struct snd_soc_dapm_widget nau8315_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Speaker"),
 	SND_SOC_DAPM_OUT_DRV_E("EN_Pin", SND_SOC_NOPM, 0, 0, NULL, 0,
 			nau8315_enpin_event,
-			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route nau8315_dapm_routes[] = {
-- 
2.25.1

