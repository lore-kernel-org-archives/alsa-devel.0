Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F79C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:15:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D342074B
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HbvwAQNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D342074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0BA21655;
	Thu,  9 Jul 2020 12:14:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0BA21655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594289702;
	bh=XlsiMKP8/LNf53wdfK4Wno7RbRbNOI+53ssxrzajTNc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HbvwAQNqLIU0Zl9JJWLoLhA0uONQt3XgK8dS3aZeblfLzJd1jRrPiYAGfR/gT7KpZ
	 P8oWM29OFkoYJsKma/AGNGLj7o3THZcXd0+6luGn8z/bayUED/eDA7+C1ufbkDnXY1
	 xhReju7K/ZDMPZYcaSVW+RhYQ1Egqgekd/Q+8XvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E6F8F80274;
	Thu,  9 Jul 2020 12:14:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C819F802BD; Thu,  9 Jul 2020 12:14:04 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E63EF800AE
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 12:13:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E63EF800AE
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 069ADpdJ6022280,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 069ADpdJ6022280
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 9 Jul 2020 18:13:51 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 9 Jul 2020 18:13:51 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 9 Jul 2020
 18:13:50 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt286: fix unexpected interrupt happens
Date: Thu, 9 Jul 2020 18:13:45 +0800
Message-ID: <20200709101345.11449-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, pierre-louis.bossart@linux.intel.com, derek.fang@realtek.com,
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

The HV/VREF should not turn off if the headphone jack plug-in.
This patch could solve the unexpected interrupt issue in some devices.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt286.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 9593a9a27bf8..e8d14eefc41b 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -272,13 +272,13 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		regmap_read(rt286->regmap, RT286_GET_MIC1_SENSE, &buf);
 		*mic = buf & 0x80000000;
 	}
-	if (!*mic) {
+
+	if (!*hp) {
 		snd_soc_dapm_disable_pin(dapm, "HV");
 		snd_soc_dapm_disable_pin(dapm, "VREF");
-	}
-	if (!*hp)
 		snd_soc_dapm_disable_pin(dapm, "LDO1");
-	snd_soc_dapm_sync(dapm);
+		snd_soc_dapm_sync(dapm);
+	}
 
 	return 0;
 }
-- 
2.27.0

