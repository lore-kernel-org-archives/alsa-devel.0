Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F570C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 10:56:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427D86138B
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 10:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 427D86138B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC414166C;
	Mon, 23 Aug 2021 12:56:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC414166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629716210;
	bh=iwoMbWscxV87mTZ+5gRvlznEmWEiN3jnlnjub3xOJ70=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GSy5XsOriWRRtMokKbKT/9Krp4ax1X8vvrrHolUUZEYsgH6gHlgCkBu3PR7YQpzz4
	 azCvtm5YB3asCSIfEYSgtfEBYF+7Fz82ba141sSrJlfGZ5v3VlYNeGHBQTOw0qng5Z
	 3Ek2dn03W9jVrk+UTVg/vJujWVXwQYkPhX5X/H9I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13DDBF80240;
	Mon, 23 Aug 2021 12:54:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5057AF80510; Mon, 23 Aug 2021 12:54:54 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.130])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 464D2F8016E
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 12:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 464D2F8016E
Received: from localhost (unknown [192.168.167.225])
 by lucky1.263xmail.com (Postfix) with ESMTP id ECCEED77B4;
 Mon, 23 Aug 2021 18:54:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P10596T140297356953344S1629716077595046_; 
 Mon, 23 Aug 2021 18:54:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <248984a6adda567a47d2b68276e71ebc>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH 14/15] ASoC: rockchip: i2s: Add support for 'rockchip,
 clk-trcm' property
Date: Mon, 23 Aug 2021 18:54:35 +0800
Message-Id: <1629716076-21465-5-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 Xing Zheng <zhengxing@rock-chips.com>, devicetree@vger.kernel.org
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

From: Xing Zheng <zhengxing@rock-chips.com>

If there is only one lrck (tx or rx) by hardware, we need to
use 'rockchip,clk-trcm' to specify which lrck can be used.

Change-Id: I3bf8d87a6bc8c45e183040012d87d8be21a4c133
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 6ccb62e..b9d9c88 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -54,6 +54,7 @@ struct rk_i2s_dev {
 	bool is_master_mode;
 	const struct rk_i2s_pins *pins;
 	unsigned int bclk_ratio;
+	unsigned int clk_trcm;
 };
 
 /* tx/rx ctrl lock */
@@ -321,7 +322,6 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct rk_i2s_dev *i2s = to_info(dai);
-	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	unsigned int val = 0;
 	unsigned int mclk_rate, bclk_rate, div_bclk, div_lrck;
 
@@ -421,13 +421,6 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
 			   I2S_DMACR_RDL(16));
 
-	val = I2S_CKR_TRCM_TXRX;
-	if (dai->driver->symmetric_rate && rtd->dai_link->symmetric_rate)
-		val = I2S_CKR_TRCM_TXONLY;
-
-	regmap_update_bits(i2s->regmap, I2S_CKR,
-			   I2S_CKR_TRCM_MASK,
-			   val);
 	return 0;
 }
 
@@ -531,7 +524,6 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 			    SNDRV_PCM_FMTBIT_S32_LE),
 	},
 	.ops = &rockchip_i2s_dai_ops,
-	.symmetric_rate = 1,
 };
 
 static const struct snd_soc_component_driver rockchip_i2s_component = {
@@ -750,6 +742,18 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	else if (of_property_read_bool(node, "rockchip,capture-only"))
 		soc_dai->playback.channels_min = 0;
 
+	i2s->clk_trcm = I2S_CKR_TRCM_TXRX;
+	if (!of_property_read_u32(node, "rockchip,clk-trcm", &val)) {
+		if (val >= 0 && val <= 2) {
+			i2s->clk_trcm = val << I2S_CKR_TRCM_SHIFT;
+			if (i2s->clk_trcm)
+				soc_dai->symmetric_rate = 1;
+		}
+	}
+
+	regmap_update_bits(i2s->regmap, I2S_CKR,
+			   I2S_CKR_TRCM_MASK, i2s->clk_trcm);
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rockchip_i2s_component,
 					      soc_dai, 1);
-- 
2.7.4



