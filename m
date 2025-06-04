Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA12C5B559
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jun 2025 07:45:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5997D60205;
	Thu,  5 Jun 2025 09:45:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5997D60205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749109526;
	bh=PqA3K1RuMVYIIzcg6RIxvAzC74Sce0YyQL0NkJQoRhg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=G+xB/jVNUrvmzcjdlQzCGVB4ar0HBActtRj1/MNmoEHS4O/uyrppYY/4S8fFJEF0n
	 mRIt1joBjGLIllGLqMR21ypzVdWbdXLxrP6TBMVuNenqMDzCDeTv75sfftZSQvHt4u
	 F2PJjHmoODgBt2PwabQLJ+SXBQFuk8FwTVfHkOz4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBE92F805F4; Thu,  5 Jun 2025 09:44:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B424CF805DF;
	Thu,  5 Jun 2025 09:44:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E1C9F8028B; Wed,  4 Jun 2025 08:18:43 +0200 (CEST)
Received: from mail78-66.sinamail.sina.com.cn (mail78-66.sinamail.sina.com.cn
 [219.142.78.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B8D24F800E4
	for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2025 08:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8D24F800E4
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.7])
	by sina.net (10.185.250.32) with ESMTP
	id 683FE52F00000DC7; Wed, 4 Jun 2025 14:18:24 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 74949610652142A89B0199F03D197027
X-SMAIL-UIID: 74949610652142A89B0199F03D197027-20250604-141824
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH] ASoC: codecs: ES8326: Modify initialization configuration
Date: Wed,  4 Jun 2025 14:18:21 +0800
Message-Id: <20250604061821.2678-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: WRCTTR4FDIFB2IZYMC3422ECMNUVDRML
X-Message-ID-Hash: WRCTTR4FDIFB2IZYMC3422ECMNUVDRML
X-Mailman-Approved-At: Thu, 05 Jun 2025 07:43:59 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WRCTTR4FDIFB2IZYMC3422ECMNUVDRML/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Modify the value of ES8326_SDINOUT1_IO in the initialization

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8326.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 066d92b54312..78c4e68f6002 100755
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -1079,8 +1079,7 @@ static void es8326_init(struct snd_soc_component *component)
 	regmap_update_bits(es8326->regmap, ES8326_HPDET_TYPE, 0x03, 0x00);
 	regmap_write(es8326->regmap, ES8326_INTOUT_IO,
 		     es8326->interrupt_clk);
-	regmap_write(es8326->regmap, ES8326_SDINOUT1_IO,
-		    (ES8326_IO_DMIC_CLK << ES8326_SDINOUT1_SHIFT));
+	regmap_write(es8326->regmap, ES8326_SDINOUT1_IO, ES8326_IO_INPUT);
 	regmap_write(es8326->regmap, ES8326_SDINOUT23_IO, ES8326_IO_INPUT);
 
 	regmap_write(es8326->regmap, ES8326_ANA_PDN, 0x00);
-- 
2.17.1

