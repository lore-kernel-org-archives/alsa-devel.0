Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79CC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 07:42:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E75D61A55
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 07:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E75D61A55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E02DA16C9;
	Fri,  1 Oct 2021 09:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E02DA16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633074153;
	bh=I4VjGsGJ1T+JnBTUww/bt/4tBWDGPpaJxP3s1O9CDRQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zkt/788zcsiIyqm6Yrzf6tUVmxXrypkhhy6slG8ZtKu8Tvh6CvRgPMemG6mNXHJID
	 hJGQwZTTO2XSwCK8Hbh4A8ps8l7ZmbepnijxuLnaFsZwcmKUyGmSPTTUo4AMhQvKbZ
	 M6x2SKY2B3Of6SNNMNs58roHof23DkdqyqlhmPIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A89D2F80227;
	Fri,  1 Oct 2021 09:41:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0EA14F8026D; Fri,  1 Oct 2021 09:41:39 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0BA8F801F7
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 09:41:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0BA8F801F7
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1917fJnT5009139,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
 by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1917fJnT5009139
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 1 Oct 2021 15:41:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 1 Oct 2021 15:41:19 +0800
Received: from localhost.localdomain (172.22.234.227) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 1 Oct 2021 15:41:18 +0800
From: <derek.fang@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 1/2] ASoC: rt5682s: Enable ASRC auto-disable to fix pop during
 jack plug-in while playback
Date: Fri, 1 Oct 2021 15:41:12 +0800
Message-ID: <20211001074113.2223-1-derek.fang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.234.227]
X-ClientProxiedBy: RTEXH36503.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/01/2021 07:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEwLzEgpFekyCAwNjowMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, Derek Fang <derek.fang@realtek.com>,
 kevin_chen_ym@realtek.com, shumingf@realtek.com, flove@realtek.com
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

From: Derek Fang <derek.fang@realtek.com>

When codec's ASRC was enabled, the DA and AD filters use
the reference clk which tracks the I2S clks.
And if the I2S clks' timing of open and close are not expected,
this patch allows the filters to switch to use sysclk if
ASRC's ref clks disappeared and could fix the below possible issues:
1. Avoid DA filter to keep surplus samples.
2. Avoid that AD filter works failed during dapm's power on.

For example,
if I2S clks were closed before dacdat during playback off
due to jack unplug, it causes ref clks disappeared and
DA filter remained some samples which will produce pop noise
on the next HP playback.
ASRC auto-disable could clear the samples during the playback off.

Signed-off-by: Derek Fang <derek.fang@realtek.com>
---
 sound/soc/codecs/rt5682s.c |  3 +++
 sound/soc/codecs/rt5682s.h | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 122adeb7beb1..5ae54a51ff9e 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -1061,6 +1061,9 @@ int rt5682s_sel_asrc_clk_src(struct snd_soc_component *component,
 			RT5682S_FILTER_CLK_SEL_MASK, clk_src << RT5682S_FILTER_CLK_SEL_SFT);
 	}
 
+	snd_soc_component_update_bits(component, RT5682S_PLL_TRACK_11,
+		RT5682S_ASRCIN_AUTO_CLKOUT_MASK, RT5682S_ASRCIN_AUTO_CLKOUT_EN);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rt5682s_sel_asrc_clk_src);
diff --git a/sound/soc/codecs/rt5682s.h b/sound/soc/codecs/rt5682s.h
index 55f1febb81e9..59ba4ea3b062 100644
--- a/sound/soc/codecs/rt5682s.h
+++ b/sound/soc/codecs/rt5682s.h
@@ -994,6 +994,19 @@
 #define RT5682S_ASRCIN_FTK_M2_MASK		(0x7 << 4)
 #define RT5682S_ASRCIN_FTK_M2_SFT		4
 
+/* ASRC Control 11 (0x008c) */
+#define RT5682S_ASRCIN_AUTO_CLKOUT_MASK		(0x1 << 5)
+#define RT5682S_ASRCIN_AUTO_CLKOUT_EN		(0x1 << 5)
+#define RT5682S_ASRCIN_AUTO_CLKOUT_DIS		(0x0 << 5)
+#define RT5682S_ASRCIN_AUTO_RST_MASK		(0x1 << 4)
+#define RT5682S_ASRCIN_AUTO_RST_EN		(0x1 << 4)
+#define RT5682S_ASRCIN_AUTO_RST_DIS		(0x0 << 4)
+#define RT5682S_SEL_LRCK_DET_MASK		(0x3)
+#define RT5682S_SEL_LRCK_DET_DIV8		(0x3)
+#define RT5682S_SEL_LRCK_DET_DIV4		(0x2)
+#define RT5682S_SEL_LRCK_DET_DIV2		(0x1)
+#define RT5682S_SEL_LRCK_DET_DIV1		(0x0)
+
 /* Depop Mode Control 1 (0x008e) */
 #define RT5682S_OUT_HP_L_EN			(0x1 << 6)
 #define RT5682S_OUT_HP_R_EN			(0x1 << 5)
-- 
2.17.1

