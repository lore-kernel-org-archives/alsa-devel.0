Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEDC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 09:13:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B879A23131
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 09:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B879A23131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BEF11813;
	Wed, 20 Jan 2021 10:12:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BEF11813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611133998;
	bh=rewafI9x7R7GiZSgReR4BvFZRtd2ll/i+DyQs/wA4es=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E6AGDUxWMI+1m3JdhmK95WYxe0W/XH1Msscd4XSbURqmS4YOgLF9CMFELTQIZ2uxf
	 CgdGoGmWPNqchHIng4OVRFv036h+eP/7kfsetGph3nK6gmac003DCApISPju3hFUlF
	 iKpd5/CAT3bKXagd5680RD2PKwozZ+rQMRbIJmPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27F31F8016E;
	Wed, 20 Jan 2021 10:12:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9594F8016E; Wed, 20 Jan 2021 10:12:25 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4643F80137
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 10:12:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4643F80137
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10K9CA7K0006149,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10K9CA7K0006149
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 20 Jan 2021 17:12:10 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 17:12:10 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: rt5682: add LDO2 power control device
 property
Date: Wed, 20 Jan 2021 17:12:07 +0800
Message-ID: <20210120091207.10778-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, derek.fang@realtek.com,
 Shuming Fan <shumingf@realtek.com>, flove@realtek.com
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

The "realtek,ldo2-pow-en" device property uses to enable LDO2 power while the headset recording.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5682.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 9c5fadb6ac82..eba2ea588564 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -46,6 +46,8 @@ Optional properties:
 
 - realtek,dmic-clk-driving-high : Set the high drving of the DMIC clock out.
 
+- realtek,ldo2-pow-en : Enable LDO2 power control if the application circuit uses VBAT, not MICVDD.
+
 Pins on the device (for linking into audio routes) for RT5682:
 
   * DMIC L1
-- 
2.29.0

