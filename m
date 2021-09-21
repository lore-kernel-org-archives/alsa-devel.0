Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9220C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:15:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6316860F70
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6316860F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC4DD167F;
	Tue, 21 Sep 2021 23:14:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC4DD167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632258901;
	bh=QnS5Cga8MAQ6BFduVQ+0hsBboMZot1AdyZOYHd/YW4M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N5LGGDlFGVvSvazlPrsceClHyHd5xceOYz2hpRSQY43Vd2YK27PepaoWJweZVK8Ky
	 WUrR/bceGd61Q9+0T3sSxpeW6C7arOeAVC/z1nH4wxhwgB3qWD9q5U4DGonE7Necx0
	 5XFVQOYdEgw9h7BQUaWSzhGeMh+ngSTSjLYQ9aR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F6CBF80517;
	Tue, 21 Sep 2021 23:11:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E7ABF80508; Tue, 21 Sep 2021 23:11:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 094ECF804E5
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:11:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 094ECF804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fD5r1+S/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA27D60F38;
 Tue, 21 Sep 2021 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632258704;
 bh=QnS5Cga8MAQ6BFduVQ+0hsBboMZot1AdyZOYHd/YW4M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fD5r1+S/1nCsv6H4NjZ+G0hNpCUEsKHVUIVQgiM39Kn/HaHfDO6faQS5rh7CX0F+u
 Y8pqjWv5Se1dykNALBcIzce4TEPOy49nleFWILJUOKBf2d0gEaVvsis35Kr9KCv5Lp
 vokNgEj3NrqMNnAT5TZ8G4BiVxSUkgVGnhnlo4/FVZupzMLKUS7jO7t/61IuIPdKP7
 VBM9hT9DGfQtQMMgz17oYVCxZNQ44mLRMm0PqRGjTjeQyd5BHZ9jbRSNGPaXRmA56p
 Cz7WmKrHa16XhxDu98ZYKTFTgYgz8gLqnShsWTUv6akmI6WdcPXpXoZi2e5DsG945e
 EewfwBOwgRPVg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 08/16] ASoC: imx-audmix: Update to modern clocking terminology
Date: Tue, 21 Sep 2021 22:10:32 +0100
Message-Id: <20210921211040.11624-8-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921211040.11624-1-broonie@kernel.org>
References: <20210921211040.11624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; h=from:subject;
 bh=QnS5Cga8MAQ6BFduVQ+0hsBboMZot1AdyZOYHd/YW4M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSknhpSHJMIZLeNDcthjEQHy+0FccpWtf96EdaQPR
 DPI46haJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpJ4QAKCRAk1otyXVSH0DHnB/
 90xHZIal1qmot1WZQkjlkBZSWPffQoQQQPbj4n7ljDk1kSVX4/Ej2XURCFegAs2Dkevp5H9eOFOw1O
 2i2Uxoo7lpzFo2NSnLwDlPZZqcgGLZxch4MNmsQCYioyqGOK2e2KUICKCym4HMMcXDF39UH2AL6RfZ
 aCusdVhPNN3Jj7KqNIVJ1HAasORBhblIPZf7xR56Cok9Yar01VV3mkhMFhFIsgfZAIj3LnsLdCnPLV
 EAqNKOWKM0HG+7QfRnt1yF2TgBjlCZ5PhEDSE25lzhAYKggEK4F9Iee9l3BxlSLS3v7DZt+t/qIEGI
 4Leu4+L67s/6u5+7JGIZAeMr05/9hO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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

As part of moving to remove the old style defines for the bus clocks update
the imx-audmix driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index a364e2415de0..e8b438a0329e 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -80,8 +80,8 @@ static int imx_audmix_fe_hw_params(struct snd_pcm_substream *substream,
 	u32 channels = params_channels(params);
 	int ret, dir;
 
-	/* For playback the AUDMIX is slave, and for record is master */
-	fmt |= tx ? SND_SOC_DAIFMT_CBS_CFS : SND_SOC_DAIFMT_CBM_CFM;
+	/* For playback the AUDMIX is consumer, and for record is provider */
+	fmt |= tx ? SND_SOC_DAIFMT_CBC_CFC : SND_SOC_DAIFMT_CBP_CFP;
 	dir  = tx ? SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN;
 
 	/* set DAI configuration */
@@ -121,8 +121,8 @@ static int imx_audmix_be_hw_params(struct snd_pcm_substream *substream,
 	if (!tx)
 		return 0;
 
-	/* For playback the AUDMIX is slave */
-	fmt |= SND_SOC_DAIFMT_CBM_CFM;
+	/* For playback the AUDMIX is consumer */
+	fmt |= SND_SOC_DAIFMT_CBP_CFP;
 
 	/* set AUDMIX DAI configuration */
 	ret = snd_soc_dai_set_fmt(asoc_rtd_to_cpu(rtd, 0), fmt);
-- 
2.20.1

