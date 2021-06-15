Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE14AC49361
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:52:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE34614A7
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE34614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA5F716B8;
	Tue, 15 Jun 2021 17:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA5F716B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623772341;
	bh=qna0s9b3nXSCyr1sPmpyt8aI5vVVDvjz9OIvUIi7AhQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5FWi1/hTxgiOrLKKZJWbgnddrVqwEf1h6AFpfIx5bhky08+R7dDfX15fkW0zZpQn
	 Z01uxhezyJTFSyE4e+litAXBh0EBrSYWT0sABx40feOTMb/97WGXvcGTbc8wf9N5UM
	 pEdW2xNWf5dSL+5Bb5k+6J4gX6uDWgNDUlOmncZg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78CE3F804CF;
	Tue, 15 Jun 2021 17:49:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77D76F8016C; Tue, 15 Jun 2021 17:49:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 023E5F8016C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 17:49:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 023E5F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="seR3FntE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1798D616E8;
 Tue, 15 Jun 2021 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623772154;
 bh=qna0s9b3nXSCyr1sPmpyt8aI5vVVDvjz9OIvUIi7AhQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=seR3FntE9zkj6LppACOScItQqLfurrMZPQ/iWcT0Nw9WoFP1gSI7NrIm50R4Zi6tr
 yAoppAWa4fJY1xVX2TmBU1OHh6vl1XVNYiuSbqaajrs7j7JD+vrRPG+8pnDdXmKRPc
 Zx+lL4AtM/+zBpf3M0epUwQL9ccvXw3uVwoUyHkl38ACZe+pogWAe9Q/VWQ/6vaLUF
 D1dfgr1FlUyVGWkhLnT0cD3/TSpG3vxB9mY43/h6qQX2gPoZyIjDtHd9Y8Hlolvwyk
 Mm9ahT3t+UqPAxrd1JQelrtqRFJ7/vI/CWh0u7yS6eto4XpcHjdR1GoXc/nKWxf1aj
 DCEBhGBuALrDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/30] ASoC: rt5659: Fix the lost powers for the
 HDA header
Date: Tue, 15 Jun 2021 11:48:42 -0400
Message-Id: <20210615154908.62388-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615154908.62388-1-sashal@kernel.org>
References: <20210615154908.62388-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>
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

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 6308c44ed6eeadf65c0a7ba68d609773ed860fbb ]

The power of "LDO2", "MICBIAS1" and "Mic Det Power" were powered off after
the DAPM widgets were added, and these powers were set by the JD settings
"RT5659_JD_HDA_HEADER" in the probe function. In the codec probe function,
these powers were ignored to prevent them controlled by DAPM.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Jack Yu <jack.yu@realtek.com>
Message-Id: <15fced51977b458798ca4eebf03dafb9@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5659.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 91a4ef7f620c..a9b079d56fd6 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -2433,13 +2433,18 @@ static int set_dmic_power(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget rt5659_particular_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5659_PWR_ANLG_3, RT5659_PWR_LDO2_BIT, 0,
 		NULL, 0),
-	SND_SOC_DAPM_SUPPLY("PLL", RT5659_PWR_ANLG_3, RT5659_PWR_PLL_BIT, 0,
-		NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5659_PWR_ANLG_2, RT5659_PWR_MB1_BIT,
+		0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Mic Det Power", RT5659_PWR_VOL,
 		RT5659_PWR_MIC_DET_BIT, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("PLL", RT5659_PWR_ANLG_3, RT5659_PWR_PLL_BIT, 0,
+		NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Mono Vref", RT5659_PWR_ANLG_1,
 		RT5659_PWR_VREF3_BIT, 0, NULL, 0),
 
@@ -2464,8 +2469,6 @@ static const struct snd_soc_dapm_widget rt5659_dapm_widgets[] = {
 		RT5659_ADC_MONO_R_ASRC_SFT, 0, NULL, 0),
 
 	/* Input Side */
-	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5659_PWR_ANLG_2, RT5659_PWR_MB1_BIT,
-		0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS2", RT5659_PWR_ANLG_2, RT5659_PWR_MB2_BIT,
 		0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS3", RT5659_PWR_ANLG_2, RT5659_PWR_MB3_BIT,
@@ -3660,10 +3663,23 @@ static int rt5659_set_bias_level(struct snd_soc_component *component,
 
 static int rt5659_probe(struct snd_soc_component *component)
 {
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_component_get_dapm(component);
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
 	rt5659->component = component;
 
+	switch (rt5659->pdata.jd_src) {
+	case RT5659_JD_HDA_HEADER:
+		break;
+
+	default:
+		snd_soc_dapm_new_controls(dapm,
+			rt5659_particular_dapm_widgets,
+			ARRAY_SIZE(rt5659_particular_dapm_widgets));
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

