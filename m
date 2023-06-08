Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F3FC7EE25
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jun 2023 08:50:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 533E8847;
	Thu,  8 Jun 2023 10:49:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 533E8847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686214235;
	bh=yBFpvdyvUdE5L7ZiJ3JX8I1dNCEtgPqdfEZ9UKzm1JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JIpGDQztobOE5xXAbFHorjDE0wFwYBW1TVNlJf7ESJaiDEn6n0+eZrJkyxrfoiZQF
	 e412d60SB7rtp+OZABPpySXA1sY9e58f+pVBXn65UjkiXf41xc0uwIqK0/ZYQMs+90
	 DDOiIED9tbOtf3aF0TyQbO+alrxzn1d7hhF+B6Oo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD982F805BB; Thu,  8 Jun 2023 10:48:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BCF2F805B4;
	Thu,  8 Jun 2023 10:48:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3A50F8055A; Thu,  8 Jun 2023 10:48:01 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 84C0BF80551
	for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2023 10:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84C0BF80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=A4qXIgXs
Received: from IcarusMOD.eternityproject.eu (unknown
 [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 721426606F15;
	Thu,  8 Jun 2023 09:47:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1686214057;
	bh=yBFpvdyvUdE5L7ZiJ3JX8I1dNCEtgPqdfEZ9UKzm1JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4qXIgXsrpU31WLaN06EJ3R+3Ki8sEYa9S8k+I1SUzdew5myZPLJdRoxVXDXhhj/a
	 zdVaKQurrls3rwKU6T6iSS3ba2OobbSkRLpCimGp0W33yR7pAmHr/WDWa7HWQmYAMS
	 kRLXc8xmG4gX9QK0SVYx4KNsBT6sgP42c2U0uAxnvisUph+WKoija26PuqsvNBdaSn
	 Znpb/soYutHbHxYydHmylK2eo70onW/yUDf0JRFt2D7pGjQ+5TojVktq962WH0ry1Y
	 MEpeIO3fz95zylk0EXsO3XUxWkd2yL2NkldQzTWw4vLXzrSLMf9iHGJ/D7CuINUDDi
	 kMXp9Cl+Nsf1Q==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	trevor.wu@mediatek.com,
	amergnat@baylibre.com,
	dan.carpenter@linaro.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/5] ASoC: mediatek: mt8188-mt6359: Compress of_device_id
 entries
Date: Thu,  8 Jun 2023 10:47:23 +0200
Message-Id: <20230608084727.74403-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DBEPW6TKQVOHV5PJ6S36QWGKQ72LIEEH
X-Message-ID-Hash: DBEPW6TKQVOHV5PJ6S36QWGKQ72LIEEH
X-MailFrom: angelogioacchino.delregno@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DBEPW6TKQVOHV5PJ6S36QWGKQ72LIEEH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Those entries fit in one line: compress them to reduce line count.
While at it, also add the sentinel comment to the last entry.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index bc4b74970a46..643a7a12a96b 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -1117,15 +1117,9 @@ static struct mt8188_card_data mt8188_nau8825_card = {
 };
 
 static const struct of_device_id mt8188_mt6359_dt_match[] = {
-	{
-		.compatible = "mediatek,mt8188-mt6359-evb",
-		.data = &mt8188_evb_card,
-	},
-	{
-		.compatible = "mediatek,mt8188-nau8825",
-		.data = &mt8188_nau8825_card,
-	},
-	{},
+	{ .compatible = "mediatek,mt8188-mt6359-evb", .data = &mt8188_evb_card, },
+	{ .compatible = "mediatek,mt8188-nau8825", .data = &mt8188_nau8825_card, },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
 
-- 
2.40.1

