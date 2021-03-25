Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB032C433C1
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:41:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA51619D5
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA51619D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 676D016D9;
	Thu, 25 Mar 2021 12:40:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 676D016D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616672464;
	bh=jV8Qh0a/nNuUyA6BX6n1VOUaTcmndklBGd6tE6qaqug=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GagiHwYQ8hIhaAd+10e/YBLaUCJi1QgkOF9G7gqaG4yC2DQpvOFAHd2Razaqg+t/b
	 Wxu5paMdhe/eZsKsAui4PwKmNpJgfJXs6g+rfftL6FEyyFu2DyYvt3T0ErDcrEFuE0
	 hdDG/ih4g9FT4cmGF3AsFXAcjGyZknsSUepXyGI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A151AF805C3;
	Thu, 25 Mar 2021 12:27:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CC64F805E7; Thu, 25 Mar 2021 12:27:56 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A16CAF80257
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:27:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A16CAF80257
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FWKizx5t"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A207B61A4C;
 Thu, 25 Mar 2021 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671655;
 bh=jV8Qh0a/nNuUyA6BX6n1VOUaTcmndklBGd6tE6qaqug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FWKizx5tXWLHiTmt+r8wgIjwMsvASb/eROW1RqZFA+VAr/lhk3qsrAQ924WsEidpN
 7HtQYu1SPA7c0+uamudra+i6+fr5Vs6RnsO/hvGrV6HNqft/0Ft8WE06OP8SGUKWsm
 i0ojWAu+HGEdV0ZjFWRSuTkX1RFJDY9zj5cyyO4cs3bdAgGpSXzbIVPMO6Odkmz1BW
 Kx/eLSPP1Sdruj3M/M37kU04tFKODZZXbhARZK2L2iDRpF9JmIdxVxqyjnkvVI+Gth
 W5xSQ1Fle31My/61+fScc2BizAqxym564xWicZlDbiKDNz09nx+KzRomI5zflZCbZI
 I9rXMVPWuJdNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/20] ASoC: cs42l42: Fix channel width support
Date: Thu, 25 Mar 2021 07:27:12 -0400
Message-Id: <20210325112724.1928174-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112724.1928174-1-sashal@kernel.org>
References: <20210325112724.1928174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Lucas Tanure <tanureal@opensource.cirrus.com>
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

From: Lucas Tanure <tanureal@opensource.cirrus.com>

[ Upstream commit 2bdc4f5c6838f7c3feb4fe68e4edbeea158ec0a2 ]

Remove the hard coded 32 bits width and replace with the correct width
calculated by params_width.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20210305173442.195740-3-tanureal@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l42.c | 47 ++++++++++++++++++--------------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index c7baa19bf317..a5bd9cff7085 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -695,24 +695,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					CS42L42_CLK_OASRC_SEL_MASK,
 					CS42L42_CLK_OASRC_SEL_12 <<
 					CS42L42_CLK_OASRC_SEL_SHIFT);
-			/* channel 1 on low LRCLK, 32 bit */
-			snd_soc_component_update_bits(component,
-					CS42L42_ASP_RX_DAI0_CH1_AP_RES,
-					CS42L42_ASP_RX_CH_AP_MASK |
-					CS42L42_ASP_RX_CH_RES_MASK,
-					(CS42L42_ASP_RX_CH_AP_LOW <<
-					CS42L42_ASP_RX_CH_AP_SHIFT) |
-					(CS42L42_ASP_RX_CH_RES_32 <<
-					CS42L42_ASP_RX_CH_RES_SHIFT));
-			/* Channel 2 on high LRCLK, 32 bit */
-			snd_soc_component_update_bits(component,
-					CS42L42_ASP_RX_DAI0_CH2_AP_RES,
-					CS42L42_ASP_RX_CH_AP_MASK |
-					CS42L42_ASP_RX_CH_RES_MASK,
-					(CS42L42_ASP_RX_CH_AP_HI <<
-					CS42L42_ASP_RX_CH_AP_SHIFT) |
-					(CS42L42_ASP_RX_CH_RES_32 <<
-					CS42L42_ASP_RX_CH_RES_SHIFT));
 			if (pll_ratio_table[i].mclk_src_sel == 0) {
 				/* Pass the clock straight through */
 				snd_soc_component_update_bits(component,
@@ -828,14 +810,29 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
-	int retval;
+	unsigned int width = (params_width(params) / 8) - 1;
+	unsigned int val = 0;
 
 	cs42l42->srate = params_rate(params);
-	cs42l42->swidth = params_width(params);
 
-	retval = cs42l42_pll_config(component);
+	switch(substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		val |= width << CS42L42_ASP_RX_CH_RES_SHIFT;
+		/* channel 1 on low LRCLK */
+		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_CH1_AP_RES,
+							 CS42L42_ASP_RX_CH_AP_MASK |
+							 CS42L42_ASP_RX_CH_RES_MASK, val);
+		/* Channel 2 on high LRCLK */
+		val |= CS42L42_ASP_RX_CH_AP_HI << CS42L42_ASP_RX_CH_AP_SHIFT;
+		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_CH2_AP_RES,
+							 CS42L42_ASP_RX_CH_AP_MASK |
+							 CS42L42_ASP_RX_CH_RES_MASK, val);
+		break;
+	default:
+		break;
+	}
 
-	return retval;
+	return cs42l42_pll_config(component);
 }
 
 static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
@@ -900,9 +897,9 @@ static int cs42l42_digital_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-#define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE | \
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE | \
-			SNDRV_PCM_FMTBIT_S32_LE)
+#define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE )
 
 
 static const struct snd_soc_dai_ops cs42l42_ops = {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 9d04ed75e5c8..23b1a63315ca 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -761,7 +761,6 @@ struct  cs42l42_private {
 	struct completion pdn_done;
 	u32 sclk;
 	u32 srate;
-	u32 swidth;
 	u8 plug_state;
 	u8 hs_type;
 	u8 ts_inv;
-- 
2.30.1

