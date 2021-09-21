Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628CC433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:14:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E715A61159
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E715A61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 895371690;
	Tue, 21 Sep 2021 23:13:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 895371690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632258888;
	bh=G7kWIcw4ckECqndMsfL0TFZeJcsVijEwbp3xeXyzy6s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PeIkVC3UiatWNQs1rmKzvYMV/kGrjclpA8V886XAzdT+N0XRTKo9djwlukblDsAu/
	 UtS7r/T6MYe3Mh9HQy6Pd1OhcKrsuLTjYH9PlDtIaRMl3/mKWG1mE2HXx590OoCEY1
	 SrpTAz9fEQ7uc2o2chmZIhjYbcj4Rdsjcjmu1Uv8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9710F8050F;
	Tue, 21 Sep 2021 23:11:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAF39F804FB; Tue, 21 Sep 2021 23:11:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73484F804BD
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73484F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PsjLy/hB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3515B61183;
 Tue, 21 Sep 2021 21:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632258701;
 bh=G7kWIcw4ckECqndMsfL0TFZeJcsVijEwbp3xeXyzy6s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PsjLy/hBB6UWCI6Kqc2TIxyW85Bou9MeIKQyUy1/xyeqYXxgFzZKdcIbTqAkOeNzn
 NaMdoh4LriHYw5NIpmO7bqWVkx8ohNLhveRKJSwssP4u49VNL5ITo+Knz0Ct8xi/xj
 t4mdso3roYEriOkLZjJhPaQaOZCLWN3O6yYFvTSGu4cFHE4cRhoWXMInaettA5Xxir
 pOUbJva8blpTMXzuuj71CXQboX6lmN6ekU9I9xskIidoSX/M30wXSjzOr5AJf5IsRz
 gIVHRegFiHUj5hUb3dCBQLs73KgPngOJwb0m+tPBNitmHSDwV1wZLQyRKNVUD/L1o6
 afL0RwQzHo4VA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 07/16] ASoC: fsl_ssi: Update to modern clocking terminology
Date: Tue, 21 Sep 2021 22:10:31 +0100
Message-Id: <20210921211040.11624-7-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210921211040.11624-1-broonie@kernel.org>
References: <20210921211040.11624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4340; h=from:subject;
 bh=G7kWIcw4ckECqndMsfL0TFZeJcsVijEwbp3xeXyzy6s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSkngHTyBkFIgFWPSSM7RcGqhjDLLq/Qb3JfQlk8H
 8gmQD6yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpJ4AAKCRAk1otyXVSH0G2BB/
 sF9aJ4jZPP6vggj6+7K060eK1tyHT0dnGkA3fYcn96JzLSw4rLED1j5mRho8zNwiLb7uC/RnMyawLh
 VteJ0ZKPET7zWw3O/Praj75sZNWPgZ0aFR2OwLV/SixPB4p89je/SmRnmzvu8vac34tiqQ/AIBuKvo
 RbUflDKTvkWBZVHaqigvHbgBcvKngEhkZmNTJOpYaGGTxq1a/eg7Z1KANRzo/C5DGAmJLbAy0fln7h
 wrFwuY91yfWxRvqWeOmU/nvOvlckOxTEtPDkhoBmgo8on+55GqCxlhTObw4qDbALEhohi1zwjklTv7
 +40yNLXSZGulZNM+Q7WmIDQQi4veCz
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
the fsl_ssi driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ecbc1c365d5b..1169d1104b9e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -350,16 +350,16 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi *ssi)
 		SND_SOC_DAIFMT_AC97;
 }
 
-static bool fsl_ssi_is_i2s_master(struct fsl_ssi *ssi)
+static bool fsl_ssi_is_i2s_clock_provider(struct fsl_ssi *ssi)
 {
-	return (ssi->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
-		SND_SOC_DAIFMT_CBS_CFS;
+	return (ssi->dai_fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
+		SND_SOC_DAIFMT_CBC_CFC;
 }
 
-static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi *ssi)
+static bool fsl_ssi_is_i2s_cbp_cfc(struct fsl_ssi *ssi)
 {
-	return (ssi->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
-		SND_SOC_DAIFMT_CBM_CFS;
+	return (ssi->dai_fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
+		SND_SOC_DAIFMT_CBP_CFC;
 }
 
 /**
@@ -808,7 +808,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	u32 wl = SSI_SxCCR_WL(sample_size);
 	int ret;
 
-	if (fsl_ssi_is_i2s_master(ssi)) {
+	if (fsl_ssi_is_i2s_clock_provider(ssi)) {
 		ret = fsl_ssi_set_bclk(substream, dai, hw_params);
 		if (ret)
 			return ret;
@@ -841,7 +841,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		u8 i2s_net = ssi->i2s_net;
 
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
-		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
+		if (fsl_ssi_is_i2s_cbp_cfc(ssi) && sample_size == 16)
 			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
 
 		/* Use Normal mode to send mono data at 1st slot of 2 slots */
@@ -865,7 +865,7 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
 
-	if (fsl_ssi_is_i2s_master(ssi) &&
+	if (fsl_ssi_is_i2s_clock_provider(ssi) &&
 	    ssi->baudclk_streams & BIT(substream->stream)) {
 		clk_disable_unprepare(ssi->baudclk);
 		ssi->baudclk_streams &= ~BIT(substream->stream);
@@ -891,18 +891,18 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 	ssi->i2s_net = SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBS_CFS:
+		switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+		case SND_SOC_DAIFMT_CBC_CFC:
 			if (IS_ERR(ssi->baudclk)) {
 				dev_err(ssi->dev,
 					"missing baudclk for master mode\n");
 				return -EINVAL;
 			}
 			fallthrough;
-		case SND_SOC_DAIFMT_CBM_CFS:
+		case SND_SOC_DAIFMT_CBP_CFC:
 			ssi->i2s_net |= SSI_SCR_I2S_MODE_MASTER;
 			break;
-		case SND_SOC_DAIFMT_CBM_CFM:
+		case SND_SOC_DAIFMT_CBP_CFP:
 			ssi->i2s_net |= SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
@@ -962,17 +962,17 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	/* DAI clock master masks */
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
+	/* DAI clock provider masks */
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
 		/* Output bit and frame sync clocks */
 		strcr |= SSI_STCR_TFDIR | SSI_STCR_TXDIR;
 		scr |= SSI_SCR_SYS_CLK_EN;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBP_CFP:
 		/* Input bit or frame sync clocks */
 		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBP_CFC:
 		/* Input bit clock but output frame sync clock */
 		strcr |= SSI_STCR_TFDIR;
 		break;
@@ -1341,7 +1341,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		}
 	}
 
-	/* Do not error out for slave cases that live without a baud clock */
+	/* Do not error out for consumer cases that live without a baud clock */
 	ssi->baudclk = devm_clk_get(dev, "baud");
 	if (IS_ERR(ssi->baudclk))
 		dev_dbg(dev, "failed to get baud clock: %ld\n",
-- 
2.20.1

