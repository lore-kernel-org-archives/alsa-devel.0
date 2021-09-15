Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1520AC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 03:48:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE06E61214
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 03:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE06E61214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A44617D8;
	Wed, 15 Sep 2021 05:47:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A44617D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631677690;
	bh=RkGH3qEKvHygQYAP8RQqw8r8IG4lwWwpmBiUG4VOWlo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U0GMcgFam/cCKRzqnyZbTveVId4QMs6Uh5pLnIlg0uNqUaYPKMXgnezrSoOwY1c2T
	 58gVmk3WHWzQEsuZhEuB1Iw73aXOC8AjU9JoyP52rkIehVpWNpBd4SsTaxghK1vWwf
	 7NV56csac76EuKfMnfmhu3OZfhBbLJNH5wDxLJjk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4B9EF80227;
	Wed, 15 Sep 2021 05:47:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97AC0F8027C; Wed, 15 Sep 2021 05:47:17 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0960F80117
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 05:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0960F80117
X-UUID: fb921b549e374c8faf3ea61a70d66d17-20210915
X-UUID: fb921b549e374c8faf3ea61a70d66d17-20210915
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 734492139; Wed, 15 Sep 2021 11:47:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Wed, 15 Sep 2021 11:47:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 15 Sep 2021 11:47:00 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
Subject: [PATCH] ASoC: mediatek: mt6359: Fix unexpected error in bind/unbind
 flow
Date: Wed, 15 Sep 2021 11:46:59 +0800
Message-ID: <20210915034659.25044-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: alsa-devel@alsa-project.org, chipeng.chang@mediatek.com, tzungbi@google.com,
 linux-kernel@vger.kernel.org, jiaxin.yu@mediatek.com, shane.chien@mediatek.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

mt6359-sound is a MFD driver. Because its regmap is retrieved from its
parent, it shouldn't be freed in mt6359-sound driver.

snd_soc_component_exit_regmap() will do regmap_exit(), this results in
unexpected results if sound card unregister flow is invoked when users
try to bind/unbind audio codec.

Remove the usage of snd_soc_component_exit_regmap(). Instead, set
component->regmap = NULL in the component remove function.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/codecs/mt6359.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 2d6a4a29b850..f8532aa7e4aa 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -2697,7 +2697,7 @@ static int mt6359_codec_probe(struct snd_soc_component *cmpnt)
 
 static void mt6359_codec_remove(struct snd_soc_component *cmpnt)
 {
-	snd_soc_component_exit_regmap(cmpnt);
+	cmpnt->regmap = NULL;
 }
 
 static const DECLARE_TLV_DB_SCALE(hp_playback_tlv, -2200, 100, 0);
-- 
2.18.0

