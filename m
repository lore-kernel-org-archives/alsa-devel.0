Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ECEC4CECD
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:43:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDC12072D
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fjd2V9kh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="noKuBg1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDC12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE1B8167F;
	Mon, 27 Apr 2020 22:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE1B8167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588020188;
	bh=u653IUXh3zj5cB7zfcD5riRt9iiLON0pUv7R7iQePwQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fjd2V9khKZ71nX9rEJkuPufVVTMMnKJL0OcBFQNPrk2JWy/ovwwu0Zi0ZCdIZKZ60
	 WtiuuoMaJYeDiaw59LM3BCVlaEtS1EgjEMUZtJngv2FqL6qUJpAmB4kihveJa8/lgN
	 FPGnc4fAeXoXe4pHFnKzZ3Ipbv3B0+yBuLNsronM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D13EF80217;
	Mon, 27 Apr 2020 22:42:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8086AF8022B; Mon, 27 Apr 2020 22:42:17 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34645F80112
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 22:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34645F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="noKuBg1N"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RKg7ao016845;
 Mon, 27 Apr 2020 15:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1588020127;
 bh=lsXYqzJZ87/b6MFwb+B5fUGJvdO4PlNLviGnIO0YnAo=;
 h=From:To:CC:Subject:Date;
 b=noKuBg1NElWkIauG42saatFVPHdxtBT6s7C7V9rBxs1bD2QpLjquLnhOTElNvrbdb
 pz36GfwWTSnnxJoHkFP4+VD97M4nE1PwA19O+niyJZUBTrJG6i+6QjqKGI/t5oUWq3
 HRTL76pFRPgpFPGtefghQpe3rRaUbV1z6SxWENI8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RKg7Yf070719;
 Mon, 27 Apr 2020 15:42:07 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 15:42:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 15:42:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RKg7gb098139;
 Mon, 27 Apr 2020 15:42:07 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix mic gain registers
Date: Mon, 27 Apr 2020 15:36:08 -0500
Message-ID: <20200427203608.7031-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
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

Fix the mic gain registers for channels 2-4.
The incorret register was being set as it was touching the CH1 config
registers.

Fixes: 37bde5acf040 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 38897568ee96..0f713efde046 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -511,11 +511,11 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 static const struct snd_kcontrol_new adcx140_snd_controls[] = {
 	SOC_SINGLE_TLV("Analog CH1 Mic Gain Volume", ADCX140_CH1_CFG1, 2, 42, 0,
 			adc_tlv),
-	SOC_SINGLE_TLV("Analog CH2 Mic Gain Volume", ADCX140_CH1_CFG2, 2, 42, 0,
+	SOC_SINGLE_TLV("Analog CH2 Mic Gain Volume", ADCX140_CH2_CFG1, 2, 42, 0,
 			adc_tlv),
-	SOC_SINGLE_TLV("Analog CH3 Mic Gain Volume", ADCX140_CH1_CFG3, 2, 42, 0,
+	SOC_SINGLE_TLV("Analog CH3 Mic Gain Volume", ADCX140_CH3_CFG1, 2, 42, 0,
 			adc_tlv),
-	SOC_SINGLE_TLV("Analog CH4 Mic Gain Volume", ADCX140_CH1_CFG4, 2, 42, 0,
+	SOC_SINGLE_TLV("Analog CH4 Mic Gain Volume", ADCX140_CH4_CFG1, 2, 42, 0,
 			adc_tlv),
 
 	SOC_SINGLE_TLV("DRE Threshold", ADCX140_DRE_CFG0, 4, 9, 0,
-- 
2.25.1

