Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE162C433EA
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:48:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFFB619C8
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFFB619C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0190286F;
	Mon, 22 Mar 2021 13:47:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0190286F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616417304;
	bh=WNMuHkLUrSsAjl6GREfUZOPSvrD3AdpSzRa5eBlAOnw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHYl2xtwuMj9lfLYFxkvhMRsvBvjIJg04+O/UhPDEcZysYsI275P6tzUcVvkM8JIW
	 dkBfuRDRTknERM5DD1YBl/4ptr0FHN42kPotECIGj/w8j0DIWEJ3thLySLmuOwy9xu
	 AaMfeL75saGV4m03Yi0TuyHp/AZn0X1hL1PhpEko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 357D3F80156;
	Mon, 22 Mar 2021 13:47:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8469DF801D5; Mon, 22 Mar 2021 13:47:31 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A848F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 13:47:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A848F80107
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12MClEHk9023290,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12MClEHk9023290
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 22 Mar 2021 20:47:14 +0800
Received: from localhost.localdomain (172.22.236.221) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 20:47:13 +0800
From: <derek.fang@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 2/2] ASoC: rt5682: Read property to get mclk control
Date: Mon, 22 Mar 2021 20:47:06 +0800
Message-ID: <20210322124706.17303-2-derek.fang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322124706.17303-1-derek.fang@realtek.com>
References: <20210322124706.17303-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.236.221]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, "derek.fang" <derek@realtek.com>, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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

From: "derek.fang" <derek@realtek.com>

The systems can use ACPI DSDT to pass on the mclk to rt5682.
Enable/Disable of the mclk is already handled in the codec so
platform drivers don't have to explicitly do handling of mclk.

Signed-off-by: derek.fang <derek@realtek.com>

diff --git a/include/sound/rt5682.h b/include/sound/rt5682.h
index 3900a07e3935..8b5288176bc4 100644
--- a/include/sound/rt5682.h
+++ b/include/sound/rt5682.h
@@ -43,6 +43,7 @@ struct rt5682_platform_data {
 	bool dmic_clk_driving_high;
 
 	const char *dai_clk_names[RT5682_DAI_NUM_CLKS];
+	const char *mclk_name;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 0e2a10ed11da..263f71dfd060 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2875,7 +2875,8 @@ static int rt5682_probe(struct snd_soc_component *component)
 	} else {
 #ifdef CONFIG_COMMON_CLK
 		/* Check if MCLK provided */
-		rt5682->mclk = devm_clk_get(component->dev, "mclk");
+		if (rt5682->pdata.mclk_name)
+			rt5682->mclk = devm_clk_get(NULL, rt5682->pdata.mclk_name);
 		if (IS_ERR(rt5682->mclk)) {
 			if (PTR_ERR(rt5682->mclk) != -ENOENT) {
 				ret = PTR_ERR(rt5682->mclk);
@@ -2905,6 +2906,11 @@ static void rt5682_remove(struct snd_soc_component *component)
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 
 	rt5682_reset(rt5682);
+
+#ifdef CONFIG_COMMON_CLK
+	if (rt5682->pdata.mclk_name)
+		devm_clk_put(rt5682->mclk);
+#endif
 }
 
 #ifdef CONFIG_PM
@@ -3002,6 +3008,9 @@ int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
 			 rt5682->pdata.dai_clk_names[RT5682_DAI_WCLK_IDX],
 			 rt5682->pdata.dai_clk_names[RT5682_DAI_BCLK_IDX]);
 
+	device_property_read_string(dev, "realtek,mclk-name",
+		&rt5682->pdata.mclk_name);
+
 	rt5682->pdata.dmic_clk_driving_high = device_property_read_bool(dev,
 		"realtek,dmic-clk-driving-high");
 
-- 
2.17.1

