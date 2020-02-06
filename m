Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE8C2D0B1
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:23:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175F020838
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BEegDsdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175F020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62302847;
	Thu,  6 Feb 2020 07:23:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62302847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580970230;
	bh=RM6T60zBaLY4IIlpTtl9adQ6VArbquSfbM7eakAiXoU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BEegDsdENaQNjjizOBZACAWEc753rFImqfngC6+/kKCMiwdYmJs+wRo1N7He+TsaE
	 qCDnqppDzL+/NehIOaZOBsNjD0aW+I30V0xwaRxIAYbfhgrHqeNynTnhfTXxpfABiq
	 SnWXV3Miv8KyEJ2tWxirlXf7jsvA3FTT1hbr6vso=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB146F8015B;
	Thu,  6 Feb 2020 07:22:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5C86F80162; Thu,  6 Feb 2020 07:22:57 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A87F6F80051
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 07:22:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A87F6F80051
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0166MfOt017169,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0166MfOt017169
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 6 Feb 2020 14:22:41 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 6 Feb 2020 14:22:41 +0800
Received: from derek-pvm.localdomain (172.22.234.75) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 6 Feb 2020 14:22:40 +0800
From: <derek.fang@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Date: Thu, 6 Feb 2020 14:22:13 +0800
Message-ID: <1580970133-14089-1-git-send-email-derek.fang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [172.22.234.75]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
Subject: [alsa-devel] [PATCH] ASoC: rl6231: Add new supports on rl6231
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Derek Fang <derek.fang@realtek.com>

1. Increases the max limit of PLL input frequency
   on RL6231 shared support.
2. Add a new pll preset map.

Signed-off-by: Derek Fang <derek.fang@realtek.com>
---
 sound/soc/codecs/rl6231.c | 1 +
 sound/soc/codecs/rl6231.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index a887d5c..d181c21 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -102,6 +102,7 @@ struct pll_calc_map {
 static const struct pll_calc_map pll_preset_table[] = {
 	{19200000,  4096000,  23, 14, 1, false},
 	{19200000,  24576000,  3, 30, 3, false},
+	{3840000,   24576000,  3, 30, 0, true},
 };
 
 static unsigned int find_best_div(unsigned int in,
diff --git a/sound/soc/codecs/rl6231.h b/sound/soc/codecs/rl6231.h
index 31a9643..6d8ed03 100644
--- a/sound/soc/codecs/rl6231.h
+++ b/sound/soc/codecs/rl6231.h
@@ -10,7 +10,7 @@
 #ifndef __RL6231_H__
 #define __RL6231_H__
 
-#define RL6231_PLL_INP_MAX	40000000
+#define RL6231_PLL_INP_MAX	50000000
 #define RL6231_PLL_INP_MIN	256000
 #define RL6231_PLL_N_MAX	0x1ff
 #define RL6231_PLL_K_MAX	0x1f
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
