Return-Path: <SRS0=ibvm=M4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09AAC4338F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 16:13:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5563C61157
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 16:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5563C61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F223016BF;
	Thu,  5 Aug 2021 18:12:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F223016BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628180030;
	bh=gLWwfdHMXRCISd9JHzBiFIWvqEOcAc0KIfWm3z9PRpA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c9SNKARGbkJxDMmN7xqFcZaCsyonSz2vVxS0xnO74VBDxCHAkJ5noDVWZH5fQ5KsB
	 gNyiH6sqml8j1+ooZfRneXAuJIty/1zr9/DPE/zjSkBTnKRxZ47sQIeWBzLYWNiKcQ
	 CSUJmdl8c5HPBgIBSqDnBC0NT9eAezgh0PjNTbTI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9A9CF8032C;
	Thu,  5 Aug 2021 18:11:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BE14F804F1; Thu,  5 Aug 2021 18:11:31 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AB0DF8049E
 for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2021 18:11:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AB0DF8049E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="SMW8D6Dk"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3V027692; 
 Thu, 5 Aug 2021 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=vCMiMKEoQoT9e4PyNQhrHRqJbFjPpEaQ/Av0RBhrd/M=;
 b=SMW8D6Dk6Un0zKpq2JDhFlpeKax36StYwgHMZYY2PaVWgJgWUtjNap2uN6xRJQX8Vz0b
 8slMh/hZuAWUbmTjOgr93YL6lyEHp0ECLwx1e7l3acvgsEy6Gd7DNJnf95YPIV4WRu+M
 lAZm8RmqKRsE3fj/1Ie61KImb3BJvA6MSPVulvgI9jajbUtTDZ617nhprQh4PfqU1AUQ
 hE1/uk/dZPieU8k93R39hVHLq01jl7MFCZz0fk1fT1tropGr5ROTmbZlz7gkt/9MW6Q2
 0eRGaike+HAtFEROWwGEN/zrdGJhlbt1Z0aMSpoTviu3iRHt8KYhrlKyflkMrrlWf0Up tg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 05 Aug 2021 11:11:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 17:11:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 5 Aug 2021 17:11:13 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com
 [198.61.65.37])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 399002BA;
 Thu,  5 Aug 2021 16:11:13 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/8] ASoC: cs42l42: PLL must be running when changing
 MCLK_SRC_SEL
Date: Thu, 5 Aug 2021 17:11:04 +0100
Message-ID: <20210805161111.10410-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q7Oxb2S5r5Ot3KbUw0pfdmIACOq2Yfx8
X-Proofpoint-ORIG-GUID: q7Oxb2S5r5Ot3KbUw0pfdmIACOq2Yfx8
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

Both SCLK and PLL clocks must be running to drive the glitch-free mux
behind MCLK_SRC_SEL and complete the switchover.

This patch moves the writing of MCLK_SRC_SEL to when the PLL is started
and stopped, so that it only transitions while the PLL is running.
The unconditional write MCLK_SRC_SEL=0 in cs42l42_mute_stream() is safe
because if the PLL is not running MCLK_SRC_SEL is already 0.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 43fc357199f9 ("ASoC: cs42l42: Set clock source for both ways of stream")
---
 sound/soc/codecs/cs42l42.c | 25 ++++++++++++++++++-------
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a00dc3c65549..c96549fe6ab2 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -619,6 +619,8 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 
 	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
 		if (pll_ratio_table[i].sclk == clk) {
+			cs42l42->pll_config = i;
+
 			/* Configure the internal sample rate */
 			snd_soc_component_update_bits(component, CS42L42_MCLK_CTL,
 					CS42L42_INTERNAL_FS_MASK,
@@ -627,14 +629,9 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					(pll_ratio_table[i].mclk_int !=
 					24000000)) <<
 					CS42L42_INTERNAL_FS_SHIFT);
-			/* Set the MCLK src (PLL or SCLK) and the divide
-			 * ratio
-			 */
+
 			snd_soc_component_update_bits(component, CS42L42_MCLK_SRC_SEL,
-					CS42L42_MCLK_SRC_SEL_MASK |
 					CS42L42_MCLKDIV_MASK,
-					(pll_ratio_table[i].mclk_src_sel
-					<< CS42L42_MCLK_SRC_SEL_SHIFT) |
 					(pll_ratio_table[i].mclk_div <<
 					CS42L42_MCLKDIV_SHIFT));
 			/* Set up the LRCLK */
@@ -892,13 +889,21 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			 */
 			regmap_multi_reg_write(cs42l42->regmap, cs42l42_to_osc_seq,
 					       ARRAY_SIZE(cs42l42_to_osc_seq));
+
+			/* Must disconnect PLL before stopping it */
+			snd_soc_component_update_bits(component,
+						      CS42L42_MCLK_SRC_SEL,
+						      CS42L42_MCLK_SRC_SEL_MASK,
+						      0);
+			usleep_range(100, 200);
+
 			snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 						      CS42L42_PLL_START_MASK, 0);
 		}
 	} else {
 		if (!cs42l42->stream_use) {
 			/* SCLK must be running before codec unmute */
-			if ((cs42l42->bclk < 11289600) && (cs42l42->sclk < 11289600)) {
+			if (pll_ratio_table[cs42l42->pll_config].mclk_src_sel) {
 				snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 							      CS42L42_PLL_START_MASK, 1);
 
@@ -919,6 +924,12 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 							       CS42L42_PLL_LOCK_TIMEOUT_US);
 				if (ret < 0)
 					dev_warn(component->dev, "PLL failed to lock: %d\n", ret);
+
+				/* PLL must be running to drive glitchless switch logic */
+				snd_soc_component_update_bits(component,
+							      CS42L42_MCLK_SRC_SEL,
+							      CS42L42_MCLK_SRC_SEL_MASK,
+							      CS42L42_MCLK_SRC_SEL_MASK);
 			}
 
 			/* Mark SCLK as present, turn off internal oscillator */
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 206b3c81d3e0..b92c17be7f58 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -775,6 +775,7 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
+	int pll_config;
 	int bclk;
 	u32 sclk;
 	u32 srate;
-- 
2.11.0

