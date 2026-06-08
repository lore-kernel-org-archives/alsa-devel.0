Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C97CCD8C9F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:31:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDBD460235;
	Mon,  8 Jun 2026 13:31:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDBD460235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918271;
	bh=9JVAFCmQgU3Kp62ol+ZD/YGYjXfJYpwOQ7FApQXA7ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BomjndMOXzX5aGAop3Aw7ukeSZ9L/Rco4+WE5imvbqf+6Yk1AneyJ2gBBAuy6DHm1
	 Slf8ev8tbLq+HC1ZJcOU2LSI+6Vf7yRDZxajONB+2MQ1YAqY3pXMJ+qb1DcXwi30FO
	 YN+TlsHw6A/uomGrYNPjZe1jTOU17qmT/dkMQJDo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D003F80615; Mon,  8 Jun 2026 13:30:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC3C8F8065B;
	Mon,  8 Jun 2026 13:30:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CA21F80423; Mon,  8 Jun 2026 10:35:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=61.135.153.176
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907751;
	b=BN8JMpWP0SG16N73HQ4wVz/T591uHHtedXmC/McnrDn0+drfuiqphzow/Bz5xb7mSGTu
	 es36jZsVUez6OrKjud/AzYXpofnCqLv5K53yF6CSXUGTqwKpVIv+kKK0rlcvBzgy3qhmE
	 IEQA+fsosngp2T29WJ0d0wkn6j2hvhx5bOvWaP2NuYZFfM1sQ/CowXofdaMk3/iEvrfYs
	 TGaVsBxJsohxza8iQNlTc7d0uRD5rGBvCdfWsUZf3wyoAFnF0eQV6dwFGE97LF9NwaRZ7
	 FH9LT5k6Ruyt2BhSUcrfij86Bxu8t0Di1Fyukd/xPSTrgUTZZzv8Q2zmaDWfGbo1Bjw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907751;
	h=From:To:Subject:Date:Message-Id;
	bh=9JVAFCmQgU3Kp62ol+ZD/YGYjXfJYpwOQ7FApQXA7ZM=;
	b=JzXaCGZ0H4Wes+vusbrzRCLaJCg5LPGDjGY4CB2Er5FJLMMC76mznt7eQeFRq+4gBSxV
	 pEA06/ELKaS0gWrNOeqBCNc4jzqU4cLa0uT0qOKfuLcUw0agR9st2ldfZaXOSpPz7uRqM
	 VOUMkgB1DB3LbfXyrhEN2On26OYjl+sfsZeHrXXQMXiDDoHGQJXa46ZbTHsjvBJgLouaY
	 bU6Jpu4KG/uBgYvyPYdnz1ONxd5zCtXaZAe7MDkBpLGDWgYVDrc84lfJuivrQ2JBtKXhJ
	 seo5TuQTvSulUDRXq8c34MgCK1/f4+UPTlAptx0WYjVh/hbeTfcbB/BqaKDczwCJUiQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=61.135.153.176
Received: from smtp153-176.sina.com.cn (smtp153-176.sina.com.cn
 [61.135.153.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58F85F80153
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58F85F80153
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:45 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: FF3B8CE09A85460290A09CA735F6B639
X-SMAIL-UIID: FF3B8CE09A85460290A09CA735F6B639-20260608-163545
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 1/7] ASoC: codecs: ES8389: Modify volatile_register
Date: Mon,  8 Jun 2026 16:35:34 +0800
Message-Id: <20260608083540.12581-2-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DQG2J3OQR6YV7OVNUALPBQSKUO3CN452
X-Message-ID-Hash: DQG2J3OQR6YV7OVNUALPBQSKUO3CN452
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DQG2J3OQR6YV7OVNUALPBQSKUO3CN452/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

Mark some registers that are not volatile as false

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8389.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index 449d9574b03a..9c816491648c 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -50,10 +50,29 @@ static const char * const es8389_core_supplies[] = {
 static bool es8389_volatile_register(struct device *dev,
 			unsigned int reg)
 {
-	if ((reg  <= 0xff))
-		return true;
-	else
+	switch (reg) {
+	case ES8389_ADC_HPF1:
+	case ES8389_ADC_HPF2:
+	case ES8389_ADCL_VOL:
+	case ES8389_ADCR_VOL:
+	case ES8389_MIC1_GAIN:
+	case ES8389_MIC2_GAIN:
+	case ES8389_DACL_VOL:
+	case ES8389_DACR_VOL:
+	case ES8389_ALC_ON:
+	case ES8389_ALC_CTL:
+	case ES8389_ALC_TARGET:
+	case ES8389_ALC_GAIN:
+	case ES8389_ADC_MUTE:
+	case ES8389_OSR_VOL:
+	case ES8389_DAC_INV:
+	case ES8389_MIX_VOL:
+	case ES8389_DAC_MIX:
+	case ES8389_ADC_RESET:
 		return false;
+	default:
+		return true;
+	}
 }
 
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9550, 50, 0);
-- 
2.54.0.windows.1

