Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE49C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:43:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1270B60240
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1270B60240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3B2416BA;
	Tue, 21 Sep 2021 23:42:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3B2416BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632260583;
	bh=tBTmSySfLPKEPabaMellE/V522O8P+h67TeK2y/iQkY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ms28nP0yUpbj2uQlVuGGPdk0cLv+A4FoSZOOrDi1sHaND9AGroDXEan763GDYjOwp
	 aSeC6QyJNYyQHWo1xvIRkWPBCMjrln0qHIWorgOFDDdHQGhY3Y4XxGMHwXUyykggk2
	 ZR4xtdFTv4y5o7+efsJK9IQFTLPOGKbM7oTEUe/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A18D2F80551;
	Tue, 21 Sep 2021 23:37:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D248F80552; Tue, 21 Sep 2021 23:37:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA1EAF8053B
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:37:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA1EAF8053B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lGLPyysB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 185A261019;
 Tue, 21 Sep 2021 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632260244;
 bh=tBTmSySfLPKEPabaMellE/V522O8P+h67TeK2y/iQkY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lGLPyysBCGU1zepwlNZzaX5AauEv5DcFvwEB/5WPHoPH24pVbrDT8akdjyHVnkSyG
 fwEg2u4kcQvLaQIPT81xKUd39rDmP/qowmo5KBqf+06YX781ZuvlUJl3OexBKY9OfU
 eiZd/DaM+pGhQe/cfLdkep/lo+8fX/wK2eAuAebhco+bj1FyN9SwtfIuM7bWzgaFur
 wHuFRKdBJtTpIVnNABdChT0PR24cTBmHiJInuXkDERCI1EVSZ63cnQCaOizp13+zca
 DOZTL9DXAoPiXYRQHNt5WwPJ28ckcHXFAF4Yzarbwk+N7AeEfyxqVEbbwFWvUlUvz5
 pofDJtGOHRq/w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH v2 15/16] ASoC: pl1022_ds: Update to modern clocking
 terminology
Date: Tue, 21 Sep 2021 22:35:41 +0100
Message-Id: <20210921213542.31688-15-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
References: <20210921213542.31688-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; h=from:subject;
 bh=tBTmSySfLPKEPabaMellE/V522O8P+h67TeK2y/iQkY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSk8eraBkqj0wEwEH9n/wZXSoslC7ytCzj5bPJuG2
 iiO9U+uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpPHgAKCRAk1otyXVSH0Fr3B/
 wK8fSgybKNjVM+xJHjb6+L2EDuvGrI3VzlhLgI/HK0LcX9s9mKjRnCY9ABRJwdS7SER6Vo6bgjLMi3
 pzNTx7LbJ+vOmmlBF6Cc2ZRi7TqwVFV1JRsMUfdiXhqQoBFPwVjMzVWTJEKbYPjQe+ZK8fwOhm1jzE
 Eu27tYyDxLMvsTBsmsaA6hoCoK4/pwHhw/ob6IZ7arSmHtCPY0irKEW9W/N2M3RUbSyX8FHNnuWAXT
 YJjc/6MvlaVjZ3SZmbIsUDSlCKh+Dv/o8gnB5bW8y6lRp+PkMtOz/Cp1hHjZcnON5gTzUR7S2AXEK/
 xtQzclLbjUMG3YxwHJ0JISbaj6YEGP
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
the pl1022_ds driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/p1022_ds.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 317c767b0099..b45742931b0d 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -275,7 +275,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 
 	if (strcasecmp(sprop, "i2s-slave") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 
@@ -293,37 +293,37 @@ static int p1022_ds_probe(struct platform_device *pdev)
 		mdata->clk_frequency = be32_to_cpup(iprop);
 	} else if (strcasecmp(sprop, "i2s-master") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBC_CFC;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "lj-slave") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBP_CFP;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "lj-master") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBC_CFC;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "rj-slave") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBP_CFP;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "rj-master") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_CBC_CFC;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBM_CFM;
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBP_CFP;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_IN;
 	} else if (strcasecmp(sprop, "ac97-master") == 0) {
 		mdata->dai_format = SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBS_CFS;
+			SND_SOC_DAIFMT_AC97 | SND_SOC_DAIFMT_CBC_CFC;
 		mdata->codec_clk_direction = SND_SOC_CLOCK_IN;
 		mdata->cpu_clk_direction = SND_SOC_CLOCK_OUT;
 	} else {
-- 
2.20.1

