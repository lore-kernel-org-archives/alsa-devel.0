Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4C1C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 08:58:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70612389E
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 08:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70612389E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95DF017FD;
	Thu, 17 Dec 2020 09:57:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95DF017FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608195487;
	bh=gw6AC9SbB8ryhFXsWblesAsC4zGrBkSG2OsYwJv1/XU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gWS4Rbsef0J/1+eCe699oMeaGTtlt5kYJuDTqX1uiXFhIpvLicsIzV7ONT9AqMMHT
	 lB7VWMPdF8pauQdsbdrcM2WcQn7O2ARhFocm3qWAvUmy8HFVVI6yqfwLaFvBz9mpnl
	 km5S7ui+VM0SDfv5LDrm0eCB2jAkkDfVhkCGlxVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0004F80148;
	Thu, 17 Dec 2020 09:57:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A67F2F80260; Thu, 17 Dec 2020 09:57:14 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06F59F80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 09:57:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06F59F80148
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BH8uxRI3011427,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb05.realtek.com.tw[172.21.6.98])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BH8uxRI3011427
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 17 Dec 2020 16:56:59 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 17 Dec 2020 16:56:59 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 17 Dec 2020 16:56:59 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt711: mutex between calibration and power state changes
Date: Thu, 17 Dec 2020 16:56:51 +0800
Message-ID: <20201217085651.24580-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXDAG01.realtek.com.tw (172.21.6.100)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, bard.liao@intel.com,
 Shuming Fan <shumingf@realtek.com>, flove@realtek.com,
 pierre-louis.bossart@intel.com
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

To avoid calibration time-out, this patch adds the mutex between calibration and power state changes

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt711.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 5771c02c3459..85f744184a60 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -462,6 +462,8 @@ static int rt711_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 	unsigned int read_ll, read_rl;
 	int i;
 
+	mutex_lock(&rt711->calibrate_mutex);
+
 	/* Can't use update bit function, so read the original value first */
 	addr_h = mc->reg;
 	addr_l = mc->rreg;
@@ -547,6 +549,8 @@ static int rt711_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 	if (dapm->bias_level <= SND_SOC_BIAS_STANDBY)
 		regmap_write(rt711->regmap,
 				RT711_SET_AUDIO_POWER_STATE, AC_PWRST_D3);
+
+	mutex_unlock(&rt711->calibrate_mutex);
 	return 0;
 }
 
@@ -859,9 +863,11 @@ static int rt711_set_bias_level(struct snd_soc_component *component,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
+		mutex_lock(&rt711->calibrate_mutex);
 		regmap_write(rt711->regmap,
 			RT711_SET_AUDIO_POWER_STATE,
 			AC_PWRST_D3);
+		mutex_unlock(&rt711->calibrate_mutex);
 		break;
 
 	default:
-- 
2.29.0

