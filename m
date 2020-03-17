Return-Path: <SRS0=KQif=5C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE015C10F29
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:34:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41401205ED
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dsZq5Ncp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41401205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 572481822;
	Tue, 17 Mar 2020 08:33:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 572481822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584430464;
	bh=SuynHyoOzWDMbfleq+YrF0w8D47BypyPb0nXcvbqVrc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dsZq5NcpyD0Qm9nnoqTjls5X6B/d4nAfbZ6kONyGkIEr2JBpMyYfi0LhTT3wFb4ag
	 vZjSF9VHOmwtqREvy474eKxLODAbLGdon14BauTFdkKZkkTPvU1jgQgSlFTTQGfFhN
	 XmJ3S69d/Yu1vzbXvU+9DXs++NmJgY9EEJXbSRWY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A09AAF800C0;
	Tue, 17 Mar 2020 08:33:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AC21F80232; Tue, 17 Mar 2020 08:33:31 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFB07F800C0
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 08:33:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFB07F800C0
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02H7XErx027295,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02H7XErx027295
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2020 15:33:14 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Mar 2020 15:33:14 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 17 Mar
 2020 15:33:14 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 1/2] ASoC: rt5682: fix the random recording noise of headset
Date: Tue, 17 Mar 2020 15:33:08 +0800
Message-ID: <20200317073308.11572-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, Shuming Fan <shumingf@realtek.com>, albertchen@realtek.com,
 derek.fang@realtek.com, sathya.prakash.m.r@intel.com, flove@realtek.com
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

From: Shuming Fan <shumingf@realtek.com>

The cycle time of FIFO clock should increase 2 times to avoid
the random recording noise issue.
This setting could apply to all known situations in i2s mode.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt5682.c | 2 ++
 sound/soc/codecs/rt5682.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 7ca02a5e52e9..023bc672274b 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -3643,6 +3643,8 @@ static int rt5682_i2c_probe(struct i2c_client *i2c,
 			RT5682_CP_CLK_HP_MASK, RT5682_CP_CLK_HP_300KHZ);
 	regmap_update_bits(rt5682->regmap, RT5682_HP_CHARGE_PUMP_1,
 			RT5682_PM_HP_MASK, RT5682_PM_HP_HV);
+	regmap_update_bits(rt5682->regmap, RT5682_DMIC_CTRL_1,
+			RT5682_FIFO_CLK_DIV_MASK, RT5682_FIFO_CLK_DIV_2);
 
 	INIT_DELAYED_WORK(&rt5682->jack_detect_work,
 				rt5682_jack_detect_handler);
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 43de6e802309..0baeece84ec4 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -657,6 +657,8 @@
 #define RT5682_DMIC_1_EN_SFT			15
 #define RT5682_DMIC_1_DIS			(0x0 << 15)
 #define RT5682_DMIC_1_EN			(0x1 << 15)
+#define RT5682_FIFO_CLK_DIV_MASK		(0x7 << 12)
+#define RT5682_FIFO_CLK_DIV_2			(0x1 << 12)
 #define RT5682_DMIC_1_DP_MASK			(0x3 << 4)
 #define RT5682_DMIC_1_DP_SFT			4
 #define RT5682_DMIC_1_DP_GPIO2			(0x0 << 4)
-- 
2.25.1

