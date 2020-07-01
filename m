Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA6C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:18:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0B2206BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="djyTeM9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0B2206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F6261661;
	Wed,  1 Jul 2020 09:17:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F6261661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593587885;
	bh=JnPvr4u4AHz5r/RSELDO1CfOuoYW56V1A4nyghnWpHI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=djyTeM9wS8/URKR07nDZtY3w9/+KAAGP0e5kgQb9/Q4qt4d9hNX/PHQBcuBZmrzu1
	 VFBeDYDreROLEFqkggT4WFevqP1iB1cSMzsmK6n5IjV7Urs7tlhZcOhyX7FHdKGL6O
	 v7YtdLAoBA6gDRZiQTdSjr7rMe7V6A8/n9syiiAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CCC0F8020C;
	Wed,  1 Jul 2020 09:17:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EC88F80217; Wed,  1 Jul 2020 09:17:14 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06876F800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 09:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06876F800EA
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0617GouwE011166,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0617GouwE011166
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 1 Jul 2020 15:16:50 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 1 Jul 2020 15:16:49 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 1 Jul 2020
 15:16:49 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt5682: cancel jack_detect_work if hs_jack is set to
 null even soundwire mode
Date: Wed, 1 Jul 2020 15:16:45 +0800
Message-ID: <20200701071645.32061-1-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com,
 alsa-devel@alsa-project.org, albertchen@realtek.com, derek.fang@realtek.com,
 bard.liao@intel.com, shumingf@realtek.com, flove@realtek.com
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

Base on https://patchwork.kernel.org/patch/11237953/
Soundwire mode also should follow it.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5682.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index e9514c81b9ba..de40b6cd16cf 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -992,16 +992,17 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
 
 	rt5682->hs_jack = hs_jack;
 
-	if (!rt5682->is_sdw) {
-		if (!hs_jack) {
-			regmap_update_bits(rt5682->regmap, RT5682_IRQ_CTRL_2,
-				RT5682_JD1_EN_MASK, RT5682_JD1_DIS);
-			regmap_update_bits(rt5682->regmap, RT5682_RC_CLK_CTRL,
-				RT5682_POW_JDH | RT5682_POW_JDL, 0);
-			cancel_delayed_work_sync(&rt5682->jack_detect_work);
-			return 0;
-		}
+	if (!hs_jack) {
+		regmap_update_bits(rt5682->regmap, RT5682_IRQ_CTRL_2,
+			RT5682_JD1_EN_MASK, RT5682_JD1_DIS);
+		regmap_update_bits(rt5682->regmap, RT5682_RC_CLK_CTRL,
+			RT5682_POW_JDH | RT5682_POW_JDL, 0);
+		cancel_delayed_work_sync(&rt5682->jack_detect_work);
 
+		return 0;
+	}
+
+	if (!rt5682->is_sdw) {
 		switch (rt5682->pdata.jd_src) {
 		case RT5682_JD1:
 			snd_soc_component_update_bits(component,
-- 
2.27.0

